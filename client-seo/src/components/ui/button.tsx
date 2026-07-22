import * as React from "react"
import { Slot } from "@radix-ui/react-slot"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const ICON_ARIA_LABELS: Record<string, string> = {
  MoreHorizontal: "More options",
  Edit: "Edit",
  Trash2: "Delete",
  Eye: "View",
  X: "Close",
  ChevronLeft: "Previous",
  ChevronRight: "Next",
  Search: "Search",
  Plus: "Add",
  Download: "Download",
  Upload: "Upload",
  Settings: "Settings",
  Bell: "Notifications",
  Menu: "Menu",
  ChevronDown: "Expand",
  ChevronUp: "Collapse",
  ArrowUpRight: "Open",
  ArrowLeft: "Back",
  ArrowRight: "Forward",
  Filter: "Filter",
  Heart: "Favorite",
  Star: "Star",
  Share2: "Share",
  Clock: "Clock",
  Calendar: "Calendar",
  MapPin: "Location",
  Home: "Home",
  Info: "Information",
  AlertCircle: "Alert",
  CheckCircle2: "Complete",
  XCircle: "Cancel",
  Send: "Send",
  RefreshCw: "Refresh",
  MoreVertical: "More options",
  Pencil: "Edit",
  Copy: "Copy",
  ExternalLink: "Open in new tab",
  HelpCircle: "Help",
  Maximize2: "Maximize",
  Minimize2: "Minimize",
  Sun: "Light mode",
  Moon: "Dark mode",
  Monitor: "System mode",
};

const buttonVariants = cva(
  "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0" +
" hover-elevate active-elevate-2",
  {
    variants: {
      variant: {
        default:
           // @replit: no hover, and add primary border
           "bg-primary text-primary-foreground border border-primary-border",
        destructive:
          "bg-destructive text-destructive-foreground shadow-sm border-destructive-border",
        outline:
          // @replit Shows the background color of whatever card / sidebar / accent background it is inside of.
          // Inherits the current text color. Uses shadow-xs. no shadow on active
          // No hover state
          " border [border-color:var(--button-outline)] shadow-xs active:shadow-none ",
        secondary:
          // @replit border, no hover, no shadow, secondary border.
          "border bg-secondary text-secondary-foreground border border-secondary-border ",
        // @replit no hover, transparent border
        ghost: "border border-transparent",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {
        // @replit changed sizes
        default: "min-h-12 px-4 py-2",
        sm: "min-h-10 rounded-md px-3 text-xs",
        lg: "min-h-12 rounded-md px-8",
        icon: "min-h-12 min-w-12 h-12 w-12",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : "button"
    const ariaLabel = props['aria-label'] || props['aria-labelledby']
      ? undefined
      : size === 'icon' && typeof props.children === 'object' && props.children !== null && 'type' in (props.children as any)
        ? ICON_ARIA_LABELS[(props.children as any).type?.displayName || ''] || ICON_ARIA_LABELS[(props.children as any).type?.name || ''] || undefined
        : undefined
    return (
      <Comp
        className={cn(buttonVariants({ variant, size, className }))}
        ref={ref}
        aria-label={ariaLabel}
        {...props}
      />
    )
  }
)
Button.displayName = "Button"

export { Button, buttonVariants }
