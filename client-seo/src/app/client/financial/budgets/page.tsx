import type { Metadata } from "next";
import { BudgetsContent } from "@/app/[locale]/client/financial/budgets/BudgetsContent";


export const metadata: Metadata = {
  title: "Budgets - Financial Budget Management | Reservatior",
  description: "Manage your financial budgets and track expenses. Set budget limits, monitor spending, and optimize your financial planning.",
  keywords: ["budgets", "financial planning", "expense tracking", "budget management"],
  openGraph: {
    title: "Budgets - Financial Budget Management | Reservatior",
    description: "Manage your financial budgets and track expenses.",
    type: "website",
  },
};

export default function BudgetsPage() {
  return <BudgetsContent />;
}
