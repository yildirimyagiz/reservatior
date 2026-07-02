import type { Metadata } from "next";
import { AIChatContent } from "./AIChatContent";

export const metadata: Metadata = {
  title: "AI Chat - Smart Property Search | Reservatior",
  description: "Find your perfect home with AI-powered natural language search. Describe what you're looking for and let our AI find the best properties for you.",
  keywords: ["AI chat", "property search", "AI assistant", "real estate AI", "smart search"],
  openGraph: {
    title: "AI Chat - Smart Property Search | Reservatior",
    description: "Find your perfect home with AI-powered natural language search.",
    type: "website",
  },
};

export const revalidate = 3600;

export default function AIChatPage() {
  return <AIChatContent />;
}
