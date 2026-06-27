/**
 * EMAIL VALIDATION LOGIC (Simplified Mock)
 * In production: Integrate with SendGrid/ZeroBounce/Abstract API
 */

const DISPOSABLE_PROVIDERS = new Set(['tempmail', 'guerrillamail', 'mailinator', 'yopmail', 'throwawaymail', '10minutemail', 'getnada']);
const FREE_PROVIDERS = new Set(['gmail', 'yahoo', 'outlook', 'hotmail', 'icloud', 'protonmail']);

export function validateEmail(email: string) {
  const [local, domain] = email.toLowerCase().split('@');
  if (!domain) return { valid: false, reason: 'INVALID_FORMAT', score: 100 };

  const domainName = domain.split('.')[0];

  // 1. Check Disposable
  if (DISPOSABLE_PROVIDERS.has(domainName)) {
    return { valid: false, reason: 'DISPOSABLE_DOMAIN', score: 100 };
  }

  // 2. Check Alias (e.g. user+alias@gmail.com)
  if (local.includes('+')) {
    // Aliases on free providers are high risk for trials
    if (FREE_PROVIDERS.has(domainName)) {
      return { valid: true, reason: 'FREE_PROVIDER_ALIAS', score: 40 };
    }
  }

  // 3. Free Provider vs Corporate
  if (FREE_PROVIDERS.has(domainName)) {
    return { valid: true, reason: 'FREE_PROVIDER', score: 10 };
  }

  // 4. Corporate/Custom Domain (Low Risk)
  return { valid: true, reason: 'CORPORATE_DOMAIN', score: 0 };
}
