/**
 * Retry Policy
 * Configurable retry with exponential backoff for saga step execution.
 *
 * Flow:
 *   step execution
 *     → retry x3 (exponential backoff: 1s, 2s, 4s)
 *     → if still fails → Dead Letter Queue
 *     → compensation triggers only after DLQ
 *
 * Usage:
 *   const result = await retryExecutor.executeWithRetry(
 *     () => publishToChannel(data),
 *     { maxRetries: 3, backoffMs: 1000 },
 *     (attempt, err) => console.log(`Retry ${attempt}: ${err.message}`)
 *   );
 */

export interface RetryPolicy {
  /** Maximum number of retries (default: 3) */
  maxRetries: number;
  /** Initial backoff delay in ms (default: 1000) */
  backoffMs: number;
  /** Backoff multiplier for exponential growth (default: 2) */
  backoffMultiplier: number;
  /** Maximum backoff delay cap in ms (default: 30000) */
  maxBackoffMs: number;
  /** Only retry on these error codes/messages. If empty, retry all errors. */
  retryableErrors?: string[];
}

export interface RetryResult<T> {
  success: boolean;
  result?: T;
  error?: Error;
  attempts: number;
  totalDurationMs: number;
}

/** Default policy: 3 retries, exponential backoff 1s → 2s → 4s */
export const DEFAULT_RETRY_POLICY: RetryPolicy = {
  maxRetries: 3,
  backoffMs: 1000,
  backoffMultiplier: 2,
  maxBackoffMs: 30_000,
};

/** Aggressive policy for critical operations */
export const CRITICAL_RETRY_POLICY: RetryPolicy = {
  maxRetries: 5,
  backoffMs: 500,
  backoffMultiplier: 2,
  maxBackoffMs: 60_000,
};

/** Light policy for non-critical operations */
export const LIGHT_RETRY_POLICY: RetryPolicy = {
  maxRetries: 2,
  backoffMs: 500,
  backoffMultiplier: 1.5,
  maxBackoffMs: 5_000,
};

export class RetryExecutor {
  /**
   * Execute a function with retry logic.
   * Returns RetryResult with success/failure info and attempt count.
   */
  async executeWithRetry<T>(
    fn: () => Promise<T>,
    policy: Partial<RetryPolicy> = {},
    onRetry?: (attempt: number, error: Error, nextDelayMs: number) => void
  ): Promise<RetryResult<T>> {
    const p: RetryPolicy = { ...DEFAULT_RETRY_POLICY, ...policy };
    const startTime = Date.now();
    let lastError: Error | undefined;

    for (let attempt = 0; attempt <= p.maxRetries; attempt++) {
      try {
        const result = await fn();
        return {
          success: true,
          result,
          attempts: attempt + 1,
          totalDurationMs: Date.now() - startTime,
        };
      } catch (err) {
        lastError = err instanceof Error ? err : new Error(String(err));

        // Check if this error is retryable
        if (p.retryableErrors && p.retryableErrors.length > 0) {
          const isRetryable = p.retryableErrors.some(
            re => lastError!.message.includes(re) || lastError!.constructor.name === re
          );
          if (!isRetryable) {
            return {
              success: false,
              error: lastError,
              attempts: attempt + 1,
              totalDurationMs: Date.now() - startTime,
            };
          }
        }

        // If we have retries left, wait and retry
        if (attempt < p.maxRetries) {
          const delay = Math.min(
            p.backoffMs * Math.pow(p.backoffMultiplier, attempt),
            p.maxBackoffMs
          );

          if (onRetry) {
            onRetry(attempt + 1, lastError, delay);
          }

          await this.sleep(delay);
        }
      }
    }

    return {
      success: false,
      error: lastError,
      attempts: p.maxRetries + 1,
      totalDurationMs: Date.now() - startTime,
    };
  }

  /**
   * Execute with retry, throwing on final failure.
   * Simpler API when you don't need the RetryResult metadata.
   */
  async executeOrThrow<T>(
    fn: () => Promise<T>,
    policy: Partial<RetryPolicy> = {},
    context?: string
  ): Promise<T> {
    const result = await this.executeWithRetry(fn, policy, (attempt, err, delay) => {
      console.warn(
        `[RetryExecutor] ${context || 'Operation'} attempt ${attempt} failed: ${err.message}. Retrying in ${delay}ms...`
      );
    });

    if (!result.success) {
      throw new Error(
        `[RetryExecutor] ${context || 'Operation'} failed after ${result.attempts} attempts: ${result.error?.message}`
      );
    }

    return result.result!;
  }

  private sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

// Singleton
export const retryExecutor = new RetryExecutor();
