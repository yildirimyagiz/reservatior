import type { Metadata } from "next";
import { SignaturesContent } from "@/app/[locale]/client/legal/signatures/SignaturesContent";

export const metadata: Metadata = {
  title: "Signatures - Digital Signatures | Reservatior",
  description: "Manage digital signatures for legal documents. Send, sign, and track document signatures.",
  keywords: ["digital signatures", "e-signatures", "document signing", "electronic signatures"],
  openGraph: {
    title: "Signatures - Digital Signatures | Reservatior",
    description: "Manage digital signatures for legal documents.",
    type: "website",
  },
};

export default function SignaturesPage() {
  return <SignaturesContent />;
}
