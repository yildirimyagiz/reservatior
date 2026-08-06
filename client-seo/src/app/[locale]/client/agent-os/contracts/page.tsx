import type { Metadata } from "next";
import ContractGenerator from "@/pages-spa/document_os/ContractGenerator";

export const metadata: Metadata = {
  title: "Agent Contracts | Reservatior",
  description: "Generate agency representation and property contracts for your deals.",
};

export default function AgentContractsPage() {
  return <ContractGenerator />;
}
