import type { Metadata } from "next";
import { ExperiencesContent } from "./ExperiencesContent";

export const metadata: Metadata = {
  title: "Experiences & Tours | Reservatior",
  description: "Book local tours, culinary experiences, and exclusive activities managed by local guides and hosts.",
  robots: { index: false, follow: false },
};

export default function ExperiencesPage() {
  return <ExperiencesContent />;
}
