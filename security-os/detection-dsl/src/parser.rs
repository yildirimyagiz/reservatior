use std::time::Duration;

use security_os_core::Severity;

use crate::ast::*;
use crate::errors::DslError;

pub struct DslParser;

impl DslParser {
    pub fn parse(input: &str) -> Result<DslRule, DslError> {
        let mut p = ParserState::new(input);
        p.parse_rule()
    }
}

struct ParserState<'a> {
    input: &'a str,
    pos: usize,
}

impl<'a> ParserState<'a> {
    fn new(input: &'a str) -> Self {
        Self { input, pos: 0 }
    }

    fn remaining(&self) -> &'a str {
        &self.input[self.pos..]
    }

    fn at_end(&self) -> bool {
        self.pos >= self.input.len()
    }

    fn error(&self, msg: impl Into<String>) -> DslError {
        DslError::ParseError {
            position: self.pos,
            message: msg.into(),
        }
    }

    fn skip_whitespace(&mut self) {
        while self.pos < self.input.len() {
            match self.input.as_bytes()[self.pos] {
                b' ' | b'\t' | b'\r' | b'\n' => self.pos += 1,
                _ => break,
            }
        }
    }

    fn skip_line_whitespace(&mut self) {
        while self.pos < self.input.len() {
            match self.input.as_bytes()[self.pos] {
                b' ' | b'\t' => self.pos += 1,
                _ => break,
            }
        }
    }

    fn peek_char_no_skip(&self) -> Option<char> {
        self.remaining().chars().next()
    }

    fn consume_char(&mut self) -> Option<char> {
        let c = self.remaining().chars().next()?;
        self.pos += c.len_utf8();
        Some(c)
    }

    fn expect_char(&mut self, expected: char) -> Result<(), DslError> {
        self.skip_whitespace();
        match self.consume_char() {
            Some(c) if c == expected => Ok(()),
            other => Err(DslError::ParseError {
                position: self.pos.saturating_sub(1),
                message: format!("expected '{}', got {:?}", expected, other),
            }),
        }
    }

    fn consume_while(&mut self, predicate: impl Fn(char) -> bool) -> String {
        let start = self.pos;
        while self.pos < self.input.len() {
            let c = self.input[self.pos..].chars().next().unwrap();
            if predicate(c) {
                self.pos += c.len_utf8();
            } else {
                break;
            }
        }
        self.input[start..self.pos].to_string()
    }

    fn consume_quoted(&mut self) -> Result<String, DslError> {
        self.skip_whitespace();
        let q = self
            .consume_char()
            .ok_or_else(|| self.error("unexpected end of input, expected quote"))?;
        if q != '"' && q != '\'' {
            return Err(DslError::ParseError {
                position: self.pos.saturating_sub(1),
                message: format!("expected quote, got '{}'", q),
            });
        }
        let start = self.pos;
        while self.pos < self.input.len() {
            let c = self.input[self.pos..].chars().next().unwrap();
            if c == q {
                let val = self.input[start..self.pos].to_string();
                self.pos += c.len_utf8();
                return Ok(val);
            }
            if c == '\\' {
                self.pos += c.len_utf8();
                if self.pos < self.input.len() {
                    let next = self.input[self.pos..].chars().next().unwrap();
                    self.pos += next.len_utf8();
                }
            } else {
                self.pos += c.len_utf8();
            }
        }
        Err(self.error("unterminated string"))
    }

    fn consume_word(&mut self) -> String {
        self.skip_whitespace();
        let start = self.pos;
        while self.pos < self.input.len() {
            let c = self.input[self.pos..].chars().next().unwrap();
            if c.is_alphanumeric() || c == '_' || c == '.' || c == '-' {
                self.pos += c.len_utf8();
            } else {
                break;
            }
        }
        self.input[start..self.pos].to_string()
    }

    fn expect_word(&mut self, expected: &str) -> Result<(), DslError> {
        self.skip_whitespace();
        let start = self.pos;
        let word = self.consume_word();
        if word == expected {
            Ok(())
        } else {
            self.pos = start;
            Err(self.error(format!("expected '{}', got '{}'", expected, word)))
        }
    }

    fn consume_line(&mut self) -> String {
        self.skip_line_whitespace();
        let start = self.pos;
        while self.pos < self.input.len() {
            let c = self.input.as_bytes()[self.pos];
            if c == b'\n' {
                break;
            }
            self.pos += 1;
        }
        self.input[start..self.pos].trim().to_string()
    }

    // ── Rule parsing ─────────────────────────────────────────────────────
    fn parse_rule(&mut self) -> Result<DslRule, DslError> {
        self.expect_word("rule")?;
        let name = self.consume_quoted()?;
        self.skip_whitespace();
        self.expect_char('{')?;

        let mut description = String::new();
        let mut severity = Severity::Informational;
        let mut mitre_tactic = None;
        let mut mitre_technique = None;
        let mut condition = None;
        let mut window = None;
        let mut group_by = Vec::new();
        let mut threshold = None;
        let mut enabled = true;
        let mut tags = Vec::new();
        let mut version = 1;

        loop {
            self.skip_whitespace();
            if self.peek_char_no_skip() == Some('}') {
                self.pos += 1;
                break;
            }
            if self.at_end() {
                return Err(self.error("unexpected end of input, expected '}'"));
            }

            // Read the key
            let key = self.consume_word();
            if key.is_empty() {
                return Err(self.error("expected field name or '}'"));
            }

            self.skip_line_whitespace();
            self.expect_char(':')?;

            match key.to_lowercase().as_str() {
                "description" => {
                    description = self.consume_quoted()?;
                }
                "severity" => {
                    self.skip_line_whitespace();
                    let s = self.consume_word();
                    severity = parse_severity(&s)?;
                }
                "mitre" => {
                    let raw = self.consume_line();
                    let (tactic, technique) = parse_mitre_raw(&raw);
                    mitre_tactic = tactic;
                    mitre_technique = technique;
                }
                "condition" => {
                    // Read the entire rest of the line as the condition expression
                    self.skip_line_whitespace();
                    let raw = self.consume_line();
                    condition = Some(parse_condition_expr(&raw)?);
                }
                "window" => {
                    self.skip_line_whitespace();
                    let raw = self.consume_word();
                    window = Some(parse_duration_str(&raw)?);
                }
                "group_by" => {
                    self.expect_char('[')?;
                    group_by = self.parse_string_list()?;
                    self.expect_char(']')?;
                }
                "threshold" => {
                    self.skip_line_whitespace();
                    let count_str = self.consume_while(|c| c.is_ascii_digit());
                    let count: u32 = count_str
                        .parse()
                        .map_err(|_| self.error("invalid threshold count"))?;
                    self.skip_line_whitespace();
                    let op_str = self.consume_word();
                    let op = parse_field_op(&op_str)?;
                    threshold = Some(Threshold { count, operator: op });
                }
                "enabled" => {
                    self.skip_line_whitespace();
                    let val = self.consume_word();
                    enabled = val == "true";
                }
                "tags" => {
                    self.expect_char('[')?;
                    tags = self.parse_string_list()?;
                    self.expect_char(']')?;
                }
                "version" => {
                    self.skip_line_whitespace();
                    let v = self.consume_while(|c| c.is_ascii_digit());
                    version = v
                        .parse()
                        .map_err(|_| self.error("invalid version number"))?;
                }
                other => {
                    return Err(self.error(format!("unknown field '{}'", other)));
                }
            }
        }

        let condition = condition.ok_or_else(|| self.error("missing 'condition' field"))?;

        Ok(DslRule {
            name,
            description,
            severity,
            mitre_tactic,
            mitre_technique,
            condition,
            window,
            group_by,
            threshold,
            enabled,
            tags,
            version,
        })
    }

    // ── String list ──────────────────────────────────────────────────────
    fn parse_string_list(&mut self) -> Result<Vec<String>, DslError> {
        let mut items = Vec::new();
        loop {
            self.skip_whitespace();
            if self.peek_char_no_skip() == Some(']') || self.at_end() {
                break;
            }
            let s = self.consume_quoted()?;
            items.push(s);
            self.skip_whitespace();
            if self.peek_char_no_skip() == Some(',') {
                self.pos += 1;
            }
        }
        Ok(items)
    }
}

// ── Condition expression parser (separate from rule parser) ───────────────────
// Parses a condition expression string like:
//   event.category == "authentication" && event.action == "Failed"

struct ConditionParser<'a> {
    input: &'a str,
    pos: usize,
}

impl<'a> ConditionParser<'a> {
    fn new(input: &'a str) -> Self {
        Self { input, pos: 0 }
    }

    fn remaining(&self) -> &'a str {
        &self.input[self.pos..]
    }

    fn at_end(&self) -> bool {
        self.pos >= self.input.len()
    }

    fn error(&self, msg: impl Into<String>) -> DslError {
        DslError::ParseError {
            position: self.pos,
            message: msg.into(),
        }
    }

    fn skip_whitespace(&mut self) {
        while self.pos < self.input.len() {
            match self.input.as_bytes()[self.pos] {
                b' ' | b'\t' | b'\r' => self.pos += 1,
                _ => break,
            }
        }
    }

    fn consume_char(&mut self) -> Option<char> {
        self.skip_whitespace();
        let c = self.remaining().chars().next()?;
        self.pos += c.len_utf8();
        Some(c)
    }

    fn consume_while(&mut self, predicate: impl Fn(char) -> bool) -> String {
        let start = self.pos;
        while self.pos < self.input.len() {
            let c = self.input[self.pos..].chars().next().unwrap();
            if predicate(c) {
                self.pos += c.len_utf8();
            } else {
                break;
            }
        }
        self.input[start..self.pos].to_string()
    }

    fn consume_word(&mut self) -> String {
        self.skip_whitespace();
        let start = self.pos;
        while self.pos < self.input.len() {
            let c = self.input[self.pos..].chars().next().unwrap();
            if c.is_alphanumeric() || c == '_' || c == '.' || c == '-' {
                self.pos += c.len_utf8();
            } else {
                break;
            }
        }
        self.input[start..self.pos].to_string()
    }

    fn consume_quoted(&mut self) -> Result<String, DslError> {
        self.skip_whitespace();
        let q = self
            .consume_char()
            .ok_or_else(|| self.error("expected quote"))?;
        if q != '"' && q != '\'' {
            return Err(DslError::ParseError {
                position: self.pos.saturating_sub(1),
                message: format!("expected quote, got '{}'", q),
            });
        }
        let start = self.pos;
        while self.pos < self.input.len() {
            let c = self.input[self.pos..].chars().next().unwrap();
            if c == q {
                let val = self.input[start..self.pos].to_string();
                self.pos += c.len_utf8();
                return Ok(val);
            }
            if c == '\\' {
                self.pos += c.len_utf8();
                if self.pos < self.input.len() {
                    let next = self.input[self.pos..].chars().next().unwrap();
                    self.pos += next.len_utf8();
                }
            } else {
                self.pos += c.len_utf8();
            }
        }
        Err(self.error("unterminated string"))
    }

    // ── Precedence climbing ──────────────────────────────────────────────
    // Lowest:  || (or)
    // Middle:  && (and)
    // High:    ! (not)
    // Highest: primary (field op value, parens, sequence, aggregate)

    fn parse_or(&mut self) -> Result<DslCondition, DslError> {
        let mut left = self.parse_and()?;
        loop {
            self.skip_whitespace();
            if self.remaining().starts_with("||") {
                self.pos += 2;
                let right = self.parse_and()?;
                match &mut left {
                    DslCondition::Or(v) => v.push(right),
                    _ => left = DslCondition::Or(vec![left, right]),
                }
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_and(&mut self) -> Result<DslCondition, DslError> {
        let mut left = self.parse_not()?;
        loop {
            self.skip_whitespace();
            if self.remaining().starts_with("&&") {
                self.pos += 2;
                let right = self.parse_not()?;
                match &mut left {
                    DslCondition::And(v) => v.push(right),
                    _ => left = DslCondition::And(vec![left, right]),
                }
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_not(&mut self) -> Result<DslCondition, DslError> {
        self.skip_whitespace();
        if self.remaining().starts_with('!') && !self.remaining().starts_with("!=") {
            self.pos += 1;
            let inner = self.parse_not()?;
            return Ok(DslCondition::Not(Box::new(inner)));
        }
        self.parse_primary()
    }

    fn parse_primary(&mut self) -> Result<DslCondition, DslError> {
        self.skip_whitespace();

        // Parenthesized
        if self.remaining().starts_with('(') {
            self.pos += 1;
            let inner = self.parse_or()?;
            self.skip_whitespace();
            if self.remaining().starts_with(')') {
                self.pos += 1;
            }
            return Ok(inner);
        }

        // Sequence keyword
        if self.remaining().starts_with("sequence") {
            return self.parse_sequence();
        }

        // Aggregate keywords
        let word_peek = self.consume_word();
        if !word_peek.is_empty() {
            self.pos -= word_peek.len();
            match word_peek.as_str() {
                "count" | "sum" | "avg" | "min" | "max" | "unique" => {
                    return self.parse_aggregate();
                }
                _ => {}
            }
        }

        // Field comparison: field op value
        self.parse_field_condition()
    }

    fn parse_field_condition(&mut self) -> Result<DslCondition, DslError> {
        let field = self.consume_word();
        if field.is_empty() {
            return Err(self.error("expected field name"));
        }
        let op = self.parse_operator()?;
        let value = self.parse_value()?;
        Ok(DslCondition::Field { field, op, value })
    }

    fn parse_operator(&mut self) -> Result<FieldOperator, DslError> {
        self.skip_whitespace();
        let rest = self.remaining();

        // Two-char symbol operators
        if rest.starts_with(">=") {
            self.pos += 2;
            return Ok(FieldOperator::Gte);
        }
        if rest.starts_with("<=") {
            self.pos += 2;
            return Ok(FieldOperator::Lte);
        }
        if rest.starts_with("==") {
            self.pos += 2;
            return Ok(FieldOperator::Equals);
        }
        if rest.starts_with("!=") {
            self.pos += 2;
            return Ok(FieldOperator::NotIn);
        }

        // Word-based operators
        let word_start = self.pos;
        let word = self.consume_word();
        if !word.is_empty() {
            match word.as_str() {
                "contains" | "has" => return Ok(FieldOperator::Contains),
                "startswith" | "starts_with" => return Ok(FieldOperator::StartsWith),
                "endswith" | "ends_with" => return Ok(FieldOperator::EndsWith),
                "regex" | "matches" => return Ok(FieldOperator::Regex),
                "in" => return Ok(FieldOperator::In),
                "not_in" | "notin" => return Ok(FieldOperator::NotIn),
                _ => {
                    // Not a word operator, rewind and try single-char
                    self.pos = word_start;
                }
            }
        }

        // Single-char operators
        let c = self
            .consume_char()
            .ok_or_else(|| self.error("expected operator"))?;
        match c {
            '=' => Ok(FieldOperator::Equals),
            '>' => Ok(FieldOperator::Gt),
            '<' => Ok(FieldOperator::Lt),
            _ => Err(self.error(format!("unexpected operator char '{}'", c))),
        }
    }

    fn parse_value(&mut self) -> Result<FieldValue, DslError> {
        self.skip_whitespace();
        let rest = self.remaining();

        // Quoted string
        if rest.starts_with('"') || rest.starts_with('\'') {
            let s = self.consume_quoted()?;
            return Ok(FieldValue::Str(s));
        }

        // Boolean keywords before number parsing
        if rest.starts_with("true") {
            let word = self.consume_while(|c| c.is_alphabetic());
            if word == "true" {
                return Ok(FieldValue::Bool(true));
            }
        }
        if rest.starts_with("false") {
            let word = self.consume_while(|c| c.is_alphabetic());
            if word == "false" {
                return Ok(FieldValue::Bool(false));
            }
        }

        // Number (digits, optional dot, optional negative)
        if rest.starts_with('-') || rest.starts_with(|c: char| c.is_ascii_digit()) {
            let start = self.pos;
            if rest.starts_with('-') {
                self.pos += 1;
            }
            let num_str = self.consume_while(|c| c.is_ascii_digit() || c == '.');
            if !num_str.is_empty() {
                if let Ok(n) = num_str.parse::<f64>() {
                    return Ok(FieldValue::Num(n));
                }
            }
            self.pos = start;
        }

        // Bare word as string
        let word = self.consume_while(|c| c.is_alphanumeric() || c == '_' || c == '.' || c == '-');
        if !word.is_empty() {
            return Ok(FieldValue::Str(word));
        }

        Err(self.error("expected value"))
    }

    // ── Aggregate ────────────────────────────────────────────────────────
    fn parse_aggregate(&mut self) -> Result<DslCondition, DslError> {
        let func_word = self.consume_while(|c| c.is_alphabetic());
        let func = match func_word.as_str() {
            "count" => AggFunc::Count,
            "sum" => AggFunc::Sum,
            "avg" => AggFunc::Avg,
            "min" => AggFunc::Min,
            "max" => AggFunc::Max,
            "unique" => AggFunc::Unique,
            _ => return Err(self.error(format!("unknown aggregate '{}'", func_word))),
        };

        self.skip_whitespace();
        if !self.remaining().starts_with('(') {
            return Err(self.error("expected '(' after aggregate function"));
        }
        self.pos += 1;

        // Parse the condition inside the parentheses
        let inner_cond = self.parse_or()?;

        self.skip_whitespace();
        if !self.remaining().starts_with(')') {
            return Err(self.error("expected ')'"));
        }
        self.pos += 1;

        // Parse operator and value after the aggregate
        let op = self.parse_operator()?;
        let value = self.parse_value()?;

        // Parse optional "by field within Nm"
        let mut group_by = Vec::new();
        let mut window = Duration::from_secs(300);

        self.skip_whitespace();
        let rest = self.remaining();
        if rest.starts_with("by") {
            self.pos += 2;
            let grp = self.consume_word();
            if !grp.is_empty() {
                group_by.push(grp);
            }

            self.skip_whitespace();
            let rest2 = self.remaining();
            if rest2.starts_with("within") {
                self.pos += 6;
                let dur = self.consume_word();
                window = parse_duration_str(&dur)?;
            }
        } else if rest.starts_with("within") {
            self.pos += 6;
            let dur = self.consume_word();
            window = parse_duration_str(&dur)?;
        }

        Ok(DslCondition::Aggregate {
            inner: Box::new(inner_cond),
            func,
            op,
            threshold_value: value,
            window,
            group_by,
        })
    }

    // ── Sequence ─────────────────────────────────────────────────────────
    fn parse_sequence(&mut self) -> Result<DslCondition, DslError> {
        let _kw = self.consume_word(); // "sequence"
        self.skip_whitespace();
        if !self.remaining().starts_with('{') {
            return Err(self.error("expected '{' after sequence"));
        }
        self.pos += 1;

        let mut conditions = Vec::new();
        loop {
            self.skip_whitespace();
            if self.remaining().starts_with('}') {
                self.pos += 1;
                break;
            }
            if self.at_end() {
                return Err(self.error("unterminated sequence"));
            }
            let inner = self.parse_or()?;
            conditions.push(inner);
            self.skip_whitespace();
            if self.remaining().starts_with(',') {
                self.pos += 1;
            }
        }

        let mut within = Duration::from_secs(300);
        let mut group_by = Vec::new();

        self.skip_whitespace();
        let rest = self.remaining();
        if rest.starts_with("within") {
            self.pos += 6;
            let dur = self.consume_word();
            within = parse_duration_str(&dur)?;
        }

        self.skip_whitespace();
        let rest2 = self.remaining();
        if rest2.starts_with("by") {
            self.pos += 2;
            loop {
                self.skip_whitespace();
                if self.at_end() || self.remaining().starts_with(|c: char| !c.is_alphanumeric() && c != '_') {
                    break;
                }
                let grp = self.consume_word();
                if grp.is_empty() {
                    break;
                }
                group_by.push(grp);
                self.skip_whitespace();
                if !self.remaining().starts_with(',') {
                    break;
                }
                self.pos += 1;
            }
        }

        Ok(DslCondition::Sequence {
            conditions,
            within,
            group_by,
        })
    }
}

/// Parse a condition expression string (used from the rule parser).
fn parse_condition_expr(input: &str) -> Result<DslCondition, DslError> {
    let mut p = ConditionParser::new(input);
    let cond = p.parse_or()?;
    Ok(cond)
}

// ── Shared utilities ──────────────────────────────────────────────────────────

pub(crate) fn parse_duration_str(s: &str) -> Result<Duration, DslError> {
    let s = s.trim();
    if s.is_empty() {
        return Err(DslError::ParseError {
            position: 0,
            message: "empty duration".into(),
        });
    }
    let (num_str, unit) = s.split_at(s.len() - 1);
    let num: u64 = num_str.parse().map_err(|_| DslError::ParseError {
        position: 0,
        message: format!("invalid duration number '{}'", num_str),
    })?;
    match unit {
        "s" | "S" => Ok(Duration::from_secs(num)),
        "m" | "M" => Ok(Duration::from_secs(num * 60)),
        "h" | "H" => Ok(Duration::from_secs(num * 3600)),
        "d" | "D" => Ok(Duration::from_secs(num * 86400)),
        _ => Err(DslError::ParseError {
            position: 0,
            message: format!("unknown duration unit '{}'", unit),
        }),
    }
}

fn parse_severity(s: &str) -> Result<Severity, DslError> {
    match s.to_lowercase().as_str() {
        "info" | "informational" => Ok(Severity::Informational),
        "low" => Ok(Severity::Low),
        "medium" | "med" => Ok(Severity::Medium),
        "high" => Ok(Severity::High),
        "critical" | "crit" => Ok(Severity::Critical),
        _ => Err(DslError::ParseError {
            position: 0,
            message: format!("unknown severity '{}'", s),
        }),
    }
}

fn parse_mitre_raw(raw: &str) -> (Option<String>, Option<String>) {
    let raw = raw.trim();
    if raw.is_empty() {
        return (None, None);
    }
    if let Some(dash_pos) = raw.find(" - ") {
        let tactics_part = &raw[..dash_pos];
        let techniques_part = &raw[dash_pos + 3..];
        let tactic = tactics_part.split('/').next().map(|s| s.trim().to_string());
        let technique = techniques_part.split('/').next().map(|s| s.trim().to_string());
        (tactic, technique)
    } else {
        (Some(raw.to_string()), None)
    }
}

fn parse_field_op(s: &str) -> Result<FieldOperator, DslError> {
    match s {
        "==" | "=" | "eq" => Ok(FieldOperator::Equals),
        "contains" | "has" => Ok(FieldOperator::Contains),
        "startswith" | "starts_with" => Ok(FieldOperator::StartsWith),
        "endswith" | "ends_with" => Ok(FieldOperator::EndsWith),
        "regex" | "matches" => Ok(FieldOperator::Regex),
        ">" | "gt" => Ok(FieldOperator::Gt),
        "<" | "lt" => Ok(FieldOperator::Lt),
        ">=" | "gte" => Ok(FieldOperator::Gte),
        "<=" | "lte" => Ok(FieldOperator::Lte),
        "in" => Ok(FieldOperator::In),
        "not_in" | "notin" => Ok(FieldOperator::NotIn),
        _ => Err(DslError::ParseError {
            position: 0,
            message: format!("unknown operator '{}'", s),
        }),
    }
}

// ── Tests ─────────────────────────────────────────────────────────────────────
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_simple_rule() {
        let input = r#"
rule "Brute Force Login" {
    description: "Detect brute force authentication attempts"
    severity: high
    condition: event.category == "authentication" && event.action == "Failed"
    tags: ["brute-force", "auth"]
}
"#;
        let rule = DslParser::parse(input).unwrap();
        assert_eq!(rule.name, "Brute Force Login");
        assert_eq!(rule.description, "Detect brute force authentication attempts");
        assert_eq!(rule.severity, Severity::High);
        assert!(rule.enabled);
        assert_eq!(rule.tags, vec!["brute-force", "auth"]);
    }

    #[test]
    fn parse_condition_and_or() {
        let input = r#"
rule "Test Rule" {
    description: "test"
    severity: medium
    condition: event.category == "authentication" && event.action == "Failed" || event.action == "Blocked"
    tags: ["test"]
}
"#;
        let rule = DslParser::parse(input).unwrap();
        match rule.condition {
            DslCondition::Or(_) => {}
            _ => panic!("expected Or at top level"),
        }
    }

    #[test]
    fn parse_severity_levels() {
        for (input, expected) in [
            ("info", Severity::Informational),
            ("low", Severity::Low),
            ("medium", Severity::Medium),
            ("high", Severity::High),
            ("critical", Severity::Critical),
        ] {
            assert_eq!(parse_severity(input).unwrap(), expected);
        }
    }

    #[test]
    fn parse_duration_variants() {
        assert_eq!(parse_duration_str("5s").unwrap(), Duration::from_secs(5));
        assert_eq!(parse_duration_str("5m").unwrap(), Duration::from_secs(300));
        assert_eq!(parse_duration_str("2h").unwrap(), Duration::from_secs(7200));
        assert_eq!(parse_duration_str("1d").unwrap(), Duration::from_secs(86400));
    }

    #[test]
    fn parse_all_operators() {
        assert_eq!(parse_field_op("==").unwrap(), FieldOperator::Equals);
        assert_eq!(parse_field_op("contains").unwrap(), FieldOperator::Contains);
        assert_eq!(parse_field_op("startswith").unwrap(), FieldOperator::StartsWith);
        assert_eq!(parse_field_op("endswith").unwrap(), FieldOperator::EndsWith);
        assert_eq!(parse_field_op("regex").unwrap(), FieldOperator::Regex);
        assert_eq!(parse_field_op(">").unwrap(), FieldOperator::Gt);
        assert_eq!(parse_field_op("<").unwrap(), FieldOperator::Lt);
        assert_eq!(parse_field_op(">=").unwrap(), FieldOperator::Gte);
        assert_eq!(parse_field_op("<=").unwrap(), FieldOperator::Lte);
        assert_eq!(parse_field_op("in").unwrap(), FieldOperator::In);
        assert_eq!(parse_field_op("not_in").unwrap(), FieldOperator::NotIn);
    }

    #[test]
    fn parse_aggregation() {
        let input = r#"
rule "Count Rule" {
    description: "aggregation test"
    severity: high
    condition: count(event.category == "authentication" && event.action == "Failed") > 5 by src_ip within 5m
    tags: ["agg"]
}
"#;
        let rule = DslParser::parse(input).unwrap();
        match &rule.condition {
            DslCondition::Aggregate {
                inner,
                func,
                window,
                group_by,
                ..
            } => {
                assert_eq!(*func, AggFunc::Count);
                assert_eq!(*window, Duration::from_secs(300));
                assert_eq!(group_by.as_slice(), &["src_ip"]);
                // Inner condition is the full And of both field comparisons
                match inner.as_ref() {
                    DslCondition::And(v) => {
                        assert_eq!(v.len(), 2);
                    }
                    other => panic!("expected And inside Aggregate, got {:?}", other),
                }
            }
            other => panic!("expected Aggregate, got {:?}", other),
        }
    }

    #[test]
    fn parse_sequence() {
        let input = r#"
rule "Sequence Rule" {
    description: "sequence test"
    severity: critical
    condition: sequence { event.category == "authentication", event.category == "process" } within 5m by src_ip
    tags: ["seq"]
}
"#;
        let rule = DslParser::parse(input).unwrap();
        match &rule.condition {
            DslCondition::Sequence {
                conditions,
                within,
                group_by,
            } => {
                assert_eq!(conditions.len(), 2);
                assert_eq!(*within, Duration::from_secs(300));
                assert_eq!(group_by.as_slice(), &["src_ip"]);
            }
            other => panic!("expected Sequence, got {:?}", other),
        }
    }

    #[test]
    fn parse_error_invalid_severity() {
        let input = r#"
rule "Bad Rule" {
    description: "bad"
    severity: bogus
    condition: event.category == "auth"
    tags: ["bad"]
}
"#;
        let err = DslParser::parse(input).unwrap_err();
        match err {
            DslError::ParseError { message, .. } => {
                assert!(message.contains("unknown severity"));
            }
            other => panic!("unexpected error: {}", other),
        }
    }
}
