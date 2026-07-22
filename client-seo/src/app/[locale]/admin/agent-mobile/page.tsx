import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";

const AgentMobilePage = dynamic(() => import("./AgentMobilePage"), {
  loading: () => (
    <div className="p-6 flex items-center justify-center min-h-[400px]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export const metadata: Metadata = {
  title: "Agent Mobile Commerce - Admin Panel | Reservatior",
  description:
    "Mobile-optimized agent commerce: property scanning, offer generation, commission tracking",
  keywords: ["agent", "mobile", "commerce", "real estate", "offers"],
};

export default function AgentMobileWrapper() {
  return (
    <Suspense fallback={
      <div className="p-6 flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    }>
      <AgentMobilePage />
    </Suspense>
  );
}
