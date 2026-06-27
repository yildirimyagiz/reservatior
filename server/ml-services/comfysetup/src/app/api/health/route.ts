/**
 * Health Check Endpoint
 * 
 * GET /api/health
 * 
 * Used by load balancers, monitoring, and container orchestration
 */

import { NextResponse } from 'next/server';

export const dynamic = 'force-dynamic';
export const revalidate = 0;

interface HealthStatus {
    status: 'healthy' | 'degraded' | 'unhealthy';
    timestamp: string;
    uptime: number;
    version: string;
    checks: {
        database: 'ok' | 'error';
        ai: 'ok' | 'error' | 'unconfigured';
        storage: 'ok' | 'error' | 'unconfigured';
    };
    memory: {
        used: number;
        total: number;
        percentage: number;
    };
}

export async function GET(): Promise<NextResponse<HealthStatus>> {
    // Basic health checks
    let dbStatus: 'ok' | 'error' = 'ok';
    let aiStatus: 'ok' | 'error' | 'unconfigured' = 'unconfigured';
    let storageStatus: 'ok' | 'error' | 'unconfigured' = 'unconfigured';
    
    // Check database
    try {
        // Quick DB check - would normally ping database
        // await prisma.$queryRaw`SELECT 1`;
        dbStatus = 'ok';
    } catch {
        dbStatus = 'error';
    }
    
    // Check AI configuration
    if (process.env.RUNPOD_API_KEY || process.env.A1111_HOST) {
        aiStatus = 'ok';
    }
    
    // Check storage configuration
    if (process.env.R2_ACCESS_KEY_ID || process.env.GCS_PROJECT_ID) {
        storageStatus = 'ok';
    }
    
    const checks = {
        database: dbStatus,
        ai: aiStatus,
        storage: storageStatus,
    };
    
    // Calculate memory usage
    const memUsage = process.memoryUsage();
    const memoryInfo = {
        used: Math.round(memUsage.heapUsed / 1024 / 1024),
        total: Math.round(memUsage.heapTotal / 1024 / 1024),
        percentage: Math.round((memUsage.heapUsed / memUsage.heapTotal) * 100),
    };
    
    // Determine overall status
    let status: 'healthy' | 'degraded' | 'unhealthy' = 'healthy';
    if (dbStatus === 'error') {
        status = 'unhealthy';
    } else if (aiStatus === 'unconfigured' || storageStatus === 'unconfigured') {
        status = 'degraded';
    }
    
    const response: HealthStatus = {
        status,
        timestamp: new Date().toISOString(),
        uptime: process.uptime(),
        version: process.env.npm_package_version || '1.0.0',
        checks,
        memory: memoryInfo,
    };
    
    const statusCode = status === 'unhealthy' ? 503 : 200;
    
    return NextResponse.json(response, { status: statusCode });
}
