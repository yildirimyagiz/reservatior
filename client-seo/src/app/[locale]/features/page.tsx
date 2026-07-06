import Features from "@/pages-spa/public/Features";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";

export default function FeaturesPage() {
  return (
    <div className="flex flex-col min-h-screen bg-background">
      <AppHeader />
      <main className="flex-1">
        <Features />
      </main>
      <Footer />
    </div>
  );
}
