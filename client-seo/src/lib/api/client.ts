import type { ApiResponse, PaginatedResponse } from '@/types/generated';
import { User } from './users';

const API_BASE_URL = (process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000") + "/api/v1";

class ApiClient {
  private baseURL: string;
  defaults: any;

  constructor(baseURL: string) {
    this.baseURL = baseURL;
  }

  private async request<T>(
    endpoint: string,
    options: RequestInit = {}
  ): Promise<ApiResponse<T>> {
    // Strip redundant /api/v1 if provided to avoid double prefix
    const cleanEndpoint = endpoint.startsWith("/api/v1") ? endpoint.substring(7) : endpoint;
    const url = `${this.baseURL}${cleanEndpoint}`;
    let token = null;
    let regionCode = null;

    if (typeof window !== "undefined") {
      const storedData = localStorage.getItem("user-storage");
      if (storedData) {
        try {
          const parsed = JSON.parse(storedData);
          token = parsed.state?.token;
        } catch (e) {
          console.error("Failed to parse user-storage", e);
        }
      }

      // Get the selected region from regions-store
      const regionsData = localStorage.getItem("regions-store");
      if (regionsData) {
        try {
          const parsed = JSON.parse(regionsData);
          regionCode = parsed.state?.selectedRegion?.countryCode || parsed.state?.selectedRegion?.code;
        } catch (e) {
          console.error("Failed to parse regions-store", e);
        }
      }
    }

    const headers: any = {
      ...(token && { Authorization: `Bearer ${token}` }),
      ...(regionCode && { "X-Region": regionCode }),
      ...options.headers,
    };

    if (!(options.body instanceof FormData) && !headers["Content-Type"]) {
      headers["Content-Type"] = "application/json";
    }

    try {
      const response = await fetch(url, {
        ...options,
        headers,
      });

      // --- GLOBAL AUDIT LOG INTERCEPTOR ---
      // Disabled temporarily due to 500 errors
      // if (response.ok && options.method && ['POST', 'PUT', 'PATCH', 'DELETE'].includes(options.method)) {
      //   // Fire and forget audit log for mutations
      //   try {
      //     const actionMap: Record<string, string> = { 'POST': 'CREATE', 'PUT': 'UPDATE', 'PATCH': 'UPDATE', 'DELETE': 'DELETE' };
      //     const segments = cleanEndpoint.split('/').filter(Boolean);
      //     const entityType = segments[0] || 'system';
      //     const entityId = segments.length > 1 ? segments[segments.length - 1] : null;
      //     
      //     fetch(`${this.baseURL}/audit-logs`, {
      //       method: 'POST',
      //       headers: { 'Content-Type': 'application/json', ...(token && { Authorization: `Bearer ${token}` }) },
      //       body: JSON.stringify({
      //         action: actionMap[options.method] || 'UNKNOWN',
      //         entityType: entityType.toUpperCase(),
      //         entityId: entityId || 'N/A',
      //         userId: token ? 'SYSTEM_USER' : 'ANONYMOUS',
      //         details: { endpoint: cleanEndpoint, timestamp: new Date().toISOString() },
      //         ipAddress: 'Client-Side'
      //       })
      //     }).catch(err => console.error("Audit log failed to send", err));
      //   } catch(e) {
      //     // Ignore audit errors so main request doesn't fail
      //   }
      // }
      // ------------------------------------

      if (!response.ok) {
        if (response.status === 401 && !url.includes("/auth/login") && !url.includes("/auth/register")) {
          if (typeof window !== "undefined") {
            localStorage.removeItem("user-storage");
            window.location.href = "/auth/login";
          }
        }
        
        // Try to get error message from body
        let errorMessage = `HTTP error! status: ${response.status}`;
        try {
          const body = await response.json();
          if (body.error) errorMessage = body.error;
          else if (body.message) errorMessage = body.message;
        } catch (e) {
          // ignore
        }
        
        const error = new Error(errorMessage) as any;
        error.status = response.status;
        throw error;
      }

      let data = {} as T;
      if (response.status !== 204) {
        try {
          if ((options as any).responseType === 'blob') {
            data = await response.blob() as any;
          } else {
            data = await response.json();
          }
        } catch (e) {
          // Empty body
        }
      }
      return { data };
    } catch (error: any) {
      console.error("API request failed:", error);
      throw error;
    }
  }

  async get<T>(
    endpoint: string,
    params?: Record<string, any>
  ): Promise<T> {
    let url = endpoint;
    if (params) {
      // If the caller passed `{ params: { ... } }` (Axios style), unwrap it
      const actualParams = params.params !== undefined ? params.params : params;
      
      const searchParams = new URLSearchParams();
      Object.entries(actualParams).forEach(([key, value]) => {
          if (value !== undefined && value !== null) {
              if (Array.isArray(value)) {
                  value.forEach(v => searchParams.append(key, String(v)));
              } else if (typeof value === 'object') {
                  searchParams.append(key, JSON.stringify(value));
              } else {
                  searchParams.append(key, String(value));
              }
          }
      });
      
      const searchStr = searchParams.toString();
      if (searchStr) {
        url += (endpoint.includes('?') ? '&' : '?') + searchStr;
      }
    }
    const response = await this.request<T>(url);
    return response.data;
  }

  async post<T>(
    endpoint: string,
    data?: any,
    options: any = {}
  ): Promise<T> {
    const isFormData = data instanceof FormData;
    const response = await this.request<T>(endpoint, {
      method: "POST",
      body: isFormData ? data : (data ? JSON.stringify(data) : undefined),
      ...options
    });
    return response.data;
  }

  async patch<T>(endpoint: string, data?: any, options: any = {}): Promise<T> {
    const response = await this.request<T>(endpoint, {
      method: "PATCH",
      body: data ? JSON.stringify(data) : undefined,
      ...options
    });
    return response.data;
  }

  async put<T>(endpoint: string, data?: any, options: any = {}): Promise<T> {
    const response = await this.request<T>(endpoint, {
      method: "PUT",
      body: data ? JSON.stringify(data) : undefined,
      ...options
    });
    return response.data;
  }

  async delete<T>(endpoint: string, options: any = {}): Promise<T> {
    const response = await this.request<T>(endpoint, {
      method: "DELETE",
      ...options
    });
    return response.data;
  }

  // ─── TYPED API METHODS ────────────────────────────────
  // User endpoints
  async getCurrentUser(): Promise<ApiResponse<User>> {
    return this.get('/auth/me');
  }
}

export const apiClient = new ApiClient(API_BASE_URL);

export default apiClient;
