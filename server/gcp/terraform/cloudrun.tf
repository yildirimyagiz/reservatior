/**
 * GCP Cloud Run Configuration
 * 
 * Creates Cloud Run services for each agent/engine
 * Independent microservices with proper IAM roles
 */

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Service Accounts
resource "google_service_account" "sa_strategic_brain" {
  account_id   = "sa-strategic-brain"
  display_name = "Strategic Brain Service Account"
  description  = "Service account for Strategic Brain Cloud Run service"
}

resource "google_service_account" "sa_opportunity_engine" {
  account_id   = "sa-opportunity-engine"
  display_name = "Opportunity Engine Service Account"
  description  = "Service account for Opportunity Engine Cloud Run service"
}

resource "google_service_account" "sa_simulation_agent" {
  account_id   = "sa-simulation-agent"
  display_name = "Simulation Agent Service Account"
  description  = "Service account for Simulation Agent Cloud Run service"
}

resource "google_service_account" "sa_ranking_engine" {
  account_id   = "sa-ranking-engine"
  display_name = "Ranking Engine Service Account"
  description  = "Service account for Ranking Engine Cloud Run service"
}

resource "google_service_account" "sa_vps_worker" {
  account_id   = "sa-vps-worker"
  display_name = "VPS Worker Service Account"
  description  = "Service account for VPS event consumer"
}

# IAM Roles for Service Accounts
# Strategic Brain - needs Vertex AI and Pub/Sub access
resource "google_project_iam_member" "strategic_brain_vertex_ai_user" {
  project = "reservatior-prod"
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.sa_strategic_brain.email}"
}

resource "google_project_iam_member" "strategic_brain_pubsub_publisher" {
  project = "reservatior-prod"
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.sa_strategic_brain.email}"
}

resource "google_project_iam_member" "strategic_brain_pubsub_subscriber" {
  project = "reservatior-prod"
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.sa_strategic_brain.email}"
}

# Opportunity Engine - needs Pub/Sub and Feature Store access
resource "google_project_iam_member" "opportunity_engine_pubsub_publisher" {
  project = "reservatior-prod"
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.sa_opportunity_engine.email}"
}

resource "google_project_iam_member" "opportunity_engine_pubsub_subscriber" {
  project = "reservatior-prod"
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.sa_opportunity_engine.email}"
}

resource "google_project_iam_member" "opportunity_engine_feature_store_viewer" {
  project = "reservatior-prod"
  role    = "roles/aiplatform.featureStoreViewer"
  member  = "serviceAccount:${google_service_account.sa_opportunity_engine.email}"
}

# Simulation Agent - needs Pub/Sub access
resource "google_project_iam_member" "simulation_agent_pubsub_publisher" {
  project = "reservatior-prod"
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.sa_simulation_agent.email}"
}

resource "google_project_iam_member" "simulation_agent_pubsub_subscriber" {
  project = "reservatior-prod"
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.sa_simulation_agent.email}"
}

# Ranking Engine - needs Pub/Sub access
resource "google_project_iam_member" "ranking_engine_pubsub_publisher" {
  project = "reservatior-prod"
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.sa_ranking_engine.email}"
}

resource "google_project_iam_member" "ranking_engine_pubsub_subscriber" {
  project = "reservatior-prod"
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.sa_ranking_engine.email}"
}

# VPS Worker - needs Pub/Sub subscriber access
resource "google_project_iam_member" "vps_worker_pubsub_subscriber" {
  project = "reservatior-prod"
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.sa_vps_worker.email}"
}

# Cloud Run Services
resource "google_cloud_run_service" "strategic_brain_service" {
  name     = "strategic-brain-service"
  location = "us-central1"

  template {
    spec {
      service_account_name = google_service_account.sa_strategic_brain.email
      
      containers {
        image = "gcr.io/reservatior-prod/strategic-brain:v1.0.0"
        
        env {
          name  = "MODEL_NAME"
          value = "gemini-2.5-flash"
        }
        
        env {
          name  = "GCP_PROJECT_ID"
          value = "reservatior-prod"
        }
        
        env {
          name  = "PUBSUB_TOPIC_PREFIX"
          value = "reservatior-prod"
        }
        
        resources {
          limits = {
            cpu    = "1000m"
            memory = "1Gi"
          }
        }
      }
      
      container_concurrency = 80
      timeout_seconds       = 300
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service" "opportunity_engine_service" {
  name     = "opportunity-engine-service"
  location = "us-central1"

  template {
    spec {
      service_account_name = google_service_account.sa_opportunity_engine.email
      
      containers {
        image = "gcr.io/reservatior-prod/opportunity-engine:v1.0.0"
        
        env {
          name  = "GCP_PROJECT_ID"
          value = "reservatior-prod"
        }
        
        env {
          name  = "PUBSUB_TOPIC_PREFIX"
          value = "reservatior-prod"
        }
        
        resources {
          limits = {
            cpu    = "500m"
            memory = "512Mi"
          }
        }
      }
      
      container_concurrency = 100
      timeout_seconds       = 60
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service" "simulation_agent_service" {
  name     = "simulation-agent-service"
  location = "us-central1"

  template {
    spec {
      service_account_name = google_service_account.sa_simulation_agent.email
      
      containers {
        image = "gcr.io/reservatior-prod/simulation-agent:v1.0.0"
        
        env {
          name  = "GCP_PROJECT_ID"
          value = "reservatior-prod"
        }
        
        env {
          name  = "PUBSUB_TOPIC_PREFIX"
          value = "reservatior-prod"
        }
        
        resources {
          limits = {
            cpu    = "1000m"
            memory = "1Gi"
          }
        }
      }
      
      container_concurrency = 50
      timeout_seconds       = 120
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service" "ranking_engine_service" {
  name     = "ranking-engine-service"
  location = "us-central1"

  template {
    spec {
      service_account_name = google_service_account.sa_ranking_engine.email
      
      containers {
        image = "gcr.io/reservatior-prod/ranking-engine:v1.0.0"
        
        env {
          name  = "GCP_PROJECT_ID"
          value = "reservatior-prod"
        }
        
        env {
          name  = "PUBSUB_TOPIC_PREFIX"
          value = "reservatior-prod"
        }
        
        resources {
          limits = {
            cpu    = "500m"
            memory = "512Mi"
          }
        }
      }
      
      container_concurrency = 100
      timeout_seconds       = 60
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Cloud Run IAM - Allow public access (or restrict as needed)
resource "google_cloud_run_service_iam_member" "strategic_brain_public_access" {
  location = google_cloud_run_service.strategic_brain_service.location
  project  = google_cloud_run_service.strategic_brain_service.project
  service  = google_cloud_run_service.strategic_brain_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_service_iam_member" "opportunity_engine_public_access" {
  location = google_cloud_run_service.opportunity_engine_service.location
  project  = google_cloud_run_service.opportunity_engine_service.project
  service  = google_cloud_run_service.opportunity_engine_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Output service URLs
output "cloud_run_services" {
  value = {
    strategic_brain_url = google_cloud_run_service.strategic_brain_service.status[0].url
    opportunity_engine_url = google_cloud_run_service.opportunity_engine_service.status[0].url
    simulation_agent_url = google_cloud_run_service.simulation_agent_service.status[0].url
    ranking_engine_url = google_cloud_run_service.ranking_engine_service.status[0].url
  }
}

output "service_accounts" {
  value = {
    strategic_brain = google_service_account.sa_strategic_brain.email
    opportunity_engine = google_service_account.sa_opportunity_engine.email
    simulation_agent = google_service_account.sa_simulation_agent.email
    ranking_engine = google_service_account.sa_ranking_engine.email
    vps_worker = google_service_account.sa_vps_worker.email
  }
}
