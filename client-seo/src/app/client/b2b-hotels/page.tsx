import type { Metadata } from "next";
import { B2BContent } from "@/app/[locale]/client/b2b-hotels/B2BContent";


export const metadata: Metadata = {
  title: "B2B Hotel Partners | Reservatior",
  description: "Manage B2B hotel partnerships, corporate rates, room blocks, and channel integrations.",
  robots: { index: false, follow: false },
};

export default function B2BHotelsPage() {
  return <B2BContent />;
}
