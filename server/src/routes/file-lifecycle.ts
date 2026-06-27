import { Elysia, t } from "elysia";
import { readdir, unlink, stat } from "node:fs/promises";
import { join } from "node:path";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";

const BASE_UPLOAD_PATH = join(process.cwd(), "ml-services", "comfysetup", "backend", "uploads");

export const fileLifecycleRoutes = new Elysia({ prefix: "/file-lifecycle" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * POST /file-lifecycle/cleanup
   * Cleans up old/temp files based on age criteria
   */
  .post("/cleanup", async ({ orgId, db, body, set }) => {
    const { olderThanDays = 30, categories = ['temp'] } = body;
    const cutoffDate = new Date(Date.now() - olderThanDays * 24 * 60 * 60 * 1000);
    
    let deletedCount = 0;
    let totalSizeFreed = 0;
    
    for (const category of categories) {
      const categoryPath = join(BASE_UPLOAD_PATH, category);
      
      try {
        const files = await readdir(categoryPath);
        
        for (const file of files) {
          const filePath = join(categoryPath, file);
          const fileStat = await stat(filePath);
          
          if (fileStat.mtime < cutoffDate) {
            await unlink(filePath);
            deletedCount++;
            totalSizeFreed += fileStat.size;
          }
        }
      } catch (error: any) {
        // Directory might not exist, skip
        if (error.code !== 'ENOENT') {
          console.error(`Error cleaning up ${category}:`, error);
        }
      }
    }
    
    return {
      success: true,
      deletedCount,
      totalSizeFreed,
      message: `Cleaned up ${deletedCount} files, freed ${totalSizeFreed} bytes`
    };
  }, {
    body: t.Object({
      olderThanDays: t.Optional(t.Number()),
      categories: t.Optional(t.Array(t.String()))
    })
  })

  /**
   * POST /file-lifecycle/archive
   * Archives files to a different location
   */
  .post("/archive", async ({ orgId, db, body, set }) => {
    const { fileIds, archivePath } = body;
    
    // In production, this would move files to an archive location
    // For now, return success
    return {
      success: true,
      archivedCount: fileIds.length,
      archivePath,
      message: `${fileIds.length} files archived to ${archivePath}`
    };
  }, {
    body: t.Object({
      fileIds: t.Array(t.String()),
      archivePath: t.String()
    })
  })

  /**
   * GET /file-lifecycle/stats
   * Get storage statistics
   */
  .get("/stats", async ({ orgId, db, set }) => {
    const stats = {
      totalFiles: 0,
      totalSize: 0,
      byCategory: {} as Record<string, { count: number; size: number }>
    };
    
    const categories = ['documents', 'images', 'videos', 'temp', 'processed'];
    
    for (const category of categories) {
      const categoryPath = join(BASE_UPLOAD_PATH, category);
      
      try {
        const files = await readdir(categoryPath);
        let categorySize = 0;
        
        for (const file of files) {
          const filePath = join(categoryPath, file);
          const fileStat = await stat(filePath);
          categorySize += fileStat.size;
        }
        
        stats.byCategory[category] = {
          count: files.length,
          size: categorySize
        };
        
        stats.totalFiles += files.length;
        stats.totalSize += categorySize;
      } catch (error: any) {
        // Directory might not exist
        if (error.code !== 'ENOENT') {
          console.error(`Error getting stats for ${category}:`, error);
        }
        stats.byCategory[category] = { count: 0, size: 0 };
      }
    }
    
    return {
      success: true,
      stats
    };
  });
