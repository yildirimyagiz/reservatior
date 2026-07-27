import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "AI Learning Loops - Admin Panel | Reservatior",
  description: "AI learning loops and continuous improvement dashboard for the admin panel.",
  keywords: ["ai", "learning", "loops", "machine learning", "continuous improvement"],
  openGraph: {
    title: "AI Learning Loops - Admin Panel | Reservatior",
    description: "AI learning loops and continuous improvement dashboard for the admin panel.",
    type: "website",
  },
};

export default function AILearningPage() {
  return <Dashboard />;
}
