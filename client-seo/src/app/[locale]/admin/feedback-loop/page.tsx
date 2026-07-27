import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Feedback Loop - Intelligence & AI | Reservatior",
  description: "Intelligence feedback loop monitor with prediction accuracy, calibration events, and model health indicators.",
  keywords: ["feedback", "loop", "calibration", "prediction", "accuracy"],
  openGraph: {
    title: "Feedback Loop - Intelligence & AI | Reservatior",
    description: "Intelligence feedback loop monitor with prediction accuracy.",
    type: "website",
  },
};

export default function FeedbackLoopPage() {
  return <Dashboard />;
}
