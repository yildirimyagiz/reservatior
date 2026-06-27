import { useState, useCallback } from "react";

export interface Toast {
  id: string;
  title?: string;
  description?: string;
  variant?: "default" | "destructive";
  duration?: number;
}

export interface ToastState {
  toasts: Toast[];
}

export interface UseToastReturn {
  toast: (props: Omit<Toast, "id">) => void;
  dismiss: (id: string) => void;
  toasts: Toast[];
}

let toastCount = 0;

export function useToast(): UseToastReturn {
  const [toasts, setToasts] = useState<Toast[]>([]);

  const toast = useCallback((props: Omit<Toast, "id">) => {
    const id = (++toastCount).toString();
    const newToast: Toast = {
      id,
      duration: 5000,
      ...props,
    };

    setToasts((prev) => [...prev, newToast]);

    // Auto dismiss after duration
    setTimeout(() => {
      setToasts((prev) => prev.filter((t) => t.id !== id));
    }, newToast.duration);
  }, []);

  const dismiss = useCallback((id: string) => {
    setToasts((prev) => prev.filter((t) => t.id !== id));
  }, []);

  return {
    toast,
    dismiss,
    toasts,
  };
}
