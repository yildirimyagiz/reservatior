import type { Metadata } from "next";
import { RightToRentContent } from "./RightToRentContent";

export const metadata: Metadata = {
  title: "Right to Rent - Tenant Verification | Reservatior",
  description: "Manage Right to Rent checks and tenant verification. Ensure compliance with rental regulations.",
  keywords: ["right to rent", "tenant verification", "rental checks", "tenant compliance"],
  openGraph: {
    title: "Right to Rent - Tenant Verification | Reservatior",
    description: "Manage Right to Rent checks and tenant verification.",
    type: "website",
  },
};

export default function RightToRentPage() {
  return <RightToRentContent />;
}
