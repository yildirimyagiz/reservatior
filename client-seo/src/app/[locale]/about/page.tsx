"use client";

import { useTranslation } from "react-i18next";
import Image from "next/image";
import { ShieldCheck, Zap, Globe, Database, Code, Building2 } from "lucide-react";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";

export default function AboutPage() {
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 to-white dark:from-slate-950 dark:to-slate-900">
      <AppHeader />
      {/* Hero Section */}
      <section className="relative py-20 px-4">
        <div className="max-w-6xl mx-auto text-center">
          <h1 className="text-5xl md:text-7xl font-black text-slate-900 dark:text-white mb-6">
            {t('about.title', { defaultValue: 'About Us' })}
          </h1>
          <p className="text-xl md:text-2xl text-slate-600 dark:text-slate-400 max-w-3xl mx-auto">
            {t('about.subtitle', { defaultValue: 'Our Story & Mission' })}
          </p>
        </div>
      </section>

      {/* Mission Section */}
      <section className="py-16 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="bg-white dark:bg-slate-900 rounded-3xl p-8 md:p-12 shadow-2xl border border-slate-200 dark:border-slate-800">
            <div className="grid md:grid-cols-2 gap-8 items-center">
              <div>
                <Image
                  src="/about-us.png"
                  alt="About Us"
                  width={600}
                  height={400}
                  className="rounded-2xl shadow-lg"
                />
              </div>
              <div className="space-y-6">
                <p className="text-lg text-slate-700 dark:text-slate-300 leading-relaxed">
                  {t('about.mission.p1', { 
                    defaultValue: 'Reservatior was founded to redefine modern hospitality and property management through high-performance, enterprise-grade technology. Focusing on the high-density, multi-tenant property landscape of Seattle, we optimize regional real-time data structures and streamline complex transactional workflows.' 
                  })}
                </p>
                <p className="text-lg text-slate-700 dark:text-slate-300 leading-relaxed">
                  {t('about.mission.p2', { 
                    defaultValue: 'By integrating Amazon API-driven furniture staging infrastructure with a low-latency SaaS engine, Reservatior bridges the gap between complex infrastructure engineering and seamless, localized operations. Our mission is to empower property managers to maximize yield, automate deployment, and scale multi-tenant portfolios with mathematical precision.' 
                  })}
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Leadership Section */}
      <section className="py-16 px-4">
        <div className="max-w-6xl mx-auto">
          <h2 className="text-4xl md:text-5xl font-black text-slate-900 dark:text-white text-center mb-12">
            {t('about.leadership.title', { defaultValue: 'Our Leadership' })}
          </h2>
          
          <div className="grid md:grid-cols-2 gap-8">
            {/* Yağız Yıldırım */}
            <div className="bg-white dark:bg-slate-900 rounded-2xl p-8 shadow-xl border border-slate-200 dark:border-slate-800">
              <div className="flex flex-col md:flex-row gap-6">
                <div className="flex-shrink-0">
                  <Image
                    src="/founder.jpg"
                    alt="Yağız Yıldırım"
                    width={200}
                    height={200}
                    className="rounded-xl shadow-lg object-cover"
                  />
                </div>
                <div className="flex-1">
                  <h3 className="text-2xl font-bold text-slate-900 dark:text-white mb-2">
                    Yağız Yıldırım
                  </h3>
                  <p className="text-lg font-semibold text-blue-600 dark:text-blue-400 mb-4">
                    {t('about.leadership.yagiz.role', { defaultValue: 'Founder & Lead AI Systems Architect' })}
                  </p>
                  <p className="text-slate-700 dark:text-slate-300 leading-relaxed">
                    {t('about.leadership.yagiz.bio', { 
                      defaultValue: 'Yağız is a Senior Software Architect and Systems Engineer specialized in building high-performance GenAI infrastructure, native data retrieval pipelines, and scalable distributed systems from scratch. Having architected and launched over 150 production systems spanning high-throughput web topologies and financial transactional pipelines, he serves as the core system architect behind Reservatior. At Reservatior, Yağız engineered the enterprise-grade workflow engine from the ground up, utilizing custom task-queue schedulers and close-to-metal kernels to maintain sub-millisecond invocation overhead under heavy multi-tenant scale.' 
                    })}
                  </p>
                </div>
              </div>
            </div>

            {/* Lance Cenk Ayar */}
            <div className="bg-white dark:bg-slate-900 rounded-2xl p-8 shadow-xl border border-slate-200 dark:border-slate-800">
              <div className="flex flex-col md:flex-row gap-6">
                <div className="flex-shrink-0">
                  <div className="w-[200px] h-[200px] rounded-xl bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center shadow-lg">
                    <Building2 className="w-24 h-24 text-white" />
                  </div>
                </div>
                <div className="flex-1">
                  <h3 className="text-2xl font-bold text-slate-900 dark:text-white mb-2">
                    Lance Cenk Ayar
                  </h3>
                  <p className="text-lg font-semibold text-blue-600 dark:text-blue-400 mb-4">
                    {t('about.leadership.lance.role', { defaultValue: 'Co-Founder & Head of Real Estate Operations' })}
                  </p>
                  <p className="text-slate-700 dark:text-slate-300 leading-relaxed">
                    {t('about.leadership.lance.bio', { 
                      defaultValue: 'Lance leads the localized execution, property acquisition, and portfolio management strategies for Reservatior directly on the ground in Seattle. Bringing over 5 years of deep real estate and field operations experience within the Keller Williams network, he bridges the gap between advanced technology and real-world property dynamics. Lance ensures smooth regional compliance, optimal property staging, and strong local industry partnerships across the Seattle metropolitan area.' 
                    })}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Why Reservatior Section */}
      <section className="py-16 px-4">
        <div className="max-w-6xl mx-auto">
          <h2 className="text-4xl md:text-5xl font-black text-slate-900 dark:text-white text-center mb-12">
            {t('about.why.title', { defaultValue: 'Why Reservatior?' })}
          </h2>
          
          <div className="grid md:grid-cols-2 gap-6">
            <div className="bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-950 dark:to-blue-900 rounded-2xl p-8 border border-blue-200 dark:border-blue-800">
              <div className="flex items-start gap-4">
                <div className="flex-shrink-0">
                  <Zap className="w-8 h-8 text-blue-600 dark:text-blue-400" />
                </div>
                <div>
                  <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-2">
                    {t('about.why.scale.title', { defaultValue: 'Engineered for Scale' })}
                  </h3>
                  <p className="text-slate-700 dark:text-slate-300">
                    {t('about.why.scale.desc', { 
                      defaultValue: 'Built on proprietary processing kernels that eliminate sluggish runtime dependencies, guaranteeing zero overhead during intensive system loads.' 
                    })}
                  </p>
                </div>
              </div>
            </div>

            <div className="bg-gradient-to-br from-purple-50 to-purple-100 dark:from-purple-950 dark:to-purple-900 rounded-2xl p-8 border border-purple-200 dark:border-purple-800">
              <div className="flex items-start gap-4">
                <div className="flex-shrink-0">
                  <Code className="w-8 h-8 text-purple-600 dark:text-purple-400" />
                </div>
                <div>
                  <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-2">
                    {t('about.why.api.title', { defaultValue: 'Seamless Amazon API Integration' })}
                  </h3>
                  <p className="text-slate-700 dark:text-slate-300">
                    {t('about.why.api.desc', { 
                      defaultValue: 'Automated staging solutions that dynamically sync property layouts with scalable furniture deployment infrastructure.' 
                    })}
                  </p>
                </div>
              </div>
            </div>

            <div className="bg-gradient-to-br from-green-50 to-green-100 dark:from-green-950 dark:to-green-900 rounded-2xl p-8 border border-green-200 dark:border-green-800">
              <div className="flex items-start gap-4">
                <div className="flex-shrink-0">
                  <Globe className="w-8 h-8 text-green-600 dark:text-green-400" />
                </div>
                <div>
                  <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-2">
                    {t('about.why.seattle.title', { defaultValue: 'Local Seattle Expertise' })}
                  </h3>
                  <p className="text-slate-700 dark:text-slate-300">
                    {t('about.why.seattle.desc', { 
                      defaultValue: 'Backed by proven real estate professionals with extensive on-the-ground knowledge of the Pacific Northwest property market.' 
                    })}
                  </p>
                </div>
              </div>
            </div>

            <div className="bg-gradient-to-br from-orange-50 to-orange-100 dark:from-orange-950 dark:to-orange-900 rounded-2xl p-8 border border-orange-200 dark:border-orange-800">
              <div className="flex items-start gap-4">
                <div className="flex-shrink-0">
                  <Database className="w-8 h-8 text-orange-600 dark:text-orange-400" />
                </div>
                <div>
                  <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-2">
                    {t('about.why.data.title', { defaultValue: 'Data Retrieval Precision' })}
                  </h3>
                  <p className="text-slate-700 dark:text-slate-300">
                    {t('about.why.data.desc', { 
                      defaultValue: 'Optimized multi-tenant data structures built to handle rapid, complex regional database queries seamlessly.' 
                    })}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <Footer />
    </div>
  );
}
