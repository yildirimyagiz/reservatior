import type { ReactNode } from "react";
import { DeveloperLayout } from "@/components/spa-layouts/developer_os/DeveloperLayout";

export default function DeveloperOSLayout({ children }: { children: ReactNode }) {
  return <DeveloperLayout>{children}</DeveloperLayout>;
}
