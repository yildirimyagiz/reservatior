import type { Metadata } from "next";
import VerifyEmailPage from "@/app/[locale]/client/verify-email/VerifyEmailPage";

export const metadata: Metadata = {
  title: "Verify Email - Confirm Your Account | Reservatior",
  description: "Verify your email address to activate your Reservatior account and access all features.",
  keywords: ["verify email","email verification","account activation"],
  openGraph: {
    title: "Verify Email - Confirm Your Account | Reservatior",
    description: "Verify your email address to activate your Reservatior account and access all features.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export const revalidate = 86400;

export default function VerifyEmailPageWrapper() {
  return <VerifyEmailPage />;
}
