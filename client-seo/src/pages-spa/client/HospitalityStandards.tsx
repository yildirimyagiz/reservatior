"use client";

import { Shield, ShieldCheck, Clock, DollarSign, Users, Building2, Scale, AlertTriangle, CheckCircle, Sparkles, Star, Lock, Eye, BadgeCheck, ArrowRight, Hotel, Key, UserCheck, Gavel, Ban } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Header } from "@/components/home/Header";
import { CTA } from "@/components/home/CTA";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { motion } from "framer-motion";
import { SEOMetadata } from "@/components/seo/SEOMetadata";

const fadeUp = {
  hidden: { opacity: 0, y: 30 },
  visible: (i: number) => ({
    opacity: 1,
    y: 0,
    transition: { delay: i * 0.08, duration: 0.5, ease: "easeOut" as const }
  })
};

const PILLARS = [
  {
    icon: <Clock className="w-7 h-7 text-amber-400" />,
    title: "Minimum Stay Policy",
    subtitle: "Quality Through Duration",
    description: "Enforcing a minimum 3-night stay eliminates single-night party bookings and attracts business travelers, families, and premium tourists who respect the residence.",
    features: [
      "Minimum 3-night stay enforced across all units",
      "Weekly & monthly rates for extended guests",
      "Peak-season premium pricing tiers",
      "Dynamic pricing aligned with 5-star benchmarks"
    ],
    gradient: "from-amber-500/10 to-orange-500/5",
    glowColor: "bg-amber-500/10"
  },
  {
    icon: <UserCheck className="w-7 h-7 text-blue-400" />,
    title: "White-Glove Operators",
    subtitle: "Licensed Property Managers Only",
    description: "Every short-term rental must be managed through a certified, Reservatior-approved property management company. No owner-managed ad hoc rentals are permitted.",
    features: [
      "Background screening for every guest",
      "Professional check-in & check-out protocols",
      "House rules briefing upon arrival",
      "24/7 on-call guest support & incident response"
    ],
    gradient: "from-blue-500/10 to-cyan-500/5",
    glowColor: "bg-blue-500/10"
  },
  {
    icon: <Building2 className="w-7 h-7 text-emerald-400" />,
    title: "Residence Segmentation",
    subtitle: "Separate Flows, Shared Prestige",
    description: "Purpose-built guest reception zones and smart elevator access ensure short-term guests never disrupt the daily life of permanent residents.",
    features: [
      "Dedicated guest reception & concierge desk",
      "Smart elevator card restricts floor access",
      "Separate luggage handling & parking zones",
      "Guest wristband system for pool & gym access"
    ],
    gradient: "from-emerald-500/10 to-green-500/5",
    glowColor: "bg-emerald-500/10"
  },
  {
    icon: <Gavel className="w-7 h-7 text-rose-400" />,
    title: "Zero-Tolerance Enforcement",
    subtitle: "Rules Without Exceptions",
    description: "Strict penalty frameworks deter rule violations. Fines are levied on owners and operators, not guests — creating an accountability chain that prioritizes quality over yield.",
    features: [
      "Noise violations: escalating fines per incident",
      "Unauthorized occupants trigger instant lockout",
      "3-strike policy revokes short-term rental license",
      "Security deposit forfeiture for property damage"
    ],
    gradient: "from-rose-500/10 to-pink-500/5",
    glowColor: "bg-rose-500/10"
  }
];

const TRUST_METRICS = [
  { value: "100%", label: "Guest Screening Rate", color: "text-emerald-400" },
  { value: "3+", label: "Minimum Night Stay", color: "text-amber-400" },
  { value: "24/7", label: "On-Site Concierge", color: "text-blue-400" },
  { value: "₺0", label: "Tolerance for Violations", color: "text-rose-400" }
];

const COMPARISON = [
  { feature: "Guest Background Check", traditional: false, reservatior: true },
  { feature: "Minimum Stay Enforcement", traditional: false, reservatior: true },
  { feature: "Licensed Operator Requirement", traditional: false, reservatior: true },
  { feature: "Separate Guest Entry Point", traditional: false, reservatior: true },
  { feature: "Smart Elevator Floor Restriction", traditional: false, reservatior: true },
  { feature: "Noise & Incident Penalty System", traditional: false, reservatior: true },
  { feature: "Real-Time Occupancy Monitoring", traditional: false, reservatior: true },
  { feature: "Owner Revenue Transparency", traditional: false, reservatior: true }
];

const GUEST_JOURNEY = [
  { step: "01", title: "Booking Request", desc: "Guest submits request through Reservatior. Minimum stay and pricing policies are auto-enforced.", icon: <Hotel className="w-5 h-5" /> },
  { step: "02", title: "Identity Screening", desc: "Government-issued ID verification + background check via our AI-powered compliance engine.", icon: <Eye className="w-5 h-5" /> },
  { step: "03", title: "Operator Assignment", desc: "A licensed property manager is assigned. They prepare the unit and coordinate logistics.", icon: <Key className="w-5 h-5" /> },
  { step: "04", title: "Guided Check-In", desc: "Professional in-person check-in. House rules & code of conduct are signed digitally.", icon: <BadgeCheck className="w-5 h-5" /> },
  { step: "05", title: "Monitored Stay", desc: "Smart sensors monitor noise levels. Concierge is available 24/7 for guests and residents.", icon: <Shield className="w-5 h-5" /> },
  { step: "06", title: "Verified Check-Out", desc: "Unit inspection, damage assessment, and security deposit release. Rating left by both parties.", icon: <Star className="w-5 h-5" /> }
];

export default function HospitalityStandards() {
  return (
    <div className="min-h-screen bg-[#fafafa] dark:bg-[#0a0a0c] selection:bg-black selection:text-white dark:selection:bg-white dark:selection:text-black">
      <SEOMetadata
        data={{
          title: "Hospitality Standards | Reservatior",
          description: "Our high-end hospitality framework ensures short-term rentals enhance — not diminish — residence prestige.",
          type: 'ORGANIZATION',
          url: window.location.href
        }}
      />
      <Header />

      <main className="max-w-[1400px] mx-auto px-8 lg:px-12 py-24 space-y-32">

        {/* ─── HERO ─────────────────────────────────────────────────────── */}
        <div className="text-center relative">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[600px] bg-indigo-500/8 blur-[160px] pointer-events-none rounded-full" />

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6 }}>
            <Badge className="mb-6 bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-5 py-1.5 text-xs font-bold tracking-wider rounded-full">
              <Sparkles className="w-3 h-3 mr-2" /> HIGH-END HOSPITALITY FRAMEWORK
            </Badge>
            <h1 className="text-5xl md:text-8xl font-black tracking-tight text-neutral-900 dark:text-white mb-8 leading-[0.9]">
              Luxury Living <br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-purple-500 dark:from-indigo-400 dark:to-purple-400">
                Meets Smart Hosting
              </span>
            </h1>
            <p className="text-lg md:text-xl text-neutral-500 dark:text-slate-400 max-w-3xl mx-auto font-medium leading-relaxed">
              Short-term rentals don&apos;t have to compromise building prestige.
              Our framework transforms every unit into a 5-star experience —
              maximizing owner revenue while protecting resident serenity.
            </p>
          </motion.div>
        </div>

        {/* ─── TRUST METRICS BAR ────────────────────────────────────────── */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="grid grid-cols-2 md:grid-cols-4 gap-6"
        >
          {TRUST_METRICS.map((m, i) => (
            <div key={i} className="bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-2xl p-8 text-center group hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all">
              <h3 className={`text-4xl md:text-5xl font-black tracking-tight mb-2 ${m.color} group-hover:scale-110 transition-transform`}>
                {m.value}
              </h3>
              <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">{m.label}</p>
            </div>
          ))}
        </motion.div>

        {/* ─── FOUR PILLARS ─────────────────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              THE FOUR PILLARS
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Quality Architecture
            </h2>
            <p className="text-neutral-500 dark:text-slate-400 max-w-2xl mx-auto font-medium">
              Every short-term rental on Reservatior must pass through four operational layers designed to preserve and elevate building prestige.
            </p>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {PILLARS.map((pillar, idx) => (
              <motion.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <Card className={`bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-[2rem] overflow-hidden shadow-xl group h-full hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all duration-500`}>
                  <CardHeader className="p-8 pb-4">
                    <div className="flex items-start justify-between mb-6">
                      <div className="p-4 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                        {pillar.icon}
                      </div>
                      <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 text-xs font-bold tracking-wider rounded-full px-3 py-1">
                        0{idx + 1}
                      </Badge>
                    </div>
                    <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase mb-1">{pillar.subtitle}</p>
                    <CardTitle className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight">{pillar.title}</CardTitle>
                  </CardHeader>
                  <CardContent className="p-8 pt-2 space-y-6">
                    <p className="text-sm font-medium text-neutral-600 dark:text-slate-400 leading-relaxed">{pillar.description}</p>
                    <ul className="space-y-3 pt-4 border-t border-neutral-200 dark:border-slate-800">
                      {pillar.features.map((f, i) => (
                        <li key={i} className="flex items-start gap-3 text-sm font-semibold text-neutral-700 dark:text-slate-300 transition-colors">
                          <CheckCircle className="w-4 h-4 text-emerald-500 shrink-0 mt-0.5 shadow-[0_0_8px_#10b981]" />
                          {f}
                        </li>
                      ))}
                    </ul>
                  </CardContent>
                </Card>
              </motion.div>
            ))}
          </div>
        </section>

        {/* ─── GUEST JOURNEY TIMELINE ──────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              GUEST LIFECYCLE
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Every Stay, Fully Managed
            </h2>
            <p className="text-neutral-500 dark:text-slate-400 max-w-2xl mx-auto font-medium">
              From the moment a guest requests a booking until they check out — every touchpoint is orchestrated for safety and excellence.
            </p>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {GUEST_JOURNEY.map((step, idx) => (
              <motion.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
                className="relative"
              >
                <div className="bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-2xl p-8 h-full hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all group">
                  <div className="flex items-center gap-4 mb-6">
                    <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center text-white shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                      {step.icon}
                    </div>
                    <span className="text-3xl font-black text-neutral-200 dark:text-slate-700 tracking-tight">{step.step}</span>
                  </div>
                  <h3 className="text-lg font-black text-neutral-900 dark:text-white tracking-tight mb-3">{step.title}</h3>
                  <p className="text-sm font-medium text-neutral-500 dark:text-slate-400 leading-relaxed">{step.desc}</p>
                </div>
              </motion.div>
            ))}
          </div>
        </section>

        {/* ─── COMPARISON TABLE ─────────────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              COMPARISON
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Traditional vs. Reservatior
            </h2>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-[2rem] overflow-hidden"
          >
            <div className="grid grid-cols-[1fr_120px_120px] md:grid-cols-[1fr_160px_160px] items-center px-8 py-5 bg-neutral-50 dark:bg-white/[0.02]">
              <span className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">Feature</span>
              <span className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase text-center">Traditional</span>
              <span className="text-xs font-bold text-indigo-600 dark:text-indigo-400 tracking-widest uppercase text-center">Reservatior</span>
            </div>
            {COMPARISON.map((row, idx) => (
              <div key={idx} className={`grid grid-cols-[1fr_120px_120px] md:grid-cols-[1fr_160px_160px] items-center px-8 py-5 ${idx % 2 === 0 ? "bg-neutral-50/50 dark:bg-white/[0.01]" : ""} border-t border-neutral-200 dark:border-slate-800 hover:bg-neutral-50 dark:hover:bg-white/[0.03] transition-colors`}>
                <span className="text-sm font-semibold text-neutral-700 dark:text-slate-300 tracking-wide">{row.feature}</span>
                <div className="flex justify-center">
                  {row.traditional ? (
                    <CheckCircle className="w-5 h-5 text-emerald-500" />
                  ) : (
                    <Ban className="w-5 h-5 text-red-500/40" />
                  )}
                </div>
                <div className="flex justify-center">
                  <CheckCircle className="w-5 h-5 text-emerald-500 shadow-[0_0_10px_#10b981]" />
                </div>
              </div>
            ))}
          </motion.div>
        </section>

        {/* ─── WIN-WIN BANNER ───────────────────────────────────────────── */}
        <motion.section
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="relative overflow-hidden"
        >
          <div className="bg-gradient-to-br from-indigo-500/5 via-white/50 dark:via-[#14151a]/50 to-purple-500/5 rounded-[2rem] md:rounded-[3rem] p-10 md:p-16 border border-white/60 dark:border-slate-800/60 relative">
            <div className="absolute top-0 right-0 w-[400px] h-[400px] bg-indigo-500/5 dark:bg-indigo-600/5 blur-[120px] rounded-full pointer-events-none" />
            <div className="absolute bottom-0 left-0 w-[300px] h-[300px] bg-purple-500/5 dark:bg-purple-600/5 blur-[100px] rounded-full pointer-events-none" />

            <div className="relative z-10 grid lg:grid-cols-2 gap-12 items-center">
              <div className="space-y-8">
                <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
                  THE WIN-WIN FORMULA
                </Badge>
                <h2 className="text-4xl md:text-5xl font-black tracking-tight text-neutral-900 dark:text-white leading-[0.95]">
                  Elevate the Standard, <br />
                  <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-purple-500 dark:from-indigo-400 dark:to-purple-400">
                    Elevate the Returns
                  </span>
                </h2>
                <p className="text-neutral-500 dark:text-slate-400 text-sm font-medium leading-relaxed max-w-lg">
                  When quality is non-negotiable, the entire ecosystem benefits. Property values rise, brand equity strengthens, and premium guests choose your building first. This isn&apos;t restriction — it&apos;s elevation.
                </p>
              </div>

              <div className="grid grid-cols-2 gap-6">
                <div className="bg-white/50 dark:bg-[#14151a]/50 p-6 rounded-2xl border border-white/60 dark:border-slate-800/60 text-center group hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all">
                  <DollarSign className="w-8 h-8 text-indigo-500 mx-auto mb-4 group-hover:scale-110 transition-transform" />
                  <h4 className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight mb-1">+40%</h4>
                  <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">Revenue vs. Long-Term</p>
                </div>
                <div className="bg-white/50 dark:bg-[#14151a]/50 p-6 rounded-2xl border border-white/60 dark:border-slate-800/60 text-center group hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all">
                  <Star className="w-8 h-8 text-emerald-500 mx-auto mb-4 group-hover:scale-110 transition-transform" />
                  <h4 className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight mb-1">4.9★</h4>
                  <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">Avg Guest Rating</p>
                </div>
                <div className="bg-white/50 dark:bg-[#14151a]/50 p-6 rounded-2xl border border-white/60 dark:border-slate-800/60 text-center group hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all">
                  <Shield className="w-8 h-8 text-indigo-500 mx-auto mb-4 group-hover:scale-110 transition-transform" />
                  <h4 className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight mb-1">0</h4>
                  <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">Security Incidents</p>
                </div>
                <div className="bg-white/50 dark:bg-[#14151a]/50 p-6 rounded-2xl border border-white/60 dark:border-slate-800/60 text-center group hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all">
                  <Users className="w-8 h-8 text-purple-500 mx-auto mb-4 group-hover:scale-110 transition-transform" />
                  <h4 className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight mb-1">98%</h4>
                  <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">Resident Satisfaction</p>
                </div>
              </div>
            </div>
          </div>
        </motion.section>

        {/* ─── FOR OWNERS CTA ──────────────────────────────────────────── */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center space-y-8"
        >
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center mx-auto shadow-lg shadow-indigo-500/20">
            <Lock className="w-8 h-8 text-white" />
          </div>
          <h2 className="text-3xl md:text-5xl font-black tracking-tight text-neutral-900 dark:text-white">
            Ready to Join the Network?
          </h2>
          <p className="text-neutral-500 dark:text-slate-400 max-w-xl mx-auto font-medium text-sm leading-relaxed">
            Claim your unit&apos;s digital twin, connect with our approved operator network, and start generating premium revenue — all while your neighbors sleep peacefully.
          </p>
          <div className="flex flex-wrap justify-center gap-4 pt-4">
            <Button
              onClick={() => window.location.href = "/property"}
              className="h-14 px-10 rounded-2xl bg-gradient-to-r from-indigo-600 to-purple-600 text-white hover:from-indigo-700 hover:to-purple-700 shadow-lg shadow-indigo-500/25 font-bold tracking-wider text-xs"
            >
              Explore Properties <ArrowRight className="w-4 h-4 ml-2" />
            </Button>
            <Button
              variant="outline"
              onClick={() => window.location.href = "/trust"}
              className="h-14 px-10 rounded-2xl border-indigo-200/60 dark:border-slate-800/60 bg-white/50 dark:bg-[#14151a]/50 text-neutral-900 dark:text-white hover:bg-white/70 dark:hover:bg-[#14151a]/70 font-bold tracking-wider text-xs"
            >
              Visit Trust Center
            </Button>
          </div>
        </motion.section>
      </main>

      <CTA />
    </div>
  );
}
