use std::collections::hash_map::DefaultHasher;
use std::hash::{Hash, Hasher};

pub struct HyperLogLog {
    registers: Vec<u8>,
    num_registers: usize,
    precision: u8,
}

impl HyperLogLog {
    pub fn new(precision: u8) -> Self {
        assert!(
            precision >= 4 && precision <= 16,
            "precision must be between 4 and 16, got {}",
            precision
        );

        let num_registers = 1usize << precision;

        Self {
            registers: vec![0u8; num_registers],
            num_registers,
            precision,
        }
    }

    pub fn add(&mut self, item: &str) {
        let hash = self.compute_hash(item);
        let register_idx = (hash >> (64 - self.precision)) as usize;
        let remaining = hash << self.precision;
        let leading_zeros = remaining.leading_zeros() as u8 + 1;
        let max_val = self.registers[register_idx];
        if leading_zeros > max_val {
            self.registers[register_idx] = leading_zeros;
        }
    }

    pub fn count(&self) -> u64 {
        let m = self.num_registers as f64;
        let alpha = self.compute_alpha();

        let raw_sum: f64 = self
            .registers
            .iter()
            .map(|&r| 2.0_f64.powi(-(r as i32)))
            .sum();

        let estimate = alpha * m * m / raw_sum;

        let small_range_correction = estimate <= 2.5 * m;
        if small_range_correction {
            let zeros = self.registers.iter().filter(|&&r| r == 0).count() as f64;
            if zeros > 0.0 {
                return (m * (m / zeros).ln()).round() as u64;
            }
        }

        let large_range_limit = (1u64 << 32) as f64 / 30.0;
        if estimate > large_range_limit {
            return (-(1i64 << 32) as f64 * (1.0 - hash_to_double(self.compute_hash("max")))).round() as u64;
        }

        estimate.round() as u64
    }

    pub fn merge(&mut self, other: &HyperLogLog) {
        assert_eq!(
            self.precision, other.precision,
            "cannot merge HyperLogLogs with different precision"
        );

        for (a, b) in self.registers.iter_mut().zip(other.registers.iter()) {
            if *b > *a {
                *a = *b;
            }
        }
    }

    pub fn reset(&mut self) {
        for r in &mut self.registers {
            *r = 0;
        }
    }

    fn compute_hash(&self, item: &str) -> u64 {
        let mut hasher = DefaultHasher::new();
        item.hash(&mut hasher);
        hasher.finish()
    }

    fn compute_alpha(&self) -> f64 {
        match self.precision {
            4 => 0.673,
            5 => 0.697,
            6 => 0.709,
            _ => 0.7213 / (1.0 + 1.079 / self.num_registers as f64),
        }
    }
}

fn hash_to_double(hash: u64) -> f64 {
    hash as f64 / u64::MAX as f64
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add_and_count() {
        let mut hll = HyperLogLog::new(14);
        for i in 0..1000 {
            hll.add(&format!("item_{}", i));
        }
        let count = hll.count();
        let error = (count as f64 - 1000.0).abs() / 1000.0;
        assert!(
            error < 0.10,
            "count {} is more than 10%% off from 1000",
            count
        );
    }

    #[test]
    fn test_count_accuracy_large() {
        let mut hll = HyperLogLog::new(14);
        for i in 0..10000 {
            hll.add(&format!("unique_{}", i));
        }
        let count = hll.count();
        let error = (count as f64 - 10000.0).abs() / 10000.0;
        assert!(
            error < 0.10,
            "count {} is more than 10%% off from 10000",
            count
        );
    }

    #[test]
    fn test_duplicates_not_counted() {
        let mut hll = HyperLogLog::new(14);
        for _ in 0..100 {
            hll.add("same_item");
        }
        let count = hll.count();
        assert!(count <= 5, "expected count near 1 for duplicates, got {}", count);
    }

    #[test]
    fn test_merge() {
        let mut hll1 = HyperLogLog::new(14);
        let mut hll2 = HyperLogLog::new(14);

        for i in 0..500 {
            hll1.add(&format!("a_{}", i));
        }
        for i in 500..1000 {
            hll2.add(&format!("b_{}", i));
        }

        hll1.merge(&hll2);
        let count = hll1.count();
        let error = (count as f64 - 1000.0).abs() / 1000.0;
        assert!(
            error < 0.12,
            "merged count {} is more than 12%% off from 1000",
            count
        );
    }

    #[test]
    fn test_reset() {
        let mut hll = HyperLogLog::new(10);
        for i in 0..100 {
            hll.add(&format!("item_{}", i));
        }
        assert!(hll.count() > 0);
        hll.reset();
        assert_eq!(hll.count(), 0);
    }

    #[test]
    fn test_different_precision() {
        let mut hll_low = HyperLogLog::new(4);
        let mut hll_high = HyperLogLog::new(14);

        for i in 0..100 {
            hll_low.add(&format!("item_{}", i));
            hll_high.add(&format!("item_{}", i));
        }

        let count_low = hll_low.count();
        let count_high = hll_high.count();

        let error_low = (count_low as f64 - 100.0).abs() / 100.0;
        let error_high = (count_high as f64 - 100.0).abs() / 100.0;

        assert!(
            error_high < error_low,
            "higher precision ({}) should be more accurate than lower ({})",
            error_high,
            error_low
        );
    }
}
