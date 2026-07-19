import type { Metadata } from "next";
import TrustScorePage from "./TrustScorePage";

export const metadata: Metadata = {
  title: "Trust Scores - Admin Panel | Reservatior",
  description: "View and manage trust scores, entity ratings, and score breakdowns",
  keywords: ["trust score","scoring","rating","admin"],
  openGraph: {
    title: "Trust Scores - Admin Panel | Reservatior",
    description: "View and manage trust scores, entity ratings, and score breakdowns",
    type: "website",
  },
};

export default function TrustScorePageWrapper() {
  return <TrustScorePage />;
}
