import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Content Publisher - Intelligence & AI | Reservatior",
  description: "Multi-channel content publishing dashboard with SEO performance, A/B tests, and content pipeline.",
};

export default function ContentPublisherPage() {
  return <Dashboard />;
}
