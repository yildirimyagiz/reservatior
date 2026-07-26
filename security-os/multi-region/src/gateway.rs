use std::sync::atomic::{AtomicU64, Ordering};

use chrono::{DateTime, Utc};
use dashmap::DashMap;

use crate::MultiRegionError;

#[derive(Debug, Clone)]
pub enum PeerStatus {
    Connecting,
    Connected,
    Disconnected,
    Error(String),
}

#[derive(Debug, Clone)]
pub struct PeerConnection {
    pub peer_id: String,
    pub peer_region: String,
    pub endpoint: String,
    pub status: PeerStatus,
    pub connected_at: Option<DateTime<Utc>>,
    pub last_sync: Option<DateTime<Utc>>,
    pub latency_ms: Option<f64>,
    pub events_synced: u64,
}

#[derive(Debug, Clone)]
pub struct RegionStats {
    pub region_id: String,
    pub total_peers: usize,
    pub connected_peers: usize,
    pub events_routed: u64,
    pub events_received: u64,
    pub avg_latency_ms: f64,
}

#[derive(Debug)]
pub struct RegionGateway {
    region_id: String,
    region_name: String,
    peers: DashMap<String, PeerConnection>,
    events_routed: AtomicU64,
    events_received: AtomicU64,
    created_at: DateTime<Utc>,
}

impl RegionGateway {
    pub fn new(region_id: &str, region_name: &str) -> Self {
        Self {
            region_id: region_id.to_string(),
            region_name: region_name.to_string(),
            peers: DashMap::new(),
            events_routed: AtomicU64::new(0),
            events_received: AtomicU64::new(0),
            created_at: Utc::now(),
        }
    }

    pub fn connect_peer(&self, peer: PeerConnection) -> Result<(), MultiRegionError> {
        if self.peers.contains_key(&peer.peer_id) {
            return Err(MultiRegionError::PeerUnavailable(format!(
                "peer {} already connected",
                peer.peer_id
            )));
        }
        self.peers.insert(peer.peer_id.clone(), peer);
        Ok(())
    }

    pub fn disconnect_peer(&self, peer_id: &str) -> bool {
        self.peers.remove(peer_id).is_some()
    }

    pub fn get_peer(&self, peer_id: &str) -> Option<PeerConnection> {
        self.peers.get(peer_id).map(|p| p.clone())
    }

    pub fn list_peers(&self) -> Vec<PeerConnection> {
        self.peers.iter().map(|p| p.clone()).collect()
    }

    pub fn stats(&self) -> RegionStats {
        let peers: Vec<PeerConnection> = self.peers.iter().map(|p| p.clone()).collect();
        let total_peers = peers.len();
        let connected_peers = peers
            .iter()
            .filter(|p| matches!(p.status, PeerStatus::Connected))
            .count();
        let latency_sum: f64 = peers.iter().filter_map(|p| p.latency_ms).sum();
        let latency_count = peers.iter().filter(|p| p.latency_ms.is_some()).count();
        let avg_latency_ms = if latency_count > 0 {
            latency_sum / latency_count as f64
        } else {
            0.0
        };

        RegionStats {
            region_id: self.region_id.clone(),
            total_peers,
            connected_peers,
            events_routed: self.events_routed.load(Ordering::Relaxed),
            events_received: self.events_received.load(Ordering::Relaxed),
            avg_latency_ms,
        }
    }

    pub fn connected_peers(&self) -> Vec<PeerConnection> {
        self.peers
            .iter()
            .filter(|p| matches!(p.status, PeerStatus::Connected))
            .map(|p| p.clone())
            .collect()
    }

    pub fn record_routed(&self) {
        self.events_routed.fetch_add(1, Ordering::Relaxed);
    }

    pub fn record_received(&self) {
        self.events_received.fetch_add(1, Ordering::Relaxed);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_peer(id: &str, status: PeerStatus) -> PeerConnection {
        PeerConnection {
            peer_id: id.to_string(),
            peer_region: "peer-region".to_string(),
            endpoint: format!("https://{}.example.com", id),
            status,
            connected_at: None,
            last_sync: None,
            latency_ms: None,
            events_synced: 0,
        }
    }

    #[test]
    fn test_new_gateway() {
        let gw = RegionGateway::new("us-east-1", "US East 1");
        let stats = gw.stats();
        assert_eq!(stats.region_id, "us-east-1");
        assert_eq!(stats.total_peers, 0);
        assert_eq!(stats.connected_peers, 0);
        assert_eq!(stats.events_routed, 0);
        assert_eq!(stats.events_received, 0);
    }

    #[test]
    fn test_connect_and_disconnect_peer() {
        let gw = RegionGateway::new("us-east-1", "US East 1");
        let peer = make_peer("peer-1", PeerStatus::Connected);

        assert!(gw.connect_peer(peer).is_ok());
        assert!(gw.get_peer("peer-1").is_some());

        assert!(gw.disconnect_peer("peer-1"));
        assert!(gw.get_peer("peer-1").is_none());
        assert!(!gw.disconnect_peer("peer-1"));
    }

    #[test]
    fn test_connect_duplicate_peer_errors() {
        let gw = RegionGateway::new("us-east-1", "US East 1");
        let peer1 = make_peer("peer-1", PeerStatus::Connected);
        let peer2 = make_peer("peer-1", PeerStatus::Connecting);

        assert!(gw.connect_peer(peer1).is_ok());
        assert!(gw.connect_peer(peer2).is_err());
    }

    #[test]
    fn test_list_peers() {
        let gw = RegionGateway::new("us-east-1", "US East 1");
        gw.connect_peer(make_peer("p1", PeerStatus::Connected))
            .unwrap();
        gw.connect_peer(make_peer("p2", PeerStatus::Disconnected))
            .unwrap();

        let peers = gw.list_peers();
        assert_eq!(peers.len(), 2);
    }

    #[test]
    fn test_stats() {
        let gw = RegionGateway::new("us-east-1", "US East 1");
        gw.connect_peer({
            let mut p = make_peer("p1", PeerStatus::Connected);
            p.latency_ms = Some(10.0);
            p
        })
        .unwrap();
        gw.connect_peer({
            let mut p = make_peer("p2", PeerStatus::Connected);
            p.latency_ms = Some(20.0);
            p
        })
        .unwrap();
        gw.connect_peer(make_peer("p3", PeerStatus::Disconnected))
            .unwrap();

        gw.record_routed();
        gw.record_routed();
        gw.record_received();

        let stats = gw.stats();
        assert_eq!(stats.total_peers, 3);
        assert_eq!(stats.connected_peers, 2);
        assert_eq!(stats.events_routed, 2);
        assert_eq!(stats.events_received, 1);
        assert!((stats.avg_latency_ms - 15.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_connected_peers_filters_correctly() {
        let gw = RegionGateway::new("us-east-1", "US East 1");
        gw.connect_peer(make_peer("p1", PeerStatus::Connected))
            .unwrap();
        gw.connect_peer(make_peer("p2", PeerStatus::Disconnected))
            .unwrap();
        gw.connect_peer(make_peer("p3", PeerStatus::Connected))
            .unwrap();

        let connected = gw.connected_peers();
        assert_eq!(connected.len(), 2);
        let ids: Vec<String> = connected.iter().map(|p| p.peer_id.clone()).collect();
        assert!(ids.contains(&"p1".to_string()));
        assert!(ids.contains(&"p3".to_string()));
    }
}
