import type { Metadata } from "next";
import ProfilePage from "./ProfilePage";

export const metadata: Metadata = {
  title: "Profile - Account Settings | Reservatior",
  description: "Manage your Reservatior account settings, preferences, and personal information.",
  keywords: ["profile","account settings","preferences","user profile"],
  openGraph: {
    title: "Profile - Account Settings | Reservatior",
    description: "Manage your Reservatior account settings, preferences, and personal information.",
    type: "website",
  },
};

export default function ProfilePageWrapper() {
  return <ProfilePage />;
}
