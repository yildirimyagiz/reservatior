import type { Metadata } from "next";
import ProfileReviewsPage from "./ProfileReviewsPage";

export const metadata: Metadata = {
  title: "My Reviews - Property Reviews | Reservatior",
  description: "Manage your property reviews, ratings, and feedback.",
  keywords: ["reviews","ratings","property feedback","user reviews"],
  openGraph: {
    title: "My Reviews - Property Reviews | Reservatior",
    description: "Manage your property reviews, ratings, and feedback.",
    type: "website",
  },
};

export default function ProfileReviewsPageWrapper() {
  return <ProfileReviewsPage />;
}
