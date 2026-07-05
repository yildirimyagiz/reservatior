import { Elysia, t } from "elysia";
import { readdir, stat } from "node:fs/promises";
import { join } from "node:path";

const BASE_DATA_PATH = join(process.cwd(), "data");

export const dataBrowserRoutes = new Elysia({ prefix: "/data-browser" })
  .get("/list", async ({ query }) => {
    const { path = "" } = query;
    
    // Security: Prevent directory traversal attacks
    const normalizedPath = path.replace(/\.\./g, "");
    const targetDir = join(BASE_DATA_PATH, normalizedPath);
    
    try {
      const entries = await readdir(targetDir, { withFileTypes: true });
      
      const items = await Promise.all(entries.map(async (entry) => {
        const itemPath = join(targetDir, entry.name);
        const itemStat = await stat(itemPath);
        
        return {
          name: entry.name,
          isDirectory: entry.isDirectory(),
          path: join(normalizedPath, entry.name).replace(/\\/g, "/"),
          size: itemStat.size,
          lastModified: itemStat.mtime
        };
      }));
      
      return {
        success: true,
        currentPath: normalizedPath,
        items: items.filter(item => !item.name.startsWith(".")) // hide hidden files
      };
    } catch (error: any) {
      // If directory doesn't exist, return empty array instead of 500 error
      if (error.code === 'ENOENT') {
        return {
          success: true,
          currentPath: normalizedPath,
          items: []
        };
      }
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      path: t.Optional(t.String())
    })
  });
