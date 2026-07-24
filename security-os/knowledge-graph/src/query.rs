use std::collections::{HashMap, HashSet};
use std::sync::Arc;

use uuid::Uuid;

use crate::models::{GraphNode, GraphEdge};
use crate::memory_graph::MemoryGraph;
use crate::pathfinding::Pathfinder;

pub struct GraphQuerier {
    graph: Arc<MemoryGraph>,
}

#[derive(Debug, Clone)]
pub struct AttackPath {
    pub nodes: Vec<GraphNode>,
    pub edges: Vec<GraphEdge>,
    pub risk_score: f64,
    pub length: usize,
}

#[derive(Debug, Clone)]
pub struct BlastRadius {
    pub source_node: GraphNode,
    pub affected_nodes: Vec<GraphNode>,
    pub affected_edges: Vec<GraphEdge>,
    pub max_depth: usize,
    pub total_risk: f64,
}

impl GraphQuerier {
    pub fn new(graph: Arc<MemoryGraph>) -> Self {
        Self { graph }
    }

    pub fn find_attack_paths(
        &self,
        source: &Uuid,
        target: &Uuid,
        max_depth: usize,
    ) -> Vec<AttackPath> {
        let pathfinder = Pathfinder::new(&self.graph);
        let mut all_paths = Vec::new();

        self.dfs_all_paths(
            &pathfinder,
            source,
            target,
            max_depth,
            &mut Vec::new(),
            &mut HashSet::new(),
            &mut all_paths,
        );

        let mut attack_paths: Vec<AttackPath> = all_paths
            .into_iter()
            .map(|path| {
                let mut total_risk = 0.0;
                let mut graph_edges = Vec::new();

                for window in path.windows(2) {
                    if let Some(edges) = self.find_edges_between(&window[0], &window[1]) {
                        for edge in &edges {
                            total_risk += edge.weight;
                            graph_edges.push(edge.clone());
                        }
                    }
                }

                let nodes: Vec<GraphNode> = path
                    .iter()
                    .filter_map(|id| self.graph.get_node(id))
                    .collect();

                AttackPath {
                    length: nodes.len(),
                    risk_score: total_risk,
                    nodes,
                    edges: graph_edges,
                }
            })
            .collect();

        attack_paths.sort_by(|a, b| b.risk_score.partial_cmp(&a.risk_score).unwrap_or(std::cmp::Ordering::Equal));
        attack_paths
    }

    fn dfs_all_paths(
        &self,
        pathfinder: &Pathfinder,
        current: &Uuid,
        target: &Uuid,
        max_depth: usize,
        path: &mut Vec<Uuid>,
        visited: &mut HashSet<Uuid>,
        all_paths: &mut Vec<Vec<Uuid>>,
    ) {
        if path.len() > max_depth {
            return;
        }
        if current == target && !path.is_empty() {
            let mut full_path = path.clone();
            full_path.push(*target);
            all_paths.push(full_path);
            return;
        }
        if visited.contains(current) {
            return;
        }

        visited.insert(*current);
        path.push(*current);

        let neighbors = self.graph.neighbors(current);
        for neighbor in &neighbors {
            if !visited.contains(&neighbor.id) || neighbor.id == *target {
                self.dfs_all_paths(
                    pathfinder,
                    &neighbor.id,
                    target,
                    max_depth,
                    path,
                    visited,
                    all_paths,
                );
            }
        }

        path.pop();
        visited.remove(current);
    }

    fn find_edges_between(
        &self,
        source: &Uuid,
        target: &Uuid,
    ) -> Option<Vec<GraphEdge>> {
        let edges = self.graph.get_edges_from(source);
        let matching: Vec<GraphEdge> = edges.into_iter().filter(|e| e.target_id == *target).collect();
        if matching.is_empty() {
            let rev_edges = self.graph.get_edges_to(source);
            let rev_matching: Vec<GraphEdge> = rev_edges.into_iter().filter(|e| e.source_id == *target).collect();
            if rev_matching.is_empty() {
                None
            } else {
                Some(rev_matching)
            }
        } else {
            Some(matching)
        }
    }

    pub fn calculate_blast_radius(
        &self,
        node_id: &Uuid,
        max_depth: usize,
    ) -> BlastRadius {
        let source_node = self.graph.get_node(node_id).expect("source node must exist");
        let pathfinder = Pathfinder::new(&self.graph);
        let reachable = pathfinder.reachable_from(node_id, max_depth);

        let affected_nodes: Vec<GraphNode> = reachable
            .iter()
            .filter_map(|id| self.graph.get_node(id))
            .collect();

        let affected_ids: HashSet<Uuid> = reachable.iter().cloned().collect();
        let mut affected_edges = Vec::new();
        let mut total_risk = source_node.risk_score;

        for edge in self.graph.get_edges_from(node_id) {
            if affected_ids.contains(&edge.target_id) {
                total_risk += edge.weight;
                affected_edges.push(edge);
            }
        }
        for edge in self.graph.get_edges_to(node_id) {
            if affected_ids.contains(&edge.source_id) {
                total_risk += edge.weight;
                affected_edges.push(edge);
            }
        }

        for &id in &reachable {
            for edge in self.graph.get_edges_from(&id) {
                if affected_ids.contains(&edge.target_id) && edge.source_id != *node_id && edge.target_id != *node_id {
                    total_risk += edge.weight * 0.5;
                    if !affected_edges.iter().any(|e| e.id == edge.id) {
                        affected_edges.push(edge);
                    }
                }
            }
        }

        BlastRadius {
            source_node,
            affected_nodes,
            affected_edges,
            max_depth,
            total_risk,
        }
    }

    pub fn find_high_risk_nodes(&self, threshold: f64) -> Vec<GraphNode> {
        let mut high_risk: Vec<GraphNode> = self
            .graph
            .find_nodes_by_type(&crate::models::NodeType::Host)
            .into_iter()
            .chain(self.graph.find_nodes_by_type(&crate::models::NodeType::User))
            .chain(self.graph.find_nodes_by_type(&crate::models::NodeType::Container))
            .chain(self.graph.find_nodes_by_type(&crate::models::NodeType::Process))
            .chain(self.graph.find_nodes_by_type(&crate::models::NodeType::Ip))
            .chain(self.graph.find_nodes_by_type(&crate::models::NodeType::Booking))
            .chain(self.graph.find_nodes_by_type(&crate::models::NodeType::Escrow))
            .chain(self.graph.find_nodes_by_type(&crate::models::NodeType::Payment))
            .filter(|n| n.risk_score >= threshold)
            .collect();

        high_risk.sort_by(|a, b| b.risk_score.partial_cmp(&a.risk_score).unwrap_or(std::cmp::Ordering::Equal));
        high_risk
    }

    pub fn entity_risk_summary(&self, entity: &str) -> HashMap<String, f64> {
        let mut summary = HashMap::new();

        if let Some(node) = self.graph.find_node_by_label(entity) {
            summary.insert("node_risk_score".into(), node.risk_score);

            let edges_from = self.graph.get_edges_from(&node.id);
            let edges_to = self.graph.get_edges_to(&node.id);
            let total_edges = edges_from.len() + edges_to.len();
            summary.insert(
                "total_connections".into(),
                total_edges as f64,
            );

            let mut max_edge_risk = 0.0;
            for edge in edges_from.iter().chain(edges_to.iter()) {
                if edge.weight > max_edge_risk {
                    max_edge_risk = edge.weight;
                }
            }
            summary.insert("max_edge_risk".into(), max_edge_risk);

            let neighbors = self.graph.neighbors(&node.id);
            let neighbor_risk: f64 = neighbors.iter().map(|n| n.risk_score).sum();
            summary.insert("neighbor_total_risk".into(), neighbor_risk);

            let compromised_count = edges_from
                .iter()
                .chain(edges_to.iter())
                .filter(|e| {
                    matches!(
                        e.relationship,
                        crate::models::EdgeRelationship::Compromised
                            | crate::models::EdgeRelationship::Escalated
                            | crate::models::EdgeRelationship::Exfiltrated
                    )
                })
                .count();
            summary.insert("security_events".into(), compromised_count as f64);
            summary.insert("event_count".into(), node.event_count as f64);
        }

        summary
    }
}
