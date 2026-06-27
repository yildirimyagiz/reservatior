import { useTranslation } from "react-i18next";
import { Moon, Sun } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useEffect, useState } from "react";
export function ThemeToggle() {
  const {
    t
  } = useTranslation();
  const [theme, setTheme] = useState<"light" | "dark">(() => {
    if (typeof window !== "undefined") {
      return document.documentElement.classList.contains("dark") ? "dark" : "light";
    }
    return "dark"; // Default to dark for Neural Hub feel
  });
  useEffect(() => {
    const root = window.document.documentElement;
    if (theme === "dark") {
      root.classList.add("dark");
    } else {
      root.classList.remove("dark");
    }
  }, [theme]);
  const toggleTheme = () => {
    setTheme(prev => prev === "light" ? "dark" : "light");
  };
  return <Button variant="ghost" size="icon" onClick={toggleTheme} className="w-10 h-10 rounded-xl bg-white/5 border border-white/5 hover:bg-white/10 text-muted-foreground hover:text-foreground transition-all duration-300 shadow-xl">
      {theme === "light" ? <Moon className="w-5 h-5 transition-all rotate-0 scale-100" /> : <Sun className="w-5 h-5 transition-all rotate-0 scale-100" />}
      <span className="sr-only">{t("client.src.toggle_theme")}</span>
    </Button>;
}