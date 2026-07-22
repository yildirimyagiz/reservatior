import type { Metadata } from "next";

import { Suspense } from "react";
import dynamic from "next/dynamic";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

const HomeChatClient = dynamic(() => import("./HomeChatClient").then(mod => ({ default: mod.HomeChatClient })), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "AI Chat Assistant | Reservatior",
  description: "Chat with Reservatior AI to find your dream property without filters. Just describe what you are looking for in natural language.",
  keywords: ["AI chat", "property search", "real estate AI", "smart search", "natural language chat"],
  openGraph: {
      url: `${siteUrl}/${locale}/chat`,
    title: "AI Chat Assistant | Reservatior",
    description: "Chat with Reservatior AI to find your dream property without filters.",
    type: "website",
  },

    alternates: {
      canonical: `${siteUrl}/${locale}/chat`,
    },
  };
}

export const revalidate = 3600;

export default function ChatPage() {
  return (
    <Suspense fallback={
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    }>
      <HomeChatClient />
    </Suspense>
  );
}
