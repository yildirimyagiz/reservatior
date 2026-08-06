import type { ReactNode } from "react";
import { PartnerLayout } from "@/components/spa-layouts/partner_os/PartnerLayout";

export default function PartnerOSLayout({ children }: { children: ReactNode }) {
  return <PartnerLayout>{children}</PartnerLayout>;
}
