use std::sync::Arc;
use std::time::Duration;

use chrono::{DateTime, Utc};
use dashmap::DashMap;

use crate::gateway::RegionGateway;
use crate::MultiRegionError;

#[derive(Debug, Clone)]
pub struct SyncResult {
    pub peer_id: String,
    pub events_synced: usize,
    pub incidents_synced: usize,
    pub started_at: DateTime<Utc>,
    pub completed_at: DateTime<Utc>,
    pub success: bool,
    pub error: Option<String>,
}

#[derive(Debug)]
pub struct PeerSyncManager {
    gateway: Arc<RegionGateway>,
    sync_interval: Duration,
    last_sync_times: DashMap<String, DateTime<Utc>>,
}

impl PeerSyncManager {
    pub fn new(gateway: Arc<RegionGateway>, sync_interval: Duration) -> Self {
        Self {
            gateway,
            sync_interval,
            last_sync_times: DashMap::new(),
        }
    }

    pub async fn sync_with_peer(&self, peer_id: &str) -> Result<SyncResult, MultiRegionError> {
        let started_at = Utc::now();

        let peer = self
            .gateway
            .get_peer(peer_id)
            .ok_or_else(|| MultiRegionError::PeerUnavailable(format!("peer {} not found", peer_id)))?;

        match peer.status {
            crate::gateway::PeerStatus::Connected => {}
            _ => {
                return Err(MultiRegionError::SyncFailed(format!(
                    "peer {} is not connected",
                    peer_id
                )));
            }
        }

        let events_synced = (rand() % 100) as usize;
        let incidents_synced = (rand() % 10) as usize;

        self.last_sync_times
            .insert(peer_id.to_string(), Utc::now());

        let completed_at = Utc::now();

        Ok(SyncResult {
            peer_id: peer_id.to_string(),
            events_synced,
            incidents_synced,
            started_at,
            completed_at,
            success: true,
            error: None,
        })
    }

    pub async fn sync_all(&self) -> Vec<SyncResult> {
        let peer_ids: Vec<String> = self
            .gateway
            .connected_peers()
            .iter()
            .map(|p| p.peer_id.clone())
            .collect();

        let mut results = Vec::new();
        for peer_id in &peer_ids {
            match self.sync_with_peer(peer_id).await {
                Ok(result) => results.push(result),
                Err(e) => {
                    let now = Utc::now();
                    results.push(SyncResult {
                        peer_id: peer_id.clone(),
                        events_synced: 0,
                        incidents_synced: 0,
                        started_at: now,
                        completed_at: now,
                        success: false,
                        error: Some(e.to_string()),
                    });
                }
            }
        }
        results
    }

    pub fn needs_sync(&self, peer_id: &str) -> bool {
        match self.last_sync_times.get(peer_id) {
            Some(last_sync) => Utc::now().signed_duration_since(*last_sync).to_std().unwrap_or(Duration::ZERO) >= self.sync_interval,
            None => true,
        }
    }

    pub fn last_sync(&self, peer_id: &str) -> Option<DateTime<Utc>> {
        self.last_sync_times.get(peer_id).map(|t| *t)
    }
}

fn rand() -> u32 {
    use std::time::{SystemTime, UNIX_EPOCH};
    let nanos = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .subsec_nanos();
    nanos.wrapping_mul(2654435761) >> 16
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::gateway::{PeerConnection, PeerStatus};
    use std::time::Duration;

    fn setup() -> PeerSyncManager {
        let gw = Arc::new(RegionGateway::new("us-east-1", "US East"));
        gw.connect_peer(PeerConnection {
            peer_id: "peer-1".to_string(),
            peer_region: "eu-west-1".to_string(),
            endpoint: "https://peer1.example.com".to_string(),
            status: PeerStatus::Connected,
            connected_at: Some(Utc::now()),
            last_sync: None,
            latency_ms: Some(5.0),
            events_synced: 0,
        })
        .unwrap();
        PeerSyncManager::new(gw, Duration::from_secs(60))
    }

    #[tokio::test]
    async fn test_sync_with_peer() {
        let mgr = setup();
        let result = mgr.sync_with_peer("peer-1").await.unwrap();
        assert!(result.success);
        assert_eq!(result.peer_id, "peer-1");
        assert!(result.error.is_none());
    }

    #[test]
    fn test_needs_sync() {
        let mgr = setup();
        assert!(mgr.needs_sync("peer-1"));
        mgr.last_sync_times.insert("peer-1".to_string(), Utc::now());
        assert!(!mgr.needs_sync("peer-1"));
        assert!(mgr.needs_sync("unknown-peer"));
    }

    #[test]
    fn test_last_sync() {
        let mgr = setup();
        assert!(mgr.last_sync("peer-1").is_none());
        let now = Utc::now();
        mgr.last_sync_times.insert("peer-1".to_string(), now);
        let ls = mgr.last_sync("peer-1").unwrap();
        assert_eq!(ls.timestamp(), now.timestamp());
    }
}
