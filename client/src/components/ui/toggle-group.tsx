// Toggle Group Component - DISABLED
// Missing @radix-ui/react-toggle-group dependency
// Use ButtonGroup or CheckboxGroup instead

import * as React from "react";
import { cn } from "@/lib/utils";

export interface ToggleGroupProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
}

const ToggleGroup = React.forwardRef<HTMLDivElement, ToggleGroupProps>(
  ({ className, children, ...props }, ref) => (
    <div
      ref={ref}
      className={cn(
        "inline-flex items-center rounded-md border border-input bg-background p-1",
        className
      )}
      {...props}
    >
      {children}
    </div>
  )
);
ToggleGroup.displayName = "ToggleGroup";

export { ToggleGroup };
