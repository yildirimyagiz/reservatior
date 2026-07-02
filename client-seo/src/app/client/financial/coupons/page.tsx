import type { Metadata } from "next";
import { CouponsContent } from "@/app/[locale]/client/financial/coupons/CouponsContent";

export const metadata: Metadata = {
  title: "Coupons - Discount Coupons | Reservatior",
  description: "Manage discount coupons and promotional codes. Create, edit, and track coupon usage.",
  keywords: ["coupons", "discount codes", "promotions", "vouchers"],
  openGraph: {
    title: "Coupons - Discount Coupons | Reservatior",
    description: "Manage discount coupons and promotional codes.",
    type: "website",
  },
};

export default function CouponsPage() {
  return <CouponsContent />;
}
