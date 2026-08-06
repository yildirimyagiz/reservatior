import type { Metadata } from "next";
import ContractGenerator from "@/pages-spa/document_os/ContractGenerator";

export const metadata: Metadata = {
  title: "Contract Generator | Reservatior",
  description: "Generate localized, legally-grounded property contracts for 23 countries.",
};

export default function ContractsPage({ searchParams }: { searchParams: { country?: string } }) {
  return <ContractGenerator initialCountry={searchParams?.country} />;
}
