import type { Metadata } from "next";
import AdminMaintenancePage from "./AdminMaintenancePage";
export const metadata: Metadata = { title: "Maintenance - Admin | Reservatior" };
export default function Wrapper() { return <AdminMaintenancePage />; }
