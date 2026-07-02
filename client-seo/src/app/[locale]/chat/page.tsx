import type { Metadata } from "next";
import { HomeChatClient } from "./HomeChatClient";

export const metadata: Metadata = {
  title: "AI Chat Assistant | Reservatior",
  description: "Chat with Reservatior AI to find your dream property without filters. Just describe what you are looking for in natural language.",
  keywords: ["AI chat", "property search", "real estate AI", "smart search", "natural language chat"],
  openGraph: {
    title: "AI Chat Assistant | Reservatior",
    description: "Chat with Reservatior AI to find your dream property without filters.",
    type: "website",
  },
};

export const revalidate = 3600;

export default function ChatPage() {
  return <HomeChatClient />;
}
