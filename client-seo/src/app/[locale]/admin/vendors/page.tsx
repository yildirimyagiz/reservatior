import type { Metadata } from "next";
import AdminVendorsPage from "./AdminVendorsPage";
export const metadata: Metadata = { title: "Vendors - Admin | Reservatior" };
export default function Wrapper() { return <AdminVendorsPage />; }
