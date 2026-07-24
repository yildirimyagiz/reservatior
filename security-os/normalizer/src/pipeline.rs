use std::sync::Arc;

use crate::errors::NormalizerError;
use crate::registry::NormalizerRegistry;
use crate::traits::{EventNormalizer, NormalizationResult, RawEvent};
use tracing::{debug, warn};

pub struct NormalizerPipeline {
    registry: NormalizerRegistry,
}

impl NormalizerPipeline {
    pub fn new(registry: NormalizerRegistry) -> Self {
        Self { registry }
    }

    pub async fn normalize(&self, event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
        let candidates: Vec<Arc<dyn EventNormalizer>> = self
            .registry
            .get_for_format(&event.source_format)
            .into_iter()
            .filter(|n| n.can_handle(event))
            .collect();

        if candidates.is_empty() {
            warn!(
                format = ?event.source_format,
                "No normalizer found for format"
            );
            return Err(NormalizerError::Unsupported(format!(
                "No normalizer registered for format {:?}",
                event.source_format
            )));
        }

        let mut best: Option<(f64, NormalizationResult)> = None;

        for normalizer in &candidates {
            let conf = normalizer.confidence(event);
            debug!(
                normalizer = normalizer.name(),
                confidence = conf,
                "Trying normalizer"
            );

            match normalizer.normalize(event).await {
                Ok(result) => {
                    let effective_confidence = result.confidence.min(conf);
                    if best.as_ref().map_or(true, |(bc, _)| effective_confidence > *bc) {
                        best = Some((effective_confidence, result));
                    }
                }
                Err(e) => {
                    warn!(
                        normalizer = normalizer.name(),
                        error = %e,
                        "Normalizer failed"
                    );
                }
            }
        }

        best.map(|(_, r)| r).ok_or_else(|| NormalizerError::Failed("All normalizers failed for this event".into()))
    }

    pub fn registry(&self) -> &NormalizerRegistry {
        &self.registry
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::traits::{SourceFormat, NormalizationResult};
    use async_trait::async_trait;
    use chrono::Utc;
    use security_os_core::*;
    use std::collections::HashMap;

    struct HighConfNormalizer;
    struct LowConfNormalizer;

    fn dummy_event() -> RawEvent {
        RawEvent {
            source_format: SourceFormat::Json,
            payload: serde_json::json!({"severity": "high"}),
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        }
    }

    fn dummy_security_event() -> SecurityEvent {
        SecurityEvent::new(
            EventCategory::System,
            EventAction::Detected,
            EventSource {
                collector: "test".into(),
                host_id: "h1".into(),
                host_name: "test-host".into(),
                agent_id: "a1".into(),
                agent_version: None,
                process_name: None,
                process_id: None,
                user_id: None,
                user_name: None,
                container_id: None,
                container_name: None,
                pod_name: None,
                namespace: None,
                service_name: None,
            },
            "Test Event",
            "Test description",
        )
    }

    #[async_trait]
    impl EventNormalizer for HighConfNormalizer {
        fn format(&self) -> SourceFormat { SourceFormat::Json }
        fn name(&self) -> &str { "high-conf" }
        fn can_handle(&self, _event: &RawEvent) -> bool { true }
        async fn normalize(&self, _event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
            Ok(NormalizationResult {
                event: dummy_security_event(),
                source_format: SourceFormat::Json,
                confidence: 0.95,
                warnings: vec![],
                unmapped_fields: vec![],
            })
        }
        fn confidence(&self, _event: &RawEvent) -> f64 { 0.95 }
    }

    #[async_trait]
    impl EventNormalizer for LowConfNormalizer {
        fn format(&self) -> SourceFormat { SourceFormat::Json }
        fn name(&self) -> &str { "low-conf" }
        fn can_handle(&self, _event: &RawEvent) -> bool { true }
        async fn normalize(&self, _event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
            Ok(NormalizationResult {
                event: dummy_security_event(),
                source_format: SourceFormat::Json,
                confidence: 0.3,
                warnings: vec![],
                unmapped_fields: vec![],
            })
        }
        fn confidence(&self, _event: &RawEvent) -> f64 { 0.3 }
    }

    #[tokio::test]
    async fn test_pipeline_picks_highest_confidence() {
        let reg = NormalizerRegistry::new();
        reg.register(Arc::new(LowConfNormalizer));
        reg.register(Arc::new(HighConfNormalizer));
        let pipeline = NormalizerPipeline::new(reg);
        let result = pipeline.normalize(&dummy_event()).await.unwrap();
        assert_eq!(result.confidence, 0.95);
    }

    #[tokio::test]
    async fn test_pipeline_no_normalizer_returns_error() {
        let reg = NormalizerRegistry::new();
        let pipeline = NormalizerPipeline::new(reg);
        let result = pipeline.normalize(&dummy_event()).await;
        assert!(result.is_err());
        match result.unwrap_err() {
            NormalizerError::Unsupported(_) => {}
            other => panic!("Expected Unsupported, got {:?}", other),
        }
    }
}
