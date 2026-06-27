const API_BASE = "/api";

async function handleResponse<T>(response: Response): Promise<T> {
  if (!response.ok) {
    const error = await response
      .json()
      .catch(() => ({ message: response.statusText }));
    throw new Error(error.message || "API request failed");
  }
  return response.json();
}

export type Achievement = {
  id: string;
  userId: string;
  goalType: string;
  goalValue: number;
  currentValue: number;
  isCompleted: boolean;
  completedAt: Date | null;
  pointsReward: number;
  bonusReward: string | null;
  createdAt: Date;
  updatedAt: Date;
  organizationId: string | null;
};

export type Property = {
  id: string;
  title: string;
  address: string;
  price: string;
  stats: {
    beds: number;
    baths: number;
    sqft: number;
  };
  description: string;
  type: "Villa" | "Apartment" | "Penthouse";
  region: "USA" | "Europe" | "Turkey";
  images: string[];
  coverImage: string;
  agent: {
    name: string;
    avatar: string;
  };
  status: "available" | "sold" | "pending";
  featured: boolean;
  createdAt: Date;
  updatedAt: Date;
};

export type User = {
  id: string;
  email: string;
  name: string;
  phone?: string;
  avatar?: string;
  role: string;
  organizationId?: string;
  createdAt: Date;
  updatedAt: Date;
};

export type Lead = {
  id: string;
  name: string;
  email: string;
  phone?: string;
  propertyId: string;
  message: string;
  status: "new" | "contacted" | "qualified" | "converted";
  createdAt: Date;
  updatedAt: Date;
};

export type Task = {
  id: string;
  title: string;
  description?: string;
  dueDate?: Date;
  completed: boolean;
  assignedTo: string;
  propertyId?: string;
  priority: "low" | "medium" | "high";
  createdAt: Date;
  updatedAt: Date;
};

// Achievement API
export const achievementsApi = {
  async getAll() {
    const response = await fetch(`${API_BASE}/achievements`);
    return handleResponse<Achievement[]>(response);
  },

  async getById(id: string) {
    const response = await fetch(`${API_BASE}/achievements/${id}`);
    return handleResponse<Achievement>(response);
  },

  async create(
    achievement: Omit<Achievement, "id" | "createdAt" | "updatedAt">
  ) {
    const response = await fetch(`${API_BASE}/achievements`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(achievement),
    });
    return handleResponse<Achievement>(response);
  },

  async update(id: string, achievement: Partial<Achievement>) {
    const response = await fetch(`${API_BASE}/achievements/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(achievement),
    });
    return handleResponse<Achievement>(response);
  },

  async delete(id: string) {
    const response = await fetch(`${API_BASE}/achievements/${id}`, {
      method: "DELETE",
    });
    return handleResponse<{ message: string }>(response);
  },
};

// Property API
export const propertiesApi = {
  async getAll() {
    const response = await fetch(`${API_BASE}/properties`);
    return handleResponse<Property[]>(response);
  },

  async getById(id: string) {
    const response = await fetch(`${API_BASE}/properties/${id}`);
    return handleResponse<Property>(response);
  },

  async create(property: Omit<Property, "id" | "createdAt" | "updatedAt">) {
    const response = await fetch(`${API_BASE}/properties`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(property),
    });
    return handleResponse<Property>(response);
  },

  async update(id: string, property: Partial<Property>) {
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

// User API
export const usersApi = {
  async getAll() {
    const response = await fetch(`${API_BASE}/users`);
    return handleResponse<User[]>(response);
  },

  async getById(id: string) {
    const response = await fetch(`${API_BASE}/users/${id}`);
    return handleResponse<User>(response);
  },

  async create(user: Omit<User, "id" | "createdAt" | "updatedAt">) {
    const response = await fetch(`${API_BASE}/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(user),
    });
    return handleResponse<User>(response);
  },

  async update(id: string, user: Partial<User>) {
    const response = await fetch(`${API_BASE}/users/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(user),
    });
    return handleResponse<User>(response);
  },
};

// Lead API
export const leadsApi = {
  async getAll() {
    const response = await fetch(`${API_BASE}/leads`);
    return handleResponse<Lead[]>(response);
  },

  async getById(id: string) {
    const response = await fetch(`${API_BASE}/leads/${id}`);
    return handleResponse<Lead>(response);
  },

  async create(lead: Omit<Lead, "id" | "createdAt" | "updatedAt">) {
    const response = await fetch(`${API_BASE}/leads`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(lead),
    });
    return handleResponse<Lead>(response);
  },

  async update(id: string, lead: Partial<Lead>) {
    const response = await fetch(`${API_BASE}/leads/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(lead),
    });
    return handleResponse<Lead>(response);
  },
};

// Task API
export const tasksApi = {
  async getAll() {
    const response = await fetch(`${API_BASE}/tasks`);
    return handleResponse<Task[]>(response);
  },

  async getById(id: string) {
    const response = await fetch(`${API_BASE}/tasks/${id}`);
    return handleResponse<Task>(response);
  },

  async create(task: Omit<Task, "id" | "createdAt" | "updatedAt">) {
    const response = await fetch(`${API_BASE}/tasks`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(task),
    });
    return handleResponse<Task>(response);
  },

  async update(id: string, task: Partial<Task>) {
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

// Health check
export const healthApi = {
  async check() {
    const response = await fetch(`/health`);
    return handleResponse<{ status: string }>(response);
  },
};
