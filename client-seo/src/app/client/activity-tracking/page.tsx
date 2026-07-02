import type { Metadata } from "next";
import ActivityTrackingPage from "@/app/[locale]/client/activity-tracking/ActivityTrackingPage";

export const metadata: Metadata = {
  title: "Activity Tracking - User Analytics | Reservatior",
  description: "Track user activity, platform engagement, and property interaction analytics.",
  keywords: ["activity tracking","analytics","user engagement","property insights"],
  openGraph: {
    title: "Activity Tracking - User Analytics | Reservatior",
    description: "Track user activity, platform engagement, and property interaction analytics.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function ActivityTrackingPageWrapper() {
  return <ActivityTrackingPage />;
}
