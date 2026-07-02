import type { Metadata } from "next";
import { DealsContent } from "./DealsContent";

export const metadata: Metadata = {
  title: "Deals - Deal Management | Reservatior",
  description: "Manage deals and opportunities. Track sales pipeline and deal progress.",
  keywords: ["deals", "opportunities", "sales pipeline", "deal tracking"],
  openGraph: {
    title: "Deals - Deal Management | Reservatior",
    description: "Manage deals and opportunities.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function DealsPage() {
  return <DealsContent />;
}
