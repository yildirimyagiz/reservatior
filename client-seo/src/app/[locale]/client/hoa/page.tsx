import type { Metadata } from "next";
import { HoaContent } from "./HoaContent";

export const metadata: Metadata = {
  title: "HOA Management | Reservatior",
  description: "Homeowners Association management dashboard. Track dues, announcements, and maintenance requests.",
  robots: { index: false, follow: false },
};

export default function HoaPage() {
  return <HoaContent />;
}
