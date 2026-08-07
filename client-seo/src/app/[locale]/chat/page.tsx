import type { Metadata } from "next";

import { Suspense } from "react";
import dynamic from "next/dynamic";
import path from "path";
import fs from "fs";

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

const HomeChatClient = dynamic(() => import("./HomeChatClient").then(mod => ({ default: mod.HomeChatClient })), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  const resolvedLocale = locale || "en";
  let metaTitle = "AI Chat Assistant | Reservatior";
  let metaDesc = "Chat with Reservatior AI to find your dream property without filters. Just describe what you are looking for in natural language.";

  try {
    const p = path.join(process.cwd(), "public", "locales", `${resolvedLocale}.json`);
    if (fs.existsSync(p)) {
      const data = JSON.parse(fs.readFileSync(p, "utf8"));
      if (data.chat_meta_title) metaTitle = data.chat_meta_title;
      if (data.chat_meta_description) metaDesc = data.chat_meta_description;
    }
  } catch (e) {
    console.error("Error loading chat metadata locale:", e);
  }

  return {
    title: metaTitle,
    description: metaDesc,
    keywords: ["AI chat", "property search", "real estate AI", "smart search", "natural language chat"],
    openGraph: {
      url: `${siteUrl}/${locale}/chat`,
      title: metaTitle,
      description: metaDesc,
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
