use std::sync::Arc;

use chrono::Utc;
use dashmap::DashMap;

use crate::actions::{execute_action, ActionResult};
use crate::approval::ApprovalManager;
use crate::errors::SoarError;
use crate::history::ExecutionHistory;
use crate::playbook::*;
use crate::triggers::{TriggerContext, matches_trigger};

pub struct PlaybookExecutor {
    playbooks: DashMap<String, Playbook>,
    executions: DashMap<String, PlaybookExecution>,
    approval_manager: Arc<ApprovalManager>,
    history: Arc<ExecutionHistory>,
}

impl PlaybookExecutor {
    pub fn new() -> Self {
        Self {
            playbooks: DashMap::new(),
            executions: DashMap::new(),
            approval_manager: Arc::new(ApprovalManager::new()),
            history: Arc::new(ExecutionHistory::new(10_000)),
        }
    }

    pub fn register_playbook(&self, playbook: Playbook) {
        tracing::info!(
            playbook_id = %playbook.id,
            name = %playbook.name,
            steps = playbook.steps.len(),
            "Registering playbook"
        );
        self.playbooks.insert(playbook.id.clone(), playbook);
    }

    pub fn remove_playbook(&self, playbook_id: &str) -> bool {
        self.playbooks.remove(playbook_id).is_some()
    }

    pub async fn trigger_playbook(
        &self,
        playbook_id: &str,
        context: TriggerContext,
    ) -> Result<String, SoarError> {
        let playbook = self
            .playbooks
            .get(playbook_id)
            .ok_or_else(|| SoarError::PlaybookNotFound(playbook_id.to_string()))?
            .clone();

        if !playbook.enabled {
            return Err(SoarError::InvalidPlaybook(format!(
                "Playbook '{}' is disabled",
                playbook.name
            )));
        }

        let trigger_match = playbook.triggers.iter().any(|t| matches_trigger(t, &context));
        if !trigger_match && context.trigger_type != "manual" {
            return Err(SoarError::ExecutionFailed(format!(
                "No trigger matched for playbook '{}'",
                playbook.name
            )));
        }

        let trigger_event_id = context
            .event
            .as_ref()
            .map(|e| e.id.to_string());

        let execution = PlaybookExecution::new(playbook_id, trigger_event_id);
        let execution_id = execution.execution_id.clone();

        tracing::info!(
            execution_id = %execution_id,
            playbook_id = %playbook_id,
            playbook_name = %playbook.name,
            "Playbook execution started"
        );

        self.executions
            .insert(execution_id.clone(), execution.clone());

        let steps = playbook.steps.clone();
        let mut current_step_index = 0;
        let mut execution = self.executions.get(&execution_id).unwrap().clone();

        while current_step_index < steps.len() {
            let step = &steps[current_step_index];

            if Self::should_skip_step(step, &execution) {
                let result = StepResult::skipped(step);
                execution.step_results.push(result);
                current_step_index += 1;
                self.executions.insert(execution_id.clone(), execution.clone());
                continue;
            }

            if step.requires_approval && !playbook.auto_approve {
                let request = ApprovalManager::create_request(
                    &execution_id,
                    &step.id,
                    &playbook.name,
                    &step.name,
                    &step.action.description(),
                    step.timeout_secs,
                );
                let _ = self.approval_manager.request_approval(request);

                execution.status = ExecutionStatus::AwaitingApproval;
                self.executions.insert(execution_id.clone(), execution.clone());

                let mut approval_obtained = false;
                let mut attempts = 0;
                let max_attempts = step.timeout_secs * 10;
                while attempts < max_attempts {
                    if self.approval_manager.is_approved(&format!(
                        "{}-{}",
                        execution_id,
                        step.id
                    )) || self.approval_manager.get_pending().is_empty() {
                        approval_obtained = true;
                        break;
                    }
                    tokio::time::sleep(std::time::Duration::from_millis(100)).await;
                    attempts += 1;
                }

                if !approval_obtained {
                    let result = StepResult::awaiting_approval(step);
                    execution.step_results.push(result);
                    execution.fail(&format!("Approval timeout for step '{}'", step.name));
                    self.executions.insert(execution_id.clone(), execution.clone());
                    self.history.record(execution);
                    return Ok(execution_id);
                }

                execution.status = ExecutionStatus::Running;
                self.executions.insert(execution_id.clone(), execution.clone());
            }

            let mut result = StepResult::running(step);
            let start = Utc::now();
            let step_result = execute_step_with_retry(step, &playbook).await;
            let elapsed = (Utc::now() - start).num_milliseconds().max(0) as u64;

            match step_result {
                Ok(action_result) => {
                    result.status = StepStatus::Completed;
                    result.output = action_result.output;
                    result.duration_ms = elapsed;
                    execution.step_results.push(result);

                    if let Some(ref next_step_id) = step.on_success {
                        if let Some(idx) = steps.iter().position(|s| s.id == *next_step_id) {
                            current_step_index = idx;
                        } else {
                            current_step_index += 1;
                        }
                    } else {
                        current_step_index += 1;
                    }
                }
                Err(e) => {
                    result.status = StepStatus::Failed;
                    result.error = Some(e.to_string());
                    result.duration_ms = elapsed;
                    execution.step_results.push(result);

                    if let Some(ref failure_step_id) = step.on_failure {
                        if failure_step_id == "rollback" {
                            tracing::warn!(
                                execution_id = %execution_id,
                                "Triggering rollback due to step failure"
                            );
                            let rollback_steps = playbook.rollback_steps.clone();
                            for rb_step in &rollback_steps {
                                let _ = execute_step_with_retry(rb_step, &playbook).await;
                            }
                            execution.rollback();
                            self.executions
                                .insert(execution_id.clone(), execution.clone());
                            self.history.record(execution);
                            return Ok(execution_id);
                        } else if let Some(idx) =
                            steps.iter().position(|s| s.id == *failure_step_id)
                        {
                            current_step_index = idx;
                            continue;
                        } else {
                            execution.fail(&format!(
                                "Step '{}' failed and no valid failure path found",
                                step.name
                            ));
                            self.executions
                                .insert(execution_id.clone(), execution.clone());
                            self.history.record(execution);
                            return Ok(execution_id);
                        }
                    } else {
                        execution.fail(&format!("Step '{}' failed", step.name));
                        self.executions
                            .insert(execution_id.clone(), execution.clone());
                        self.history.record(execution);
                        return Ok(execution_id);
                    }
                }
            }

            self.executions.insert(execution_id.clone(), execution.clone());
        }

        let mut final_exec = self
            .executions
            .get(&execution_id)
            .unwrap()
            .clone();
        final_exec.complete();
        self.executions
            .insert(execution_id.clone(), final_exec.clone());

        tracing::info!(
            execution_id = %execution_id,
            steps_completed = final_exec.step_results.len(),
            "Playbook execution completed successfully"
        );

        self.history.record(final_exec);
        Ok(execution_id)
    }

    pub fn get_execution(&self, execution_id: &str) -> Option<PlaybookExecution> {
        self.executions.get(execution_id).map(|e| e.value().clone())
    }

    pub fn list_playbooks(&self) -> Vec<Playbook> {
        self.playbooks.iter().map(|p| p.value().clone()).collect()
    }

    pub fn active_executions(&self) -> Vec<PlaybookExecution> {
        self.executions
            .iter()
            .filter(|e| e.status == ExecutionStatus::Running || e.status == ExecutionStatus::AwaitingApproval)
            .map(|e| e.value().clone())
            .collect()
    }

    pub async fn cancel_execution(&self, execution_id: &str) -> Result<(), SoarError> {
        self.executions
            .get_mut(execution_id)
            .ok_or_else(|| SoarError::PlaybookNotFound(format!(
                "Execution {} not found",
                execution_id
            )))
            .map(|mut exec| {
                exec.cancel();
                tracing::warn!(
                    execution_id = %execution_id,
                    "Execution cancelled"
                );
                let cancelled = exec.value().clone();
                self.history.record(cancelled);
            })
    }

    pub fn approval_manager(&self) -> Arc<ApprovalManager> {
        self.approval_manager.clone()
    }

    pub fn history(&self) -> Arc<ExecutionHistory> {
        self.history.clone()
    }

    pub async fn execute_step(
        &self,
        step: &PlaybookStep,
        execution: &mut PlaybookExecution,
    ) -> StepResult {
        let mut result = StepResult::running(step);
        let start = Utc::now();

        match execute_step_with_retry(step, &Playbook {
            id: String::new(),
            name: String::new(),
            description: String::new(),
            version: 0,
            enabled: true,
            triggers: Vec::new(),
            steps: Vec::new(),
            rollback_steps: Vec::new(),
            tags: Vec::new(),
            created_at: Utc::now(),
            updated_at: Utc::now(),
            max_execution_time_secs: 0,
            auto_approve: false,
        })
        .await
        {
            Ok(action_result) => {
                result.status = StepStatus::Completed;
                result.output = action_result.output;
                result.duration_ms = (Utc::now() - start).num_milliseconds().max(0) as u64;
            }
            Err(e) => {
                result.status = StepStatus::Failed;
                result.error = Some(e.to_string());
                result.duration_ms = (Utc::now() - start).num_milliseconds().max(0) as u64;
            }
        }

        execution.step_results.push(result.clone());
        result
    }

    fn should_skip_step(step: &PlaybookStep, execution: &PlaybookExecution) -> bool {
        if step.conditions.is_empty() {
            return false;
        }
        step.conditions.iter().all(|c| c.evaluate(execution))
    }
}

impl Default for PlaybookExecutor {
    fn default() -> Self {
        Self::new()
    }
}

async fn execute_step_with_retry(
    step: &PlaybookStep,
    _playbook: &Playbook,
) -> Result<ActionResult, SoarError> {
    let mut last_error = None;
    let max_attempts = step.retry_count + 1;

    for attempt in 0..max_attempts {
        if attempt > 0 {
            tracing::info!(
                step_id = %step.id,
                attempt = attempt + 1,
                max_attempts = max_attempts,
                "Retrying step"
            );
            tokio::time::sleep(std::time::Duration::from_secs(step.retry_delay_secs)).await;
        }

        match tokio::time::timeout(
            std::time::Duration::from_secs(step.timeout_secs),
            execute_action(&step.action),
        )
        .await
        {
            Ok(Ok(result)) => return Ok(result),
            Ok(Err(e)) => {
                last_error = Some(e);
                tracing::warn!(
                    step_id = %step.id,
                    attempt = attempt + 1,
                    error = %last_error.as_ref().unwrap(),
                    "Step action failed"
                );
            }
            Err(_) => {
                last_error = Some(SoarError::Timeout(format!(
                    "Step '{}' timed out after {} seconds",
                    step.name, step.timeout_secs
                )));
                tracing::warn!(
                    step_id = %step.id,
                    timeout = step.timeout_secs,
                    "Step execution timed out"
                );
            }
        }
    }

    Err(last_error.unwrap_or_else(|| SoarError::StepFailed(format!(
        "Step '{}' failed after {} retries",
        step.name, step.retry_count
    ))))
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::actions::StepAction;

    fn make_test_playbook() -> Playbook {
        Playbook {
            id: "pb-test-1".to_string(),
            name: "Test Playbook".to_string(),
            description: "A test playbook".to_string(),
            version: 1,
            enabled: true,
            triggers: vec![crate::triggers::Trigger::Manual],
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

    #[tokio::test]
    async fn test_register_playbook() {
        let executor = PlaybookExecutor::new();
        let playbook = make_test_playbook();
        executor.register_playbook(playbook.clone());
        let playbooks = executor.list_playbooks();
        assert_eq!(playbooks.len(), 1);
        assert_eq!(playbooks[0].id, "pb-test-1");
    }

    #[tokio::test]
    async fn test_trigger_playbook() {
        let executor = PlaybookExecutor::new();
        let playbook = make_test_playbook();
        executor.register_playbook(playbook);
        let context = TriggerContext::manual();
        let execution_id = executor
            .trigger_playbook("pb-test-1", context)
            .await
            .unwrap();
        let execution = executor.get_execution(&execution_id).unwrap();
        assert_eq!(execution.status, ExecutionStatus::Completed);
        assert_eq!(execution.step_results.len(), 1);
        assert_eq!(execution.step_results[0].status, StepStatus::Completed);
    }

    #[tokio::test]
    async fn test_execute_step() {
        let executor = PlaybookExecutor::new();
        let playbook = make_test_playbook();
        executor.register_playbook(playbook.clone());
        let step = &playbook.steps[0];
        let mut execution = PlaybookExecution::new("pb-test-1", None);
        let result = executor.execute_step(step, &mut execution).await;
        assert_eq!(result.status, StepStatus::Completed);
        assert!(result.output.is_some());
    }

    #[tokio::test]
    async fn test_get_execution() {
        let executor = PlaybookExecutor::new();
        let playbook = make_test_playbook();
        executor.register_playbook(playbook);
        let context = TriggerContext::manual();
        let execution_id = executor
            .trigger_playbook("pb-test-1", context)
            .await
            .unwrap();
        let execution = executor.get_execution(&execution_id);
        assert!(execution.is_some());
        assert_eq!(execution.unwrap().status, ExecutionStatus::Completed);
    }

    #[tokio::test]
    async fn test_cancel_execution() {
        let executor = PlaybookExecutor::new();
        let playbook = make_test_playbook();
        executor.register_playbook(playbook);
        let context = TriggerContext::manual();
        let execution_id = executor
            .trigger_playbook("pb-test-1", context)
            .await
            .unwrap();

        let exec_before = executor.get_execution(&execution_id).unwrap();
        assert_eq!(exec_before.status, ExecutionStatus::Completed);

        let new_exec_id = {
            let mut exec = PlaybookExecution::new("pb-test-1", None);
            exec.status = ExecutionStatus::Running;
            let id = exec.execution_id.clone();
            executor.executions.insert(id.clone(), exec);
            id
        };

        let _ = executor.cancel_execution(&new_exec_id).await;
        let execution = executor.get_execution(&new_exec_id).unwrap();
        assert_eq!(execution.status, ExecutionStatus::Cancelled);
    }
}
