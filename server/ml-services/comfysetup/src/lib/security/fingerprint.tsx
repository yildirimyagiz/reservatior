'use client';

import { useEffect, useState } from 'react';
import FingerprintJS from '@fingerprintjs/fingerprintjs';

// Initialize the agent at application startup.
const fpPromise = FingerprintJS.load();

export function useFingerprint() {
  const [visitorId, setVisitorId] = useState<string>('');
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const getFingerprint = async () => {
      try {
        const fp = await fpPromise;
        const result = await fp.get();
        setVisitorId(result.visitorId);
      } catch (error) {
        console.error('Fingerprint error:', error);
      } finally {
        setIsLoading(false);
      }
    };

    getFingerprint();
  }, []);

  return { visitorId, isLoading };
}

/**
 * Component to verify device integrity (Client-side checks)
 * In a real app, you'd also capture screen resolution, timezone, etc.
 * and compare with server headers.
 */
export function DeviceIntegrityCheck() {
  const { visitorId } = useFingerprint();

  if (!visitorId) return null;

  return (
    <input type="hidden" name="fingerprintId" value={visitorId} />
  );
}
