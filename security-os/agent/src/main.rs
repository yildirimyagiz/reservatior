use security_os_agent::Agent;
use security_os_agent::config::AgentConfig;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    tracing_subscriber::fmt().init();
    let config = AgentConfig::load_from_file("agent.toml")
        .unwrap_or_else(|_| AgentConfig::defaults());
    let mut agent = Agent::new(config)?;
    agent.start().await?;
    tokio::signal::ctrl_c().await?;
    agent.stop().await?;
    Ok(())
}
