import { apiClient } from "./client";

export interface CloudService {
  name: string;
  status: 'ACTIVE' | 'DEPLOYING' | 'ERROR' | 'STOPPED';
  usage: {
    cpu: number;
    memory: number;
    storage: number;
    bandwidth: number;
  };
  limits: {
    cpu: number;
    memory: number;
    storage: number;
    bandwidth: number;
  };
  cost: {
    current: number;
    projected: number;
  };
  url?: string;
}

// Mock initial data since backend API is not fully implemented yet
let MOCK_SERVICES: CloudService[] = [
  {
    name: "Frontend (React)",
    status: "ACTIVE",
    usage: { cpu: 25, memory: 512, storage: 2.1, bandwidth: 150 },
    limits: { cpu: 100, memory: 2048, storage: 5120, bandwidth: 1024 },
    cost: { current: 0.00, projected: 0.00 },
    url: "https://client.reservatiormain.app"
  },
  {
    name: "Backend (Elysia)",
    status: "ACTIVE",
    usage: { cpu: 45, memory: 1024, storage: 850, bandwidth: 320 },
    limits: { cpu: 100, memory: 2048, storage: 5120, bandwidth: 1024 },
    cost: { current: 0.00, projected: 0.00 },
    url: "https://api.reservatiormain.app"
  },
  {
    name: "Database (PostgreSQL)",
    status: "ACTIVE",
    usage: { cpu: 15, memory: 768, storage: 1200, bandwidth: 50 },
    limits: { cpu: 100, memory: 2048, storage: 5120, bandwidth: 1024 },
    cost: { current: 0.00, projected: 0.00 },
    url: "https://db.reservatiormain.app"
  },
  {
    name: "Storage (Cloud Storage)",
    status: "ACTIVE",
    usage: { cpu: 0, memory: 0, storage: 3500, bandwidth: 200 },
    limits: { cpu: 0, memory: 0, storage: 5120, bandwidth: 1024 },
    cost: { current: 0.00, projected: 0.00 },
    url: "https://storage.reservatiormain.app"
  }
];

export const cloudApi = {
  getServices: async (): Promise<CloudService[]> => {
    // In the future this should call apiClient.get('/system/cloud') or similar
    return new Promise((resolve) => setTimeout(() => resolve([...MOCK_SERVICES]), 500));
  },
  deployService: async (serviceName: string): Promise<CloudService> => {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        const service = MOCK_SERVICES.find(s => s.name === serviceName);
        if (service) {
          service.status = 'ACTIVE';
          resolve(service);
        } else {
          reject(new Error("Service not found"));
        }
      }, 3000);
    });
  },
  stopService: async (serviceName: string): Promise<CloudService> => {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        const service = MOCK_SERVICES.find(s => s.name === serviceName);
        if (service) {
          service.status = 'STOPPED';
          resolve(service);
        } else {
          reject(new Error("Service not found"));
        }
      }, 1000);
    });
  }
};
