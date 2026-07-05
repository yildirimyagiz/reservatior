import { apiClient } from "./client";

export interface DataNode {
  name: string;
  isDirectory: boolean;
  path: string;
  size: number;
  lastModified: string;
}

export const dataBrowserApi = {
  listDirectory: async (path: string = ""): Promise<{ currentPath: string; items: DataNode[] }> => {
    const res: any = await apiClient.get("/api/v1/data-browser/list", { path });
    return res as { currentPath: string; items: DataNode[] };
  }
};
