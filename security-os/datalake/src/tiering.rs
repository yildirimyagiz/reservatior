use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use tracing::info;

use crate::errors::DataLakeError;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum StorageTier {
    Hot,
    Warm,
    Cold,
}

pub struct TierConfig {
    pub hot_days: u32,
    pub warm_days: u32,
    pub cold_days: u32,
    pub hot_path: String,
    pub warm_path: String,
    pub cold_path: String,
}

impl Default for TierConfig {
    fn default() -> Self {
        Self {
            hot_days: 7,
            warm_days: 30,
            cold_days: 365,
            hot_path: "/data/hot".to_string(),
            warm_path: "/data/warm".to_string(),
            cold_path: "/data/cold".to_string(),
        }
    }
}

pub struct TieredEvent {
    pub event_id: String,
    pub tier: StorageTier,
    pub created_at: DateTime<Utc>,
    pub size_bytes: u64,
    pub last_accessed: DateTime<Utc>,
}

pub struct TierStatus {
    pub hot_events: u64,
    pub warm_events: u64,
    pub cold_events: u64,
    pub total_events: u64,
    pub hot_size_bytes: u64,
    pub warm_size_bytes: u64,
    pub cold_size_bytes: u64,
}

pub struct TierManager {
    config: TierConfig,
    events: DashMap<String, TieredEvent>,
}

impl TierManager {
    pub fn new(config: TierConfig) -> Self {
        Self {
            config,
            events: DashMap::new(),
        }
    }

    pub fn add_event(&self, event_id: &str, size_bytes: u64) -> StorageTier {
        let now = Utc::now();
        let tiered = TieredEvent {
            event_id: event_id.to_string(),
            tier: StorageTier::Hot,
            created_at: now,
            size_bytes,
            last_accessed: now,
        };
        self.events.insert(event_id.to_string(), tiered);
        StorageTier::Hot
    }

    pub fn get_tier(&self, event_id: &str) -> Option<StorageTier> {
        self.events.get(event_id).map(|e| e.value().tier)
    }

    pub fn promote(&self, event_id: &str) -> Result<(), DataLakeError> {
        let mut entry = self.events.get_mut(event_id)
            .ok_or_else(|| DataLakeError::TierMigrationFailed(format!("Event '{}' not found", event_id)))?;

        let new_tier = match entry.value().tier {
            StorageTier::Cold => StorageTier::Warm,
            StorageTier::Warm => StorageTier::Hot,
            StorageTier::Hot => return Ok(()),
        };

        entry.value_mut().tier = new_tier;
        entry.value_mut().last_accessed = Utc::now();
        Ok(())
    }

    pub fn demote(&self, event_id: &str) -> Result<(), DataLakeError> {
        let mut entry = self.events.get_mut(event_id)
            .ok_or_else(|| DataLakeError::TierMigrationFailed(format!("Event '{}' not found", event_id)))?;

        let new_tier = match entry.value().tier {
            StorageTier::Hot => StorageTier::Warm,
            StorageTier::Warm => StorageTier::Cold,
            StorageTier::Cold => return Ok(()),
        };

        entry.value_mut().tier = new_tier;
        entry.value_mut().last_accessed = Utc::now();
        Ok(())
    }

    pub fn needs_migration(&self) -> Vec<(String, StorageTier)> {
        let now = Utc::now();
        let mut migrations = Vec::new();

        for entry in self.events.iter() {
            let event = entry.value();
            let age = now - event.created_at;

            let target_tier = if age > Duration::days(self.config.cold_days as i64) {
                StorageTier::Cold
            } else if age > Duration::days(self.config.warm_days as i64) {
                StorageTier::Warm
            } else if age > Duration::days(self.config.hot_days as i64) {
                StorageTier::Hot
            } else {
                continue;
            };

            if event.tier != target_tier {
                migrations.push((event.event_id.clone(), target_tier));
            }
        }

        migrations
    }

    pub fn execute_migration(&self) -> Result<usize, DataLakeError> {
        let migrations = self.needs_migration();
        let count = migrations.len();

        for (event_id, target_tier) in &migrations {
            if let Some(mut entry) = self.events.get_mut(event_id) {
                let old_tier = entry.value().tier;
                entry.value_mut().tier = *target_tier;
                entry.value_mut().last_accessed = Utc::now();
                info!(
                    event_id = %event_id,
                    from = ?old_tier,
                    to = ?target_tier,
                    "Migrated event between tiers"
                );
            }
        }

        Ok(count)
    }

    pub fn status(&self) -> TierStatus {
        let mut hot_events = 0u64;
        let mut warm_events = 0u64;
        let mut cold_events = 0u64;
        let mut hot_size = 0u64;
        let mut warm_size = 0u64;
        let mut cold_size = 0u64;

        for entry in self.events.iter() {
            let event = entry.value();
            match event.tier {
                StorageTier::Hot => {
                    hot_events += 1;
                    hot_size += event.size_bytes;
                }
                StorageTier::Warm => {
                    warm_events += 1;
                    warm_size += event.size_bytes;
                }
                StorageTier::Cold => {
                    cold_events += 1;
                    cold_size += event.size_bytes;
                }
            }
        }

        TierStatus {
            hot_events,
            warm_events,
            cold_events,
            total_events: hot_events + warm_events + cold_events,
            hot_size_bytes: hot_size,
            warm_size_bytes: warm_size,
            cold_size_bytes: cold_size,
        }
    }

    pub fn auto_tier(&self) -> usize {
        self.execute_migration().unwrap_or(0)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn default_config() -> TierConfig {
        TierConfig {
            hot_days: 1,
            warm_days: 2,
            cold_days: 3,
            hot_path: "/data/hot".to_string(),
            warm_path: "/data/warm".to_string(),
            cold_path: "/data/cold".to_string(),
        }
    }

    #[test]
    fn test_add_event() {
        let manager = TierManager::new(default_config());
        let tier = manager.add_event("evt-1", 1024);
        assert_eq!(tier, StorageTier::Hot);
        assert_eq!(manager.get_tier("evt-1"), Some(StorageTier::Hot));
        assert_eq!(manager.get_tier("nonexistent"), None);
    }

    #[test]
    fn test_tier_promotion_and_demotion() {
        let manager = TierManager::new(default_config());
        manager.add_event("evt-1", 1024);

        manager.promote("evt-1").unwrap();
        assert_eq!(manager.get_tier("evt-1"), Some(StorageTier::Hot));

        manager.demote("evt-1").unwrap();
        assert_eq!(manager.get_tier("evt-1"), Some(StorageTier::Warm));

        manager.demote("evt-1").unwrap();
        assert_eq!(manager.get_tier("evt-1"), Some(StorageTier::Cold));

        manager.demote("evt-1").unwrap();
        assert_eq!(manager.get_tier("evt-1"), Some(StorageTier::Cold));

        manager.promote("evt-1").unwrap();
        assert_eq!(manager.get_tier("evt-1"), Some(StorageTier::Warm));

        assert!(manager.promote("nonexistent").is_err());
        assert!(manager.demote("nonexistent").is_err());
    }

    #[test]
    fn test_needs_migration() {
        let manager = TierManager::new(default_config());
        manager.add_event("evt-1", 512);

        let migrations = manager.needs_migration();
        assert!(migrations.is_empty());
    }

    #[test]
    fn test_execute_migration() {
        let manager = TierManager::new(default_config());
        manager.add_event("evt-1", 256);
        manager.add_event("evt-2", 512);

        let migrated = manager.execute_migration().unwrap();
        assert_eq!(migrated, 0);
    }

    #[test]
    fn test_auto_tier() {
        let manager = TierManager::new(default_config());
        manager.add_event("evt-1", 100);

        let migrated = manager.auto_tier();
        assert_eq!(migrated, 0);

        let status = manager.status();
        assert_eq!(status.total_events, 1);
        assert_eq!(status.hot_events, 1);
        assert_eq!(status.hot_size_bytes, 100);
    }
}
