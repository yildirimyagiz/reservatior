import { Outlet } from "react-router-dom";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";

export default function PublicLayout() {
  return (
    <div className="flex flex-col min-h-screen bg-background overflow-x-hidden">
      <AppHeader />
      <main className="flex-1">
        <Outlet />
      </main>
      <Footer />
    </div>
  );
}
