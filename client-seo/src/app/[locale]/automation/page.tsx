import type { Metadata } from "next";
import AutomationPage from "./AutomationPage";

export const metadata: Metadata = {
  title: "Automation Dashboard - Smart Workflow Management | Reservatior",
  description: "Automate your real estate workflows with AI-powered triggers and smart notifications. Streamline property management tasks effortlessly.",
  keywords: ["automation","workflow","triggers","real estate automation","smart notifications"],
  openGraph: {
    title: "Automation Dashboard - Smart Workflow Management | Reservatior",
    description: "Automate your real estate workflows with AI-powered triggers and smart notifications. Streamline property management tasks effortlessly.",
    type: "website",
  },
};

export const revalidate = 3600;

export default function AutomationPageWrapper() {
  return <AutomationPage />;
}
