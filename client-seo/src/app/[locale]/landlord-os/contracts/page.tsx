import type { Metadata } from "next";
import ContractGenerator from "@/pages-spa/document_os/ContractGenerator";

export const metadata: Metadata = {
  title: "Landlord Contracts | Reservatior",
  description: "Generate lease, sales and property management contracts.",
};

export default function LandlordContractsPage() {
  return <ContractGenerator />;
}
