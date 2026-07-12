import type { Metadata } from "next";
import SalesDealCreator from "@/pages-spa/finance_os/SalesDealCreator";

export const metadata: Metadata = {
  title: "Sales Deal Creator | Reservatior Finance OS",
  description: "Global real estate sales commission engine — 23 countries, 3 payment models, multi-language contracts.",
  keywords: ["sales commission", "real estate", "global", "installment", "contract"],
  openGraph: {
    title: "Sales Deal Creator | Reservatior",
    description: "Generate sales agreements with smart commission splitting across 23 countries and 3 payment models.",
    type: "website",
  },
};

export default function SalesDealPage() {
  return <SalesDealCreator />;
}
