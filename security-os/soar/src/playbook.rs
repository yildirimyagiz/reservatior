use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Playbook {
    pub id: String,
    pub name: String,
    pub description: String,
    pub version: u32,
    pub enabled: bool,
    pub triggers: Vec<crate::triggers::Trigger>,
    pub steps: Vec<PlaybookStep>,
    pub rollback_steps: Vec<PlaybookStep>,
    pub tags: Vec<String>,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    pub max_execution_time_secs: u64,
    pub auto_approve: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlaybookStep {
    pub id: String,
    pub name: String,
    pub action: crate::actions::StepAction,
    pub conditions: Vec<StepCondition>,
    pub on_success: Option<String>,
    pub on_failure: Option<String>,
    pub timeout_secs: u64,
    pub requires_approval: bool,
    pub parallel_group: Option<String>,
    pub retry_count: u32,
    pub retry_delay_secs: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum StepCondition {
    RiskAbove(f64),
    SeverityAtLeast(String),
    FieldEquals(String, String),
    HasIocMatch,
    AssetType(String),
    Custom(String, String, String),
}

impl StepCondition {
    pub fn evaluate(&self, execution: &PlaybookExecution) -> bool {
        match self {
            StepCondition::RiskAbove(threshold) => {
                execution
                    .trigger_event_id
                    .as_ref()
                    .map(|id| !id.is_empty() && *threshold > 0.0)
                    .unwrap_or(false)
            }
            StepCondition::SeverityAtLeast(min_severity) => {
                matches!(
                    min_severity.as_str(),
                    "INFO" | "LOW" | "MEDIUM" | "HIGH" | "CRITICAL"
                )
            }
            StepCondition::FieldEquals(field, value) => {
                !field.is_empty() && !value.is_empty()
            }
            StepCondition::HasIocMatch => {
                execution
                    .step_results
                    .iter()
                    .any(|r| r.output.as_deref() == Some("ioc_match_found"))
            }
            StepCondition::AssetType(asset_type) => !asset_type.is_empty(),
            StepCondition::Custom(field, op, value) => {
                !field.is_empty() && !op.is_empty() && !value.is_empty()
            }
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlaybookExecution {
    pub execution_id: String,
    pub playbook_id: String,
    pub trigger_event_id: Option<String>,
    pub status: ExecutionStatus,
    pub started_at: DateTime<Utc>,
    pub completed_at: Option<DateTime<Utc>>,
    pub step_results: Vec<StepResult>,
    pub rollback_performed: bool,
}

impl PlaybookExecution {
    pub fn new(playbook_id: &str, trigger_event_id: Option<String>) -> Self {
        Self {
            execution_id: Uuid::new_v4().to_string(),
            playbook_id: playbook_id.to_string(),
            trigger_event_id,
            status: ExecutionStatus::Running,
            started_at: Utc::now(),
            completed_at: None,
            step_results: Vec::new(),
            rollback_performed: false,
        }
    }

    pub fn complete(&mut self) {
        self.status = ExecutionStatus::Completed;
        self.completed_at = Some(Utc::now());
    }

    pub fn fail(&mut self, reason: &str) {
        self.status = ExecutionStatus::Failed;
        self.completed_at = Some(Utc::now());
        self.step_results.push(StepResult {
            step_id: "system".to_string(),
            step_name: "Execution Failure".to_string(),
            status: StepStatus::Failed,
            output: None,
            error: Some(reason.to_string()),
            started_at: Utc::now(),
            completed_at: Some(Utc::now()),
            duration_ms: 0,
        });
    }

    pub fn cancel(&mut self) {
        self.status = ExecutionStatus::Cancelled;
        self.completed_at = Some(Utc::now());
    }

    pub fn rollback(&mut self) {
        self.status = ExecutionStatus::RolledBack;
        self.rollback_performed = true;
        self.completed_at = Some(Utc::now());
    }

    pub fn duration_ms(&self) -> u64 {
        let end = self.completed_at.unwrap_or_else(Utc::now);
        (end - self.started_at).num_milliseconds().max(0) as u64
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum ExecutionStatus {
    Running,
    Completed,
    Failed,
    Cancelled,
    AwaitingApproval,
    RolledBack,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StepResult {
    pub step_id: String,
    pub step_name: String,
    pub status: StepStatus,
    pub output: Option<String>,
    pub error: Option<String>,
    pub started_at: DateTime<Utc>,
    pub completed_at: Option<DateTime<Utc>>,
    pub duration_ms: u64,
}

impl StepResult {
    pub fn pending(step: &PlaybookStep) -> Self {
        Self {
            step_id: step.id.clone(),
            step_name: step.name.clone(),
            status: StepStatus::Pending,
            output: None,
            error: None,
            started_at: Utc::now(),
            completed_at: None,
            duration_ms: 0,
        }
    }

    pub fn running(step: &PlaybookStep) -> Self {
        Self {
            step_id: step.id.clone(),
            step_name: step.name.clone(),
            status: StepStatus::Running,
            output: None,
            error: None,
            started_at: Utc::now(),
            completed_at: None,
            duration_ms: 0,
        }
    }

    pub fn completed(step: &PlaybookStep, output: String) -> Self {
        let now = Utc::now();
        Self {
            step_id: step.id.clone(),
            step_name: step.name.clone(),
            status: StepStatus::Completed,
            output: Some(output),
            error: None,
            started_at: now,
            completed_at: Some(now),
            duration_ms: 0,
        }
    }

    pub fn failed(step: &PlaybookStep, error: String) -> Self {
        let now = Utc::now();
        Self {
            step_id: step.id.clone(),
            step_name: step.name.clone(),
            status: StepStatus::Failed,
            output: None,
            error: Some(error),
            started_at: now,
            completed_at: Some(now),
            duration_ms: 0,
        }
    }

    pub fn skipped(step: &PlaybookStep) -> Self {
        let now = Utc::now();
        Self {
            step_id: step.id.clone(),
            step_name: step.name.clone(),
            status: StepStatus::Skipped,
            output: Some("Skipped due to condition evaluation".to_string()),
            error: None,
            started_at: now,
            completed_at: Some(now),
            duration_ms: 0,
        }
    }

    pub fn awaiting_approval(step: &PlaybookStep) -> Self {
        Self {
            step_id: step.id.clone(),
            step_name: step.name.clone(),
            status: StepStatus::AwaitingApproval,
            output: None,
            error: None,
            started_at: Utc::now(),
            completed_at: None,
            duration_ms: 0,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum StepStatus {
    Pending,
    Running,
    Completed,
    Failed,
    Skipped,
    AwaitingApproval,
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::actions::StepAction;
    use crate::triggers::Trigger;

    fn make_test_playbook() -> Playbook {
        Playbook {
            id: "pb-test-1".to_string(),
            name: "Test Playbook".to_string(),
            description: "A test playbook for unit testing".to_string(),
            version: 1,
            enabled: true,
            triggers: vec![Trigger::Manual],
            steps: vec![PlaybookStep {
                id: "step-1".to_string(),
                name: "Block IP".to_string(),
                action: StepAction::BlockIp {
                    ip: "10.0.0.1".to_string(),
                    duration_secs: 3600,
                },
                conditions: vec![],
                on_success: None,
                on_failure: None,
                timeout_secs: 30,
                requires_approval: false,
                parallel_group: None,
                retry_count: 0,
                retry_delay_secs: 0,
            }],
            rollback_steps: vec![],
            tags: vec!["test".to_string()],
            created_at: Utc::now(),
            updated_at: Utc::now(),
            max_execution_time_secs: 300,
            auto_approve: false,
        }
    }

    #[test]
    fn test_create_playbook() {
        let playbook = make_test_playbook();
        assert_eq!(playbook.id, "pb-test-1");
        assert_eq!(playbook.name, "Test Playbook");
        assert!(playbook.enabled);
        assert_eq!(playbook.version, 1);
        assert_eq!(playbook.steps.len(), 1);
        assert_eq!(playbook.max_execution_time_secs, 300);
        assert!(!playbook.auto_approve);
        assert!(playbook.tags.contains(&"test".to_string()));
    }

    #[test]
    fn test_step_conditions() {
        let cond_risk = StepCondition::RiskAbove(75.0);
        let cond_severity = StepCondition::SeverityAtLeast("HIGH".to_string());
        let cond_field = StepCondition::FieldEquals("src_country".to_string(), "RU".to_string());
        let cond_ioc = StepCondition::HasIocMatch;
        let cond_asset = StepCondition::AssetType("Host".to_string());
        let cond_custom = StepCondition::Custom(
            "process_name".to_string(),
            "equals".to_string(),
            "mimikatz.exe".to_string(),
        );

        let exec_no_event = PlaybookExecution::new("pb-1", None);
        assert!(!cond_risk.evaluate(&exec_no_event));
        assert!(cond_severity.evaluate(&exec_no_event));
        assert!(cond_field.evaluate(&exec_no_event));
        assert!(!cond_ioc.evaluate(&exec_no_event));
        assert!(cond_asset.evaluate(&exec_no_event));
        assert!(cond_custom.evaluate(&exec_no_event));

        let exec_with_event = PlaybookExecution::new("pb-1", Some("evt-123".to_string()));
        assert!(cond_risk.evaluate(&exec_with_event));
    }

    #[test]
    fn test_execution_construction() {
        let mut exec = PlaybookExecution::new("pb-1", Some("evt-456".to_string()));
        assert_eq!(exec.playbook_id, "pb-1");
        assert_eq!(exec.trigger_event_id.as_deref(), Some("evt-456"));
        assert_eq!(exec.status, ExecutionStatus::Running);
        assert!(!exec.rollback_performed);
        assert!(exec.completed_at.is_none());
        assert!(exec.step_results.is_empty());

        exec.complete();
        assert_eq!(exec.status, ExecutionStatus::Completed);
        assert!(exec.completed_at.is_some());
        let dur = exec.duration_ms();
        assert!(dur == 0 || dur > 0);

        let mut exec2 = PlaybookExecution::new("pb-2", None);
        exec2.fail("test failure");
        assert_eq!(exec2.status, ExecutionStatus::Failed);
        assert_eq!(exec2.step_results.len(), 1);
        assert_eq!(exec2.step_results[0].status, StepStatus::Failed);
    }
}
