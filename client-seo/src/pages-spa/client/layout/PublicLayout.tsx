import { Outlet, useLocation } from "react-router-dom";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";

export default function PublicLayout() {
  const location = useLocation();
  const isHomeChat = location.pathname === "/";

  return (
    <div className={`flex flex-col bg-background overflow-x-hidden ${
      isHomeChat ? "h-[100dvh] overflow-hidden" : "min-h-screen"
    }`}>
      <AppHeader />
      <main className="flex-1 overflow-hidden">
        <Outlet />
      </main>
      {!isHomeChat && <Footer />}
    </div>
  );
}
