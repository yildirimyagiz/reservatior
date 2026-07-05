import type { Metadata } from "next";
import AdminMembershipPage from "./AdminMembershipPage";
export const metadata: Metadata = { title: "Membership - Admin | Reservatior" };
export default function Wrapper() { return <AdminMembershipPage />; }
