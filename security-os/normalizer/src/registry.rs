use dashmap::DashMap;
use std::sync::Arc;

use crate::traits::EventNormalizer;

pub struct NormalizerRegistry {
    normalizers: DashMap<String, Arc<dyn EventNormalizer>>,
    format_order: DashMap<crate::traits::SourceFormat, Vec<String>>,
}

impl NormalizerRegistry {
    pub fn new() -> Self {
        Self {
            normalizers: DashMap::new(),
            format_order: DashMap::new(),
        }
    }

    pub fn register(&self, normalizer: Arc<dyn EventNormalizer>) {
        let name = normalizer.name().to_string();
        let format = normalizer.format();
        self.normalizers.insert(name.clone(), normalizer);
        self.format_order
            .entry(format)
            .or_default()
            .push(name);
    }

    pub fn get(&self, name: &str) -> Option<Arc<dyn EventNormalizer>> {
        self.normalizers.get(name).map(|r| Arc::clone(&r))
    }

    pub fn list(&self) -> Vec<String> {
        self.normalizers.iter().map(|r| r.key().clone()).collect()
    }

    pub fn get_for_format(&self, format: &crate::traits::SourceFormat) -> Vec<Arc<dyn EventNormalizer>> {
        self.format_order
            .get(format)
            .map(|names| {
                names
                    .iter()
                    .filter_map(|n| self.normalizers.get(n).map(|r| Arc::clone(&r)))
                    .collect()
            })
            .unwrap_or_default()
    }

    pub fn count(&self) -> usize {
        self.normalizers.len()
    }
}

impl Default for NormalizerRegistry {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::traits::{EventNormalizer, RawEvent, NormalizationResult, SourceFormat};
    use crate::errors::NormalizerError;
    use async_trait::async_trait;

    struct DummyNormalizer {
        name: String,
    }

    #[async_trait]
    impl EventNormalizer for DummyNormalizer {
        fn format(&self) -> SourceFormat { SourceFormat::Json }
        fn name(&self) -> &str { &self.name }
        fn can_handle(&self, _event: &RawEvent) -> bool { true }
        async fn normalize(&self, _event: &RawEvent) -> Result<NormalizationResult, NormalizerError> {
            unimplemented!()
        }
        fn confidence(&self, _event: &RawEvent) -> f64 { 1.0 }
    }

    #[test]
    fn test_register_and_get() {
        let reg = NormalizerRegistry::new();
        let n: Arc<dyn EventNormalizer> = Arc::new(DummyNormalizer { name: "test-norm".into() });
        reg.register(n);
        assert!(reg.get("test-norm").is_some());
        assert!(reg.get("nonexistent").is_none());
        assert_eq!(reg.count(), 1);
    }

    #[test]
    fn test_list() {
        let reg = NormalizerRegistry::new();
        reg.register(Arc::new(DummyNormalizer { name: "a".into() }));
        reg.register(Arc::new(DummyNormalizer { name: "b".into() }));
        let mut names = reg.list();
        names.sort();
        assert_eq!(names, vec!["a", "b"]);
    }

    #[test]
    fn test_get_for_format() {
        let reg = NormalizerRegistry::new();
        reg.register(Arc::new(DummyNormalizer { name: "json-norm".into() }));
        let for_json = reg.get_for_format(&SourceFormat::Json);
        assert_eq!(for_json.len(), 1);
        let for_syslog = reg.get_for_format(&SourceFormat::Syslog);
        assert!(for_syslog.is_empty());
    }
}
