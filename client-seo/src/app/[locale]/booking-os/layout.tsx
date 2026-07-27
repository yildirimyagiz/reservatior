import { RoleGuard } from "@/components/auth/RoleGuard";

export default function BookingOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="booking-os">{children}</RoleGuard>;
}
