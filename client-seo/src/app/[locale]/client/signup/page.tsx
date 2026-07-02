import type { Metadata } from "next";
import SignupPage from "./SignupPage";

export const metadata: Metadata = {
  title: "Create Account - Join Reservatior",
  description: "Create your Reservatior account and start managing properties with AI-powered real estate tools.",
  keywords: ["sign up","create account","register","real estate platform"],
  openGraph: {
    title: "Create Account - Join Reservatior",
    description: "Create your Reservatior account and start managing properties with AI-powered real estate tools.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export const revalidate = 86400;

export default function SignupPageWrapper() {
  return <SignupPage />;
}
