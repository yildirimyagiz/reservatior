use dashmap::DashMap;
use std::time::Duration;

use crate::playbook::{ExecutionStatus, PlaybookExecution};

pub struct ExecutionHistory {
    history: DashMap<String, PlaybookExecution>,
    max_entries: usize,
}

impl ExecutionHistory {
    pub fn new(max_entries: usize) -> Self {
        Self {
            history: DashMap::with_capacity(max_entries.min(1024)),
            max_entries,
        }
    }

    pub fn record(&self, execution: PlaybookExecution) {
        let id = execution.execution_id.clone();
        self.history.insert(id, execution);

        if self.history.len() > self.max_entries {
            let mut keys_to_remove: Vec<String> = self
                .history
                .iter()
                .filter(|e| e.status != ExecutionStatus::Running && e.status != ExecutionStatus::AwaitingApproval)
                .map(|e| {
                    (
                        e.execution_id.clone(),
                        e.started_at,
                    )
                })
                .collect::<Vec<_>>()
                .into_iter()
                .collect::<Vec<_>>()
                .iter()
                .map(|(id, _)| id.clone())
                .collect();

            keys_to_remove.truncate(self.history.len() - self.max_entries);
            for key in keys_to_remove {
                self.history.remove(&key);
            }
        }
    }

    pub fn get(&self, execution_id: &str) -> Option<PlaybookExecution> {
        self.history.get(execution_id).map(|e| e.value().clone())
    }

    pub fn by_playbook(&self, playbook_id: &str) -> Vec<PlaybookExecution> {
        self.history
            .iter()
            .filter(|e| e.playbook_id == playbook_id)
            .map(|e| e.value().clone())
            .collect()
    }

    pub fn recent(&self, limit: usize) -> Vec<PlaybookExecution> {
        let mut entries: Vec<PlaybookExecution> = self
            .history
            .iter()
            .map(|e| e.value().clone())
            .collect();

        entries.sort_by(|a, b| b.started_at.cmp(&a.started_at));
        entries.into_iter().take(limit).collect()
    }

    pub fn success_rate(&self, playbook_id: &str) -> f64 {
        let entries: Vec<PlaybookExecution> = self
            .history
            .iter()
            .filter(|e| e.playbook_id == playbook_id)
            .map(|e| e.value().clone())
            .collect();

        if entries.is_empty() {
            return 0.0;
        }

        let completed = entries
            .iter()
            .filter(|e| e.status == ExecutionStatus::Completed)
            .count();

        (completed as f64 / entries.len() as f64) * 100.0
    }

    pub fn avg_duration(&self, playbook_id: &str) -> Option<Duration> {
        let entries: Vec<PlaybookExecution> = self
            .history
            .iter()
            .filter(|e| {
                e.playbook_id == playbook_id
                    && e.status != ExecutionStatus::Running
                    && e.status != ExecutionStatus::AwaitingApproval
            })
            .map(|e| e.value().clone())
            .collect();

        if entries.is_empty() {
            return None;
        }

        let total_ms: u64 = entries.iter().map(|e| e.duration_ms()).sum();
        let avg_ms = total_ms / entries.len() as u64;
        Some(Duration::from_millis(avg_ms))
    }

    pub fn total_executions(&self) -> usize {
        self.history.len()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::playbook::{PlaybookExecution, StepResult, StepStatus};
    use chrono::Duration;

    fn make_execution(playbook_id: &str, status: ExecutionStatus) -> PlaybookExecution {
        let is_terminal = status != ExecutionStatus::Running && status != ExecutionStatus::AwaitingApproval;
        let mut exec = PlaybookExecution::new(playbook_id, None);
        exec.status = status;
        exec.step_results.push(StepResult {
            step_id: "step-1".to_string(),
            step_name: "Test Step".to_string(),
            status: StepStatus::Completed,
            output: Some("done".to_string()),
            error: None,
            started_at: exec.started_at,
            completed_at: Some(exec.started_at + Duration::seconds(5)),
            duration_ms: 5000,
        });
        if is_terminal {
            exec.completed_at = Some(exec.started_at + Duration::seconds(5));
        }
        exec
    }

    #[test]
    fn test_record_and_get() {
        let history = ExecutionHistory::new(100);
        let exec = make_execution("pb-1", ExecutionStatus::Completed);
        let id = exec.execution_id.clone();
        history.record(exec);
        let retrieved = history.get(&id).unwrap();
        assert_eq!(retrieved.status, ExecutionStatus::Completed);
        assert_eq!(retrieved.playbook_id, "pb-1");
    }

    #[test]
    fn test_by_playbook() {
        let history = ExecutionHistory::new(100);
        history.record(make_execution("pb-1", ExecutionStatus::Completed));
        history.record(make_execution("pb-1", ExecutionStatus::Failed));
        history.record(make_execution("pb-2", ExecutionStatus::Completed));
        let pb1_execs = history.by_playbook("pb-1");
        assert_eq!(pb1_execs.len(), 2);
    }

    #[test]
    fn test_success_rate() {
        let history = ExecutionHistory::new(100);
        history.record(make_execution("pb-1", ExecutionStatus::Completed));
        history.record(make_execution("pb-1", ExecutionStatus::Completed));
        history.record(make_execution("pb-1", ExecutionStatus::Failed));
        history.record(make_execution("pb-1", ExecutionStatus::Completed));
        let rate = history.success_rate("pb-1");
        assert!((rate - 75.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_recent() {
        let history = ExecutionHistory::new(100);
        for i in 0..5 {
            let mut exec = make_execution("pb-1", ExecutionStatus::Completed);
            exec.execution_id = format!("exec-{}", i);
            history.record(exec);
        }
        let recent = history.recent(3);
        assert_eq!(recent.len(), 3);
    }
}
