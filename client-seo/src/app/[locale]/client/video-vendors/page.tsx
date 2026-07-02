import type { Metadata } from "next";
import VideoVendorsPage from "./VideoVendorsPage";

export const metadata: Metadata = {
  title: "Video Service Providers - Property Video Vendors | Reservatior",
  description: "Connect with professional video service providers for property tours, aerial photography, and virtual staging.",
  keywords: ["video vendors","property video","aerial photography","virtual staging"],
  openGraph: {
    title: "Video Service Providers - Property Video Vendors | Reservatior",
    description: "Connect with professional video service providers for property tours, aerial photography, and virtual staging.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export const revalidate = 3600;

export default function VideoVendorsPageWrapper() {
  return <VideoVendorsPage />;
}
