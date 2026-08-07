/**
 * REOS v5 — Workflow OS: Temporal Worker
 *
 * The worker process registers all activities and workflows with Temporal.
 * Run this alongside the main server (or as a separate process/container).
 *
 * Requirements:
 *   - Temporal dev server running: `npx @temporalio/cli server start-dev`
 *   - Or a Temporal Cloud / self-hosted instance
 *   - TEMPORAL_ADDRESS env var (default: localhost:7233)
 *
 * Start: bun run src/core/workflows/temporal/worker.ts
 */

import { Worker, NativeConnection } from '@temporalio/worker';
import * as activities from './marketing-package.activities';

const TEMPORAL_ADDRESS   = process.env.TEMPORAL_ADDRESS   ?? 'localhost:7233';
const TEMPORAL_NAMESPACE = process.env.TEMPORAL_NAMESPACE ?? 'default';
const TASK_QUEUE         = process.env.TEMPORAL_TASK_QUEUE ?? 'reos-marketing-package';

async function run() {
  console.log('\n╔════════════════════════════════════════════════╗');
  console.log('║   REOS v5: Temporal Worker Starting           ║');
  console.log('╠════════════════════════════════════════════════╣');
  console.log(`║  Address:    ${TEMPORAL_ADDRESS.padEnd(32)} ║`);
  console.log(`║  Namespace:  ${TEMPORAL_NAMESPACE.padEnd(32)} ║`);
  console.log(`║  Task Queue: ${TASK_QUEUE.padEnd(32)} ║`);
  console.log('╚════════════════════════════════════════════════╝\n');

  let connection: NativeConnection;
  try {
    connection = await NativeConnection.connect({ address: TEMPORAL_ADDRESS });
  } catch (err) {
    console.error(`[Temporal Worker] ❌ Cannot connect to Temporal at ${TEMPORAL_ADDRESS}`);
    console.error('  → Start Temporal dev server: npx @temporalio/cli server start-dev');
    process.exit(1);
  }

  const worker = await Worker.create({
    connection,
    namespace: TEMPORAL_NAMESPACE,
    taskQueue: TASK_QUEUE,

    // Workflow bundle — Temporal bundles workflow code separately from activities
    workflowsPath: require.resolve('./marketing-package.workflow'),

    // All activity functions registered here
    activities,
  });

  console.log(`[Temporal Worker] ✅ Ready. Listening on task queue: ${TASK_QUEUE}`);
  console.log('[Temporal Worker] Activities registered:', Object.keys(activities).join(', '));

  await worker.run();
}

run().catch(err => {
  console.error('[Temporal Worker] Fatal error:', err);
  process.exit(1);
});
