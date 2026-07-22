import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

const AIStudioContent = dynamic(() => import("./AIStudioContent").then(mod => ({ default: mod.AIStudioContent })), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

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
    canonical: "/admin/ai/studio",
  },
};

export const revalidate = 3600;

export default function AIStudioPage() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "AI Studio", url: "/admin/ai/studio" },
      ]} />
      <Suspense fallback={
        <div className="flex items-center justify-center min-h-[60vh]">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
        </div>
      }>
        <AIStudioContent />
      </Suspense>
    </>
  );
}
