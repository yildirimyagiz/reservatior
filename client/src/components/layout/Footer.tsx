import { useTranslation } from "react-i18next";
import { Link } from "react-router-dom";
import { Github, Twitter, Linkedin, Facebook, Heart } from "lucide-react";
export function Footer() {
  const {
    t
  } = useTranslation();
  const currentYear = new Date().getFullYear();
  return <footer className="w-full border-t border-border dark:border-slate-800/50 bg-card/80 dark:bg-[#14151a]/90 backdrop-blur-sm py-12 mt-auto transition-colors duration-300">
      <div className="container mx-auto px-6">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
          {/* Brand & Mission */}
          <div className="col-span-1 md:col-span-1">
            <div className="flex items-center gap-2 mb-4">
              <span className="text-xl font-bold tracking-tight uppercase bg-linear-to-r from-blue-600 via-blue-400 to-blue-600 bg-size-[200%_auto] animate-shimmer bg-clip-text text-transparent">Reservatior</span>
            </div>
            <p className="text-sm text-slate-600 dark:text-slate-300 leading-relaxed max-w-xs">{t("client.src.empowering_property_managers_with")}</p>
          </div>

          {/* Quick Links */}
          <div>
            <h4 className="text-sm font-semibold text-foreground uppercase tracking-wider mb-5">{t("client.src.platform")}</h4>
            <ul className="space-y-3">
              <li><Link to="/properties" className="text-sm text-slate-600 dark:text-slate-300 hover:text-blue-500 dark:hover:text-blue-400 transition-colors">{t("client.src.inventory")}</Link></li>
              <li><Link to="/bookings" className="text-sm text-slate-600 dark:text-slate-300 hover:text-blue-500 dark:hover:text-blue-400 transition-colors">{t("client.src.bookings")}</Link></li>
              <li><Link to="/ai-studio" className="text-sm text-slate-600 dark:text-slate-300 hover:text-blue-500 dark:hover:text-blue-400 transition-colors">{t("client.src.ai_studio")}</Link></li>
              <li><Link to="/analytics" className="text-sm text-slate-600 dark:text-slate-300 hover:text-blue-500 dark:hover:text-blue-400 transition-colors">{t("client.src.analytics")}</Link></li>
            </ul>
          </div>

          {/* Support */}
          <div>
            <h4 className="text-sm font-semibold text-foreground uppercase tracking-wider mb-5">{t("client.src.support")}</h4>
            <ul className="space-y-3">
              <li><Link to="/support" className="text-sm text-slate-600 dark:text-slate-300 hover:text-blue-500 dark:hover:text-blue-400 transition-colors">{t("client.src.help_center")}</Link></li>
              <li><Link to="/legal/compliance" className="text-sm text-slate-600 dark:text-slate-300 hover:text-blue-500 dark:hover:text-blue-400 transition-colors">{t("client.src.compliance")}</Link></li>
              <li><Link to="/privacy" className="text-sm text-slate-600 dark:text-slate-300 hover:text-blue-500 dark:hover:text-blue-400 transition-colors">{t("client.src.privacy_policy")}</Link></li>
              <li><Link to="/terms" className="text-sm text-slate-600 dark:text-slate-300 hover:text-blue-500 dark:hover:text-blue-400 transition-colors">{t("client.src.terms_of_service")}</Link></li>
            </ul>
          </div>

          {/* Social & Contact */}
          <div>
            <h4 className="text-sm font-semibold text-foreground uppercase tracking-wider mb-5">{t("client.src.connect")}</h4>
            <div className="flex gap-4 mb-6">
              <a href="https://twitter.com/reservatior" target="_blank" rel="noopener noreferrer" className="w-10 h-10 rounded-xl bg-slate-100 dark:bg-white/10 border border-slate-200 dark:border-white/10 flex items-center justify-center text-slate-600 dark:text-slate-300 hover:text-white hover:bg-blue-600 dark:hover:bg-blue-600 hover:border-blue-600 dark:hover:border-blue-600 transition-all duration-300">
                <Twitter className="w-5 h-5" />
              </a>
              <a href="https://linkedin.com/company/reservatior" target="_blank" rel="noopener noreferrer" className="w-10 h-10 rounded-xl bg-slate-100 dark:bg-white/10 border border-slate-200 dark:border-white/10 flex items-center justify-center text-slate-600 dark:text-slate-300 hover:text-white hover:bg-blue-700 dark:hover:bg-blue-700 hover:border-blue-700 dark:hover:border-blue-700 transition-all duration-300">
                <Linkedin className="w-5 h-5" />
              </a>
              <a href="https://github.com/reservatior" target="_blank" rel="noopener noreferrer" className="w-10 h-10 rounded-xl bg-slate-100 dark:bg-white/10 border border-slate-200 dark:border-white/10 flex items-center justify-center text-slate-600 dark:text-slate-300 hover:text-white hover:bg-indigo-600 dark:hover:bg-indigo-600 hover:border-indigo-600 dark:hover:border-indigo-600 transition-all duration-300">
                <Github className="w-5 h-5" />
              </a>
            </div>
            <p className="text-xs text-slate-700 dark:text-slate-200 uppercase font-medium mb-2">{t("client.src.status_system")}</p>
            <div className="flex items-center gap-2">
              <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></div>
              <span className="text-xs text-slate-600 dark:text-slate-300">{t("client.src.all_systems_operational")}</span>
            </div>
          </div>
        </div>

        <div className="pt-8 border-t border-slate-200 dark:border-slate-800/50 flex flex-col md:flex-row justify-between items-center gap-4">
          <p className="text-sm text-slate-700 dark:text-slate-200 flex items-center gap-1 font-medium">
            © {currentYear}{t("client.src.reservatior_inc_made_with")}<Heart className="w-3 h-3 text-rose-500 fill-rose-500" />{t("client.src.by_deepmind_engineering")}</p>
          <div className="flex gap-6">
            <Link to="/privacy" className="text-xs uppercase font-bold tracking-widest text-slate-600 dark:text-slate-300 hover:text-foreground transition-colors">{t("client.src.privacy")}</Link>
            <Link to="/terms" className="text-xs uppercase font-bold tracking-widest text-slate-600 dark:text-slate-300 hover:text-foreground transition-colors">{t("client.src.terms")}</Link>
            <Link to="/cookies" className="text-xs uppercase font-bold tracking-widest text-slate-600 dark:text-slate-300 hover:text-foreground transition-colors">{t("client.src.cookies")}</Link>
          </div>
        </div>
      </div>
    </footer>;
}