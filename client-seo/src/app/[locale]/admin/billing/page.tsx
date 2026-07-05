import type { Metadata } from "next";
import AdminBillingPage from "./AdminBillingPage";
export const metadata: Metadata = { title: "Billing - Admin | Reservatior" };
export default function Wrapper() { return <AdminBillingPage />; }
