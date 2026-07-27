import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "User Passport - Intelligence & AI | Reservatior",
  description: "User intelligence profile with behavior analysis, engagement scoring, and intent prediction.",
};

export default function UserPassportPage() {
  return <Dashboard />;
}
