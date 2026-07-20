import type { Metadata } from "next";
import ContractFinancials from "@/pages-spa/finance_os/ContractFinancials";

export const metadata: Metadata = {
  title: "Contract Financials | Reservatior Finance OS",
  description: "Hybrid Settlement Pipeline — early capture cycles, tri-party split, and installment schedules.",
};

export default function ContractFinancialsPage() {
  return <ContractFinancials />;
}
