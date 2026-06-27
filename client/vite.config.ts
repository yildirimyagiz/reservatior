import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { resolve } from "path";

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": resolve(__dirname, "./src"),
      "@/components": resolve(__dirname, "./src/components"),
      "@/lib": resolve(__dirname, "./src/lib"),
      "@/hooks": resolve(__dirname, "./src/hooks"),
      "@/assets": resolve(__dirname, "./src/assets"),
    },
  },
  define: {},
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          // Core vendor libraries
          vendor: ['react', 'react-dom', 'react-router-dom'],
          
          // UI components (only existing ones)
          ui: [
            '@radix-ui/react-dialog',
            '@radix-ui/react-dropdown-menu',
            '@radix-ui/react-select',
            '@radix-ui/react-toast',
            'lucide-react'
          ],
          
          // Charts and analytics
          charts: ['recharts'],
          
          // Date utilities
          date: ['date-fns'],
          
          Forms: ['react-hook-form', '@hookform/resolvers', 'zod']
        }
      }
    },
    chunkSizeWarningLimit: 400 // Lower limit to encourage smaller chunks
  },
  server: {
    port: 5173,
  },
});
