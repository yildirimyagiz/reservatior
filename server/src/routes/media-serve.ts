import { Elysia, t } from "elysia";
import { readFile, stat } from "node:fs/promises";
import { join } from "node:path";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";

const BASE_UPLOAD_PATH = join(process.cwd(), "ml-services", "comfysetup", "backend", "uploads");

export const mediaServeRoutes = new Elysia({ prefix: "/uploads" })
  .use(authMiddleware)
  .use(regionMiddleware)
  
  /**
   * GET /uploads/*
   * Serves uploaded files with access control
   */
  .get("/*", async ({ params, set, db, userId, orgId }) => {
    const filePath = params['*'];
    if (!filePath) {
      set.status = 400;
      return { error: "Invalid file path" };
    }
    
    const fullPath = join(BASE_UPLOAD_PATH, filePath);
    
    try {
      // Check if file exists
      const fileStat = await stat(fullPath);
      
      // Parse path to extract country/state/city/propertyType/category/processingType/org/property for access control
      const pathParts = filePath.split('/');
      const countryCode = pathParts[0] || 'GLOBAL';
      const stateCode = pathParts[1] || 'default-state';
      const cityCode = pathParts[2] || 'default-city';
      const propertyType = pathParts[3] || 'UNKNOWN';
      const fileCategory = pathParts[4] || 'documents';
      const processingType = pathParts[5] || 'raw';
      const fileOrgId = pathParts[6] || 'default-org';
      
      // Access control: User must belong to the org or have admin access
      // In production, check user's permissions against the file's org
      const hasAccess = await checkFileAccess(db, userId, orgId, fileOrgId, countryCode, stateCode, cityCode, propertyType);
      
      if (!hasAccess) {
        set.status = 403;
        return { error: "Access denied" };
      }
      
      // Read and serve file
      const fileBuffer = await readFile(fullPath);
      
      // Set appropriate content type based on file extension
      const ext = filePath.split('.').pop();
      const contentTypes: Record<string, string> = {
        'pdf': 'application/pdf',
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'png': 'image/png',
        'gif': 'image/gif',
        'mp4': 'video/mp4',
        'webm': 'video/webm',
        'mov': 'video/quicktime'
      };
      
      set.headers['Content-Type'] = contentTypes[ext || ''] || 'application/octet-stream';
      set.headers['Content-Length'] = fileBuffer.length.toString();
      set.headers['Cache-Control'] = 'public, max-age=31536000'; // 1 year cache
      
      return fileBuffer;
    } catch (error: any) {
      if (error.code === 'ENOENT') {
        set.status = 404;
        return { error: "File not found" };
      }
      set.status = 500;
      return { error: "Failed to serve file" };
    }
  });

/**
 * Check if user has access to the requested file
 */
async function checkFileAccess(
  db: any,
  userId: string,
  userOrgId: string | undefined,
  fileOrgId: string,
  countryCode: string,
  stateCode: string,
  cityCode: string,
  propertyType: string
): Promise<boolean> {
  // Admin users have access to all files
  const user = await db.user.findUnique({
    where: { id: userId },
    include: { role: true }
  });
  
  if (user?.role?.name === 'ADMIN') {
    return true;
  }
  
  // Users have access to files from their own organization
  if (userOrgId && userOrgId === fileOrgId) {
    return true;
  }
  
  // Country-specific access rules can be added here
  // For example, TR users can only access TR files
  // City-specific rules can also be added
  // Property-type specific rules can be added
  
  return false;
}
