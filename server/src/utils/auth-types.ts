// Universal types for CRUD API
export interface AuthUser {
  id: string;
  email: string;
  name?: string;
  role?: string;
  organizationId?: string;
}

export const getAuthUser = (request: Request): AuthUser | null => {
  // Simple JWT token parsing (gerçek implementasyon'da proper validation kullanın)
  const token = request.headers.get('Authorization')?.replace('Bearer ', '');
  
  if (!token) return null;
  
  try {
    // Basic JWT decode (production'da proper validation kullanın)
    const payload = JSON.parse(atob(token.split('.')[1]));
    
    return {
      id: payload.sub,
      email: payload.email,
      name: payload.name,
      role: payload.role,
      organizationId: payload.organizationId
    };
  } catch {
    return null;
  }
};
