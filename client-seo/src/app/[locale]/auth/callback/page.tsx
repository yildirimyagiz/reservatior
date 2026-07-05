import type { Metadata } from "next";
import AuthCallbackPage from "../../client/auth/callback/AuthCallbackPage";

export const metadata: Metadata = {
  title: "Authentication - Reservatior",
  description: "Completing authentication process for Reservatior platform.",
  keywords: ["authentication","callback","OAuth"],
  openGraph: {
    title: "Authentication - Reservatior",
    description: "Completing authentication process for Reservatior platform.",
    type: "website",
  },
};

export default function AuthCallbackPageWrapper() {
  return <AuthCallbackPage />;
}
