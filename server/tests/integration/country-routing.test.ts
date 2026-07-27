/**
 * Country Routing Integration Test
 * 
 * Validates that Database Router correctly routes to country-specific schemas
 * Agents never know about country-specific schemas
 */

import { databaseRouter } from '../../src/database/database-router';
import { EventFactory } from '../../src/events/base/event-envelope';

describe('Country Routing Integration', () => {
  beforeAll(() => {
    // Setup test environment variables
    process.env.DATABASE_URL_TR = process.env.DATABASE_URL || 'postgresql://test:test@localhost:5432/test_tr';
    process.env.DATABASE_URL_USA = process.env.DATABASE_URL || 'postgresql://test:test@localhost:5432/test_usa';
    process.env.DATABASE_URL_AE = process.env.DATABASE_URL || 'postgresql://test:test@localhost:5432/test_ae';
    process.env.DATABASE_URL_UK = process.env.DATABASE_URL || 'postgresql://test:test@localhost:5432/test_uk';
  });

  test('should route to correct country database', async () => {
    // Test Turkey routing
    const trConfig = databaseRouter.getConfig('TR');
    expect(trConfig).toBeDefined();
    expect(trConfig?.country_code).toBe('TR');
    expect(trConfig?.schema_name).toBe('schema_tr');

    // Test USA routing
    const usConfig = databaseRouter.getConfig('US');
    expect(usConfig).toBeDefined();
    expect(usConfig?.country_code).toBe('US');
    expect(usConfig?.schema_name).toBe('schema_usa');

    // Test UAE routing
    const aeConfig = databaseRouter.getConfig('AE');
    expect(aeConfig).toBeDefined();
    expect(aeConfig?.country_code).toBe('AE');
    expect(aeConfig?.schema_name).toBe('schema_ae');

    // Test UK routing
    const ukConfig = databaseRouter.getConfig('GB');
    expect(ukConfig).toBeDefined();
    expect(ukConfig?.country_code).toBe('GB');
    expect(ukConfig?.schema_name).toBe('schema_uk');
  });

  test('should create event with country code', () => {
    const event = EventFactory.createEvent({
      event_type: 'listing.ingested.v1',
      producer: 'reservatior-edge',
      country_code: 'AE',
      data: {
        property_id: 'ae_dubai_001',
        source: 'mls'
      }
    });

    expect(event.country_code).toBe('AE');
    expect(event.event_type).toBe('listing.ingested.v1');
    expect(event.data.property_id).toBe('ae_dubai_001');
  });

  test('should validate event envelope', () => {
    const event = EventFactory.createEvent({
      event_type: 'listing.ingested.v1',
      producer: 'reservatior-edge',
      country_code: 'TR',
      data: {
        property_id: 'tr_istanbul_001',
        source: 'mls'
      }
    });

    const validation = EventFactory.validateEvent(event);
    expect(validation.valid).toBe(true);
    expect(validation.errors).toHaveLength(0);
  });

  test('should reject invalid country code', () => {
    const event = EventFactory.createEvent({
      event_type: 'listing.ingested.v1',
      producer: 'reservatior-edge',
      country_code: 'INVALID', // Invalid country code
      data: {
        property_id: 'test_001',
        source: 'mls'
      }
    });

    const validation = EventFactory.validateEvent(event);
    expect(validation.valid).toBe(false);
    expect(validation.errors.length).toBeGreaterThan(0);
  });

  test('should reject invalid event type format', () => {
    const event = EventFactory.createEvent({
      event_type: 'invalid-format', // Should be domain.action.version
      producer: 'reservatior-edge',
      country_code: 'TR',
      data: {
        property_id: 'test_001',
        source: 'mls'
      }
    });

    const validation = EventFactory.validateEvent(event);
    expect(validation.valid).toBe(false);
    expect(validation.errors.length).toBeGreaterThan(0);
  });

  test('should get all configured countries', () => {
    const countries = databaseRouter.getConfiguredCountries();
    expect(countries).toContain('TR');
    expect(countries).toContain('US');
    expect(countries).toContain('AE');
    expect(countries).toContain('GB');
  });

  test('should handle unknown country code gracefully', () => {
    const config = databaseRouter.getConfig('UNKNOWN');
    expect(config).toBeUndefined();
  });

  test('should parse event from JSON string', () => {
    const event = EventFactory.createEvent({
      event_type: 'property.updated.v1',
      producer: 'reservatior-edge',
      country_code: 'US',
      data: {
        property_id: 'us_nyc_001',
        update_data: { price: 500000 }
      }
    });

    const jsonString = JSON.stringify(event);
    const parsedEvent = EventFactory.parseEvent(jsonString);

    expect(parsedEvent.event_id).toBe(event.event_id);
    expect(parsedEvent.country_code).toBe('US');
    expect(parsedEvent.data.property_id).toBe('us_nyc_001');
  });

  test('should handle event creation for all supported countries', () => {
    const countries = ['TR', 'US', 'AE', 'GB'];

    countries.forEach(countryCode => {
      const event = EventFactory.createListingIngestedEvent({
        country_code: countryCode,
        property_id: `${countryCode.toLowerCase()}_test_001`,
        source: 'mls',
        source_listing_id: `mls_${countryCode.toLowerCase()}_001`,
        property_data: {
          location: 'Test Location',
          price: 100000
        }
      });

      expect(event.country_code).toBe(countryCode);
      expect(event.event_type).toBe('listing.ingested.v1');
    });
  });
});

describe('Database Router Connection Status', () => {
  test('should report connection status for all countries', async () => {
    const status = await databaseRouter.getConnectionStatus();
    
    expect(status).toHaveProperty('TR');
    expect(status).toHaveProperty('US');
    expect(status).toHaveProperty('AE');
    expect(status).toHaveProperty('GB');
    
    // Note: In test environment, connections may fail
    // This is expected - we're testing the status reporting mechanism
    Object.values(status).forEach(status => {
      expect(typeof status).toBe('boolean');
    });
  });
});
