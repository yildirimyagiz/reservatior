import type { Metadata } from "next";
import { Tax1099FormsContent } from "./Tax1099FormsContent";


export const metadata: Metadata = {
  title: "Tax 1099 Forms - Tax Documents | Reservatior",
  description: "Generate and manage 1099 tax forms for agents and contractors.",
  keywords: ["1099 forms", "tax documents", "IRS forms", "tax reporting"],
  openGraph: {
    title: "Tax 1099 Forms - Tax Documents | Reservatior",
    description: "Generate and manage 1099 tax forms.",
    type: "website",
  },
};

export default function Tax1099FormsPage() {
  return <Tax1099FormsContent />;
}
