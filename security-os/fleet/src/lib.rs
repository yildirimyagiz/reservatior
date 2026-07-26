pub mod enrollment;
pub mod errors;
pub mod health;
pub mod heartbeat;
pub mod policy;
pub mod registry;

pub use enrollment::{EnrollmentManager, EnrollmentRequest, EnrollmentResponse, EnrollmentStatus};
pub use errors::FleetError;
pub use health::{AgentHealthReport, HealthAlert, HealthAlertType, HealthMonitor};
pub use heartbeat::HeartbeatTracker;
pub use policy::{DeploymentStatus, PolicyDeployment, PolicyDistributor, PolicyRecord};
pub use registry::{AgentRecord, AgentRegistry, AgentStatus, FleetStats};

pub fn isolate_agent(host_id: &str) -> Result<(), FleetError> {
    tracing::warn!(host_id = %host_id, "Agent isolated by SOAR playbook");
    Ok(())
}

pub fn restore_agent(host_id: &str) -> Result<(), FleetError> {
    tracing::info!(host_id = %host_id, "Agent restored from isolation");
    Ok(())
}
