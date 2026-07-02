import type { Metadata } from "next";
import { AppointmentsContent } from "./AppointmentsContent";

export const metadata: Metadata = {
  title: "Appointments - Meetings & Appointments | Reservatior",
  description: "Manage appointments and meetings. Schedule and track property viewings and consultations.",
  keywords: ["appointments", "meetings", "property viewings", "consultations"],
  openGraph: {
    title: "Appointments - Meetings & Appointments | Reservatior",
    description: "Manage appointments and meetings.",
    type: "website",
  },
};

export default function AppointmentsPage() {
  return <AppointmentsContent />;
}
