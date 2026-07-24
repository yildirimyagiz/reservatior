use security_os_core::{SecurityOsError, SecurityEvent, Result};
use sqlx::postgres::{PgPool, PgPoolOptions};
use tracing::info;

pub struct EventStore {
    pool: PgPool,
}

impl EventStore {
    pub async fn new(connection_string: &str, max_connections: u32) -> Result<Self> {
        let pool = PgPoolOptions::new()
            .max_connections(max_connections)
            .connect(connection_string)
            .await
            .map_err(|e| SecurityOsError::Storage(format!("Connection failed: {}", e)))?;

        Self::run_migrations(&pool).await?;

        info!("EventStore initialized");
        Ok(Self { pool })
    }

    async fn run_migrations(pool: &PgPool) -> Result<()> {
        sqlx::query(
            r#"
            CREATE TABLE IF NOT EXISTS security_events (
                id UUID PRIMARY KEY,
                timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                category TEXT NOT NULL,
                action TEXT NOT NULL,
                severity TEXT NOT NULL,
                confidence DOUBLE PRECISION NOT NULL DEFAULT 1.0,
                source JSONB NOT NULL,
                title TEXT NOT NULL,
                description TEXT NOT NULL,
                metadata JSONB NOT NULL DEFAULT '{}',
                risk_score DOUBLE PRECISION NOT NULL DEFAULT 0.0,
                mitre_tactic TEXT,
                mitre_technique TEXT,
                mitre_id TEXT,
                correlation_id UUID,
                parent_event_id UUID,
                tags TEXT[] NOT NULL DEFAULT '{}',
                ioc_matches JSONB NOT NULL DEFAULT '[]',
                affected_entities JSONB NOT NULL DEFAULT '[]',
                created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
            );

            CREATE INDEX IF NOT EXISTS idx_events_timestamp ON security_events(timestamp DESC);
            CREATE INDEX IF NOT EXISTS idx_events_category ON security_events(category);
            CREATE INDEX IF NOT EXISTS idx_events_severity ON security_events(severity);
            CREATE INDEX IF NOT EXISTS idx_events_risk_score ON security_events(risk_score DESC);
            CREATE INDEX IF NOT EXISTS idx_events_correlation ON security_events(correlation_id);
            CREATE INDEX IF NOT EXISTS idx_events_host ON security_events((source->>'host_id'));
            CREATE INDEX IF NOT EXISTS idx_events_user ON security_events((source->>'user_name'));
            CREATE INDEX IF NOT EXISTS idx_events_tags ON security_events USING GIN(tags);

            CREATE TABLE IF NOT EXISTS risk_scores (
                entity_type TEXT NOT NULL,
                entity_value TEXT NOT NULL,
                score DOUBLE PRECISION NOT NULL DEFAULT 0.0,
                last_updated TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                metadata JSONB NOT NULL DEFAULT '{}',
                PRIMARY KEY (entity_type, entity_value)
            );

            CREATE INDEX IF NOT EXISTS idx_risk_score_value ON risk_scores(score DESC);

            CREATE TABLE IF NOT EXISTS ioc_cache (
                ioc_type TEXT NOT NULL,
                ioc_value TEXT NOT NULL,
                feed TEXT NOT NULL,
                severity TEXT NOT NULL,
                confidence DOUBLE PRECISION NOT NULL DEFAULT 1.0,
                first_seen TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                last_seen TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                metadata JSONB NOT NULL DEFAULT '{}',
                PRIMARY KEY (ioc_type, ioc_value, feed)
            );

            CREATE TABLE IF NOT EXISTS incidents (
                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                title TEXT NOT NULL,
                severity TEXT NOT NULL,
                status TEXT NOT NULL DEFAULT 'open',
                event_ids UUID[] NOT NULL DEFAULT '{}',
                created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                assigned_to TEXT,
                resolution TEXT
            );
            "#,
        )
        .execute(pool)
        .await
        .map_err(|e| SecurityOsError::Storage(format!("Migration failed: {}", e)))?;

        info!("Database migrations completed");
        Ok(())
    }

    pub async fn store_event(&self, event: &SecurityEvent) -> Result<()> {
        let source_json = serde_json::to_value(&event.source)
            .map_err(|e| SecurityOsError::Storage(e.to_string()))?;
        let metadata_json = serde_json::to_value(&event.metadata)
            .map_err(|e| SecurityOsError::Storage(e.to_string()))?;
        let ioc_json = serde_json::to_value(&event.ioc_matches)
            .map_err(|e| SecurityOsError::Storage(e.to_string()))?;
        let entities_json = serde_json::to_value(&event.affected_entities)
            .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

        sqlx::query(
            r#"
            INSERT INTO security_events (
                id, timestamp, category, action, severity, confidence,
                source, title, description, metadata, risk_score,
                mitre_tactic, mitre_technique, mitre_id,
                correlation_id, parent_event_id, tags, ioc_matches, affected_entities
            ) VALUES (
                $1, $2, $3, $4, $5, $6,
                $7, $8, $9, $10, $11,
                $12, $13, $14,
                $15, $16, $17, $18, $19
            )
            "#,
        )
        .bind(event.id)
        .bind(event.timestamp)
        .bind(format!("{:?}", event.category))
        .bind(format!("{:?}", event.action))
        .bind(event.severity.to_string())
        .bind(event.confidence)
        .bind(source_json)
        .bind(&event.title)
        .bind(&event.description)
        .bind(metadata_json)
        .bind(event.risk_score)
        .bind(&event.mitre_tactic)
        .bind(&event.mitre_technique)
        .bind(&event.mitre_id)
        .bind(event.correlation_id)
        .bind(event.parent_event_id)
        .bind(&event.tags)
        .bind(ioc_json)
        .bind(entities_json)
        .execute(&self.pool)
        .await
        .map_err(|e| SecurityOsError::Storage(format!("Store failed: {}", e)))?;

        Ok(())
    }

    pub async fn store_events_batch(&self, events: &[SecurityEvent]) -> Result<u64> {
        let mut tx = self.pool.begin()
            .await
            .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

        let mut count = 0u64;
        for event in events {
            let source_json = serde_json::to_value(&event.source)
                .map_err(|e| SecurityOsError::Storage(e.to_string()))?;
            let metadata_json = serde_json::to_value(&event.metadata)
                .map_err(|e| SecurityOsError::Storage(e.to_string()))?;
            let ioc_json = serde_json::to_value(&event.ioc_matches)
                .map_err(|e| SecurityOsError::Storage(e.to_string()))?;
            let entities_json = serde_json::to_value(&event.affected_entities)
                .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

            sqlx::query(
                r#"
                INSERT INTO security_events (
                    id, timestamp, category, action, severity, confidence,
                    source, title, description, metadata, risk_score,
                    mitre_tactic, mitre_technique, mitre_id,
                    correlation_id, parent_event_id, tags, ioc_matches, affected_entities
                ) VALUES (
                    $1, $2, $3, $4, $5, $6,
                    $7, $8, $9, $10, $11,
                    $12, $13, $14,
                    $15, $16, $17, $18, $19
                )
                "#,
            )
            .bind(event.id)
            .bind(event.timestamp)
            .bind(format!("{:?}", event.category))
            .bind(format!("{:?}", event.action))
            .bind(event.severity.to_string())
            .bind(event.confidence)
            .bind(source_json)
            .bind(&event.title)
            .bind(&event.description)
            .bind(metadata_json)
            .bind(event.risk_score)
            .bind(&event.mitre_tactic)
            .bind(&event.mitre_technique)
            .bind(&event.mitre_id)
            .bind(event.correlation_id)
            .bind(event.parent_event_id)
            .bind(&event.tags)
            .bind(ioc_json)
            .bind(entities_json)
            .execute(&mut *tx)
            .await
            .map_err(|e| SecurityOsError::Storage(format!("Batch store failed: {}", e)))?;
            count += 1;
        }

        tx.commit()
            .await
            .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

        Ok(count)
    }

    pub async fn query_events(
        &self,
        limit: i64,
        offset: i64,
        category: Option<&str>,
        severity: Option<&str>,
        min_risk: Option<f64>,
    ) -> Result<Vec<serde_json::Value>> {
        let mut query = String::from(
            "SELECT id, timestamp, category, action, severity, confidence, title, description, risk_score, tags FROM security_events WHERE 1=1"
        );

        if let Some(cat) = category {
            query.push_str(&format!(" AND category = '{}'", cat));
        }
        if let Some(sev) = severity {
            query.push_str(&format!(" AND severity = '{}'", sev));
        }
        if let Some(risk) = min_risk {
            query.push_str(&format!(" AND risk_score >= {}", risk));
        }
        query.push_str(&format!(" ORDER BY timestamp DESC LIMIT {} OFFSET {}", limit, offset));

        let rows = sqlx::query_scalar::<_, serde_json::Value>(&query)
            .fetch_all(&self.pool)
            .await
            .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

        Ok(rows)
    }

    pub async fn get_stats(&self) -> Result<serde_json::Value> {
        let total: (i64,) = sqlx::query_as("SELECT COUNT(*) FROM security_events")
            .fetch_one(&self.pool)
            .await
            .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

        let critical: (i64,) = sqlx::query_as(
            "SELECT COUNT(*) FROM security_events WHERE severity = 'CRITICAL'"
        )
        .fetch_one(&self.pool)
        .await
        .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

        let avg_risk: (Option<f64>,) = sqlx::query_as(
            "SELECT AVG(risk_score) FROM security_events WHERE timestamp > NOW() - INTERVAL '1 hour'"
        )
        .fetch_one(&self.pool)
        .await
        .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

        Ok(serde_json::json!({
            "total_events": total.0,
            "critical_events": critical.0,
            "avg_risk_score": avg_risk.0.unwrap_or(0.0),
        }))
    }

    pub async fn cleanup_old_events(&self, retention_days: u32) -> Result<u64> {
        let result = sqlx::query(
            "DELETE FROM security_events WHERE timestamp < NOW() - INTERVAL '1 day' * $1"
        )
        .bind(retention_days as i64)
        .execute(&self.pool)
        .await
        .map_err(|e| SecurityOsError::Storage(e.to_string()))?;

        Ok(result.rows_affected())
    }
}
