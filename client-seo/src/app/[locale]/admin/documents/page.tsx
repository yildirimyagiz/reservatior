import type { Metadata } from "next";
import AdminDocumentsPage from "./AdminDocumentsPage";
export const metadata: Metadata = { title: "Documents - Admin | Reservatior" };
export default function Wrapper() { return <AdminDocumentsPage />; }
