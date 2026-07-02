import type { Metadata } from "next";
import ProfileFavoritesPage from "@/app/[locale]/client/profile/favorites/ProfileFavoritesPage";

export const metadata: Metadata = {
  title: "Favorites - Saved Properties | Reservatior",
  description: "View and manage your saved favorite properties and listings.",
  keywords: ["favorites","saved properties","wishlist","bookmarked listings"],
  openGraph: {
    title: "Favorites - Saved Properties | Reservatior",
    description: "View and manage your saved favorite properties and listings.",
    type: "website",
  },
};

export default function ProfileFavoritesPageWrapper() {
  return <ProfileFavoritesPage />;
}
