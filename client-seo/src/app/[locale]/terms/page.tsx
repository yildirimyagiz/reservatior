"use client";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import { useTranslation } from "react-i18next";
import { m } from "framer-motion";
import { ScrollArea } from "@/components/ui/scroll-area";
import { useState, useEffect } from "react";

export default function TermsPage() {
  const { t } = useTranslation();
  const [activeSection, setActiveSection] = useState("acceptance");

  const sections = [
    { id: "acceptance", label: t("terms.nav.acceptance", { defaultValue: "1. Acceptance of Terms" }) },
    { id: "services", label: t("terms.nav.services", { defaultValue: "2. Description of Services" }) },
    { id: "accounts", label: t("terms.nav.accounts", { defaultValue: "3. User Accounts & Security" }) },
    { id: "ai", label: t("terms.nav.ai", { defaultValue: "4. AI Services & Liability" }) },
    { id: "payments", label: t("terms.nav.payments", { defaultValue: "5. Fees & Payments" }) },
    { id: "termination", label: t("terms.nav.termination", { defaultValue: "6. Termination" }) },
    { id: "disputes", label: t("terms.nav.disputes", { defaultValue: "7. Dispute Resolution" }) },
    { id: "changes", label: t("terms.nav.changes", { defaultValue: "8. Changes to Terms" }) }
  ];

  useEffect(() => {
    const handleScroll = () => {
      const sectionElements = sections.map(s => document.getElementById(s.id));
      const currentScroll = window.scrollY;

      for (let i = sectionElements.length - 1; i >= 0; i--) {
        const el = sectionElements[i];
        if (el && currentScroll >= (el.offsetTop - 150)) {
          setActiveSection(sections[i].id);
          break;
        }
      }
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const scrollTo = (id: string) => {
    const el = document.getElementById(id);
    if (el) {
      window.scrollTo({ top: el.offsetTop - 100, behavior: "smooth" });
    }
  };

  return (
    <div className="flex flex-col min-h-screen bg-background text-foreground selection:bg-primary/30">
      <AppHeader />
      <main className="flex-1 w-full pt-32 pb-20">
        
        {/* Header */}
        <section className="px-6 md:px-12 max-w-[1200px] mx-auto mb-16">
          <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="max-w-3xl">
            <h1 className="text-4xl md:text-6xl font-black tracking-tighter mb-6">
              {t("terms.hero.title", { defaultValue: "Terms of Service" })}
            </h1>
            <p className="text-xl text-muted-foreground font-medium">
              {t("terms.hero.subtitle", { defaultValue: "Please read these terms carefully before using Reservatior." })}
            </p>
            <div className="mt-6 flex items-center gap-4 text-sm font-bold text-muted-foreground tracking-widest uppercase">
              <span>{t("terms.hero.last_updated", { defaultValue: "Last Updated" })}: {t("terms.hero.date", { defaultValue: "August 2026" })}</span>
            </div>
          </m.div>
        </section>

        {/* Content */}
        <section className="px-6 md:px-12 max-w-[1200px] mx-auto grid grid-cols-1 md:grid-cols-12 gap-12">
          
          {/* Navigation Sidebar */}
          <div className="md:col-span-4 lg:col-span-3 hidden md:block">
            <div className="sticky top-32">
              <h3 className="font-bold tracking-widest uppercase text-xs text-muted-foreground mb-6">
                {t("terms.nav.title", { defaultValue: "Contents" })}
              </h3>
              <nav className="flex flex-col gap-2 border-l border-border pl-4">
                {sections.map(s => (
                  <button
                    key={s.id}
                    onClick={() => scrollTo(s.id)}
                    className={`text-left text-sm font-semibold transition-colors ${
                      activeSection === s.id ? "text-foreground" : "text-muted-foreground hover:text-foreground"
                    }`}
                  >
                    {s.label}
                  </button>
                ))}
              </nav>
            </div>
          </div>

          {/* Terms Content */}
          <div className="md:col-span-8 lg:col-span-9 prose prose-gray dark:prose-invert max-w-none prose-headings:font-black prose-headings:tracking-tight">
            <div id="acceptance" className="scroll-mt-32 mb-16">
              <h2>{t("terms.nav.acceptance", { defaultValue: "1. Acceptance of Terms" })}</h2>
              <p>{t("terms.content.acceptance_1", { defaultValue: "By accessing or using the Reservatior platform, applications, and APIs (collectively, the 'Services'), you agree to be bound by these Terms of Service. If you disagree with any part of the terms, you may not access the Service." })}</p>
              <p>{t("terms.content.acceptance_2", { defaultValue: "These Terms apply to all visitors, users, property managers, property owners, and others who access or use the Service." })}</p>
            </div>

            <div id="services" className="scroll-mt-32 mb-16">
              <h2>{t("terms.nav.services", { defaultValue: "2. Description of Services" })}</h2>
              <p>{t("terms.content.services_1", { defaultValue: "Reservatior provides a comprehensive hybrid rental operating system, AI-driven property management tools, smart pricing engines, and compliance management solutions." })}</p>
              <p>{t("terms.content.services_2", { defaultValue: "We reserve the right to modify, suspend, or discontinue, temporarily or permanently, the Service or any part of it with or without notice." })}</p>
            </div>

            <div id="accounts" className="scroll-mt-32 mb-16">
              <h2>{t("terms.nav.accounts", { defaultValue: "3. User Accounts & Security" })}</h2>
              <p>{t("terms.content.accounts_1", { defaultValue: "When you create an account with us, you must provide information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms." })}</p>
              <p>{t("terms.content.accounts_2", { defaultValue: "You are responsible for safeguarding the password and for any activities or actions under your password. You agree not to disclose your password to any third party." })}</p>
            </div>

            <div id="ai" className="scroll-mt-32 mb-16">
              <h2>{t("terms.nav.ai", { defaultValue: "4. AI Services & Liability" })}</h2>
              <p>{t("terms.content.ai_1", { defaultValue: "Reservatior utilizes advanced neural agents and AI for pricing, compliance, and guest communication. While our AI systems strive for high accuracy, they are provided on an 'AS IS' basis." })}</p>
              <p>{t("terms.content.ai_2", { defaultValue: "You acknowledge that AI-generated recommendations (such as dynamic pricing or compliance suggestions) should be reviewed by human operators where appropriate. Reservatior is not liable for revenue loss or compliance penalties resulting from automated AI actions." })}</p>
            </div>

            <div id="payments" className="scroll-mt-32 mb-16">
              <h2>{t("terms.nav.payments", { defaultValue: "5. Fees & Payments" })}</h2>
              <p>{t("terms.content.payments_1", { defaultValue: "Certain aspects of the Service may be provided for a fee or other charge. If you elect to use paid aspects of the Service, you agree to our pricing and payment terms." })}</p>
              <p>{t("terms.content.payments_2", { defaultValue: "All fees are exclusive of all taxes, levies, or duties imposed by taxing authorities, and you shall be responsible for payment of all such taxes." })}</p>
            </div>

            <div id="termination" className="scroll-mt-32 mb-16">
              <h2>{t("terms.nav.termination", { defaultValue: "6. Termination" })}</h2>
              <p>{t("terms.content.termination_1", { defaultValue: "We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms." })}</p>
              <p>{t("terms.content.termination_2", { defaultValue: "Upon termination, your right to use the Service will immediately cease. If you wish to terminate your account, you may simply discontinue using the Service." })}</p>
            </div>

            <div id="disputes" className="scroll-mt-32 mb-16">
              <h2>{t("terms.nav.disputes", { defaultValue: "7. Dispute Resolution" })}</h2>
              <p>{t("terms.content.disputes_1", { defaultValue: "Any dispute arising from or relating to these Terms of Service shall be resolved through binding arbitration, rather than in court." })}</p>
              <p>{t("terms.content.disputes_2", { defaultValue: "These Terms shall be governed and construed in accordance with international commercial law, without regard to its conflict of law provisions." })}</p>
            </div>

            <div id="changes" className="scroll-mt-32 mb-16">
              <h2>{t("terms.nav.changes", { defaultValue: "8. Changes to Terms" })}</h2>
              <p>{t("terms.content.changes_1", { defaultValue: "We reserve the right, at our sole discretion, to modify or replace these Terms at any time. We will provide at least 30 days' notice prior to any new terms taking effect." })}</p>
              <p>{t("terms.content.changes_2", { defaultValue: "By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms." })}</p>
            </div>
          </div>
        </section>

      </main>
      <Footer />
    </div>
  );
}
