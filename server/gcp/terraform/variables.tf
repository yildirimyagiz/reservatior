/**
 * GCP Terraform Variables
 * 
 * Configuration variables for Reservatior GCP infrastructure
 */

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "reservatior-prod"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "environment" {
  description = "Environment (staging, production)"
  type        = string
  default     = "production"
}

variable "vps_ip_address" {
  description = "VPS IP address for push subscription"
  type        = string
  default     = "72.62.163.166"
}

variable "vps_endpoint" {
  description = "VPS endpoint for push subscription"
  type        = string
  default     = "https://72.62.163.166/api/v1/edge/events"
}

variable "enable_apis" {
  description = "Enable GCP APIs"
  type        = bool
  default     = true
}

variable "create_pubsub_topics" {
  description = "Create Pub/Sub topics"
  type        = bool
  default     = true
}

variable "create_cloud_run_services" {
  description = "Create Cloud Run services"
  type        = bool
  default     = false
}

variable "create_bigquery_dataset" {
  description = "Create BigQuery dataset"
  type        = bool
  default     = false
}
