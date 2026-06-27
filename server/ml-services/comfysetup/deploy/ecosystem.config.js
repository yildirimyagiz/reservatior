/**
 * PM2 Ecosystem Configuration
 * 
 * For running Next.js on GCP e2-micro instance
 * Optimized for 1GB RAM
 */

module.exports = {
  apps: [
    {
      name: 'atlasvs',
      script: 'node_modules/next/dist/bin/next',
      args: 'start',
      cwd: '/app',
      
      // Instance configuration
      instances: 1, // Only 1 instance on e2-micro
      exec_mode: 'fork', // Fork mode is more memory efficient
      
      // Memory management
      max_memory_restart: '700M', // Restart if memory exceeds 700MB
      
      // Environment
      env: {
        NODE_ENV: 'production',
        PORT: 3000,
      },
      
      // Logging
      log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
      error_file: '/var/log/atlasvs/error.log',
      out_file: '/var/log/atlasvs/out.log',
      merge_logs: true,
      
      // Process management
      autorestart: true,
      watch: false,
      max_restarts: 10,
      restart_delay: 5000,
      
      // Kill timeout
      kill_timeout: 5000,
      
      // Graceful shutdown
      wait_ready: true,
      listen_timeout: 10000,
    },
  ],
};
