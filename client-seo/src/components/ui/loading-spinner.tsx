import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
interface LoadingSpinnerProps {
  size?: "sm" | "md" | "lg";
  className?: string;
  text?: string;
}
export function LoadingSpinner({
  size = "md",
  className,
  text
}: LoadingSpinnerProps) {
  const {
    t
  } = useTranslation();
  const sizeClasses = {
    sm: "w-4 h-4",
    md: "w-6 h-6",
    lg: "w-8 h-8"
  };
  return <div className={cn("flex items-center gap-2", className)}>
      <div className={cn("animate-spin rounded-full border-2 border-current border-t-transparent", sizeClasses[size])} />
      {text && <span className="text-sm text-muted-foreground">{text}</span>}
    </div>;
}
export function LoadingPage() {
  const {
    t
  } = useTranslation();
  return <div className="min-h-screen flex items-center justify-center">
      <div className="text-center space-y-4">
        <LoadingSpinner size="lg" />
        <p className="text-muted-foreground">{t("client.src.loading")}</p>
      </div>
    </div>;
}
export function LoadingCard({
  text = "Loading..."
}: {
  text?: string;
}) {
  return <div className="flex items-center justify-center p-8 border rounded-lg bg-muted/20">
      <LoadingSpinner text={text} />
    </div>;
}
export function LoadingTable({
  rows = 5,
  columns = 4
}: {
  rows?: number;
  columns?: number;
}) {
  return <div className="space-y-2">
      {Array.from({
      length: rows
    }).map((_, rowIndex) => <div key={rowIndex} className="flex gap-4 p-2 border-b">
          {Array.from({
        length: columns
      }).map((_, colIndex) => <div key={colIndex} className="h-4 bg-muted rounded animate-pulse flex-1" style={{
        animationDelay: `${(rowIndex * columns + colIndex) * 0.1}s`
      }} />)}
        </div>)}
    </div>;
}
export function LoadingSkeleton({
  className,
  lines = 3
}: {
  className?: string;
  lines?: number;
}) {
  return <div className={cn("space-y-2", className)}>
      {Array.from({
      length: lines
    }).map((_, i) => <div key={i} className="h-4 bg-muted rounded animate-pulse" style={{
      width: `${Math.random() * 40 + 60}%`,
      animationDelay: `${i * 0.1}s`
    }} />)}
    </div>;
}