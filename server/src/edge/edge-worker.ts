/**
 * VPS Edge Worker
 * 
 * Background daemon that runs on VPS
 * NO AI processing - only event publishing/consuming and database routing
 */

import { edgeEventPublisher } from './event-publisher';
import { edgeEventConsumer } from './event-consumer';
import { databaseRouter } from '../database/database-router';

async function startEdgeWorker() {
  console.log('🚀 [VPS Edge Worker] Starting Reservatior Edge Worker...');
  console.log('[VPS Edge Worker] NO AI PROCESSING - Only event routing and database operations');
  
  try {
    // Test database connections
    console.log('[VPS Edge Worker] Testing database connections...');
    const connectionStatus = await databaseRouter.getConnectionStatus();
    console.log('[VPS Edge Worker] Database connection status:', connectionStatus);
    
    // Start event consumer subscriptions
    console.log('[VPS Edge Worker] Starting Pub/Sub subscriptions...');
    await edgeEventConsumer.startAll();
    
    // Get status
    const publisherStatus = edgeEventPublisher.getStatus();
    const consumerStatus = edgeEventConsumer.getStatus();
    
    console.log('[VPS Edge Worker] Edge Worker started successfully');
    console.log(`[VPS Edge Worker] Publisher: ${publisherStatus.projectId} | Consumer: ${consumerStatus.activeSubscriptions} subscriptions`);
    
    // Keep process alive
    process.on('SIGINT', () => {
      console.log('[VPS Edge Worker] Received SIGINT, shutting down gracefully...');
      databaseRouter.closeAllConnections();
      process.exit(0);
    });
    
    process.on('SIGTERM', () => {
      console.log('[VPS Edge Worker] Received SIGTERM, shutting down gracefully...');
      databaseRouter.closeAllConnections();
      process.exit(0);
    });
    
  } catch (error) {
    console.error('[VPS Edge Worker] Error starting worker:', error);
    process.exit(1);
  }
}

// Start the worker
startEdgeWorker();
