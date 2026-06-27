#!/usr/bin/env bun
// Client-side Universal API Demo

// Simulate client-side usage (browser environment)
const API_BASE = 'http://localhost:3000/api/universal';

// Mock localStorage for demo
const localStorage = {
  getItem: (key: string) => 'demo-jwt-token',
  setItem: (key: string, value: string) => {},
};

// Mock fetch for demo
global.fetch = async (url: string, options?: any) => {
  console.log(`🌐 ${options?.method || 'GET'} ${url}`);
  if (options?.body) {
    console.log(`📦 Body:`, JSON.parse(options.body));
  }
  
  // Mock responses
  if (url.includes('/api/universal/')) {
    return {
      ok: true,
      json: async () => ({
        message: 'Universal CRUD API Ready',
        availableModels: [
          'User', 'Organization', 'Property', 'Listing', 'Booking',
          'Contact', 'Agent', 'Document', 'Role', 'Permission',
          'Achievement', 'AccessCode', 'AccessLog', 'SmartLock',
          'MaintenanceBlock', 'Lease', 'Review', 'Payment', 'Commission'
        ],
        endpoints: {
          'GET /api/universal/{model}': 'List all records',
          'POST /api/universal/{model}': 'Create new record',
          'GET /api/universal/{model}/{id}': 'Get single record',
          'PUT /api/universal/{model}/{id}': 'Update record',
          'DELETE /api/universal/{model}/{id}': 'Delete record'
        }
      })
    };
  }
  
  if (url.includes('/api/universal/user')) {
    return {
      ok: true,
      json: async () => ({
        data: [
          { id: '1', email: 'user1@example.com', name: 'User One', createdAt: '2024-01-01' },
          { id: '2', email: 'user2@example.com', name: 'User Two', createdAt: '2024-01-02' },
          { id: '3', email: 'user3@example.com', name: 'User Three', createdAt: '2024-01-03' }
        ],
        pagination: {
          page: 1,
          limit: 10,
          total: 3,
          totalPages: 1
        }
      })
    };
  }
  
  if (url.includes('/api/universal/organization')) {
    return {
      ok: true,
      json: async () => ({
        data: [
          { id: '1', name: 'Organization One', type: 'AGENCY', isActive: true },
          { id: '2', name: 'Organization Two', type: 'OWNER_PORTFOLIO', isActive: true }
        ],
        pagination: {
          page: 1,
          limit: 10,
          total: 2,
          totalPages: 1
        }
      })
    };
  }
  
  return {
    ok: true,
    json: async () => ({ success: true })
  };
};

// Universal API Client (simplified for demo)
class UniversalAPIClient {
  constructor(private baseURL: string = API_BASE) {}

  private getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem('auth_token')}`,
    };
  }

  async request<T>(endpoint: string, options: RequestInit = {}) {
    const url = `${this.baseURL}${endpoint}`;
    const response = await fetch(url, {
      ...options,
      headers: {
        ...this.getHeaders(),
        ...options.headers,
      },
    });

    return response.json();
  }

  async getAPIInfo() {
    return this.request('/');
  }

  async list<T>(model: string, query: any = {}) {
    const params = new URLSearchParams();
    Object.entries(query).forEach(([key, value]) => {
      if (value !== undefined && value !== null) {
        params.append(key, String(value));
      }
    });

    const queryString = params.toString();
    const endpoint = `/${model}${queryString ? `?${queryString}` : ''}`;
    
    return this.request<T[]>(endpoint);
  }

  async create<T>(model: string, data: any) {
    return this.request<T>(`/${model}`, {
      method: 'POST',
      body: JSON.stringify(data),
    });
  }

  async update<T>(model: string, id: string, data: any) {
    return this.request<T>(`/${model}/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  }

  async delete(model: string, id: string) {
    return this.request(`/${model}/${id}`, {
      method: 'DELETE',
    });
  }
}

// Demo
async function clientDemo() {
  console.log('🚀 Client-side Universal API Demo');
  console.log('==================================\n');
  
  const api = new UniversalAPIClient();
  
  try {
    // 1. API Info
    console.log('1. API Info ve Mevcut Modeller:');
    const info = await api.getAPIInfo();
    console.log('✅ Mevcut modeller:', info.availableModels);
    console.log('✅ Endpoint\'ler:', info.endpoints);
    console.log('\n');
    
    // 2. User Listeleme
    console.log('2. User Listeleme:');
    const users = await api.list('user', { page: 1, limit: 10 });
    console.log('📋 Users:', users.data?.length, 'kayıt');
    console.log('📄 Pagination:', users.pagination);
    console.log('\n');
    
    // 3. Organization Listeleme
    console.log('3. Organization Listeleme:');
    const orgs = await api.list('organization', { page: 1, limit: 5 });
    console.log('🏢 Organizations:', orgs.data?.length, 'kayıt');
    console.log('\n');
    
    // 4. Yeni User Oluşturma
    console.log('4. Yeni User Oluşturma:');
    const newUser = await api.create('user', {
      email: 'new-user@example.com',
      name: 'New User',
      locale: 'en-US'
    });
    console.log('✅ Yeni user oluşturuldu');
    console.log('\n');
    
    // 5. User Güncelleme
    console.log('5. User Güncelleme:');
    const updatedUser = await api.update('user', '1', {
      name: 'Updated User Name'
    });
    console.log('✅ User güncellendi');
    console.log('\n');
    
    // 6. Advanced Filtering
    console.log('6. Advanced Filtering:');
    const filteredUsers = await api.list('user', {
      page: 1,
      limit: 5,
      sortBy: 'createdAt',
      sortOrder: 'desc',
      name: 'user*' // Wildcard search
    });
    console.log('🔍 Filtrelenmiş users:', filteredUsers.data?.length);
    console.log('\n');
    
    // 7. React Hook Usage Example
    console.log('7. React Hook Usage:');
    console.log(`
// React Component Example
import { useUsers } from './api/hooks';

function UserList() {
  const { data: users, loading, error, pagination, nextPage, updateQuery } = useUsers();
  
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  
  return (
    <div>
      <h2>Users ({pagination.total})</h2>
      <input 
        placeholder="Search..."
        onChange={(e) => updateQuery({ name: \`\${e.target.value}*\` })}
      />
      <ul>
        {users.map(user => (
          <li key={user.id}>{user.name} ({user.email})</li>
        ))}
      </ul>
      <button onClick={nextPage}>Next Page</button>
    </div  );
}
    `);
    
    console.log('\n');
    
    // 8. Migration Benefits
    console.log('🎯 Migration Benefits:');
    console.log('   📦 200+ API dosyası → 4 dosya');
    console.log('   ⚡ Development time: Haftalar → Dakikalar');
    console.log('   🛡️ Type safety: Runtime validation');
    console.log('   🔄 Consistency: Otomatik endpoint pattern');
    console.log('   📚 Documentation: Built-in API info');
    console.log('   🚀 Performance: Optimized queries');
    
  } catch (error) {
    console.error('❌ Demo başarısız:', error);
    console.log('💡 Sunucunun çalıştığından emin olun: bun run universal:dev');
  }
}

// Run demo
if (import.meta.main) {
  clientDemo();
}
