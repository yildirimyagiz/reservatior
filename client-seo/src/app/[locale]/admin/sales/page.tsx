import type { Metadata } from "next";
import AdminSalesPage from "./AdminSalesPage";
export const metadata: Metadata = { title: "Sales & Commission - Admin | Reservatior" };
export default function Wrapper() { return <AdminSalesPage />; }
