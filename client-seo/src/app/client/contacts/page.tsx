import type { Metadata } from "next";
import ContactsPage from "@/app/[locale]/client/contacts/ContactsPage";

export const metadata: Metadata = {
  title: "Contacts - Client Relationship Management | Reservatior",
  description: "Manage your real estate contacts, clients, and professional network.",
  keywords: ["contacts","CRM","client management","real estate contacts"],
  openGraph: {
    title: "Contacts - Client Relationship Management | Reservatior",
    description: "Manage your real estate contacts, clients, and professional network.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function ContactsPageWrapper() {
  return <ContactsPage />;
}
