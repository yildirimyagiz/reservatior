use std::time::Duration;

use regex::Regex;
use uuid::Uuid;

use crate::ast::*;
use crate::errors::DslError;

#[derive(Debug, Clone)]
pub struct CompiledRule {
    pub rule: DslRule,
    pub compiled_condition: CompiledCondition,
    pub rule_id: String,
}

#[derive(Debug, Clone)]
pub enum CompiledCondition {
    RegexMatch {
        field: String,
        regex: Regex,
    },
    FieldCompare {
        field: String,
        op: FieldOperator,
        value: FieldValue,
    },
    LogicalAnd(Vec<CompiledCondition>),
    LogicalOr(Vec<CompiledCondition>),
    LogicalNot(Box<CompiledCondition>),
    Threshold {
        inner: Box<CompiledCondition>,
        threshold_count: u32,
        window: Duration,
        group_by: Vec<String>,
    },
}

pub struct RuleCompiler;

impl RuleCompiler {
    pub fn compile(rule: DslRule) -> Result<CompiledRule, DslError> {
        let compiled_condition = Self::compile_condition(&rule.condition)?;
        let rule_id = Uuid::new_v4().to_string();
        Ok(CompiledRule {
            rule,
            compiled_condition,
            rule_id,
        })
    }

    pub fn compile_condition(cond: &DslCondition) -> Result<CompiledCondition, DslError> {
        match cond {
            DslCondition::Field { field, op, value } => {
                if *op == FieldOperator::Regex {
                    if let FieldValue::Str(ref pattern) = value {
                        let regex = Regex::new(pattern)
                            .map_err(|e| DslError::RegexError(format!("{}: {}", pattern, e)))?;
                        return Ok(CompiledCondition::RegexMatch {
                            field: field.clone(),
                            regex,
                        });
                    }
                }
                Ok(CompiledCondition::FieldCompare {
                    field: field.clone(),
                    op: *op,
                    value: value.clone(),
                })
            }
            DslCondition::And(conditions) => {
                let compiled: Result<Vec<_>, _> =
                    conditions.iter().map(Self::compile_condition).collect();
                Ok(CompiledCondition::LogicalAnd(compiled?))
            }
            DslCondition::Or(conditions) => {
                let compiled: Result<Vec<_>, _> =
                    conditions.iter().map(Self::compile_condition).collect();
                Ok(CompiledCondition::LogicalOr(compiled?))
            }
            DslCondition::Not(inner) => {
                let compiled = Self::compile_condition(inner)?;
                Ok(CompiledCondition::LogicalNot(Box::new(compiled)))
            }
            DslCondition::Aggregate {
                inner,
                func: _,
                op: _,
                threshold_value,
                window,
                group_by,
            } => {
                // Compile the inner condition
                let compiled_inner = Self::compile_condition(inner)?;
                // Extract threshold count from the threshold value
                let threshold_count = match threshold_value {
                    FieldValue::Num(n) => *n as u32,
                    _ => 0,
                };
                Ok(CompiledCondition::Threshold {
                    inner: Box::new(compiled_inner),
                    threshold_count,
                    window: *window,
                    group_by: group_by.clone(),
                })
            }
            DslCondition::Sequence {
                conditions,
                within,
                group_by,
            } => {
                // Compile sequence as a chain: all conditions ANDed together
                let compiled: Result<Vec<_>, _> =
                    conditions.iter().map(Self::compile_condition).collect();
                let compiled = compiled?;
                let inner = if compiled.len() == 1 {
                    Box::new(compiled.into_iter().next().unwrap())
                } else {
                    Box::new(CompiledCondition::LogicalAnd(compiled))
                };
                Ok(CompiledCondition::Threshold {
                    inner,
                    threshold_count: conditions.len() as u32,
                    window: *within,
                    group_by: group_by.clone(),
                })
            }
            DslCondition::Near {
                left,
                right,
                max_distance,
            } => {
                let l = Self::compile_condition(left)?;
                let r = Self::compile_condition(right)?;
                let inner = Box::new(CompiledCondition::LogicalAnd(vec![l, r]));
                Ok(CompiledCondition::Threshold {
                    inner,
                    threshold_count: 2,
                    window: Duration::from_secs(*max_distance as u64),
                    group_by: vec![],
                })
            }
            DslCondition::Graph { nodes, .. } => {
                let mut all_conditions = Vec::new();
                for node in nodes {
                    for cond in &node.conditions {
                        all_conditions.push(Self::compile_condition(cond)?);
                    }
                }
                let inner = if all_conditions.len() == 1 {
                    Box::new(all_conditions.remove(0))
                } else {
                    Box::new(CompiledCondition::LogicalAnd(all_conditions))
                };
                Ok(CompiledCondition::Threshold {
                    inner,
                    threshold_count: 1,
                    window: Duration::from_secs(300),
                    group_by: vec![],
                })
            }
        }
    }
}

// ── Tests ─────────────────────────────────────────────────────────────────────
#[cfg(test)]
mod tests {
    use super::*;
    use crate::parser::DslParser;

    #[test]
    fn compile_simple_rule() {
        let input = r#"
rule "Simple Rule" {
    description: "simple"
    severity: low
    condition: event.category == "authentication"
    tags: ["simple"]
}
"#;
        let rule = DslParser::parse(input).unwrap();
        let compiled = RuleCompiler::compile(rule).unwrap();
        assert_eq!(compiled.rule.name, "Simple Rule");
        assert!(!compiled.rule_id.is_empty());
        match &compiled.compiled_condition {
            CompiledCondition::FieldCompare { field, op, value } => {
                assert_eq!(field, "event.category");
                assert_eq!(*op, FieldOperator::Equals);
                assert_eq!(*value, FieldValue::Str("authentication".into()));
            }
            other => panic!("expected FieldCompare, got {:?}", other),
        }
    }

    #[test]
    fn compile_regex_condition() {
        let input = r#"
rule "Regex Rule" {
    description: "regex"
    severity: medium
    condition: event.cmdline regex "^/bin/(ba)?sh"
    tags: ["regex"]
}
"#;
        let rule = DslParser::parse(input).unwrap();
        let compiled = RuleCompiler::compile(rule).unwrap();
        match &compiled.compiled_condition {
            CompiledCondition::RegexMatch { field, regex } => {
                assert_eq!(field, "event.cmdline");
                assert!(regex.is_match("/bin/bash"));
                assert!(regex.is_match("/bin/sh"));
                assert!(!regex.is_match("/usr/bin/bash"));
            }
            other => panic!("expected RegexMatch, got {:?}", other),
        }
    }

    #[test]
    fn compile_threshold() {
        let input = r#"
rule "Threshold Rule" {
    description: "threshold"
    severity: high
    condition: count(event.category == "authentication" && event.action == "Failed") > 5 by src_ip within 5m
    tags: ["threshold"]
}
"#;
        let rule = DslParser::parse(input).unwrap();
        let compiled = RuleCompiler::compile(rule).unwrap();
        match &compiled.compiled_condition {
            CompiledCondition::Threshold {
                inner,
                window,
                group_by,
                threshold_count,
            } => {
                assert_eq!(*window, Duration::from_secs(300));
                assert_eq!(group_by.as_slice(), &["src_ip"]);
                assert_eq!(*threshold_count, 5);
                // Inner condition is the full compiled And of both field comparisons
                match inner.as_ref() {
                    CompiledCondition::LogicalAnd(v) => {
                        assert_eq!(v.len(), 2);
                    }
                    other => panic!("expected LogicalAnd inside Threshold, got {:?}", other),
                }
            }
            other => panic!("expected Threshold, got {:?}", other),
        }
    }

    #[test]
    fn compile_logical_operators() {
        let input = r#"
rule "Logical Rule" {
    description: "logical"
    severity: critical
    condition: (event.category == "authentication" && event.action == "Failed") || event.category == "network"
    tags: ["logical"]
}
"#;
        let rule = DslParser::parse(input).unwrap();
        let compiled = RuleCompiler::compile(rule).unwrap();
        match &compiled.compiled_condition {
            CompiledCondition::LogicalOr(v) => {
                assert_eq!(v.len(), 2);
                match &v[0] {
                    CompiledCondition::LogicalAnd(inner) => {
                        assert_eq!(inner.len(), 2);
                    }
                    other => panic!("expected LogicalAnd inside Or, got {:?}", other),
                }
            }
            other => panic!("expected LogicalOr, got {:?}", other),
        }
    }
}
