import { apiClient } from "./client";

export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  email: string;
  password: string;
  name: string;
  phone?: string;
  organizationName?: string;
  promoCode?: string;
  accountType?: "INDIVIDUAL" | "CORPORATE";
  corporateType?: string;
}

export interface AuthResponse {
  user: {
    id: string;
    clerkId?: string;
    email: string;
    firstName: string;
    lastName: string;
    phone?: string;
    imageUrl?: string;
    role: "SUPER_ADMIN" | "ORG_ADMIN" | "ADMIN" | "AGENT" | "TENANT" | "USER" | "AGENCY_ADMIN" | "TENANT_GUEST";
    status: "ACTIVE" | "INACTIVE" | "PENDING" | "SUSPENDED" | "DELETED";
    permissions: string[];
    locale: string;
    timezone: string;
    orgId?: string | null;
    preferences: {
      theme: "light" | "dark" | "system";
      language: string;
      timezone: string;
      notifications: {
        email: boolean;
        push: boolean;
        sms: boolean;
      };
    };
    createdAt: string;
    updatedAt: string;
    lastLogin?: string;
  };
  token: string;
  refreshToken: string;
  expiresIn: number;
}

export interface ForgotPasswordRequest {
  email: string;
}

export interface ResetPasswordRequest {
  token: string;
  newPassword: string;
}

export interface ChangePasswordRequest {
  currentPassword: string;
  newPassword: string;
}

export const authApi = {
  login: async (data: LoginRequest): Promise<AuthResponse> => {
    const response = await apiClient.post<AuthResponse>("/auth/login", data);
    return response;
  },

  register: async (data: RegisterRequest): Promise<AuthResponse> => {
    const response = await apiClient.post<AuthResponse>("/auth/register", data);
    return response;
  },

  logout: async (): Promise<void> => {
    await apiClient.post("/auth/logout");
  },

  refreshToken: async (refreshToken: string): Promise<AuthResponse> => {
    const response = await apiClient.post<AuthResponse>("/auth/refresh", {
      refreshToken,
    });
    return response;
  },

  forgotPassword: async (data: ForgotPasswordRequest): Promise<void> => {
    await apiClient.post("/auth/forgot-password", data);
  },

  resetPassword: async (data: ResetPasswordRequest): Promise<void> => {
    await apiClient.post("/auth/reset-password", data);
  },

  changePassword: async (data: ChangePasswordRequest): Promise<void> => {
    await apiClient.post("/auth/change-password", data);
  },

  verifyEmail: async (token: string): Promise<void> => {
    await apiClient.post("/auth/verify-email", { token });
  },

  resendVerification: async (email: string): Promise<void> => {
    await apiClient.post("/auth/resend-verification", { email });
  },

  enable2FA: async (): Promise<{ secret: string; qrCode: string }> => {
    const response = await apiClient.post<{ secret: string; qrCode: string }>(
      "/auth/2fa/enable"
    );
    return response;
  },

  verify2FA: async (token: string): Promise<void> => {
    await apiClient.post("/auth/2fa/verify", { token });
  },

  disable2FA: async (password: string): Promise<void> => {
    await apiClient.post("/auth/2fa/disable", { password });
  },
  
  updateProfile: async (data: any): Promise<AuthResponse['user']> => {
    const response = await apiClient.patch<AuthResponse['user']>(`/users/${data.id}`, data);
    return response;
  }
};
