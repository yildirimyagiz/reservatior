use std::collections::hash_map::DefaultHasher;
use std::hash::{Hash, Hasher};

pub struct BloomFilter {
    bits: Vec<u64>,
    size: usize,
    hash_count: usize,
    insert_count: u64,
}

impl BloomFilter {
    pub fn new(expected_items: usize, false_positive_rate: f64) -> Self {
        assert!(expected_items > 0, "expected_items must be > 0");
        assert!(
            false_positive_rate > 0.0 && false_positive_rate < 1.0,
            "false_positive_rate must be between 0 and 1"
        );

        let ln2 = 2.0_f64.ln();
        let ln2_sq = ln2 * ln2;
        let m = -((expected_items as f64) * false_positive_rate.ln()) / ln2_sq;
        let size = m.ceil() as usize;
        let size_words = (size + 63) / 64;
        let k = ((size as f64 / expected_items as f64) * ln2).round() as usize;
        let hash_count = k.max(1);

        Self {
            bits: vec![0u64; size_words],
            size,
            hash_count,
            insert_count: 0,
        }
    }

    pub fn insert(&mut self, item: &str) {
        let (h1, h2) = self.hash_pair(item);

        for i in 0..self.hash_count {
            let idx = self.get_index(h1, h2, i);
            let word = idx / 64;
            let bit = idx % 64;
            if word < self.bits.len() {
                self.bits[word] |= 1u64 << bit;
            }
        }
        self.insert_count += 1;
    }

    pub fn might_contain(&self, item: &str) -> bool {
        let (h1, h2) = self.hash_pair(item);

        for i in 0..self.hash_count {
            let idx = self.get_index(h1, h2, i);
            let word = idx / 64;
            let bit = idx % 64;
            if word >= self.bits.len() || (self.bits[word] & (1u64 << bit)) == 0 {
                return false;
            }
        }
        true
    }

    pub fn count(&self) -> u64 {
        self.insert_count
    }

    pub fn fill_ratio(&self) -> f64 {
        let total_bits = self.size as f64;
        let mut set_bits = 0u64;
        for &word in &self.bits {
            set_bits += word.count_ones() as u64;
        }
        set_bits as f64 / total_bits
    }

    pub fn reset(&mut self) {
        for word in &mut self.bits {
            *word = 0;
        }
        self.insert_count = 0;
    }

    fn hash_pair(&self, item: &str) -> (u64, u64) {
        let mut h1_hasher = DefaultHasher::new();
        item.hash(&mut h1_hasher);
        let h1 = h1_hasher.finish();

        let mut h2_hasher = DefaultHasher::new();
        h1.hash(&mut h2_hasher);
        for byte in item.bytes() {
            byte.hash(&mut h2_hasher);
        }
        let h2 = h2_hasher.finish();

        (h1, h2)
    }

    fn get_index(&self, h1: u64, h2: u64, i: usize) -> usize {
        let combined = h1.wrapping_add((i as u64).wrapping_mul(h2));
        (combined % self.size as u64) as usize
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_insert_and_might_contain() {
        let mut bloom = BloomFilter::new(100, 0.01);
        bloom.insert("hello");
        bloom.insert("world");
        assert!(bloom.might_contain("hello"));
        assert!(bloom.might_contain("world"));
        assert!(!bloom.might_contain("missing"));
    }

    #[test]
    fn test_fill_ratio() {
        let mut bloom = BloomFilter::new(1000, 0.01);
        let fill_before = bloom.fill_ratio();
        assert!(fill_before < 0.01);

        for i in 0..100 {
            bloom.insert(&format!("item_{}", i));
        }
        let fill_after = bloom.fill_ratio();
        assert!(fill_after > fill_before);
        assert!(fill_after < 0.5);
    }

    #[test]
    fn test_count() {
        let mut bloom = BloomFilter::new(100, 0.01);
        assert_eq!(bloom.count(), 0);
        bloom.insert("a");
        bloom.insert("b");
        assert_eq!(bloom.count(), 2);
    }

    #[test]
    fn test_reset() {
        let mut bloom = BloomFilter::new(100, 0.01);
        bloom.insert("hello");
        bloom.insert("world");
        assert!(bloom.might_contain("hello"));
        bloom.reset();
        assert!(!bloom.might_contain("hello"));
        assert_eq!(bloom.count(), 0);
        assert!(bloom.fill_ratio() < 0.001);
    }

    #[test]
    fn test_false_positive_rate() {
        let mut bloom = BloomFilter::new(10000, 0.01);
        for i in 0..1000 {
            bloom.insert(&format!("inserted_{}", i));
        }

        let mut false_positives = 0;
        let test_count = 10000;
        for i in 0..test_count {
            if bloom.might_contain(&format!("not_inserted_{}", i)) {
                false_positives += 1;
            }
        }

        let fp_rate = false_positives as f64 / test_count as f64;
        assert!(
            fp_rate < 0.05,
            "false positive rate too high: {}",
            fp_rate
        );
    }
}
