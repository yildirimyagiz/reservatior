import type { Metadata } from "next";
import AdminReservationsPage from "./AdminReservationsPage";
export const metadata: Metadata = { title: "Reservations - Admin | Reservatior" };
export default function Wrapper() { return <AdminReservationsPage />; }
