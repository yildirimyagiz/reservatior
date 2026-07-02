import type { Metadata } from "next";
import { TagsContent } from "@/app/[locale]/client/crm/tags/TagsContent";

export const metadata: Metadata = {
  title: "Tags - Tag Management | Reservatior",
  description: "Manage tags and categories for organizing contacts and properties.",
  keywords: ["tags", "categories", "organization", "tagging"],
  openGraph: {
    title: "Tags - Tag Management | Reservatior",
    description: "Manage tags and categories.",
    type: "website",
  },
};

export default function TagsPage() {
  return <TagsContent />;
}
