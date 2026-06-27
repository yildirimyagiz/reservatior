"use client";

import * as React from "react";
import { AnimatePresence, motion } from "framer-motion";
import { X } from "lucide-react";
import { cn } from "@/lib/utils";

const DialogContext = React.createContext<{
  open: boolean;
  onOpenChange: (open: boolean) => void;
}>({
  open: false,
  onOpenChange: () => {},
});

export const Dialog = ({
  children,
  open,
  onOpenChange,
}: {
  children: React.ReactNode;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}) => {
  return (
    <DialogContext.Provider value={{ open, onOpenChange }}>
      {children}
    </DialogContext.Provider>
  );
};

export const DialogTrigger = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  const { onOpenChange } = React.useContext(DialogContext);
  return (
    <div onClick={() => onOpenChange(true)} className="inline-block cursor-pointer">
      {children}
    </div>
  );
};

export const DialogContent = ({
  children,
  className,
}: {
  children: React.ReactNode;
  className?: string;
}) => {
  const { open, onOpenChange } = React.useContext(DialogContext);

  return (
    <AnimatePresence>
      {open && (
        <>
          {/* Backdrop */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm"
            onClick={() => onOpenChange(false)}
          />
          {/* Content */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95, translateX: "-50%", translateY: "-50%" }}
            animate={{ opacity: 1, scale: 1, translateX: "-50%", translateY: "-50%" }}
            exit={{ opacity: 0, scale: 0.95, translateX: "-50%", translateY: "-50%" }}
            className={cn(
              "fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg gap-4 border border-slate-800 bg-slate-950 p-6 shadow-lg duration-200 sm:rounded-lg md:w-full",
              className
            )}
          >
            {children}
            <button
              onClick={() => onOpenChange(false)}
              className="absolute right-4 top-4 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-accent data-[state=open]:text-muted-foreground"
            >
              <X className="h-4 w-4 text-slate-400" />
              <span className="sr-only">Close</span>
            </button>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
};

export const DialogHeader = ({
  children,
  className,
}: {
  children: React.ReactNode;
  className?: string;
}) => (
  <div className={cn("flex flex-col space-y-1.5 text-center sm:text-left", className)}>
    {children}
  </div>
);

export const DialogTitle = ({
  children,
  className,
}: {
  children: React.ReactNode;
  className?: string;
}) => (
  <h2 className={cn("text-lg font-semibold leading-none tracking-tight text-white", className)}>
    {children}
  </h2>
);

export const DialogDescription = ({
  children,
  className,
}: {
  children: React.ReactNode;
  className?: string;
}) => (
  <p className={cn("text-sm text-slate-400", className)}>{children}</p>
);
