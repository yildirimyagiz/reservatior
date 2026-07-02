import type { Metadata } from "next";
import FilesPage from "@/app/[locale]/client/files/FilesPage";

export const metadata: Metadata = {
  title: "Files - Document Management | Reservatior",
  description: "Store, organize, and manage your real estate documents and files securely.",
  keywords: ["files","documents","document management","real estate files"],
  openGraph: {
    title: "Files - Document Management | Reservatior",
    description: "Store, organize, and manage your real estate documents and files securely.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function FilesPageWrapper() {
  return <FilesPage />;
}
