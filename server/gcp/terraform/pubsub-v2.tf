/**
 * GCP Pub/Sub Configuration v2
 * 
 * Country-independent event bus for multi-country architecture
 * Domain-based topic naming: listing.ingested.v1, valuation.completed.v1, etc.
 */

# Pub/Sub Topics (Country-Independent)
resource "google_pubsub_topic" "listing_ingested_v1" {
  name = "listing-ingested-v1"
  
  message_retention_duration = "604800s" # 7 days
  
  labels = {
    domain = "listing"
    action = "ingested"
    version = "v1"
    environment = "production"
    type = "ingestion"
  }
}

resource "google_pubsub_topic" "property_normalized_v1" {
  name = "property-normalized-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "property"
    action = "normalized"
    version = "v1"
    environment = "production"
    type = "processing"
  }
}

resource "google_pubsub_topic" "valuation_completed_v1" {
  name = "valuation-completed-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "valuation"
    action = "completed"
    version = "v1"
    environment = "production"
    type = "intelligence"
  }
}

resource "google_pubsub_topic" "spatial_analysis_completed_v1" {
  name = "spatial-analysis-completed-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "spatial"
    action = "analysis.completed"
    version = "v1"
    environment = "production"
    type = "intelligence"
  }
}

resource "google_pubsub_topic" "property_embedding_created_v1" {
  name = "property-embedding-created-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "property"
    action = "embedding.created"
    version = "v1"
    environment = "production"
    type = "intelligence"
  }
}

resource "google_pubsub_topic" "opportunity_detected_v1" {
  name = "opportunity-detected-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "opportunity"
    action = "detected"
    version = "v1"
    environment = "production"
    type = "acquisition"
  }
}

resource "google_pubsub_topic" "opportunity_scored_v1" {
  name = "opportunity-scored-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "opportunity"
    action = "scored"
    version = "v1"
    environment = "production"
    type = "acquisition"
  }
}

resource "google_pubsub_topic" "opportunity_approved_v1" {
  name = "opportunity-approved-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "opportunity"
    action = "approved"
    version = "v1"
    environment = "production"
    type = "acquisition"
  }
}

resource "google_pubsub_topic" "property_claimed_v1" {
  name = "property-claimed-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "property"
    action = "claimed"
    version = "v1"
    environment = "production"
    type = "execution"
  }
}

resource "google_pubsub_topic" "campaign_created_v1" {
  name = "campaign-created-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "campaign"
    action = "created"
    version = "v1"
    environment = "production"
    type = "execution"
  }
}

resource "google_pubsub_topic" "campaign_launched_v1" {
  name = "campaign-launched-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "campaign"
    action = "launched"
    version = "v1"
    environment = "production"
    type = "execution"
  }
}

resource "google_pubsub_topic" "lead_generated_v1" {
  name = "lead-generated-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "lead"
    action = "generated"
    version = "v1"
    environment = "production"
    type = "execution"
  }
}

resource "google_pubsub_topic" "transaction_completed_v1" {
  name = "transaction-completed-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "transaction"
    action = "completed"
    version = "v1"
    environment = "production"
    type = "finance"
  }
}

resource "google_pubsub_topic" "commission_generated_v1" {
  name = "commission-generated-v1"
  
  message_retention_duration = "604800s"
  
  labels = {
    domain = "commission"
    action = "generated"
    version = "v1"
    environment = "production"
    type = "finance"
  }
}

# Pub/Sub Subscriptions for Google Cloud Agents
resource "google_pubsub_subscription" "property_intelligence_worker_sub" {
  name = "property-intelligence-worker-sub"
  topic = google_pubsub_topic.listing_ingested_v1.name
  
  ack_deadline_seconds = 60
  
  labels = {
    consumer = "property-intelligence-agent"
    environment = "production"
  }
}

resource "google_pubsub_subscription" "valuation_worker_sub" {
  name = "valuation-worker-sub"
  topic = google_pubsub_topic.property_normalized_v1.name
  
  ack_deadline_seconds = 60
  
  labels = {
    consumer = "valuation-agent"
    environment = "production"
  }
}

resource "google_pubsub_subscription" "opportunity_engine_sub" {
  name = "opportunity-engine-sub"
  topic = google_pubsub_topic.valuation_completed_v1.name
  
  ack_deadline_seconds = 60
  
  labels = {
    consumer = "opportunity-engine"
    environment = "production"
  }
}

resource "google_pubsub_subscription" "strategic_brain_sub" {
  name = "strategic-brain-sub"
  topic = google_pubsub_topic.opportunity_scored_v1.name
  
  ack_deadline_seconds = 60
  
  labels = {
    consumer = "strategic-brain"
    environment = "production"
  }
}

# Pub/Sub Subscription for VPS Edge Worker (Push)
resource "google_pubsub_subscription" "vps_edge_result_sub" {
  name = "vps-edge-result-sub"
  topic = google_pubsub_topic.opportunity_approved_v1.name
  
  ack_deadline_seconds = 60
  message_retention_duration = "604800s"
  
  push_config {
    push_endpoint = "https://72.62.163.166/api/v1/edge/events"
    oidc_token {
      service_account_email = "sa-vps-edge-worker@reservatior-prod.iam.gserviceaccount.com"
      audience = "https://72.62.163.166"
    }
  }
  
  labels = {
    consumer = "vps-edge-worker"
    environment = "production"
  }
}

# Dead Letter Queue for failed messages
resource "google_pubsub_topic" "dead_letter_queue" {
  name = "dead-letter-queue"
  
  message_retention_duration = "1209600s" # 14 days
  
  labels = {
    type = "dead-letter"
    environment = "production"
  }
}

# Output topic names
output "pubsub_topics" {
  value = {
    listing_ingested_v1 = google_pubsub_topic.listing_ingested_v1.name
    property_normalized_v1 = google_pubsub_topic.property_normalized_v1.name
    valuation_completed_v1 = google_pubsub_topic.valuation_completed_v1.name
    opportunity_scored_v1 = google_pubsub_topic.opportunity_scored_v1.name
    opportunity_approved_v1 = google_pubsub_topic.opportunity_approved_v1.name
  }
}

output "pubsub_subscriptions" {
  value = {
    property_intelligence_worker_sub = google_pubsub_subscription.property_intelligence_worker_sub.name
    valuation_worker_sub = google_pubsub_subscription.valuation_worker_sub.name
    opportunity_engine_sub = google_pubsub_subscription.opportunity_engine_sub.name
    strategic_brain_sub = google_pubsub_subscription.strategic_brain_sub.name
    vps_edge_result_sub = google_pubsub_subscription.vps_edge_result_sub.name
  }
}
