use std::collections::{HashMap, HashSet, VecDeque};

use dashmap::DashMap;
use uuid::Uuid;

use crate::models::{GraphEdge, GraphNode, GraphStats, NodeType};

pub struct MemoryGraph {
    nodes: DashMap<Uuid, GraphNode>,
    adjacency: DashMap<Uuid, Vec<Uuid>>,
    reverse_adj: DashMap<Uuid, Vec<Uuid>>,
    edges: DashMap<Uuid, GraphEdge>,
    label_index: DashMap<String, Uuid>,
    type_index: DashMap<String, Vec<Uuid>>,
}

impl Default for MemoryGraph {
    fn default() -> Self {
        Self::new()
    }
}

impl MemoryGraph {
    pub fn new() -> Self {
        Self {
            nodes: DashMap::new(),
            adjacency: DashMap::new(),
            reverse_adj: DashMap::new(),
            edges: DashMap::new(),
            label_index: DashMap::new(),
            type_index: DashMap::new(),
        }
    }

    pub fn add_node(&self, node: GraphNode) -> Uuid {
        let id = node.id;
        let type_key = node.type_key();
        let label = node.label.clone();

        self.label_index.insert(label, id);
        self.type_index
            .entry(type_key)
            .or_insert_with(Vec::new)
            .push(id);
        self.adjacency.insert(id, Vec::new());
        self.reverse_adj.insert(id, Vec::new());
        self.nodes.insert(id, node);
        id
    }

    pub fn get_node(&self, id: &Uuid) -> Option<GraphNode> {
        self.nodes.get(id).map(|n| n.clone())
    }

    pub fn find_node_by_label(&self, label: &str) -> Option<GraphNode> {
        self.label_index
            .get(label)
            .and_then(|id| self.nodes.get(&id).map(|n| n.clone()))
    }

    pub fn find_nodes_by_type(&self, node_type: &NodeType) -> Vec<GraphNode> {
        let type_key = node_type.to_string();
        self.type_index
            .get(&type_key)
            .map(|ids| {
                ids.iter()
                    .filter_map(|id| self.nodes.get(id).map(|n| n.clone()))
                    .collect()
            })
            .unwrap_or_default()
    }

    pub fn update_node(&self, id: &Uuid, properties: HashMap<String, serde_json::Value>) {
        if let Some(mut node) = self.nodes.get_mut(id) {
            node.last_seen = chrono::Utc::now();
            node.event_count += 1;
            node.properties.extend(properties);
        }
    }

    pub fn remove_node(&self, id: &Uuid) -> bool {
        if let Some((_, node)) = self.nodes.remove(id) {
            let type_key = node.node_type.to_string();
            if let Some(mut ids) = self.type_index.get_mut(&type_key) {
                ids.retain(|nid| nid != id);
            }
            self.label_index.remove(&node.label);

            if let Some((_, outgoing)) = self.adjacency.remove(id) {
                for target_id in outgoing {
                    if let Some(mut rev) = self.reverse_adj.get_mut(&target_id) {
                        rev.retain(|nid| nid != id);
                    }
                }
            }
            if let Some((_, incoming)) = self.reverse_adj.remove(id) {
                for source_id in incoming {
                    if let Some(mut adj) = self.adjacency.get_mut(&source_id) {
                        adj.retain(|nid| nid != id);
                    }
                }
            }

            self.edges.retain(|_, e| e.source_id != *id && e.target_id != *id);
            self.adjacency.remove(id);
            self.reverse_adj.remove(id);
            true
        } else {
            false
        }
    }

    pub fn add_edge(&self, edge: GraphEdge) -> Uuid {
        let id = edge.id;
        let source = edge.source_id;
        let target = edge.target_id;

        self.adjacency.entry(source).or_insert_with(Vec::new).push(target);
        self.reverse_adj.entry(target).or_insert_with(Vec::new).push(source);
        self.edges.insert(id, edge);
        id
    }

    pub fn get_edges_from(&self, node_id: &Uuid) -> Vec<GraphEdge> {
        self.adjacency
            .get(node_id)
            .map(|targets| {
                targets
                    .iter()
                    .filter_map(|target| {
                        self.edges
                            .iter()
                            .find(|e| e.source_id == *node_id && e.target_id == *target)
                            .map(|e| e.clone())
                    })
                    .collect()
            })
            .unwrap_or_default()
    }

    pub fn get_edges_to(&self, node_id: &Uuid) -> Vec<GraphEdge> {
        self.reverse_adj
            .get(node_id)
            .map(|sources| {
                sources
                    .iter()
                    .filter_map(|source| {
                        self.edges
                            .iter()
                            .find(|e| e.source_id == *source && e.target_id == *node_id)
                            .map(|e| e.clone())
                    })
                    .collect()
            })
            .unwrap_or_default()
    }

    pub fn remove_edge(&self, edge_id: &Uuid) -> bool {
        if let Some((_, edge)) = self.edges.remove(edge_id) {
            if let Some(mut targets) = self.adjacency.get_mut(&edge.source_id) {
                targets.retain(|t| *t != edge.target_id);
            }
            if let Some(mut sources) = self.reverse_adj.get_mut(&edge.target_id) {
                sources.retain(|s| *s != edge.source_id);
            }
            true
        } else {
            false
        }
    }

    pub fn neighbors(&self, node_id: &Uuid) -> Vec<GraphNode> {
        let mut result = Vec::new();
        if let Some(targets) = self.adjacency.get(node_id) {
            for target_id in targets.iter() {
                if let Some(node) = self.nodes.get(target_id) {
                    result.push(node.clone());
                }
            }
        }
        if let Some(sources) = self.reverse_adj.get(node_id) {
            for source_id in sources.iter() {
                if !result.iter().any(|n| &n.id == source_id) {
                    if let Some(node) = self.nodes.get(source_id) {
                        result.push(node.clone());
                    }
                }
            }
        }
        result
    }

    pub fn stats(&self) -> GraphStats {
        let total_nodes = self.nodes.len();
        let total_edges = self.edges.len();

        let mut nodes_by_type: HashMap<String, usize> = HashMap::new();
        for node in self.nodes.iter() {
            let type_key = node.node_type.to_string();
            *nodes_by_type.entry(type_key).or_insert(0) += 1;
        }

        let mut edges_by_type: HashMap<String, usize> = HashMap::new();
        for edge in self.edges.iter() {
            let rel_key = edge.relationship.to_string();
            *edges_by_type.entry(rel_key).or_insert(0) += 1;
        }

        let avg_degree = if total_nodes > 0 {
            (total_edges * 2) as f64 / total_nodes as f64
        } else {
            0.0
        };

        let connected_components = self.count_connected_components();

        GraphStats {
            total_nodes,
            total_edges,
            nodes_by_type,
            edges_by_type,
            avg_degree,
            connected_components,
        }
    }

    pub fn node_count(&self) -> usize {
        self.nodes.len()
    }

    pub fn edge_count(&self) -> usize {
        self.edges.len()
    }

    fn count_connected_components(&self) -> usize {
        let mut visited: HashSet<Uuid> = HashSet::new();
        let mut components = 0;

        for node_id in self.nodes.iter().map(|n| *n.key()) {
            if visited.contains(&node_id) {
                continue;
            }
            components += 1;
            let mut queue = VecDeque::new();
            queue.push_back(node_id);
            visited.insert(node_id);

            while let Some(current) = queue.pop_front() {
                if let Some(targets) = self.adjacency.get(&current) {
                    for &target in targets.iter() {
                        if visited.insert(target) {
                            queue.push_back(target);
                        }
                    }
                }
                if let Some(sources) = self.reverse_adj.get(&current) {
                    for &source in sources.iter() {
                        if visited.insert(source) {
                            queue.push_back(source);
                        }
                    }
                }
            }
        }

        components
    }
}
