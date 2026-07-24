use std::collections::{BinaryHeap, HashMap, HashSet, VecDeque};
use std::cmp::Ordering;

use uuid::Uuid;

use crate::memory_graph::MemoryGraph;

pub struct Pathfinder<'a> {
    graph: &'a MemoryGraph,
}

#[derive(Copy, Clone, Eq, PartialEq)]
struct State {
    cost: u64,
    position: Uuid,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl<'a> Pathfinder<'a> {
    pub fn new(graph: &'a MemoryGraph) -> Self {
        Self { graph }
    }

    pub fn bfs(&self, start: &Uuid, end: &Uuid, max_depth: usize) -> Option<Vec<Uuid>> {
        if start == end {
            return Some(vec![*start]);
        }

        let mut visited: HashSet<Uuid> = HashSet::new();
        let mut parent: HashMap<Uuid, Uuid> = HashMap::new();
        let mut queue = VecDeque::new();

        queue.push_back((*start, 0usize));
        visited.insert(*start);

        while let Some((current, depth)) = queue.pop_front() {
            if depth >= max_depth {
                continue;
            }

            let neighbors = self.graph.neighbors(&current);
            for neighbor in &neighbors {
                if !visited.contains(&neighbor.id) {
                    visited.insert(neighbor.id);
                    parent.insert(neighbor.id, current);
                    queue.push_back((neighbor.id, depth + 1));

                    if neighbor.id == *end {
                        return Some(self.reconstruct_path(&parent, start, end));
                    }
                }
            }
        }

        None
    }

    pub fn dijkstra(
        &self,
        start: &Uuid,
        end: &Uuid,
        max_depth: usize,
    ) -> Option<(Vec<Uuid>, f64)> {
        if start == end {
            return Some((vec![*start], 0.0));
        }

        let mut dist: HashMap<Uuid, f64> = HashMap::new();
        let mut parent: HashMap<Uuid, Uuid> = HashMap::new();
        let mut visited: HashSet<Uuid> = HashSet::new();
        let mut heap = BinaryHeap::new();

        dist.insert(*start, 0.0);
        heap.push(State {
            cost: 0,
            position: *start,
        });

        while let Some(State { position, .. }) = heap.pop() {
            if visited.contains(&position) {
                continue;
            }
            visited.insert(position);

            let current_dist = dist[&position];
            if current_dist > max_depth as f64 {
                continue;
            }

            let neighbors = self.graph.neighbors(&position);
            for neighbor in &neighbors {
                if visited.contains(&neighbor.id) {
                    continue;
                }

                let edges = self.graph.get_edges_from(&position);
                let edge_weight = edges
                    .iter()
                    .find(|e| e.target_id == neighbor.id)
                    .map(|e| e.weight)
                    .unwrap_or(1.0);

                let weight = if edge_weight > 0.0 { edge_weight } else { 1.0 };
                let new_dist = current_dist + weight;

                if new_dist <= max_depth as f64 {
                    let should_update = dist
                        .get(&neighbor.id)
                        .map(|&d| new_dist < d)
                        .unwrap_or(true);

                    if should_update {
                        dist.insert(neighbor.id, new_dist);
                        parent.insert(neighbor.id, position);
                        heap.push(State {
                            cost: (new_dist * 1000.0) as u64,
                            position: neighbor.id,
                        });
                    }
                }
            }

            if position == *end {
                let path = self.reconstruct_path(&parent, start, end);
                let total_cost = dist[end];
                return Some((path, total_cost));
            }
        }

        None
    }

    pub fn reachable_from(&self, start: &Uuid, max_depth: usize) -> Vec<Uuid> {
        let mut visited: HashSet<Uuid> = HashSet::new();
        let mut queue = VecDeque::new();

        queue.push_back((*start, 0usize));
        visited.insert(*start);

        while let Some((current, depth)) = queue.pop_front() {
            if depth >= max_depth {
                continue;
            }

            let neighbors = self.graph.neighbors(&current);
            for neighbor in &neighbors {
                if visited.insert(neighbor.id) {
                    queue.push_back((neighbor.id, depth + 1));
                }
            }
        }

        visited.remove(start);
        visited.into_iter().collect()
    }

    fn reconstruct_path(
        &self,
        parent: &HashMap<Uuid, Uuid>,
        start: &Uuid,
        end: &Uuid,
    ) -> Vec<Uuid> {
        let mut path = Vec::new();
        let mut current = *end;
        path.push(current);

        while let Some(&p) = parent.get(&current) {
            path.push(p);
            current = p;
            if current == *start {
                break;
            }
        }

        path.reverse();
        path
    }
}
