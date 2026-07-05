import type { Metadata } from "next";
import AdminTasksPage from "./AdminTasksPage";
export const metadata: Metadata = { title: "Tasks - Admin | Reservatior" };
export default function Wrapper() { return <AdminTasksPage />; }
