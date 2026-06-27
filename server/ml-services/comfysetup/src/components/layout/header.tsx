"use client";

import * as React from "react";
import Link from "next/link";
import { useParams, usePathname } from "next/navigation";
import { motion, AnimatePresence } from "framer-motion";
import {
  Sofa,
  ChevronDown,
  Home,
  Palette,
  Video,
  Wand2,
  ImageIcon,
  Box,
  Sparkles,
  Camera,
  Building2,
  Users,
  BookOpen,
  HelpCircle,
  Menu,
  X,
} from "lucide-react";

import { Button } from "@/components/ui/button";
import type { Dictionary } from "@/lib/i18n/config";
import { LanguageSwitcher } from "./language-switcher";
import { UserDropdown } from "./user-dropdown";
import { NotificationDropdown } from "./notification-dropdown";
import { useSession } from "next-auth/react";
import { cn } from "@/lib/utils";
import { AtlasLogo } from "@/components/ui/logo";

interface HeaderProps {
  dictionary: Dictionary;
}

interface DropdownItem {
  label: string;
  href: string;
  description: string;
  icon: React.ElementType;
  badge?: string;
}

function NavDropdownMenu({
  label,
  items,
  isOpen,
  onToggle,
  locale,
}: {
  label: string;
  items: DropdownItem[];
  isOpen: boolean;
  onToggle: () => void;
  locale: string;
}) {
  return (
    <div className="relative">
      <button
        onClick={onToggle}
        className={cn(
          "flex items-center gap-1 text-sm font-medium transition-colors",
          isOpen ? "text-white" : "text-slate-400 hover:text-white"
        )}
      >
        {label}
        <ChevronDown
          className={cn(
            "h-4 w-4 transition-transform duration-200",
            isOpen && "rotate-180"
          )}
        />
      </button>

      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: 10, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 10, scale: 0.95 }}
            transition={{ duration: 0.15 }}
            className="absolute left-0 top-full mt-3 w-80 rounded-2xl border border-slate-800 bg-slate-950/95 p-2 shadow-2xl backdrop-blur-xl"
          >
            <div className="grid gap-1">
              {items.map((item) => (
                <Link
                  key={item.href}
                  href={`/${locale}${item.href}`}
                  className="group flex items-start gap-3 rounded-xl p-3 transition-colors hover:bg-slate-800/50"
                >
                  <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-gradient-to-br from-purple-600/20 to-indigo-600/20 text-purple-400 group-hover:from-purple-600/30 group-hover:to-indigo-600/30">
                    <item.icon className="h-5 w-5" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      <span className="text-sm font-medium text-white">
                        {item.label}
                      </span>
                      {item.badge && (
                        <span
                          className={cn(
                            "px-2 py-0.5 text-[10px] font-bold uppercase rounded-full",
                            (item.badge === "Popular" || item.badge === "Popüler") &&
                            "bg-green-500/20 text-green-400",
                            item.badge === "Premium" &&
                            "bg-amber-500/20 text-amber-400",
                            (item.badge === "Coming Soon" || item.badge === "Yakında") &&
                            "bg-blue-500/20 text-blue-400"
                          )}
                        >
                          {item.badge}
                        </span>
                      )}
                    </div>
                    <p className="mt-0.5 text-xs text-slate-500 line-clamp-1">
                      {item.description}
                    </p>
                  </div>
                </Link>
              ))}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export function Header({ dictionary }: HeaderProps) {
  const params = useParams();
  const pathname = usePathname();
  const locale = params.locale as string;
  const [openDropdown, setOpenDropdown] = React.useState<string | null>(null);
  const [mobileMenuOpen, setMobileMenuOpen] = React.useState(false);

  const d = dictionary.landing.header;

  const SERVICES_DROPDOWN: DropdownItem[] = [
    {
      label: d.services.staging.label,
      href: "/editor",
      description: d.services.staging.description,
      icon: Sofa,
      badge: d.badges.popular,
    },
    {
      label: d.services.redesign.label,
      href: "/editor?mode=redesign",
      description: d.services.redesign.description,
      icon: Wand2,
    },
    {
      label: d.services.enhance.label,
      href: "/editor?mode=enhance",
      description: d.services.enhance.description,
      icon: ImageIcon,
    },
    {
      label: d.services['3d'].label,
      href: "/editor?mode=3d",
      description: d.services['3d'].description,
      icon: Box,
      badge: d.badges.soon,
    },
    {
      label: d.services.video.label,
      href: "/editor?mode=video",
      description: d.services.video.description,
      icon: Video,
    },
  ];

  const CATEGORIES_DROPDOWN: DropdownItem[] = [
    {
      label: dictionary.roomCategories.livingRoom,
      href: "/editor?room=living-room",
      description: d.services.staging.description,
      icon: Home,
    },
    {
      label: dictionary.roomCategories.bedroom,
      href: "/editor?room=bedroom",
      description: d.services.staging.description,
      icon: Home,
    },
    {
      label: dictionary.roomCategories.kitchen,
      href: "/editor?room=kitchen",
      description: d.services.staging.description,
      icon: Home,
    },
    {
      label: dictionary.roomCategories.commercial,
      href: "/editor?room=commercial",
      description: d.services.staging.description,
      icon: Building2,
    },
    {
      label: dictionary.roomCategories.outdoor,
      href: "/editor?room=outdoor",
      description: d.services.staging.description,
      icon: Camera,
    },
  ];

  const STYLES_DROPDOWN: DropdownItem[] = [
    {
      label: dictionary.styles['modern-minimalist'].name,
      href: "/editor?style=modern-minimalist",
      description: dictionary.styles['modern-minimalist'].description,
      icon: Palette,
    },
    {
      label: dictionary.styles['scandinavian'].name,
      href: "/editor?style=scandinavian",
      description: dictionary.styles['scandinavian'].description,
      icon: Palette,
    },
    {
      label: dictionary.styles['industrial'].name,
      href: "/editor?style=industrial",
      description: dictionary.styles['industrial'].description,
      icon: Palette,
    },
    {
      label: dictionary.styles['luxury'].name,
      href: "/editor?style=luxury",
      description: dictionary.styles['luxury'].description,
      icon: Sparkles,
      badge: d.badges.premium,
    },
    {
      label: dictionary.styles['japanese'].name,
      href: "/editor?style=japanese",
      description: dictionary.styles['japanese'].description,
      icon: Palette,
    },
  ];

  const RESOURCES_DROPDOWN: DropdownItem[] = [
    {
      label: d.resources.docs.label,
      href: "/docs",
      description: d.resources.docs.description,
      icon: BookOpen,
    },
    {
      label: d.resources.caseStudies.label,
      href: "/case-studies",
      description: d.resources.caseStudies.description,
      icon: Users,
    },
    {
      label: d.resources.help.label,
      href: "/help",
      description: d.resources.help.description,
      icon: HelpCircle,
    },
  ];

  const handleDropdownToggle = (name: string) => {
    setOpenDropdown(openDropdown === name ? null : name);
  };

  // Close dropdown when clicking outside
  React.useEffect(() => {
    const handleClickOutside = () => setOpenDropdown(null);
    if (openDropdown) {
      document.addEventListener("click", handleClickOutside);
      return () => document.removeEventListener("click", handleClickOutside);
    }
  }, [openDropdown]);

  if (pathname?.includes("/editor")) {
    return null;
  }

  return (
    <motion.header
      initial={{ y: -20, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      className="fixed top-0 z-50 w-full border-b border-slate-800/50 bg-slate-950/80 backdrop-blur-xl"
    >
      <div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8">
        {/* Logo */}
        <Link href={`/${locale}`} className="block">
          <AtlasLogo />
        </Link>

        {/* Desktop Navigation */}
        <nav
          className="hidden items-center gap-8 lg:flex"
          onClick={(e) => e.stopPropagation()}
        >
          <NavDropdownMenu
            label={d.nav.services}
            items={SERVICES_DROPDOWN}
            isOpen={openDropdown === "services"}
            onToggle={() => handleDropdownToggle("services")}
            locale={locale}
          />
          <NavDropdownMenu
            label={d.nav.categories}
            items={CATEGORIES_DROPDOWN}
            isOpen={openDropdown === "categories"}
            onToggle={() => handleDropdownToggle("categories")}
            locale={locale}
          />
          <NavDropdownMenu
            label={d.nav.styles}
            items={STYLES_DROPDOWN}
            isOpen={openDropdown === "styles"}
            onToggle={() => handleDropdownToggle("styles")}
            locale={locale}
          />
          <Link
            href={`/${locale}/pricing`}
            className="text-sm font-medium text-slate-400 transition-colors hover:text-white"
          >
            {d.nav.pricing}
          </Link>
          <NavDropdownMenu
            label={d.nav.resources}
            items={RESOURCES_DROPDOWN}
            isOpen={openDropdown === "resources"}
            onToggle={() => handleDropdownToggle("resources")}
            locale={locale}
          />
        </nav>

        {/* Right side */}
        <div className="flex items-center gap-4">
          <LanguageSwitcher />

          <AuthButtons dictionary={dictionary} />

          {/* Mobile menu button */}
          <button
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="lg:hidden p-2 text-slate-400 hover:text-white"
          >
            {mobileMenuOpen ? (
              <X className="h-6 w-6" />
            ) : (
              <Menu className="h-6 w-6" />
            )}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      <AnimatePresence>
        {mobileMenuOpen && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            className="lg:hidden border-t border-slate-800 bg-slate-950/95 backdrop-blur-xl"
          >
            <div className="p-4 space-y-4">
              {[
                { label: d.nav.services, items: SERVICES_DROPDOWN },
                { label: d.nav.categories, items: CATEGORIES_DROPDOWN },
                { label: d.nav.styles, items: STYLES_DROPDOWN },
                { label: d.nav.resources, items: RESOURCES_DROPDOWN },
              ].map((section) => (
                <div key={section.label}>
                  <p className="text-xs font-semibold uppercase text-slate-500 mb-2">
                    {section.label}
                  </p>
                  <div className="grid grid-cols-2 gap-2">
                    {section.items.slice(0, 4).map((item) => (
                      <Link
                        key={item.href}
                        href={`/${locale}${item.href}`}
                        className="flex items-center gap-2 p-2 rounded-lg text-sm text-slate-300 hover:bg-slate-800"
                        onClick={() => setMobileMenuOpen(false)}
                      >
                        <item.icon className="h-4 w-4 text-purple-400" />
                        {item.label}
                      </Link>
                    ))}
                  </div>
                </div>
              ))}
              <Link href={`/${locale}/editor`} className="block">
                <Button className="w-full bg-gradient-to-r from-purple-600 to-indigo-600">
                  {d.auth.freeTrial}
                </Button>
              </Link>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </motion.header>
  );
}

function AuthButtons({ dictionary }: { dictionary: Dictionary }) {
  const { data: session, status } = useSession();
  const params = useParams();
  const locale = params.locale as string;

  const d = dictionary.landing.header.auth;

  if (status === 'loading') {
    return <div className="h-9 w-24 bg-slate-800/50 rounded-lg animate-pulse" />;
  }

  if (session) {
    return (
      <div className="flex items-center gap-3">
        <NotificationDropdown />
        <div className="h-6 w-px bg-slate-800" />
        <UserDropdown />
      </div>
    );
  }

  return (
    <div className="flex items-center gap-4">
      <Link
        href={`/${locale}/auth/signin`}
        className="hidden sm:block"
      >
        <Button variant="ghost" className="text-slate-400 hover:text-white hover:bg-slate-800/50">
          {d.signIn}
        </Button>
      </Link>
      <Link href={`/${locale}/auth/signup`} className="hidden sm:block">
        <Button
          size="sm"
          className="bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-500 hover:to-indigo-500 shadow-lg shadow-purple-500/25"
        >
          {dictionary.landing.hero.cta}
        </Button>
      </Link>
    </div>
  );
}
