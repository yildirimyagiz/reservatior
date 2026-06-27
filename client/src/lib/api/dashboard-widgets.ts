import { apiClient } from "./client";
export interface DashboardWidget { id: string; orgId: string; userId: string; widgetType: string; title: string; config: any; position: any; createdAt: Date; updatedAt: Date; }

export interface DashboardWidgetCreate extends Partial<DashboardWidget> {
  widgetType: string;
  title: string;
  config: any;
  position?: any;
}

export interface DashboardWidgetUpdate extends Partial<DashboardWidget> {}

export const dashboardWidgetsApi = {
  getAll: async (params?: {
    page?: number;
    limit?: number;
    search?: string;
  }) => {
    return await apiClient.get("/api/dashboardwidgets", { params });
  },

  getById: async (id: string) => {
    return await apiClient.get(`/api/dashboardwidgets/${id}`);
  },

  create: async (data: DashboardWidgetCreate) => {
    return await apiClient.post("/api/dashboardwidgets", data);
  },

  update: async (id: string, data: DashboardWidgetUpdate) => {
    return await apiClient.patch(`/api/dashboardwidgets/${id}`, data);
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/dashboardwidgets/${id}`, {
      data: { tags: [] },
    });
  },

  // Get widgets for current user
  getUserWidgets: async () => {
    return await apiClient.get("/api/dashboardwidgets", {
      params: { userId: "current" },
    });
  },

  // Update widget positions (for drag and drop)
  updatePositions: async (widgets: Array<{ id: string; position: any }>) => {
    return await apiClient.patch(
      "/api/dashboardwidgets/bulk-update",
      {
        widgets,
      }
    );
  },
};
