import { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "B2B Bulk Onboarding | Reservatior Admin",
  description: "Corporate housing provider bulk onboarding and portfolio management",
};

export default function B2BOnboardingPage() {
  return <Dashboard />;
}
