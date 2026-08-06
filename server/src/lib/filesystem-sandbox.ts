/**
 * File System Sandbox
 * Organization-isolated file storage with permission checks
 * Prevents cross-tenant file access
 */

import { mkdir, stat, readdir, unlink, readFile, writeFile } from 'fs/promises';
import { join } from 'path';
import { existsSync } from 'fs';

const BASE_STORAGE_PATH = process.env.STORAGE_PATH || './storage';

export interface FilePermission {
  orgId: string;
  userId: string;
  permissions: string[];
}

export interface FileInfo {
  name: string;
  path: string;
  size: number;
  mimeType: string;
  createdAt: Date;
  orgId: string;
}

/**
 * Get organization-specific storage path
 */
export function getOrgStoragePath(orgId: string): string {
  return join(BASE_STORAGE_PATH, 'organizations', orgId);
}

/**
 * Get user-specific storage path within organization
 */
export function getUserStoragePath(orgId: string, userId: string): string {
  return join(getOrgStoragePath(orgId), 'users', userId);
}

/**
 * Get document storage path
 */
export function getDocumentPath(orgId: string, documentId: string): string {
  return join(getOrgStoragePath(orgId), 'documents', documentId);
}

/**
 * Initialize organization storage directory
 */
export async function initializeOrgStorage(orgId: string): Promise<void> {
  const orgPath = getOrgStoragePath(orgId);
  
  if (!existsSync(orgPath)) {
    await mkdir(orgPath, { recursive: true });
    await mkdir(join(orgPath, 'documents'), { recursive: true });
    await mkdir(join(orgPath, 'users'), { recursive: true });
    await mkdir(join(orgPath, 'uploads'), { recursive: true });
    await mkdir(join(orgPath, 'temp'), { recursive: true });
    
    console.log(`[FileSystem] Initialized storage for org: ${orgId}`);
  }
}

/**
 * Check if path is within organization's sandbox
 */
export function isPathInSandbox(orgId: string, filePath: string): boolean {
  const orgPath = getOrgStoragePath(orgId);
  const resolvedPath = join(process.cwd(), filePath);
  const resolvedOrgPath = join(process.cwd(), orgPath);
  
  return resolvedPath.startsWith(resolvedOrgPath);
}

/**
 * Check file access permission
 */
export function checkFilePermission(
  permission: FilePermission,
  filePath: string,
  action: 'read' | 'write' | 'delete'
): boolean {
  // Super admins have all permissions
  if (permission.permissions.includes('*')) {
    return true;
  }

  // Check if file belongs to organization
  if (!isPathInSandbox(permission.orgId, filePath)) {
    return false;
  }

  // Check specific permission
  const requiredPermission = `files:${action}`;
  return permission.permissions.includes(requiredPermission);
}

/**
 * Write file to sandbox
 */
export async function writeSandboxFile(
  orgId: string,
  userId: string,
  fileName: string,
  content: Buffer,
  permission: FilePermission
): Promise<string> {
  if (!checkFilePermission(permission, fileName, 'write')) {
    throw new Error('Permission denied: Cannot write file');
  }

  await initializeOrgStorage(orgId);
  
  const userPath = getUserStoragePath(orgId, userId);
  const filePath = join(userPath, fileName);
  
  await writeFile(filePath, content);
  
  console.log(`[FileSystem] Wrote file: ${fileName} for org: ${orgId}`);
  
  return filePath;
}

/**
 * Read file from sandbox
 */
export async function readSandboxFile(
  orgId: string,
  filePath: string,
  permission: FilePermission
): Promise<Buffer> {
  if (!checkFilePermission(permission, filePath, 'read')) {
    throw new Error('Permission denied: Cannot read file');
  }

  if (!isPathInSandbox(orgId, filePath)) {
    throw new Error('Security violation: File outside sandbox');
  }

  const content = await readFile(filePath);
  
  console.log(`[FileSystem] Read file: ${filePath} for org: ${orgId}`);
  
  return content;
}

/**
 * Delete file from sandbox
 */
export async function deleteSandboxFile(
  orgId: string,
  filePath: string,
  permission: FilePermission
): Promise<void> {
  if (!checkFilePermission(permission, filePath, 'delete')) {
    throw new Error('Permission denied: Cannot delete file');
  }

  if (!isPathInSandbox(orgId, filePath)) {
    throw new Error('Security violation: File outside sandbox');
  }

  await unlink(filePath);
  
  console.log(`[FileSystem] Deleted file: ${filePath} for org: ${orgId}`);
}

/**
 * List files in sandbox directory
 */
export async function listSandboxFiles(
  orgId: string,
  directory: string,
  permission: FilePermission
): Promise<FileInfo[]> {
  if (!checkFilePermission(permission, directory, 'read')) {
    throw new Error('Permission denied: Cannot list files');
  }

  const dirPath = join(getOrgStoragePath(orgId), directory);
  
  if (!isPathInSandbox(orgId, dirPath)) {
    throw new Error('Security violation: Directory outside sandbox');
  }

  const files = await readdir(dirPath);
  
  const fileInfos: FileInfo[] = [];
  
  for (const file of files) {
    const filePath = join(dirPath, file);
    const stats = await stat(filePath);
    
    fileInfos.push({
      name: file,
      path: filePath,
      size: stats.size,
      mimeType: 'application/octet-stream', // TODO: Detect from extension
      createdAt: stats.mtime,
      orgId,
    });
  }
  
  return fileInfos;
}

/**
 * Get file info
 */
export async function getSandboxFileInfo(
  orgId: string,
  filePath: string,
  permission: FilePermission
): Promise<FileInfo> {
  if (!checkFilePermission(permission, filePath, 'read')) {
    throw new Error('Permission denied: Cannot access file');
  }

  if (!isPathInSandbox(orgId, filePath)) {
    throw new Error('Security violation: File outside sandbox');
  }

  const stats = await stat(filePath);
  
  return {
    name: filePath.split('/').pop() || '',
    path: filePath,
    size: stats.size,
    mimeType: 'application/octet-stream',
   createdAt: stats.mtime,
    orgId,
  };
}

/**
 * Clean up temporary files
 */
export async function cleanupTempFiles(orgId: string): Promise<void> {
  const tempPath = join(getOrgStoragePath(orgId), 'temp');
  
  if (existsSync(tempPath)) {
    const files = await readdir(tempPath);
    
    for (const file of files) {
      const filePath = join(tempPath, file);
      const stats = await stat(filePath);
      
      // Delete files older than 1 hour
      if (Date.now() - stats.mtimeMs > 3600000) {
        await unlink(filePath);
      }
    }
  }
  
  console.log(`[FileSystem] Cleaned temp files for org: ${orgId}`);
}

/**
 * Get organization storage quota
 */
export async function getOrgStorageQuota(orgId: string): Promise<{
  used: number;
  limit: number;
  percentage: number;
}> {
  const orgPath = getOrgStoragePath(orgId);
  
  if (!existsSync(orgPath)) {
    return { used: 0, limit: 10737418240, percentage: 0 }; // 10GB default limit
  }
  
  // Calculate total size (simplified - in production use du command)
  const files = await readdir(orgPath, { recursive: true });
  let totalSize = 0;
  
  for (const file of files) {
    try {
      const filePath = join(orgPath, file);
      const stats = await stat(filePath);
      if (stats.isFile()) {
        totalSize += stats.size;
      }
    } catch {
      // Skip files that can't be accessed
    }
  }
  
  const limit = 10737418240; // 10GB
  const percentage = (totalSize / limit) * 100;
  
  return {
    used: totalSize,
    limit,
    percentage,
  };
}

/**
 * Sanitize file name to prevent path traversal
 */
export function sanitizeFileName(fileName: string): string {
  // Remove path traversal attempts
  const sanitized = fileName.replace(/(\.\.(\/|\\|$))/g, '');
  // Remove non-alphanumeric characters except dashes, underscores, dots
  return sanitized.replace(/[^a-zA-Z0-9._-]/g, '_');
}
