import type { Metadata } from "next";
import { AIStudioContent } from "@/app/[locale]/client/ai/studio/AIStudioContent";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "AI Studio - AI-Powered Tools | Reservatior",
  description: "Access powerful AI tools for property analysis, OCR, translation, and video processing. Powered by state-of-the-art AI models.",
  keywords: ["AI studio", "AI tools", "OCR", "translation", "video AI", "property AI"],
  openGraph: {
    title: "AI Studio - AI-Powered Tools | Reservatior",
    description: "Access powerful AI tools for property analysis, OCR, translation, and video processing.",
    type: "website",
  },
  alternates: {
    canonical: "/client/ai/studio",
  },
};

export const revalidate = 3600;

export default function AIStudioPage() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "AI Studio", url: "/client/ai/studio" },
      ]} />
      <AIStudioContent />
    </>
  );
}
