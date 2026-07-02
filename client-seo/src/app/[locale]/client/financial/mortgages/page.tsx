import type { Metadata } from "next";
import { MortgagesContent } from "./MortgagesContent";

export const metadata: Metadata = {
  title: "Mortgages - Mortgage Management | Reservatior",
  description: "Manage mortgage applications and approvals. Track mortgage rates and loan processing.",
  keywords: ["mortgages", "loans", "mortgage rates", "property financing"],
  openGraph: {
    title: "Mortgages - Mortgage Management | Reservatior",
    description: "Manage mortgage applications and approvals.",
    type: "website",
  },
};

export default function MortgagesPage() {
  return <MortgagesContent />;
}
