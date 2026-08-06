import CommissionInstallments from "../CommissionInstallments";
import { Metadata } from "next";

export const metadata: Metadata = {
  title: "Commission Installments | Reservatior",
  description: "Manage and track commission installment payments",
};

export default function CommissionInstallmentsPage() {
  return <CommissionInstallments />;
}
