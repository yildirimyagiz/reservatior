use std::collections::{HashMap, VecDeque};
use std::convert::Infallible;
use std::net::SocketAddr;
use std::pin::Pin;
use std::sync::Arc;

use axum::extract::{Path, Query, State};
use axum::http::StatusCode;
use axum::response::sse::{Event as SseEvent, KeepAlive, Sse};
use axum::response::{IntoResponse, Json, Response};
use axum::routing::get;
use axum::Router;
use futures::stream::Stream;
use serde::{Deserialize, Serialize};
use tokio::net::TcpListener;
use tokio::sync::RwLock;
use tower_http::cors::{Any, CorsLayer};
use tower_http::trace::TraceLayer;
use tracing::{error, info};
use uuid::Uuid;

use security_os_core::{EventBus, SecurityEvent, Severity};

const MAX_RECENT_EVENTS: usize = 1000;
const API_VERSION: &str = "0.1.0";

type BoxStream = Pin<Box<dyn Stream<Item = Result<SseEvent, Infallible>> + Send>>;

#[derive(Clone)]
pub struct ApiServer {
    bus: EventBus,
    bind_address: String,
    state: Arc<ApiState>,
}

pub struct ApiState {
    bus: EventBus,
    recent_events: RwLock<VecDeque<SecurityEvent>>,
}

#[derive(Serialize)]
struct HealthResponse {
    status: String,
    version: String,
}

#[derive(Deserialize)]
struct EventsQuery {
    limit: Option<usize>,
    category: Option<String>,
}

#[derive(Serialize)]
struct EventStatsResponse {
    total_events: usize,
    by_category: HashMap<String, usize>,
    by_severity: HashMap<String, usize>,
}

#[derive(Serialize)]
struct SeverityDistribution {
    informational: usize,
    low: usize,
    medium: usize,
    high: usize,
    critical: usize,
}

#[derive(Serialize)]
struct ErrorResponse {
    error: String,
}

impl ApiServer {
    pub fn new(bus: EventBus, bind_address: String) -> Self {
        let state = Arc::new(ApiState {
            bus: bus.clone(),
            recent_events: RwLock::new(VecDeque::with_capacity(MAX_RECENT_EVENTS)),
        });
        Self {
            bus,
            bind_address,
            state,
        }
    }

    pub async fn run(self) {
        let state = self.state.clone();

        tokio::spawn(async move {
            Self::event_collector_task(state.clone()).await;
        });

        let app = self.build_router();

        let addr: SocketAddr = self
            .bind_address
            .parse()
            .expect("Invalid bind address");
        info!(address = %addr, "API server starting");

        let listener = TcpListener::bind(addr).await.unwrap();
        axum::serve(listener, app).await.unwrap();
    }

    fn build_router(&self) -> Router {
        let cors = CorsLayer::new()
            .allow_origin(Any)
            .allow_methods(Any)
            .allow_headers(Any);

        Router::new()
            .route("/api/health", get(health_handler))
            .route("/api/events", get(events_handler))
            .route("/api/events/{id}", get(event_by_id_handler))
            .route("/api/stats", get(stats_handler))
            .route(
                "/api/severity-distribution",
                get(severity_distribution_handler),
            )
            .route("/api/stream", get(sse_handler))
            .layer(cors)
            .layer(TraceLayer::new_for_http())
            .with_state(self.state.clone())
    }

    async fn event_collector_task(state: Arc<ApiState>) {
        let mut rx = state.bus.subscribe();
        loop {
            match rx.recv().await {
                Ok(event) => {
                    let mut events = state.recent_events.write().await;
                    if events.len() >= MAX_RECENT_EVENTS {
                        events.pop_front();
                    }
                    events.push_back(event);
                }
                Err(tokio::sync::broadcast::error::RecvError::Lagged(n)) => {
                    error!("Event collector lagged, missed {} events", n);
                }
                Err(tokio::sync::broadcast::error::RecvError::Closed) => {
                    info!("Event bus closed, stopping event collector");
                    break;
                }
            }
        }
    }
}

async fn health_handler() -> Json<HealthResponse> {
    Json(HealthResponse {
        status: "ok".to_string(),
        version: API_VERSION.to_string(),
    })
}

async fn events_handler(
    State(state): State<Arc<ApiState>>,
    Query(query): Query<EventsQuery>,
) -> Json<Vec<SecurityEvent>> {
    let limit = query.limit.unwrap_or(100).min(1000);
    let events = state.recent_events.read().await;

    let filtered: Vec<SecurityEvent> = events
        .iter()
        .rev()
        .filter(|e| {
            query
                .category
                .as_ref()
                .map(|c| format!("{:?}", e.category) == *c)
                .unwrap_or(true)
        })
        .take(limit)
        .cloned()
        .collect();

    Json(filtered)
}

async fn event_by_id_handler(
    State(state): State<Arc<ApiState>>,
    Path(id): Path<Uuid>,
) -> Result<Json<SecurityEvent>, (StatusCode, Json<ErrorResponse>)> {
    let events = state.recent_events.read().await;
    events
        .iter()
        .find(|e| e.id == id)
        .cloned()
        .map(Json)
        .ok_or_else(|| {
            (
                StatusCode::NOT_FOUND,
                Json(ErrorResponse {
                    error: format!("Event {} not found", id),
                }),
            )
        })
}

async fn stats_handler(State(state): State<Arc<ApiState>>) -> Json<EventStatsResponse> {
    let events = state.recent_events.read().await;

    let mut by_category: HashMap<String, usize> = HashMap::new();
    let mut by_severity: HashMap<String, usize> = HashMap::new();

    for event in events.iter() {
        *by_category
            .entry(format!("{:?}", event.category))
            .or_insert(0) += 1;
        *by_severity
            .entry(event.severity.to_string())
            .or_insert(0) += 1;
    }

    Json(EventStatsResponse {
        total_events: events.len(),
        by_category,
        by_severity,
    })
}

async fn severity_distribution_handler(
    State(state): State<Arc<ApiState>>,
) -> Json<SeverityDistribution> {
    let events = state.recent_events.read().await;

    let mut dist = SeverityDistribution {
        informational: 0,
        low: 0,
        medium: 0,
        high: 0,
        critical: 0,
    };

    for event in events.iter() {
        match event.severity {
            Severity::Informational => dist.informational += 1,
            Severity::Low => dist.low += 1,
            Severity::Medium => dist.medium += 1,
            Severity::High => dist.high += 1,
            Severity::Critical => dist.critical += 1,
        }
    }

    Json(dist)
}

async fn sse_handler(State(state): State<Arc<ApiState>>) -> Response {
    let bus = state.bus.clone();

    let stream: BoxStream = Box::pin(async_stream::stream! {
        let mut rx = bus.subscribe();

        loop {
            match rx.recv().await {
                Ok(event) => {
                    match serde_json::to_string(&event) {
                        Ok(data) => {
                            yield Ok(SseEvent::default()
                                .event("security-event")
                                .data(data));
                        }
                        Err(e) => {
                            error!("Failed to serialize event: {}", e);
                        }
                    }
                }
                Err(tokio::sync::broadcast::error::RecvError::Lagged(n)) => {
                    error!("SSE stream lagged, missed {} events", n);
                }
                Err(tokio::sync::broadcast::error::RecvError::Closed) => {
                    break;
                }
            }
        }
    });

    Sse::new(stream)
        .keep_alive(
            KeepAlive::new()
                .interval(std::time::Duration::from_secs(30))
                .text("ping"),
        )
        .into_response()
}
