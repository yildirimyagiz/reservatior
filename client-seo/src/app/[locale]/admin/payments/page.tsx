import type { Metadata } from "next";
import AdminPaymentsPage from "./AdminPaymentsPage";
export const metadata: Metadata = { title: "Payments - Admin | Reservatior" };
export default function Wrapper() { return <AdminPaymentsPage />; }
