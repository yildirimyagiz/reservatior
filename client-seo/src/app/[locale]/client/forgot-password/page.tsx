import type { Metadata } from "next";
import ForgotPasswordPage from "./ForgotPasswordPage";

export const metadata: Metadata = {
  title: "Reset Password - Reservatior Account Recovery",
  description: "Reset your Reservatior account password and regain access to your real estate management tools.",
  keywords: ["forgot password","reset password","account recovery"],
  openGraph: {
    title: "Reset Password - Reservatior Account Recovery",
    description: "Reset your Reservatior account password and regain access to your real estate management tools.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export const revalidate = 86400;

export default function ForgotPasswordPageWrapper() {
  return <ForgotPasswordPage />;
}
