pub mod errors;
pub mod traits;
pub mod registry;
pub mod pipeline;
pub mod sigma;
pub mod otel;
pub mod cef;
pub mod ecs;
pub mod syslog;
pub mod json;
pub mod tests;

pub use errors::NormalizerError;
pub use traits::{RawEvent, SourceFormat, NormalizationResult, EventNormalizer};
pub use registry::NormalizerRegistry;
pub use pipeline::NormalizerPipeline;
pub use sigma::SigmaNormalizer;
pub use otel::OtelNormalizer;
pub use cef::CefNormalizer;
pub use ecs::EcsNormalizer;
pub use syslog::SyslogNormalizer;
pub use json::JsonNormalizer;

use std::sync::Arc;

pub fn default_registry() -> NormalizerRegistry {
    let registry = NormalizerRegistry::new();
    registry.register(Arc::new(SigmaNormalizer::new()));
    registry.register(Arc::new(OtelNormalizer::new()));
    registry.register(Arc::new(CefNormalizer::new()));
    registry.register(Arc::new(EcsNormalizer::new()));
    registry.register(Arc::new(SyslogNormalizer::new()));
    registry.register(Arc::new(JsonNormalizer::new()));
    registry
}
