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
    <div className="min-h-screen bg-[#14151a]">
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
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[600px] bg-amber-500/8 blur-[160px] pointer-events-none rounded-full" />

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6 }}>
            <Badge className="mb-6 bg-amber-500/10 text-amber-400 border border-amber-500/20 px-6 py-1 text-[10px] font-black tracking-[0.2em] italic">
              <Sparkles className="w-3 h-3 mr-2" /> HIGH-END HOSPITALITY FRAMEWORK
            </Badge>
            <h1 className="text-5xl md:text-8xl font-black text-white tracking-tighter mb-8 italic leading-[0.9]">
              Luxury Living <br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-amber-400 via-orange-400 to-rose-400">
                Meets Smart Hosting
              </span>
            </h1>
            <p className="text-lg md:text-xl text-slate-500 max-w-3xl mx-auto font-bold tracking-wide italic leading-relaxed">
              Short-term rentals don't have to compromise building prestige.
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
            <div key={i} className="bg-[#1a1b1e]/60 backdrop-blur-3xl border border-white/5 rounded-3xl p-8 text-center group hover:border-white/10 transition-all border-l border-t">
              <h3 className={`text-4xl md:text-5xl font-black italic tracking-tighter mb-2 ${m.color} group-hover:scale-110 transition-transform`}>
                {m.value}
              </h3>
              <p className="text-[10px] font-black text-slate-500 tracking-widest italic uppercase">{m.label}</p>
            </div>
          ))}
        </motion.div>

        {/* ─── FOUR PILLARS ─────────────────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-white/5 text-white border border-white/10 px-4 py-1 text-[9px] font-black tracking-widest italic">
              THE FOUR PILLARS
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">
              Quality Architecture
            </h2>
            <p className="text-slate-500 max-w-2xl mx-auto font-bold italic tracking-wide">
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
                <Card className={`bg-gradient-to-br ${pillar.gradient} border-white/5 rounded-[40px] overflow-hidden shadow-3xl border-l border-t group h-full hover:border-white/10 transition-all duration-500`}>
                  <CardHeader className="p-10 pb-4">
                    <div className="flex items-start justify-between mb-6">
                      <div className={`p-4 rounded-2xl bg-black/40 border border-white/5 shadow-inner group-hover:scale-110 transition-transform`}>
                        {pillar.icon}
                      </div>
                      <Badge className="bg-white/5 text-white/40 border-white/5 text-[8px] font-black tracking-widest italic">
                        0{idx + 1}
                      </Badge>
                    </div>
                    <p className="text-[10px] font-black text-slate-500 tracking-widest italic uppercase mb-1">{pillar.subtitle}</p>
                    <CardTitle className="text-2xl font-black text-white italic tracking-tighter">{pillar.title}</CardTitle>
                  </CardHeader>
                  <CardContent className="p-10 pt-2 space-y-6">
                    <p className="text-sm font-bold text-slate-400 tracking-tight italic leading-relaxed">{pillar.description}</p>
                    <ul className="space-y-3 pt-4 border-t border-white/5">
                      {pillar.features.map((f, i) => (
                        <li key={i} className="flex items-start gap-3 text-[11px] font-black text-white/70 italic tracking-wide group-hover:text-white/90 transition-colors">
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
            <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/20 px-4 py-1 text-[9px] font-black tracking-widest italic">
              GUEST LIFECYCLE
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">
              Every Stay, Fully Managed
            </h2>
            <p className="text-slate-500 max-w-2xl mx-auto font-bold italic tracking-wide">
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
                <div className="bg-[#1a1b1e]/60 backdrop-blur-xl border border-white/5 rounded-3xl p-8 h-full hover:border-white/10 transition-all group border-l border-t">
                  <div className="flex items-center gap-4 mb-6">
                    <div className="w-12 h-12 rounded-2xl bg-blue-500/10 border border-blue-500/20 flex items-center justify-center text-blue-400 group-hover:scale-110 transition-transform">
                      {step.icon}
                    </div>
                    <span className="text-3xl font-black text-white/10 italic tracking-tighter">{step.step}</span>
                  </div>
                  <h3 className="text-lg font-black text-white italic tracking-tight mb-3">{step.title}</h3>
                  <p className="text-xs font-bold text-slate-400 italic leading-relaxed tracking-wide">{step.desc}</p>
                </div>
              </motion.div>
            ))}
          </div>
        </section>

        {/* ─── COMPARISON TABLE ─────────────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 px-4 py-1 text-[9px] font-black tracking-widest italic">
              COMPARISON
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">
              Traditional vs. Reservatior
            </h2>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="bg-[#1a1b1e]/60 backdrop-blur-3xl border border-white/5 rounded-[40px] overflow-hidden border-l border-t"
          >
            <div className="grid grid-cols-[1fr_120px_120px] md:grid-cols-[1fr_160px_160px] items-center px-8 py-5 bg-white/[0.02]">
              <span className="text-[10px] font-black text-slate-500 tracking-widest italic uppercase">Feature</span>
              <span className="text-[10px] font-black text-slate-500 tracking-widest italic uppercase text-center">Traditional</span>
              <span className="text-[10px] font-black text-emerald-500 tracking-widest italic uppercase text-center">Reservatior</span>
            </div>
            {COMPARISON.map((row, idx) => (
              <div key={idx} className={`grid grid-cols-[1fr_120px_120px] md:grid-cols-[1fr_160px_160px] items-center px-8 py-5 ${idx % 2 === 0 ? "bg-white/[0.01]" : ""} border-t border-white/5 hover:bg-white/[0.03] transition-colors`}>
                <span className="text-xs font-black text-white/80 italic tracking-wide">{row.feature}</span>
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
          <div className="bg-gradient-to-br from-amber-500/10 via-[#1a1b1e]/80 to-emerald-500/10 rounded-[60px] p-12 md:p-20 border border-white/5 border-l border-t relative">
            <div className="absolute top-0 right-0 w-[400px] h-[400px] bg-amber-500/5 blur-[120px] rounded-full pointer-events-none" />
            <div className="absolute bottom-0 left-0 w-[300px] h-[300px] bg-emerald-500/5 blur-[100px] rounded-full pointer-events-none" />

            <div className="relative z-10 grid lg:grid-cols-2 gap-12 items-center">
              <div className="space-y-8">
                <Badge className="bg-amber-500/10 text-amber-400 border border-amber-500/20 px-4 py-1 text-[9px] font-black tracking-widest italic">
                  THE WIN-WIN FORMULA
                </Badge>
                <h2 className="text-4xl md:text-5xl font-black text-white italic tracking-tighter leading-[0.95]">
                  Elevate the Standard, <br />
                  <span className="text-transparent bg-clip-text bg-gradient-to-r from-amber-400 to-emerald-400">
                    Elevate the Returns
                  </span>
                </h2>
                <p className="text-slate-400 text-sm font-bold italic tracking-wide leading-relaxed max-w-lg">
                  When quality is non-negotiable, the entire ecosystem benefits. Property values rise, brand equity strengthens, and premium guests choose your building first. This isn't restriction — it's elevation.
                </p>
              </div>

              <div className="grid grid-cols-2 gap-6">
                <div className="bg-black/40 p-8 rounded-[32px] border border-white/5 backdrop-blur-3xl text-center group hover:border-amber-500/20 transition-all border-l border-t">
                  <DollarSign className="w-8 h-8 text-amber-400 mx-auto mb-4 group-hover:scale-110 transition-transform" />
                  <h4 className="text-2xl font-black text-white italic tracking-tighter mb-1">+40%</h4>
                  <p className="text-[9px] font-black text-slate-500 tracking-widest italic">Revenue vs. Long-Term</p>
                </div>
                <div className="bg-black/40 p-8 rounded-[32px] border border-white/5 backdrop-blur-3xl text-center group hover:border-emerald-500/20 transition-all border-l border-t">
                  <Star className="w-8 h-8 text-emerald-400 mx-auto mb-4 group-hover:scale-110 transition-transform" />
                  <h4 className="text-2xl font-black text-white italic tracking-tighter mb-1">4.9★</h4>
                  <p className="text-[9px] font-black text-slate-500 tracking-widest italic">Avg Guest Rating</p>
                </div>
                <div className="bg-black/40 p-8 rounded-[32px] border border-white/5 backdrop-blur-3xl text-center group hover:border-blue-500/20 transition-all border-l border-t">
                  <Shield className="w-8 h-8 text-blue-400 mx-auto mb-4 group-hover:scale-110 transition-transform" />
                  <h4 className="text-2xl font-black text-white italic tracking-tighter mb-1">0</h4>
                  <p className="text-[9px] font-black text-slate-500 tracking-widest italic">Security Incidents</p>
                </div>
                <div className="bg-black/40 p-8 rounded-[32px] border border-white/5 backdrop-blur-3xl text-center group hover:border-rose-500/20 transition-all border-l border-t">
                  <Users className="w-8 h-8 text-rose-400 mx-auto mb-4 group-hover:scale-110 transition-transform" />
                  <h4 className="text-2xl font-black text-white italic tracking-tighter mb-1">98%</h4>
                  <p className="text-[9px] font-black text-slate-500 tracking-widest italic">Resident Satisfaction</p>
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
          <Lock className="w-12 h-12 text-white/20 mx-auto" />
          <h2 className="text-3xl md:text-5xl font-black text-white italic tracking-tighter">
            Ready to Join the Network?
          </h2>
          <p className="text-slate-500 max-w-xl mx-auto font-bold italic tracking-wide text-sm">
            Claim your unit's digital twin, connect with our approved operator network, and start generating premium revenue — all while your neighbors sleep peacefully.
          </p>
          <div className="flex flex-wrap justify-center gap-4 pt-4">
            <Button
              onClick={() => window.location.href = "/properties"}
              className="h-14 px-10 rounded-2xl bg-white text-black hover:bg-slate-200 font-black tracking-widest text-xs"
            >
              Explore Properties <ArrowRight className="w-4 h-4 ml-2" />
            </Button>
            <Button
              variant="outline"
              onClick={() => window.location.href = "/trust"}
              className="h-14 px-10 rounded-2xl border-white/10 bg-white/5 text-white hover:bg-white/10 font-black tracking-widest text-xs"
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
