import { apiClient } from "./client";

export const securityApi = {
  // 2FA
  setup2FA: () => apiClient.get("/security/2fa/setup"),
  verify2FA: (token: string, secret: string) => apiClient.post("/security/2fa/verify", { token, secret }),
  disable2FA: (password: string) => apiClient.post("/security/2fa/disable", { password }),

  // Biometric
  enableBiometric: (publicKey: string, deviceId: string) => 
    apiClient.post("/security/biometric/enable", { publicKey, deviceId }),

  // Sessions
  getSessions: () => apiClient.get<any[]>("/security/sessions"),
  revokeSession: (id: string) => apiClient.delete(`/security/sessions/${id}`),

  // Stripe
  createPaymentIntent: (amount: number, currency: string = "usd") => 
    apiClient.post("/payments/create-payment-intent", { amount, currency }),
};
