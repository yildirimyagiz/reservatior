use async_trait::async_trait;
use security_os_core::SecurityEvent;
use security_os_proto::{AlertNotification, ResponseAction};

#[derive(Debug, thiserror::Error)]
pub enum PluginError {
    #[error("Plugin initialization failed: {0}")]
    InitFailed(String),

    #[error("Plugin runtime error: {0}")]
    Runtime(String),

    #[error("Plugin shutdown error: {0}")]
    ShutdownFailed(String),
}

pub type Result<T> = std::result::Result<T, PluginError>;

#[async_trait]
pub trait Plugin: Send + Sync {
    fn name(&self) -> &str;
    fn version(&self) -> &str;
    fn description(&self) -> &str;

    async fn on_event(&self, event: &SecurityEvent) -> Option<SecurityEvent>;
    async fn on_alert(&self, notification: &AlertNotification) -> Vec<ResponseAction>;
    async fn initialize(&mut self) -> Result<()>;
    async fn shutdown(&mut self) -> Result<()>;
}

pub struct PluginManager {
    plugins: Vec<Box<dyn Plugin>>,
}

impl PluginManager {
    pub fn new() -> Self {
        Self {
            plugins: Vec::new(),
        }
    }

    pub fn register(&mut self, plugin: Box<dyn Plugin>) {
        tracing::info!(
            "Registering plugin: {} v{}",
            plugin.name(),
            plugin.version()
        );
        self.plugins.push(plugin);
    }

    pub async fn initialize_all(&mut self) -> Result<()> {
        for plugin in &mut self.plugins {
            tracing::info!("Initializing plugin: {}", plugin.name());
            plugin.initialize().await?;
            tracing::info!("Plugin {} initialized", plugin.name());
        }
        Ok(())
    }

    pub async fn process_event(&self, event: &SecurityEvent) -> Option<SecurityEvent> {
        let mut current = Some(event.clone());
        for plugin in &self.plugins {
            if let Some(ref evt) = current {
                match plugin.on_event(evt).await {
                    Some(transformed) => {
                        tracing::debug!(
                            "Plugin {} transformed event",
                            plugin.name()
                        );
                        current = Some(transformed);
                    }
                    None => {
                        tracing::debug!(
                            "Plugin {} filtered out event",
                            plugin.name()
                        );
                        return None;
                    }
                }
            }
        }
        current
    }

    pub async fn process_alert(
        &self,
        notification: &AlertNotification,
    ) -> Vec<ResponseAction> {
        let mut actions = Vec::new();
        for plugin in &self.plugins {
            let plugin_actions = plugin.on_alert(notification).await;
            if !plugin_actions.is_empty() {
                tracing::debug!(
                    "Plugin {} produced {} response actions",
                    plugin.name(),
                    plugin_actions.len()
                );
            }
            actions.extend(plugin_actions);
        }
        actions
    }

    pub async fn shutdown_all(&mut self) -> Result<()> {
        for plugin in &mut self.plugins {
            tracing::info!("Shutting down plugin: {}", plugin.name());
            if let Err(e) = plugin.shutdown().await {
                tracing::error!("Failed to shutdown plugin {}: {}", plugin.name(), e);
            }
        }
        Ok(())
    }

    pub fn plugin_names(&self) -> Vec<&str> {
        self.plugins.iter().map(|p| p.name()).collect()
    }

    pub fn plugin_count(&self) -> usize {
        self.plugins.len()
    }
}

impl Default for PluginManager {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventCategory, EventSource, Severity};

    struct TestPlugin {
        name: String,
        initialized: bool,
    }

    impl TestPlugin {
        fn new(name: &str) -> Self {
            Self {
                name: name.to_string(),
                initialized: false,
            }
        }
    }

    #[async_trait]
    impl Plugin for TestPlugin {
        fn name(&self) -> &str {
            &self.name
        }
        fn version(&self) -> &str {
            "0.1.0"
        }
        fn description(&self) -> &str {
            "A test plugin"
        }

        async fn on_event(&self, event: &SecurityEvent) -> Option<SecurityEvent> {
            if event.severity >= Severity::High {
                Some(event.clone())
            } else {
                None
            }
        }

        async fn on_alert(&self, _notification: &AlertNotification) -> Vec<ResponseAction> {
            vec![ResponseAction::new(
                security_os_proto::ActionType::Notify,
                "admin@example.com",
            )]
        }

        async fn initialize(&mut self) -> Result<()> {
            self.initialized = true;
            Ok(())
        }

        async fn shutdown(&mut self) -> Result<()> {
            self.initialized = false;
            Ok(())
        }
    }

    fn test_event(severity: Severity) -> SecurityEvent {
        SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            EventSource {
                collector: "test".into(),
                host_id: "h1".into(),
                host_name: "testhost".into(),
                agent_id: "a1".into(),
                process_name: None,
                process_id: None,
                user_id: None,
                user_name: None,
                container_id: None,
                container_name: None,
                pod_name: None,
                namespace: None,
            
                agent_version: None,
                service_name: None,
            },
            "Test event",
            "Desc",
        )
        .with_severity(severity)
    }

    #[tokio::test]
    async fn test_plugin_manager_register_and_count() {
        let mut mgr = PluginManager::new();
        assert_eq!(mgr.plugin_count(), 0);

        mgr.register(Box::new(TestPlugin::new("plugin-a")));
        mgr.register(Box::new(TestPlugin::new("plugin-b")));
        assert_eq!(mgr.plugin_count(), 2);
        assert_eq!(mgr.plugin_names(), vec!["plugin-a", "plugin-b"]);
    }

    #[tokio::test]
    async fn test_plugin_manager_initialize_all() {
        let mut mgr = PluginManager::new();
        mgr.register(Box::new(TestPlugin::new("p1")));
        mgr.register(Box::new(TestPlugin::new("p2")));

        let result = mgr.initialize_all().await;
        assert!(result.is_ok());
    }

    #[tokio::test]
    async fn test_process_event_filters_low_severity() {
        let mut mgr = PluginManager::new();
        mgr.register(Box::new(TestPlugin::new("filter")));
        mgr.initialize_all().await.unwrap();

        let low_event = test_event(Severity::Low);
        let result = mgr.process_event(&low_event).await;
        assert!(result.is_none());

        let high_event = test_event(Severity::High);
        let result = mgr.process_event(&high_event).await;
        assert!(result.is_some());
    }

    #[tokio::test]
    async fn test_process_alert() {
        let mut mgr = PluginManager::new();
        mgr.register(Box::new(TestPlugin::new("alerter")));
        mgr.initialize_all().await.unwrap();

        let alert = AlertNotification::new(
            uuid::Uuid::new_v4(),
            Severity::Critical,
            "Alert!",
            "Something bad",
            vec![],
        );

        let actions = mgr.process_alert(&alert).await;
        assert_eq!(actions.len(), 1);
        assert_eq!(
            actions[0].action_type,
            security_os_proto::ActionType::Notify
        );
    }

    #[tokio::test]
    async fn test_shutdown_all() {
        let mut mgr = PluginManager::new();
        mgr.register(Box::new(TestPlugin::new("s")));
        let result = mgr.shutdown_all().await;
        assert!(result.is_ok());
    }
}
