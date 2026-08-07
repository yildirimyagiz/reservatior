import { Connection, Client } from '@temporalio/client';
import fs from 'fs';

let temporalClientInstance: Client | null = null;

export async function getTemporalClient(): Promise<Client> {
  if (temporalClientInstance) {
    return temporalClientInstance;
  }

  const address = process.env.TEMPORAL_ADDRESS ?? 'localhost:7233';
  const namespace = process.env.TEMPORAL_NAMESPACE ?? 'default';

  // Support for mTLS (Temporal Cloud or secure self-hosted)
  const certPath = process.env.TEMPORAL_MTLS_CERT;
  const keyPath = process.env.TEMPORAL_MTLS_KEY;

  let connectionOptions: any = {
    address,
  };

  if (certPath && keyPath) {
    try {
      connectionOptions.tls = {
        clientCertPair: {
          crt: fs.readFileSync(certPath),
          key: fs.readFileSync(keyPath),
        },
      };
      console.log(`[Temporal Client] Configured mTLS connection to ${address}`);
    } catch (err) {
      console.error('[Temporal Client] Error reading mTLS certificates:', err);
    }
  } else {
    console.log(`[Temporal Client] Connecting without mTLS to ${address}`);
  }

  const connection = await Connection.connect(connectionOptions);

  temporalClientInstance = new Client({
    connection,
    namespace,
  });

  return temporalClientInstance;
}
