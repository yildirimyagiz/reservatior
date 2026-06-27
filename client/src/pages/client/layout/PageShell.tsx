import { ReactNode } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Search, Plus, Activity } from "lucide-react";
import { cn } from "@/lib/utils";
import { motion } from "framer-motion";

interface PageShellProps {
  title: string;
  description?: string;
  createLabel?: string;
  onCreateClick?: () => void;
  searchValue?: string;
  onSearchChange?: (value: string) => void;
  searchPlaceholder?: string;
  filters?: ReactNode;
  stats?: { label: string; value: string | number; color?: string }[];
  children: ReactNode;
  actions?: ReactNode;
}

export function PageShell({
  title,
  description,
  createLabel,
  onCreateClick,
  searchValue,
  onSearchChange,
  searchPlaceholder = "Search Protocol...",
  filters,
  stats,
  children,
  actions,
}: PageShellProps) {
  return (
    <div className="p-8 lg:p-12 space-y-10 min-h-screen bg-background text-foreground transition-colors duration-300">
      {/* Tactical Header */}
      {(title || description || createLabel) && (
        <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-8 relative">
          <div className="space-y-2 relative z-10">
            {title && (
              <h1 className="text-2xl md:text-3xl font-bold tracking-tight text-foreground">
                {title}
              </h1>
            )}
            {description && (
              <p className="text-sm text-muted-foreground mt-2 opacity-80">
                {description}
              </p>
            )}
          </div>
        
        <div className="flex items-center gap-4 relative z-10">
          {actions}
          {createLabel && onCreateClick && (
              <Button 
                onClick={onCreateClick} 
                className="h-10 px-6 rounded-lg bg-primary hover:bg-primary/90 text-primary-foreground font-medium shadow-sm transition-all active:scale-95 group border-none"
              >
                <Plus className="w-4 h-4 mr-2" />
                {createLabel}
              </Button>
          )}
        </div>
      </div>
      )}

      {/* Neural Stats HUD */}
      {stats && stats.length > 0 && (
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-6">
          {stats.map((stat, idx) => (
            <motion.div
              key={stat.label}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
              className="bg-card dark:bg-[#1a1b1e]/60 border border-border dark:border-white/5 border-l border-t rounded-[32px] p-8 backdrop-blur-3xl shadow-2xl relative overflow-hidden group hover:bg-accent/10 transition-all"
            >
              <div className="absolute top-0 right-0 p-6 opacity-5 text-primary group-hover:scale-110 transition-transform">
                 <Activity className="w-12 h-12" />
              </div>
              <p className="text-xs font-semibold text-muted-foreground tracking-wider mb-2">{stat.label}</p>
              <p className="text-2xl font-bold text-foreground">{stat.value}</p>
              <div className="mt-4 h-1 w-full bg-muted rounded-full overflow-hidden">
                 <div className="h-full bg-primary shadow-[0_0_10px_var(--color-primary)] w-2/3" />
              </div>
            </motion.div>
          ))}
        </div>
      )}

      {/* Control Layer: Search + Filters */}
      {(onSearchChange || filters) && (
        <div className="flex flex-col lg:flex-row gap-6 items-center">
          {onSearchChange && (
            <div className="relative flex-1 w-full lg:max-w-md group">
              <Search className="absolute left-5 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
              <Input
                placeholder={searchPlaceholder}
                value={searchValue}
                onChange={(e) => onSearchChange(e.target.value)}
                className="h-11 pl-10 bg-card border-border dark:border-white/5 rounded-lg text-sm text-foreground placeholder:text-muted-foreground/50 focus:border-primary/50 transition-all shadow-sm"
              />
            </div>
          )}
          <div className="flex flex-wrap gap-4 w-full lg:w-auto items-center">
            {filters}
          </div>
        </div>
      )}

      <div className="relative">
         {children}
      </div>
    </div>
  );
}
