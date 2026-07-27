/**
 * VPS Edge Event Publisher
 * 
 * Publishes events to Google Cloud Pub/Sub
 * NO AI processing on VPS - only event publishing
 */

import { EventFactory, EventEnvelope } from '../events/base/event-envelope';
import { databaseRouter } from '../database/database-router';

export class EdgeEventPublisher {
  private projectId: string;
  private topicPrefix: string;

  constructor() {
    this.projectId = process.env.GCP_PROJECT_ID || 'reservatior-prod';
    this.topicPrefix = process.env.GCP_PUBSUB_TOPIC_PREFIX || 'reservatior-prod';
  }

  /**
   * Publish event to Google Cloud Pub/Sub
   */
  async publish(event: EventEnvelope): Promise<{ success: boolean; event_id: string; topic: string }> {
    const topic = `${this.topicPrefix}-${event.event_type}`;
    
    console.log(`[EdgeEventPublisher] Publishing to topic: ${topic}`);
    console.log(`[EdgeEventPublisher] Event: ${event.event_id} | Type: ${event.event_type} | Country: ${event.country_code}`);

    // TODO: Implement actual Pub/Sub publishing
    // const { PubSub } = require('@google-cloud/pubsub');
    // const pubsub = new PubSub({ projectId: this.projectId });
    // const topicObj = pubsub.topic(topic);
    // await topicObj.publishMessage({ data: Buffer.from(JSON.stringify(event)) });

    console.log(`[EdgeEventPublisher] Event published successfully (simulated)`);

    return {
      success: true,
      event_id: event.event_id,
      topic
    };
  }

  /**
   * Publish listing ingested event
   * Called when new property is created in any country database
   */
  async publishListingIngested(params: {
    country_code: string;
    property_id: string;
    source: string;
    source_listing_id: string;
    property_data: any;
  }) {
    const event = EventFactory.createListingIngestedEvent(params);
    return await this.publish(event);
  }

  /**
   * Publish property updated event
   */
  async publishPropertyUpdated(params: {
    country_code: string;
    property_id: string;
    update_data: any;
  }) {
    const event = EventFactory.createEvent({
      event_type: 'property.updated.v1',
      producer: 'reservatior-edge',
      country_code: params.country_code,
      data: {
        property_id: params.property_id,
        update_data: params.update_data
      }
    });
    return await this.publish(event);
  }

  /**
   * Publish property claimed event
   */
  async publishPropertyClaimed(params: {
    country_code: string;
    property_id: string;
    owner_id: string;
    claim_data: any;
  }) {
    const event = EventFactory.createEvent({
      event_type: 'property.claimed.v1',
      producer: 'reservatior-edge',
      country_code: params.country_code,
      data: {
        property_id: params.property_id,
        owner_id: params.owner_id,
        claim_data: params.claim_data
      }
    });
    return await this.publish(event);
  }

  /**
   * Publish campaign created event
   */
  async publishCampaignCreated(params: {
    country_code: string;
    campaign_id: string;
    campaign_data: any;
  }) {
    const event = EventFactory.createEvent({
      event_type: 'campaign.created.v1',
      producer: 'reservatior-edge',
      country_code: params.country_code,
      data: {
        campaign_id: params.campaign_id,
        campaign_data: params.campaign_data
      }
    });
    return await this.publish(event);
  }

  /**
   * Publish transaction completed event
   */
  async publishTransactionCompleted(params: {
    country_code: string;
    transaction_id: string;
    transaction_data: any;
  }) {
    const event = EventFactory.createEvent({
      event_type: 'transaction.completed.v1',
      producer: 'reservatior-edge',
      country_code: params.country_code,
      data: {
        transaction_id: params.transaction_id,
        transaction_data: params.transaction_data
      }
    });
    return await this.publish(event);
  }

  /**
   * Get publisher status
   */
  getStatus() {
    return {
      projectId: this.projectId,
      topicPrefix: this.topicPrefix,
      status: 'active'
    };
  }
}

export const edgeEventPublisher = new EdgeEventPublisher();
