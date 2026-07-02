import type { Metadata } from "next";
import UnauthorizedPage from "./UnauthorizedPage";

export const metadata: Metadata = {
  title: "Unauthorized - Access Denied | Reservatior",
  description: "You do not have permission to access this page. Contact support if you believe this is an error.",
  keywords: ["unauthorized","access denied","permission denied"],
  openGraph: {
    title: "Unauthorized - Access Denied | Reservatior",
    description: "You do not have permission to access this page. Contact support if you believe this is an error.",
    type: "website",
  },
  alternates: {
    canonical: "/client/unauthorized",
  },
};

export const revalidate = 86400;

export default function UnauthorizedPageWrapper() {
  return <UnauthorizedPage />;
}
