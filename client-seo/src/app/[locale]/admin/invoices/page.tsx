import type { Metadata } from "next";
import AdminInvoicesPage from "./AdminInvoicesPage";
export const metadata: Metadata = { title: "Invoices - Admin | Reservatior" };
export default function Wrapper() { return <AdminInvoicesPage />; }
