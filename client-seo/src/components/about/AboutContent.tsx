"use client"

import { useTranslation } from "react-i18next"
import Image from "next/image"
import Link from "next/link"

export default function AboutContent() {
  const { t } = useTranslation()

  return (
    <div className="min-h-screen bg-white dark:bg-slate-950">
      {/* Hero Section */}
      <section className="relative overflow-hidden">
        <div className="absolute inset-0">
          <Image
            src="/images/seattle-hero.jpg"
            alt="Seattle Skyline"
            fill
            className="object-cover"
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-b from-slate-950/80 via-slate-950/60 to-slate-950/90" />
        </div>
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 md:py-32">
          <div className="text-center max-w-4xl mx-auto">
            <h1 className="text-4xl md:text-6xl font-bold tracking-tight text-white mb-6">
              {t("about.hero.title", { defaultValue: "About Us" })}
            </h1>
            <p className="text-xl md:text-2xl text-blue-300 font-semibold mb-8">
              {t("about.hero.subtitle", { defaultValue: "Our Story & Mission" })}
            </p>
            <div className="max-w-3xl mx-auto text-left">
              <p className="text-slate-200 leading-relaxed">
                {t("about.hero.paragraph1", {
                  defaultValue: "Reservatior was founded to redefine modern hospitality and property management through high-performance, enterprise-grade technology. Focusing on the high-density, multi-tenant property landscape of Seattle, we optimize regional real-time data structures and streamline complex transactional workflows."
                })}
              </p>
              <p className="text-slate-200 leading-relaxed mt-6">
                {t("about.hero.paragraph2", {
                  defaultValue: "By integrating Amazon API-driven furniture staging infrastructure with a low-latency SaaS engine, Reservatior bridges the gap between complex infrastructure engineering and seamless, localized operations. Our mission is to empower property managers to maximize yield, automate deployment, and scale multi-tenant portfolios with mathematical precision."
                })}
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Leadership Section */}
      <section className="py-20 bg-slate-50 dark:bg-slate-900">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl md:text-4xl font-bold text-center text-slate-900 dark:text-white mb-16">
            {t("about.leadership.title", { defaultValue: "Our Leadership" })}
          </h2>

          <div className="grid md:grid-cols-2 gap-12 max-w-5xl mx-auto">
            {/* Yağız Yıldırım */}
            <div className="bg-white dark:bg-slate-800 rounded-2xl p-8 shadow-lg border border-slate-200 dark:border-slate-700">
              <div className="flex items-center gap-4 mb-6">
                <Image
                  src="/founder.jpg"
                  alt="Yağız Yıldırım"
                  width={64}
                  height={64}
                  className="w-16 h-16 rounded-full object-cover border-2 border-blue-200 dark:border-blue-800"
                />
                <div>
                  <h3 className="text-xl font-bold text-slate-900 dark:text-white">
                    {t("about.leadership.yagiz.name", { defaultValue: "Yağız Yıldırım" })}
                  </h3>
                  <p className="text-blue-600 dark:text-blue-400 font-medium">
                    {t("about.leadership.yagiz.role", { defaultValue: "Founder & Lead AI Systems Architect" })}
                  </p>
                </div>
              </div>
              <p className="text-slate-600 dark:text-slate-300 leading-relaxed">
                {t("about.leadership.yagiz.bio", {
                  defaultValue: "Yağız is a Senior Software Architect and Systems Engineer specialized in building high-performance GenAI infrastructure, native data retrieval pipelines, and scalable distributed systems from scratch. Having architected and launched over 150 production systems spanning high-throughput web topologies and financial transactional pipelines, he serves as the core system architect behind Reservatior. At Reservatior, Yağız engineered the enterprise-grade workflow engine from the ground up, utilizing custom task-queue schedulers and close-to-metal kernels to maintain sub-millisecond invocation overhead under heavy multi-tenant scale."
                })}
              </p>
              <div className="mt-4">
                <Link
                  href="https://www.linkedin.com/in/yldyagz/"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-2 text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300 font-medium transition-colors"
                >
                  <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z" />
                  </svg>
                  {t("about.linkedin", { defaultValue: "LinkedIn" })}
                </Link>
              </div>
            </div>

            {/* Lance Cenk Ayar */}
            <div className="bg-white dark:bg-slate-800 rounded-2xl p-8 shadow-lg border border-slate-200 dark:border-slate-700">
              <div className="flex items-center gap-4 mb-6">
                <div className="w-16 h-16 rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center text-white text-2xl font-bold">
                  LA
                </div>
                <div>
                  <h3 className="text-xl font-bold text-slate-900 dark:text-white">
                    {t("about.leadership.lance.name", { defaultValue: "Lance Cenk Ayar" })}
                  </h3>
                  <p className="text-blue-600 dark:text-blue-400 font-medium">
                    {t("about.leadership.lance.role", { defaultValue: "Co-Founder & Head of Real Estate Operations" })}
                  </p>
                </div>
              </div>
              <p className="text-slate-600 dark:text-slate-300 leading-relaxed">
                {t("about.leadership.lance.bio", {
                  defaultValue: "Lance leads the localized execution, property acquisition, and portfolio management strategies for Reservatior directly on the ground in Seattle. Bringing over 5 years of deep real estate and field operations experience within the Keller Williams network, he bridges the gap between advanced technology and real-world property dynamics. Lance ensures smooth regional compliance, optimal property staging, and strong local industry partnerships across the Seattle metropolitan area."
                })}
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Why Reservatior Section */}
      <section className="py-20 bg-white dark:bg-slate-950">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl md:text-4xl font-bold text-center text-slate-900 dark:text-white mb-16">
            {t("about.why.title", { defaultValue: "Why Reservatior?" })}
          </h2>

          <div className="grid md:grid-cols-2 gap-8 max-w-5xl mx-auto">
            <div className="bg-slate-50 dark:bg-slate-800/50 rounded-xl p-8 border border-slate-200 dark:border-slate-700">
              <div className="w-12 h-12 rounded-lg bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center mb-4">
                <svg className="w-6 h-6 text-blue-600 dark:text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
                </svg>
              </div>
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-3">
                {t("about.why.engineered.title", { defaultValue: "Engineered for Scale" })}
              </h3>
              <p className="text-slate-600 dark:text-slate-300 leading-relaxed">
                {t("about.why.engineered.desc", {
                  defaultValue: "Built on proprietary processing kernels that eliminate sluggish runtime dependencies, guaranteeing zero overhead during intensive system loads."
                })}
              </p>
            </div>

            <div className="bg-slate-50 dark:bg-slate-800/50 rounded-xl p-8 border border-slate-200 dark:border-slate-700">
              <div className="w-12 h-12 rounded-lg bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center mb-4">
                <svg className="w-6 h-6 text-purple-600 dark:text-purple-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                </svg>
              </div>
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-3">
                {t("about.why.amazon.title", { defaultValue: "Seamless Amazon API Integration" })}
              </h3>
              <p className="text-slate-600 dark:text-slate-300 leading-relaxed">
                {t("about.why.amazon.desc", {
                  defaultValue: "Automated staging solutions that dynamically sync property layouts with scalable furniture deployment infrastructure."
                })}
              </p>
            </div>

            <div className="bg-slate-50 dark:bg-slate-800/50 rounded-xl p-8 border border-slate-200 dark:border-slate-700">
              <div className="w-12 h-12 rounded-lg bg-emerald-100 dark:bg-emerald-900/30 flex items-center justify-center mb-4">
                <svg className="w-6 h-6 text-emerald-600 dark:text-emerald-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
              </div>
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-3">
                {t("about.why.seattle.title", { defaultValue: "Local Seattle Expertise" })}
              </h3>
              <p className="text-slate-600 dark:text-slate-300 leading-relaxed">
                {t("about.why.seattle.desc", {
                  defaultValue: "Backed by proven real estate professionals with extensive on-the-ground knowledge of the Pacific Northwest property market."
                })}
              </p>
            </div>

            <div className="bg-slate-50 dark:bg-slate-800/50 rounded-xl p-8 border border-slate-200 dark:border-slate-700">
              <div className="w-12 h-12 rounded-lg bg-amber-100 dark:bg-amber-900/30 flex items-center justify-center mb-4">
                <svg className="w-6 h-6 text-amber-600 dark:text-amber-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                </svg>
              </div>
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-3">
                {t("about.why.data.title", { defaultValue: "Data Retrieval Precision" })}
              </h3>
              <p className="text-slate-600 dark:text-slate-300 leading-relaxed">
                {t("about.why.data.desc", {
                  defaultValue: "Optimized multi-tenant data structures built to handle rapid, complex regional database queries seamlessly."
                })}
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  )
}
