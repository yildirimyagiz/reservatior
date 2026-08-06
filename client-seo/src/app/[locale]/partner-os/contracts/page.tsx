import type { Metadata } from "next";
import ContractGenerator from "@/pages-spa/document_os/ContractGenerator";

export const metadata: Metadata = {
  title: "Partner Contracts | Reservatior",
  description: "Generate partnership, agency and service contracts.",
};

export default function PartnerContractsPage() {
  return <ContractGenerator />;
}
