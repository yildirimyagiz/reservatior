import type { Metadata } from "next";
import { TaxContent } from "./TaxContent";


export const metadata: Metadata = {
  title: "Tax - Tax Management | Reservatior",
  description: "Manage tax records, 1099 forms, and tax compliance. Track tax obligations and generate reports.",
  keywords: ["tax", "tax compliance", "1099 forms", "tax records"],
  openGraph: {
    title: "Tax - Tax Management | Reservatior",
    description: "Manage tax records, 1099 forms, and tax compliance.",
    type: "website",
  },
};

export default function TaxPage() {
  return <TaxContent />;
}
