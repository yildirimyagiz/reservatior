import type { Metadata } from "next";
import NotFoundPage from "@/app/[locale]/client/not-found/NotFoundPage";

export const metadata: Metadata = {
  title: "Page Not Found - 404 | Reservatior",
  description: "The page you are looking for does not exist. Return to Reservatior homepage.",
  keywords: ["404","not found","page not found"],
  openGraph: {
    title: "Page Not Found - 404 | Reservatior",
    description: "The page you are looking for does not exist. Return to Reservatior homepage.",
    type: "website",
  },
  alternates: {
    canonical: "/client/not-found",
  },
};

export const revalidate = 86400;

export default function NotFoundPageWrapper() {
  return <NotFoundPage />;
}
