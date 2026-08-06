"use client";

import { ReactNode } from "react";
import { cn } from "@/lib/utils";

interface PageShellProps {
  children: ReactNode;
  className?: string;
  title?: string;
  description?: string;
}

export function PageShell({ children, className, title, description }: PageShellProps) {
  return (
    <div className={cn("ui-page p-6 lg:p-8", className)}>
      {(title || description) && (
        <div className="ui-page-header mb-6">
          <div>
            {title && <h1 className="ui-title">{title}</h1>}
            {description && <p className="ui-subtitle">{description}</p>}
          </div>
        </div>
      )}
      {children}
    </div>
  );
}
