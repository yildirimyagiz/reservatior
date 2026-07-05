import type { Metadata } from "next";
import AdminContactsPage from "./AdminContactsPage";
export const metadata: Metadata = { title: "Contacts - Admin | Reservatior" };
export default function Wrapper() { return <AdminContactsPage />; }
