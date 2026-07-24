use std::collections::HashMap;
use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
use std::sync::Arc;
use std::time::{Duration, Instant};
use tokio::sync::Mutex;

#[derive(Debug, Clone)]
pub struct BackpressureConfig {
    pub max_queue_depth: usize,
    pub max_message_rate_per_sec: u64,
    pub slowdown_threshold_pct: u32,
    pub recovery_threshold_pct: u32,
    pub window_size: Duration,
}

impl Default for BackpressureConfig {
    fn default() -> Self {
        Self {
            max_queue_depth: 10_000,
            max_message_rate_per_sec: 1_000,
            slowdown_threshold_pct: 80,
            recovery_threshold_pct: 50,
            window_size: Duration::from_secs(1),
        }
    }
}

struct RateWindow {
    count: u64,
    window_start: Instant,
}

impl RateWindow {
    fn new(now: Instant) -> Self {
        Self {
            count: 0,
            window_start: now,
        }
    }
}

pub struct BackpressureManager {
    config: BackpressureConfig,
    is_slowed: Arc<AtomicBool>,
    total_backpressure_events: Arc<AtomicU64>,
    queue_depth: Arc<AtomicU64>,
    rate_windows: Arc<Mutex<HashMap<String, RateWindow>>>,
}

impl BackpressureManager {
    pub fn new(config: BackpressureConfig) -> Self {
        Self {
            config,
            is_slowed: Arc::new(AtomicBool::new(false)),
            total_backpressure_events: Arc::new(AtomicU64::new(0)),
            queue_depth: Arc::new(AtomicU64::new(0)),
            rate_windows: Arc::new(Mutex::new(HashMap::new())),
        }
    }

    pub async fn check_rate_limit(&self, topic: &str) -> bool {
        let now = Instant::now();
        let mut windows = self.rate_windows.lock().await;
        let window = windows
            .entry(topic.to_string())
            .or_insert_with(|| RateWindow::new(now));

        if now.duration_since(window.window_start) >= self.config.window_size {
            window.count = 0;
            window.window_start = now;
        }

        window.count += 1;

        if window.count > self.config.max_message_rate_per_sec {
            self.total_backpressure_events.fetch_add(1, Ordering::Relaxed);
            return false;
        }

        true
    }

    pub fn increment_queue_depth(&self) {
        let depth = self.queue_depth.fetch_add(1, Ordering::Relaxed) + 1;
        self.evaluate_threshold(depth);
    }

    pub fn decrement_queue_depth(&self) {
        let depth = self.queue_depth.fetch_sub(1, Ordering::Relaxed).saturating_sub(1);
        self.evaluate_threshold(depth);
    }

    fn evaluate_threshold(&self, depth: u64) {
        let max = self.config.max_queue_depth as u64;
        if max == 0 {
            return;
        }

        let pct = (depth * 100) / max;
        let was_slowed = self.is_slowed.load(Ordering::Relaxed);

        if !was_slowed && pct >= self.config.slowdown_threshold_pct as u64 {
            self.is_slowed.store(true, Ordering::Relaxed);
            self.total_backpressure_events.fetch_add(1, Ordering::Relaxed);
        } else if was_slowed && pct <= self.config.recovery_threshold_pct as u64 {
            self.is_slowed.store(false, Ordering::Relaxed);
        }
    }

    pub fn is_slowed(&self) -> bool {
        self.is_slowed.load(Ordering::Relaxed)
    }

    pub fn total_backpressure_events(&self) -> u64 {
        self.total_backpressure_events.load(Ordering::Relaxed)
    }

    pub fn current_queue_depth(&self) -> u64 {
        self.queue_depth.load(Ordering::Relaxed)
    }

    pub async fn should_throttle(&self, topic: &str) -> bool {
        if self.is_slowed() {
            return true;
        }
        !self.check_rate_limit(topic).await
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_rate_limit_within_bounds() {
        let config = BackpressureConfig {
            max_message_rate_per_sec: 5,
            window_size: Duration::from_secs(10),
            ..Default::default()
        };
        let manager = BackpressureManager::new(config);
        for _ in 0..5 {
            assert!(manager.check_rate_limit("topic-a").await);
        }
    }

    #[tokio::test]
    async fn test_rate_limit_exceeded() {
        let config = BackpressureConfig {
            max_message_rate_per_sec: 2,
            window_size: Duration::from_secs(10),
            ..Default::default()
        };
        let manager = BackpressureManager::new(config);
        assert!(manager.check_rate_limit("topic-a").await);
        assert!(manager.check_rate_limit("topic-a").await);
        assert!(!manager.check_rate_limit("topic-a").await);
    }

    #[test]
    fn test_queue_depth_triggers_slowdown() {
        let config = BackpressureConfig {
            max_queue_depth: 100,
            slowdown_threshold_pct: 80,
            recovery_threshold_pct: 50,
            ..Default::default()
        };
        let manager = BackpressureManager::new(config);
        assert!(!manager.is_slowed());
        for _ in 0..80 {
            manager.increment_queue_depth();
        }
        assert!(manager.is_slowed());
    }

    #[test]
    fn test_queue_depth_recovery() {
        let config = BackpressureConfig {
            max_queue_depth: 100,
            slowdown_threshold_pct: 80,
            recovery_threshold_pct: 50,
            ..Default::default()
        };
        let manager = BackpressureManager::new(config);
        for _ in 0..90 {
            manager.increment_queue_depth();
        }
        assert!(manager.is_slowed());
        for _ in 0..45 {
            manager.decrement_queue_depth();
        }
        assert!(!manager.is_slowed());
    }

    #[tokio::test]
    async fn test_backpressure_events_counted() {
        let config = BackpressureConfig {
            max_message_rate_per_sec: 1,
            window_size: Duration::from_secs(60),
            ..Default::default()
        };
        let manager = BackpressureManager::new(config);
        assert!(manager.check_rate_limit("t").await);
        assert!(!manager.check_rate_limit("t").await);
        assert!(manager.total_backpressure_events() >= 1);
    }
}
