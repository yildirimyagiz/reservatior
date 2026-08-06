"use client";

import { useTranslation } from "react-i18next";
import { Link } from "@/lib/react-router-shim";
import { Github, Twitter, Linkedin, Heart } from "lucide-react";

export function Footer() {
  const { t } = useTranslation();
  const currentYear = new Date().getFullYear();

  const linkClass =
    "text-sm text-muted-foreground hover:text-brand transition-colors min-h-12 flex items-center";
  const socialClass =
    "min-h-12 min-w-12 w-12 h-12 rounded-xl bg-muted border border-border flex items-center justify-center text-muted-foreground hover:text-primary-foreground hover:bg-brand hover:border-brand transition-all duration-300";

  return (
    <footer
      className="w-full border-t border-border bg-card/80 backdrop-blur-sm py-12 mt-auto transition-colors duration-300"
      suppressHydrationWarning
    >
      <div className="container mx-auto px-6">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
          <div className="col-span-1 md:col-span-1">
            <div className="flex items-center gap-2 mb-4">
              <span className="text-xl font-bold tracking-tight uppercase bg-gradient-to-r from-brand via-info to-brand bg-size-[200%_auto] animate-shimmer bg-clip-text text-transparent">
                Reservatior
              </span>
            </div>
            <p className="text-sm text-muted-foreground leading-relaxed max-w-xs" suppressHydrationWarning>
              {t("footer.mission", t("client.src.empowering_property_managers_with"))}
            </p>
          </div>

          <div>
            <h2
              className="text-sm font-semibold text-foreground uppercase tracking-wider mb-5"
              suppressHydrationWarning
            >
              {t("footer.platform", t("common.platform"))}
            </h2>
            <ul className="space-y-1">
              <li>
                <Link to="/property" className={linkClass} suppressHydrationWarning>
                  {t("footer.inventory", t("client.src.inventory"))}
                </Link>
              </li>
              <li>
                <Link to="/bookings" className={linkClass} suppressHydrationWarning>
                  {t("footer.bookings", t("common.bookings"))}
                </Link>
              </li>
              <li>
                <Link to="/ai-studio" className={linkClass} suppressHydrationWarning>
                  {t("footer.ai_studio", t("client.src.ai_studio"))}
                </Link>
              </li>
              <li>
                <Link to="/analytics" className={linkClass} suppressHydrationWarning>
                  {t("footer.analytics", t("common.analytics"))}
                </Link>
              </li>
              <li>
                <Link to="/global-os" className={linkClass} suppressHydrationWarning>
                  {t("footer.global_os", "Global Hybrid Rental OS")}
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h2
              className="text-sm font-semibold text-foreground uppercase tracking-wider mb-5"
              suppressHydrationWarning
            >
              {t("footer.support", t("client.src.support"))}
            </h2>
            <ul className="space-y-1">
              <li>
                <Link to="/support" className={linkClass} suppressHydrationWarning>
                  {t("footer.help_center", t("client.src.help_center"))}
                </Link>
              </li>
              <li>
                <Link to="/legal/compliance" className={linkClass} suppressHydrationWarning>
                  {t("footer.compliance", t("client.src.compliance"))}
                </Link>
              </li>
              <li>
                <Link to="/privacy" className={linkClass} suppressHydrationWarning>
                  {t("footer.privacy_policy", t("client.src.privacy_policy"))}
                </Link>
              </li>
              <li>
                <Link to="/terms" className={linkClass} suppressHydrationWarning>
                  {t("footer.terms_of_service", t("client.src.terms_of_service"))}
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h2
              className="text-sm font-semibold text-foreground uppercase tracking-wider mb-5"
              suppressHydrationWarning
            >
              {t("footer.connect", t("client.src.connect"))}
            </h2>
            <div className="flex gap-4 mb-6">
              <a
                href="https://twitter.com/reservatior"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="Twitter"
                className={socialClass}
              >
                <Twitter className="w-5 h-5" />
              </a>
              <a
                href="https://linkedin.com/company/reservatior"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="LinkedIn"
                className={socialClass}
              >
                <Linkedin className="w-5 h-5" />
              </a>
              <a
                href="https://github.com/reservatior"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="GitHub"
                className={socialClass}
              >
                <Github className="w-5 h-5" />
              </a>
            </div>
            <p
              className="text-xs text-muted-foreground uppercase font-medium mb-2"
              suppressHydrationWarning
            >
              {t("footer.status_system", t("client.src.status_system"))}
            </p>
            <div className="flex items-center gap-2">
              <div className="w-2 h-2 rounded-full bg-success animate-pulse" />
              <span className="text-xs text-muted-foreground" suppressHydrationWarning>
                {t("footer.all_systems_operational", t("client.src.all_systems_operational"))}
              </span>
            </div>
          </div>
        </div>

        <div className="pt-8 border-t border-border flex flex-col md:flex-row justify-between items-center gap-4">
          <p
            className="text-sm text-muted-foreground flex items-center gap-1 font-medium"
            suppressHydrationWarning
          >
            © {currentYear} Reservatior
            {t("footer.made_with", t("client.src.reservatior_inc_made_with"))}
            <Heart className="w-3 h-3 text-destructive fill-destructive" />
            {t("footer.by_team", t("client.src.by_deepmind_engineering"))}
          </p>
          <div className="flex gap-2">
            <Link
              to="/privacy"
              className="text-xs uppercase font-bold tracking-widest text-muted-foreground hover:text-foreground transition-colors min-h-12 flex items-center px-2"
              suppressHydrationWarning
            >
              {t("footer.privacy", t("client.src.privacy"))}
            </Link>
            <Link
              to="/terms"
              className="text-xs uppercase font-bold tracking-widest text-muted-foreground hover:text-foreground transition-colors min-h-12 flex items-center px-2"
              suppressHydrationWarning
            >
              {t("footer.terms", t("client.src.terms"))}
            </Link>
            <Link
              to="/cookies"
              className="text-xs uppercase font-bold tracking-widest text-muted-foreground hover:text-foreground transition-colors min-h-12 flex items-center px-2"
              suppressHydrationWarning
            >
              {t("footer.cookies", t("client.src.cookies"))}
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
