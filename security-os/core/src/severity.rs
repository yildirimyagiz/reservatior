use serde::{Deserialize, Serialize};
use std::fmt;

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub enum Severity {
    Informational,
    Low,
    Medium,
    High,
    Critical,
}

impl Severity {
    pub fn numeric(&self) -> u8 {
        match self {
            Self::Informational => 0,
            Self::Low => 1,
            Self::Medium => 2,
            Self::High => 3,
            Self::Critical => 4,
        }
    }

    pub fn risk_weight(&self) -> f64 {
        match self {
            Self::Informational => 0.1,
            Self::Low => 0.3,
            Self::Medium => 0.6,
            Self::High => 0.85,
            Self::Critical => 1.0,
        }
    }
}

impl fmt::Display for Severity {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Informational => write!(f, "INFO"),
            Self::Low => write!(f, "LOW"),
            Self::Medium => write!(f, "MEDIUM"),
            Self::High => write!(f, "HIGH"),
            Self::Critical => write!(f, "CRITICAL"),
        }
    }
}

impl From<u8> for Severity {
    fn from(v: u8) -> Self {
        match v {
            0 => Self::Informational,
            1 => Self::Low,
            2 => Self::Medium,
            3 => Self::High,
            _ => Self::Critical,
        }
    }
}
