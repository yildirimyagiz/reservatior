import type { Metadata } from "next";
import { LoyaltyContent } from "@/app/[locale]/client/loyalty/LoyaltyContent";

export const metadata: Metadata = {
  title: "Loyalty & Rewards | Reservatior",
  description: "Track your reward points, view membership status, and redeem exclusive discounts.",
  robots: { index: false, follow: false },
};

export default function LoyaltyPage() {
  return <LoyaltyContent />;
}
