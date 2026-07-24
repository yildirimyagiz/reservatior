use std::time::Duration;

use security_os_core::Severity;

// ── Top-level rule ────────────────────────────────────────────────────────────
#[derive(Debug, Clone)]
pub struct DslRule {
    pub name: String,
    pub description: String,
    pub severity: Severity,
    pub mitre_tactic: Option<String>,
    pub mitre_technique: Option<String>,
    pub condition: DslCondition,
    pub window: Option<Duration>,
    pub group_by: Vec<String>,
    pub threshold: Option<Threshold>,
    pub enabled: bool,
    pub tags: Vec<String>,
    pub version: u32,
}

// ── Conditions ────────────────────────────────────────────────────────────────
#[derive(Debug, Clone)]
pub enum DslCondition {
    Field {
        field: String,
        op: FieldOperator,
        value: FieldValue,
    },
    And(Vec<DslCondition>),
    Or(Vec<DslCondition>),
    Not(Box<DslCondition>),
    Near {
        left: Box<DslCondition>,
        right: Box<DslCondition>,
        max_distance: u32,
    },
    Sequence {
        conditions: Vec<DslCondition>,
        within: Duration,
        group_by: Vec<String>,
    },
    Aggregate {
        inner: Box<DslCondition>,
        func: AggFunc,
        op: FieldOperator,
        threshold_value: FieldValue,
        window: Duration,
        group_by: Vec<String>,
    },
    Graph {
        nodes: Vec<GraphPattern>,
        edges: Vec<GraphEdge>,
    },
}

// ── Operators ─────────────────────────────────────────────────────────────────
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FieldOperator {
    Equals,
    Contains,
    StartsWith,
    EndsWith,
    Regex,
    Gt,
    Lt,
    Gte,
    Lte,
    In,
    NotIn,
}

// ── Values ────────────────────────────────────────────────────────────────────
#[derive(Debug, Clone, PartialEq)]
pub enum FieldValue {
    Str(String),
    Num(f64),
    Bool(bool),
    List(Vec<String>),
}

// ── Aggregation functions ─────────────────────────────────────────────────────
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AggFunc {
    Count,
    Sum,
    Avg,
    Min,
    Max,
    Unique,
}

// ── Threshold ─────────────────────────────────────────────────────────────────
#[derive(Debug, Clone)]
pub struct Threshold {
    pub count: u32,
    pub operator: FieldOperator,
}

// ── Graph patterns ────────────────────────────────────────────────────────────
#[derive(Debug, Clone)]
pub struct GraphPattern {
    pub id: String,
    pub entity_type: String,
    pub conditions: Vec<DslCondition>,
}

#[derive(Debug, Clone)]
pub struct GraphEdge {
    pub from: String,
    pub to: String,
    pub relationship: String,
}

// ── Tests ─────────────────────────────────────────────────────────────────────
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn condition_construction() {
        let cond = DslCondition::And(vec![
            DslCondition::Field {
                field: "event.category".into(),
                op: FieldOperator::Equals,
                value: FieldValue::Str("authentication".into()),
            },
            DslCondition::Field {
                field: "event.action".into(),
                op: FieldOperator::Equals,
                value: FieldValue::Str("Failed".into()),
            },
        ]);
        match cond {
            DslCondition::And(v) => assert_eq!(v.len(), 2),
            _ => panic!("expected And"),
        }
    }

    #[test]
    fn field_value_variants() {
        let s = FieldValue::Str("hello".into());
        let n = FieldValue::Num(42.0);
        let b = FieldValue::Bool(true);
        let l = FieldValue::List(vec!["a".into(), "b".into()]);
        assert_eq!(s, FieldValue::Str("hello".into()));
        assert_eq!(n, FieldValue::Num(42.0));
        assert_eq!(b, FieldValue::Bool(true));
        assert_eq!(l, FieldValue::List(vec!["a".into(), "b".into()]));
    }

    #[test]
    fn graph_pattern_construction() {
        let node = GraphPattern {
            id: "n1".into(),
            entity_type: "Host".into(),
            conditions: vec![DslCondition::Field {
                field: "cluster".into(),
                op: FieldOperator::Equals,
                value: FieldValue::Str("prod".into()),
            }],
        };
        let edge = GraphEdge {
            from: "n1".into(),
            to: "n2".into(),
            relationship: "connects_to".into(),
        };
        let graph = DslCondition::Graph {
            nodes: vec![node],
            edges: vec![edge],
        };
        match graph {
            DslCondition::Graph { nodes, edges } => {
                assert_eq!(nodes.len(), 1);
                assert_eq!(edges.len(), 1);
                assert_eq!(nodes[0].entity_type, "Host");
                assert_eq!(edges[0].relationship, "connects_to");
            }
            _ => panic!("expected Graph"),
        }
    }
}
