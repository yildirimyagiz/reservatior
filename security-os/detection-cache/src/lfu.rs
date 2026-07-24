use chrono::{DateTime, Utc};
use dashmap::DashMap;
use std::hash::Hash;
use std::time::Duration;

pub struct LfuCache<K: Eq + Hash + Clone, V: Clone> {
    entries: DashMap<K, CacheEntry<V>>,
    max_size: usize,
    default_ttl: Duration,
    access_counts: DashMap<K, u64>,
}

#[derive(Debug, Clone)]
pub struct CacheEntry<V> {
    pub value: V,
    pub inserted_at: DateTime<Utc>,
    pub access_count: u64,
    pub ttl: Option<Duration>,
}

impl<K: Eq + Hash + Clone, V: Clone> LfuCache<K, V> {
    pub fn new(max_size: usize, default_ttl: Duration) -> Self {
        Self {
            entries: DashMap::new(),
            max_size,
            default_ttl,
            access_counts: DashMap::new(),
        }
    }

    pub fn get(&self, key: &K) -> Option<V> {
        if let Some(entry) = self.entries.get(key) {
            if self.is_expired(entry.value()) {
                drop(entry);
                self.entries.remove(key);
                self.access_counts.remove(key);
                return None;
            }

            let value = entry.value().value.clone();
            drop(entry);

            self.access_counts
                .entry(key.clone())
                .and_modify(|c| *c += 1)
                .or_insert(1);

            Some(value)
        } else {
            None
        }
    }

    pub fn insert(&self, key: K, value: V) {
        self.insert_with_ttl(key, value, self.default_ttl);
    }

    pub fn insert_with_ttl(&self, key: K, value: V, ttl: Duration) {
        if self.entries.len() >= self.max_size && !self.entries.contains_key(&key) {
            self.evict_lfu();
        }

        let entry = CacheEntry {
            value,
            inserted_at: Utc::now(),
            access_count: 0,
            ttl: Some(ttl),
        };

        self.entries.insert(key.clone(), entry);
        self.access_counts
            .entry(key)
            .and_modify(|c| *c += 1)
            .or_insert(1);
    }

    pub fn remove(&self, key: &K) -> Option<V> {
        self.access_counts.remove(key);
        self.entries.remove(key).map(|(_, entry)| entry.value)
    }

    pub fn contains(&self, key: &K) -> bool {
        if let Some(entry) = self.entries.get(key) {
            if self.is_expired(entry.value()) {
                drop(entry);
                self.entries.remove(key);
                self.access_counts.remove(key);
                return false;
            }
            true
        } else {
            false
        }
    }

    pub fn len(&self) -> usize {
        self.entries.len()
    }

    pub fn evict_expired(&self) -> usize {
        let mut evicted = 0;
        let mut keys_to_remove = Vec::new();

        for entry in self.entries.iter() {
            if self.is_expired(entry.value()) {
                keys_to_remove.push(entry.key().clone());
            }
        }

        for key in keys_to_remove {
            self.entries.remove(&key);
            self.access_counts.remove(&key);
            evicted += 1;
        }

        evicted
    }

    fn is_expired(&self, entry: &CacheEntry<V>) -> bool {
        if let Some(ttl) = entry.ttl {
            Utc::now().signed_duration_since(entry.inserted_at) > chrono::Duration::from_std(ttl).unwrap_or(chrono::TimeDelta::MAX)
        } else {
            false
        }
    }

    fn evict_lfu(&self) {
        if self.entries.is_empty() {
            return;
        }

        let mut min_key = None;
        let mut min_count = u64::MAX;

        for entry in self.entries.iter() {
            let key = entry.key().clone();
            let count = self.access_counts.get(&key).map(|c| *c).unwrap_or(0);
            if count < min_count {
                min_count = count;
                min_key = Some(key);
            }
        }

        if let Some(key) = min_key {
            self.entries.remove(&key);
            self.access_counts.remove(&key);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_insert() {
        let cache = LfuCache::new(10, Duration::from_secs(60));
        cache.insert("key1", "value1");
        cache.insert("key2", "value2");

        assert_eq!(cache.get(&"key1"), Some("value1"));
        assert_eq!(cache.get(&"key2"), Some("value2"));
        assert_eq!(cache.get(&"key3"), None);
    }

    #[test]
    fn test_ttl_eviction() {
        let cache = LfuCache::new(10, Duration::from_secs(60));
        cache.insert_with_ttl("key1", "value1", Duration::from_millis(50));

        assert_eq!(cache.get(&"key1"), Some("value1"));
        std::thread::sleep(Duration::from_millis(100));
        assert_eq!(cache.get(&"key1"), None);
        assert_eq!(cache.len(), 0);
    }

    #[test]
    fn test_size_limit() {
        let cache = LfuCache::new(3, Duration::from_secs(60));
        cache.insert("a", 1);
        cache.insert("b", 2);
        cache.insert("c", 3);

        cache.get(&"a");
        cache.get(&"b");
        cache.get(&"c");

        cache.insert("d", 4);

        assert!(cache.len() <= 3);
        assert!(cache.get(&"d").is_some());
    }

    #[test]
    fn test_remove() {
        let cache = LfuCache::new(10, Duration::from_secs(60));
        cache.insert("key1", "value1");
        assert!(cache.contains(&"key1"));

        let removed = cache.remove(&"key1");
        assert_eq!(removed, Some("value1"));
        assert!(!cache.contains(&"key1"));
    }

    #[test]
    fn test_contains() {
        let cache = LfuCache::new(10, Duration::from_secs(60));
        cache.insert("key1", "value1");
        assert!(cache.contains(&"key1"));
        assert!(!cache.contains(&"key2"));
    }

    #[test]
    fn test_len() {
        let cache = LfuCache::new(10, Duration::from_secs(60));
        assert_eq!(cache.len(), 0);
        cache.insert("a", 1);
        assert_eq!(cache.len(), 1);
        cache.insert("b", 2);
        assert_eq!(cache.len(), 2);
        cache.remove(&"a");
        assert_eq!(cache.len(), 1);
    }

    #[test]
    fn test_evict_expired() {
        let cache = LfuCache::new(10, Duration::from_secs(60));
        cache.insert_with_ttl("key1", "value1", Duration::from_millis(50));
        cache.insert_with_ttl("key2", "value2", Duration::from_millis(50));
        cache.insert("key3", "value3");

        assert_eq!(cache.len(), 3);
        std::thread::sleep(Duration::from_millis(100));

        let evicted = cache.evict_expired();
        assert_eq!(evicted, 2);
        assert_eq!(cache.len(), 1);
        assert!(cache.contains(&"key3"));
    }

    #[test]
    fn test_insert_overwrite() {
        let cache = LfuCache::new(10, Duration::from_secs(60));
        cache.insert("key1", "value1");
        cache.insert("key1", "value2");
        assert_eq!(cache.get(&"key1"), Some("value2"));
        assert_eq!(cache.len(), 1);
    }

    #[test]
    fn test_lfu_eviction_order() {
        let cache = LfuCache::new(3, Duration::from_secs(60));
        cache.insert("a", 1);
        cache.insert("b", 2);
        cache.insert("c", 3);

        cache.get(&"a");
        cache.get(&"a");
        cache.get(&"b");

        cache.insert("d", 4);

        assert!(cache.len() <= 3);
        assert!(cache.get(&"a").is_some());
        assert!(cache.get(&"b").is_some());
        assert!(cache.get(&"d").is_some());
    }
}
