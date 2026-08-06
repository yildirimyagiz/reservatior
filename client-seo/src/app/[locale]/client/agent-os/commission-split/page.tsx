import CommissionSplit from "./CommissionSplit";
import { Metadata } from "next";

export const metadata: Metadata = {
  title: "Commission Split | Reservatior",
  description: "Manage co-brokerage and commission splits",
};

export default function CommissionSplitPage() {
  return <CommissionSplit />;
}

