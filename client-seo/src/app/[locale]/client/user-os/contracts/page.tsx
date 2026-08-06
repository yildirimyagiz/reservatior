import type { Metadata } from "next";
import ContractGenerator from "@/pages-spa/document_os/ContractGenerator";

export const metadata: Metadata = {
  title: "My Contracts | Reservatior",
  description: "Generate and manage your property contracts.",
};

export default function UserContractsPage() {
  return <ContractGenerator />;
}
