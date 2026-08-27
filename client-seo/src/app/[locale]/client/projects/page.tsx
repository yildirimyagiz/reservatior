import dynamic from "next/dynamic";
import type { Metadata } from "next";
import { Suspense } from "react";

const ProjectSearch = dynamic(() => import("@/app/[locale]/client/pages-spa-client/projects/ProjectSearchMap"), {
  ssr: false,
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export const metadata: Metadata = {
  title: "New Projects | Reservatior",
  description: "Search and explore new real estate projects and developments.",
};

export default function ProjectSearchPage() {
  return (
    <Suspense fallback={
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    }>
      <ProjectSearch />
    </Suspense>
  );
}
