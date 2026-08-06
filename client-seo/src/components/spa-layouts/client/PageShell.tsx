import { ReactNode } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Search, Plus, Activity } from "lucide-react";
import { cn } from "@/lib/utils";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

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
  searchPlaceholder,
  filters,
  stats,
  children,
  actions,
}: PageShellProps) {
  const { t } = useTranslation();
  const placeholder = searchPlaceholder ?? t("common.search", "Search");

  return (
    <div className="ui-page min-h-screen p-8 lg:p-12">
      {(title || description || createLabel) && (
        <div className="ui-page-header relative gap-8 lg:items-center">
          <div className="relative z-10 space-y-2">
            {title && <h1 className="ui-title text-2xl md:text-3xl">{title}</h1>}
            {description && <p className="ui-subtitle opacity-80">{description}</p>}
          </div>

          <div className="relative z-10 flex items-center gap-4">
            {actions}
            {createLabel && onCreateClick && (
              <Button
                onClick={onCreateClick}
                className="ui-btn-primary h-10 rounded-lg px-6 font-medium shadow-sm transition-all active:scale-95"
              >
                <Plus className="mr-2 h-4 w-4" />
                {createLabel}
              </Button>
            )}
          </div>
        </div>
      )}

      {stats && stats.length > 0 && (
        <div className="grid grid-cols-2 gap-6 lg:grid-cols-4">
          {stats.map((stat, idx) => (
            <m.div
              key={stat.label}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
              className="ui-kpi group relative overflow-hidden rounded-[32px] p-8 shadow-2xl transition-all hover:bg-accent/10"
            >
              <div className="absolute right-0 top-0 p-6 text-primary opacity-5 transition-transform group-hover:scale-110">
                <Activity className="h-12 w-12" />
              </div>
              <p className="mb-2 text-xs font-semibold tracking-wider text-muted-foreground">{stat.label}</p>
              <p className="text-2xl font-bold text-foreground">{stat.value}</p>
              <div className="mt-4 h-1 w-full overflow-hidden rounded-full bg-muted">
                <div className="h-full w-2/3 bg-brand" />
              </div>
            </m.div>
          ))}
        </div>
      )}

      {(onSearchChange || filters) && (
        <div className="flex flex-col items-center gap-6 lg:flex-row">
          {onSearchChange && (
            <div className="group relative w-full flex-1 lg:max-w-md">
              <Search className="absolute left-5 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground transition-colors group-focus-within:text-brand" />
              <Input
                placeholder={placeholder}
                value={searchValue}
                onChange={(e) => onSearchChange(e.target.value)}
                className="h-11 rounded-lg border-border bg-card pl-10 text-sm text-foreground shadow-sm placeholder:text-muted-foreground/50 focus:border-brand/50"
              />
            </div>
          )}
          <div className={cn("flex w-full flex-wrap items-center gap-4 lg:w-auto")}>{filters}</div>
        </div>
      )}

      <div className="relative">{children}</div>
    </div>
  );
}
