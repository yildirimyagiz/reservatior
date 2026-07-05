import type { Metadata } from "next";
import AdminProjectsPage from "./AdminProjectsPage";
export const metadata: Metadata = { title: "Projects - Admin | Reservatior" };
export default function Wrapper() { return <AdminProjectsPage />; }
