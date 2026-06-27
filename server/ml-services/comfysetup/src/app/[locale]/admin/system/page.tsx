import { requireAdmin } from "@/lib/admin";
import { Server, Database, Cpu, HardDrive, Activity, AlertTriangle } from "lucide-react";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export default async function SystemPage({ params }: PageProps) {
  await requireAdmin();

  // Mock system stats - in production, these would come from actual monitoring
  const systemStats = {
    uptime: "99.9%",
    cpuUsage: "45%",
    memoryUsage: "62%",
    diskUsage: "38%",
    activeConnections: 1234,
    queuedJobs: 12,
  };

  const services = [
    { name: "Next.js Frontend", status: "online", uptime: "100%" },
    { name: "FastAPI Backend", status: "online", uptime: "99.9%" },
    { name: "PostgreSQL Database", status: "online", uptime: "100%" },
    { name: "Redis Cache", status: "online", uptime: "99.8%" },
    { name: "ComfyUI Service", status: "online", uptime: "98.5%" },
    { name: "RunPod GPU", status: "online", uptime: "97.2%" },
  ];

  const recentLogs = [
    { time: "2 min ago", level: "INFO", message: "User authentication successful" },
    { time: "5 min ago", level: "INFO", message: "Generation completed for user xyz" },
    { time: "12 min ago", level: "WARN", message: "High memory usage detected" },
    { time: "20 min ago", level: "INFO", message: "Database backup completed" },
    { time: "35 min ago", level: "ERROR", message: "Failed to connect to external API" },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-white">System Monitoring</h1>
        <p className="mt-2 text-slate-400">Monitor system health and performance</p>
      </div>

      {/* System Stats */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-3 lg:grid-cols-6">
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-2 mb-2">
            <Activity className="h-4 w-4 text-green-400" />
            <p className="text-sm text-slate-400">Uptime</p>
          </div>
          <p className="text-2xl font-bold text-white">{systemStats.uptime}</p>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-2 mb-2">
            <Cpu className="h-4 w-4 text-blue-400" />
            <p className="text-sm text-slate-400">CPU</p>
          </div>
          <p className="text-2xl font-bold text-white">{systemStats.cpuUsage}</p>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-2 mb-2">
            <Server className="h-4 w-4 text-purple-400" />
            <p className="text-sm text-slate-400">Memory</p>
          </div>
          <p className="text-2xl font-bold text-white">{systemStats.memoryUsage}</p>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-2 mb-2">
            <HardDrive className="h-4 w-4 text-orange-400" />
            <p className="text-sm text-slate-400">Disk</p>
          </div>
          <p className="text-2xl font-bold text-white">{systemStats.diskUsage}</p>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-2 mb-2">
            <Database className="h-4 w-4 text-cyan-400" />
            <p className="text-sm text-slate-400">Connections</p>
          </div>
          <p className="text-2xl font-bold text-white">{systemStats.activeConnections}</p>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-2 mb-2">
            <Activity className="h-4 w-4 text-yellow-400" />
            <p className="text-sm text-slate-400">Queue</p>
          </div>
          <p className="text-2xl font-bold text-white">{systemStats.queuedJobs}</p>
        </div>
      </div>

      {/* Services Status */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
        <h2 className="text-xl font-bold text-white mb-4">Service Status</h2>
        <div className="grid grid-cols-1 gap-3 md:grid-cols-2 lg:grid-cols-3">
          {services.map((service) => (
            <div key={service.name} className="rounded-lg border border-slate-800 bg-slate-800/50 p-4">
              <div className="flex items-center justify-between mb-2">
                <span className="font-medium text-white">{service.name}</span>
                <span className="flex items-center gap-1">
                  <span className="h-2 w-2 rounded-full bg-green-500" />
                  <span className="text-xs text-green-400">{service.status}</span>
                </span>
              </div>
              <p className="text-sm text-slate-400">Uptime: {service.uptime}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Recent Logs */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
        <h2 className="text-xl font-bold text-white mb-4">Recent System Logs</h2>
        <div className="space-y-2">
          {recentLogs.map((log, idx) => (
            <div key={idx} className="flex items-start gap-3 rounded-lg border border-slate-800 bg-slate-800/50 p-3">
              <span className="text-xs text-slate-500 min-w-[80px]">{log.time}</span>
              <span
                className={`text-xs font-semibold min-w-[60px] ${
                  log.level === "ERROR"
                    ? "text-red-400"
                    : log.level === "WARN"
                    ? "text-yellow-400"
                    : "text-blue-400"
                }`}
              >
                {log.level}
              </span>
              <span className="text-sm text-slate-300 flex-1">{log.message}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Environment Variables */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
        <h2 className="text-xl font-bold text-white mb-4">Environment Configuration</h2>
        <div className="grid grid-cols-1 gap-3 md:grid-cols-2">
          <div className="rounded-lg border border-slate-800 bg-slate-800/50 p-4">
            <p className="text-sm text-slate-400">Node Environment</p>
            <p className="mt-1 font-mono text-white">{process.env.NODE_ENV}</p>
          </div>
          <div className="rounded-lg border border-slate-800 bg-slate-800/50 p-4">
            <p className="text-sm text-slate-400">Database Connected</p>
            <p className="mt-1 font-mono text-green-400">✓ Connected</p>
          </div>
          <div className="rounded-lg border border-slate-800 bg-slate-800/50 p-4">
            <p className="text-sm text-slate-400">API Version</p>
            <p className="mt-1 font-mono text-white">v1.0.0</p>
          </div>
          <div className="rounded-lg border border-slate-800 bg-slate-800/50 p-4">
            <p className="text-sm text-slate-400">Build Date</p>
            <p className="mt-1 font-mono text-white">{new Date().toLocaleDateString()}</p>
          </div>
        </div>
      </div>
    </div>
  );
}
