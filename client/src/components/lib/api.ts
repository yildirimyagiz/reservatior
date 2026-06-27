import { Task } from "@/lib/api/index";
import { Lead } from "@/lib/api/leads";
import { Property } from "@/lib/api/property";
import { User } from "@/lib/api/users";


// Define input types for create operations
export type InsertProperty = Omit<Property, "id" | "createdAt" | "updatedAt">;
export type InsertLead = Omit<Lead, "id" | "createdAt" | "updatedAt">;
export type InsertTask = Omit<Task, "id" | "createdAt" | "updatedAt">;

const API_BASE = "/api";

export type PropertyWithAgent = Property & { agent: User };

async function handleResponse<T>(response: Response): Promise<T> {
  if (!response.ok) {
    const error = await response
      .json()
      .catch(() => ({ message: response.statusText }));
    throw new Error(error.message || "API request failed");
  }
  return response.json();
}

export const authApi = {
  async register(data: {
    email: string;
    password: string;
    name: string;
    agency?: string;
  }) {
    const response = await fetch(`${API_BASE}/auth/register`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    });
    return handleResponse<User>(response);
  },

  async login(email: string, password: string) {
    const response = await fetch(`${API_BASE}/auth/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password }),
    });
    return handleResponse<User>(response);
  },

  async logout() {
    const response = await fetch(`${API_BASE}/auth/logout`, {
      method: "POST",
    });
    return handleResponse<{ message: string }>(response);
  },

  async getCurrentUser() {
    const response = await fetch(`${API_BASE}/auth/me`);
    return handleResponse<User>(response);
  },
};

export const propertiesApi = {
  async getAll() {
    const response = await fetch(`${API_BASE}/properties`);
    return handleResponse<PropertyWithAgent[]>(response);
  },

  async getById(id: string) {
    const response = await fetch(`${API_BASE}/properties/${id}`);
    return handleResponse<PropertyWithAgent>(response);
  },

  async getByAgent(agentId: string) {
    const response = await fetch(`${API_BASE}/properties/agent/${agentId}`);
    return handleResponse<Property[]>(response);
  },

  async create(property: InsertProperty) {
    const response = await fetch(`${API_BASE}/properties`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(property),
    });
    return handleResponse<Property>(response);
  },

  async update(id: string, property: Partial<InsertProperty>) {
    const response = await fetch(`${API_BASE}/properties/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(property),
    });
    return handleResponse<Property>(response);
  },

  async delete(id: string) {
    const response = await fetch(`${API_BASE}/properties/${id}`, {
      method: "DELETE",
    });
    return handleResponse<{ message: string }>(response);
  },
};

export const leadsApi = {
  async getAll() {
    const response = await fetch(`${API_BASE}/leads`);
    return handleResponse<Lead[]>(response);
  },

  async getById(id: string) {
    const response = await fetch(`${API_BASE}/leads/${id}`);
    return handleResponse<Lead>(response);
  },

  async getByProperty(propertyId: string) {
    const response = await fetch(`${API_BASE}/leads/property/${propertyId}`);
    return handleResponse<Lead[]>(response);
  },

  async create(lead: InsertLead) {
    const response = await fetch(`${API_BASE}/leads`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(lead),
    });
    return handleResponse<Lead>(response);
  },

  async update(id: string, lead: Partial<InsertLead>) {
    const response = await fetch(`${API_BASE}/leads/${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(lead),
    });
    return handleResponse<Lead>(response);
  },

  async delete(id: string) {
    const response = await fetch(`${API_BASE}/leads/${id}`, {
      method: "DELETE",
    });
    return handleResponse<{ message: string }>(response);
  },
};

export const tasksApi = {
  async getById(id: string) {
    const response = await fetch(`${API_BASE}/tasks/${id}`);
    return handleResponse<Task>(response);
  },

  async getByUser(userId: string) {
    const response = await fetch(`${API_BASE}/tasks/user/${userId}`);
    return handleResponse<Task[]>(response);
  },

  async getByProperty(propertyId: string) {
    const response = await fetch(`${API_BASE}/tasks/property/${propertyId}`);
    return handleResponse<Task[]>(response);
  },

  async create(task: InsertTask) {
    const response = await fetch(`${API_BASE}/tasks`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(task),
    });
    return handleResponse<Task>(response);
  },

  async update(id: string, task: Partial<InsertTask>) {
    const response = await fetch(`${API_BASE}/tasks/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(task),
    });
    return handleResponse<Task>(response);
  },

  async delete(id: string) {
    const response = await fetch(`${API_BASE}/tasks/${id}`, {
      method: "DELETE",
    });
    return handleResponse<{ message: string }>(response);
  },
};
