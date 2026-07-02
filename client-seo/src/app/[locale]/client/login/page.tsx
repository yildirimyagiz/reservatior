import type { Metadata } from "next";
import LoginPage from "./LoginPage";

export const metadata: Metadata = {
  title: "Sign In - Reservatior Account Access",
  description: "Sign in to your Reservatior account to manage properties, bookings, and access AI-powered real estate tools.",
  keywords: ["login","sign in","account access","real estate platform"],
  openGraph: {
    title: "Sign In - Reservatior Account Access",
    description: "Sign in to your Reservatior account to manage properties, bookings, and access AI-powered real estate tools.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export const revalidate = 86400;

export default function LoginPageWrapper() {
  return <LoginPage />;
}
