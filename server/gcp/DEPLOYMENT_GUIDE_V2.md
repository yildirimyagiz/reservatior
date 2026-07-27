# Reservatior GCP Deployment Guide v2

## Overview

This guide covers deploying Reservatior's GCP infrastructure using Terraform. The infrastructure includes Pub/Sub topics/subscriptions for event-driven architecture, with optional Cloud Run services and BigQuery dataset.

## Prerequisites

- GCP Project: `reservatior-prod`
- Terraform installed
- GCP CLI installed and authenticated
- Service account with appropriate permissions

## Phase 3: Terraform Deployment

### Step 1: Initialize Terraform

```bash
cd /Users/os2026/Downloads/Reservatior/server/gcp/terraform
terraform init
```

### Step 2: Review Terraform Plan

```bash
terraform plan \
  -var="project_id=reservatior-prod" \
  -var="environment=production" \
  -var="vps_ip_address=72.62.163.166"
```

### Step 3: Apply Terraform Configuration

```bash
terraform apply \
  -var="project_id=reservatior-prod" \
  -var="environment=production" \
  -var="vps_ip_address=72.62.163.166" \
  -auto-approve
```

### Step 4: Verify Deployment

```bash
# Check Pub/Sub topics
gcloud pubsub topics list --project=reservatior-prod

# Check Pub/Sub subscriptions
gcloud pubsub subscriptions list --project=reservatior-prod

# Check dead letter queue
gcloud pubsub topics describe dead-letter-queue --project=reservatior-prod
```

## Infrastructure Components

### Pub/Sub Topics

The following topics will be created:

1. **listing-ingested-v1** - New property listings
2. **property-normalized-v1** - Normalized property data
3. **valuation-completed-v1** - Valuation results
4. **spatial-analysis-completed-v1** - Spatial analysis results
5. **property-embedding-created-v1** - Property embeddings
6. **opportunity-detected-v1** - Opportunity detection
7. **opportunity-scored-v1** - Opportunity scoring results
8. **opportunity-approved-v1** - Acquisition approval
9. **property-claimed-v1** - Property ownership claims
10. **campaign-created-v1** - Campaign creation
11. **campaign-launched-v1** - Campaign launch
12. **lead-generated-v1** - Lead generation
13. **transaction-completed-v1** - Transaction completion
14. **commission-generated-v1** - Commission generation

### Pub/Sub Subscriptions

The following subscriptions will be created:

1. **property-intelligence-worker-sub** - Property intelligence agent
2. **valuation-worker-sub** - Valuation agent
3. **opportunity-engine-sub** - Opportunity engine
4. **strategic-brain-sub** - Strategic brain
5. **vps-edge-result-sub** - VPS edge worker (push subscription)

### Dead Letter Queue

- **dead-letter-queue** - Failed messages (14-day retention)

## Configuration Variables

### Required Variables

- `project_id` - GCP Project ID (default: `reservatior-prod`)
- `region` - GCP Region (default: `us-central1`)
- `vps_ip_address` - VPS IP address (default: `72.62.163.166`)
- `vps_endpoint` - VPS endpoint (default: `https://72.62.163.166/api/v1/edge/events`)

### Optional Variables

- `environment` - Environment (default: `production`)
- `enable_apis` - Enable GCP APIs (default: `true`)
- `create_pubsub_topics` - Create Pub/Sub topics (default: `true`)
- `create_cloud_run_services` - Create Cloud Run services (default: `false`)
- `create_bigquery_dataset` - Create BigQuery dataset (default: `false`)

## IAM Permissions

Required IAM roles for deployment:

- `roles/pubsub.admin`
- `roles/iam.serviceAccountAdmin`
- `roles/resourcemanager.projectIamAdmin`
- `roles/cloudrun.admin` (if creating Cloud Run services)
- `roles/bigquery.admin` (if creating BigQuery dataset)

## Service Accounts

The following service accounts will be created (if Cloud Run is enabled):

1. **sa-strategic-brain** - Strategic Brain service account
2. **sa-opportunity-engine** - Opportunity Engine service account
3. **sa-vps-worker** - VPS Worker service account

## VPS Integration

### Push Subscription Configuration

The VPS push subscription is configured with:

- **Push Endpoint**: `https://72.62.163.166/api/v1/edge/events`
- **OIDC Token**: Service account authentication
- **Audience**: `https://72.62.163.166`

### VPS Service Account

The VPS worker service account (`sa-vps-worker`) has the following IAM role:

- `roles/pubsub.subscriber` - Subscribe to Pub/Sub topics

## Testing the Deployment

### Test Event Publishing

```bash
# Publish a test event
gcloud pubsub topics publish listing-ingested-v1 \
  --project=reservatior-prod \
  --message='{
    "event_id": "test_001",
    "event_type": "listing.ingested.v1",
    "country_code": "TR",
    "data": {
      "property_id": "test_property_001",
      "source": "test"
    }
  }'
```

### Test Subscription

```bash
# Pull from subscription
gcloud pubsub subscriptions pull vps-edge-result-sub \
  --project=reservatior-prod \
  --max-messages=1
```

## Troubleshooting

### Common Issues

1. **Permission Denied**
   - Ensure you have the required IAM roles
   - Run `gcloud auth login` to authenticate

2. **Topic Already Exists**
   - Use `terraform import` to import existing resources
   - Or delete existing resources manually

3. **Push Subscription Fails**
   - Verify VPS endpoint is accessible
   - Check firewall rules allow GCP Pub/Sub traffic
   - Verify OIDC token configuration

### Logs

```bash
# View Pub/Sub logs
gcloud logging read "resource.type=pubsub_topic" \
  --project=reservatior-prod \
  --limit=50

# View subscription logs
gcloud logging read "resource.type=pubsub_subscription" \
  --project=reservatior-prod \
  --limit=50
```

## Cleanup

To destroy the infrastructure:

```bash
terraform destroy \
  -var="project_id=reservatior-prod" \
  -var="environment=production" \
  -auto-approve
```

## Next Steps

After successful deployment:

1. **Configure VPS Environment Variables**
   - Add GCP credentials to `/etc/reservatior/gcp-prod-key.json`
   - Update systemd service configuration

2. **Deploy VPS Edge Worker**
   - Copy systemd service file
   - Enable and start the service

3. **Test Event Flow**
   - Create a test property via API
   - Verify event is published to Pub/Sub
   - Verify event is consumed by VPS worker

4. **Monitor Performance**
   - Setup Cloud Monitoring
   - Setup Cloud Logging
   - Setup Cloud Alerts

## Security Considerations

1. **Service Account Keys**
   - Store service account keys securely
   - Use Secret Manager for production
   - Rotate keys regularly

2. **Network Security**
   - Use VPC Service Controls if needed
   - Configure firewall rules
   - Enable VPC peering if required

3. **Data Encryption**
   - Enable Customer-Managed Encryption Keys (CMEK)
   - Use Cloud KMS for key management

## Cost Optimization

1. **Pub/Sub Pricing**
   - Monitor message volume
   - Use appropriate retention periods
   - Configure dead letter queue limits

2. **Cloud Run Pricing**
   - Configure appropriate CPU/memory limits
   - Use min/max instances
   - Enable autoscaling

3. **BigQuery Pricing**
   - Use query optimization
   - Configure partitioning
   - Use materialized views

## Support

For issues or questions:

- Check GCP Console: https://console.cloud.google.com
- Check Terraform state: `terraform show`
- Check logs: `gcloud logging read`
- Review this guide for troubleshooting steps
