"use client";

import { Shield, ShieldCheck, Clock, DollarSign, Users, Building2, Scale, AlertTriangle, CheckCircle, Sparkles, Star, Lock, Eye, BadgeCheck, ArrowRight, Hotel, Key, UserCheck, Gavel, Ban, FileText, Camera, Bell, MapPin, Calendar, CreditCard, Phone, Mail, Home, Award, TrendingUp, Zap, Target, Crown, Gem } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { CTA } from "@/components/home/CTA";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { m } from "framer-motion";
import { SEOMetadata } from "@/components/seo/SEOMetadata";

const fadeUp = {
  hidden: { opacity: 0, y: 30 },
  visible: (i: number) => ({
    opacity: 1,
    y: 0,
    transition: { delay: i * 0.08, duration: 0.5, ease: "easeOut" as const }
  })
};

const SECURITY_PILLARS = [
  {
    icon: <UserCheck className="w-7 h-7 text-brand" />,
    title: "Guest Identity Verification",
    subtitle: "Know Who You're Hosting",
    description: "Every guest undergoes rigorous identity verification including government ID checks, background screening, and review history analysis before booking approval.",
    features: [
      "Government-issued ID verification",
      "AI-powered background screening",
      "Social media profile analysis",
      "Review history & rating validation",
      "Previous host reference checks"
    ],
    gradient: "from-blue-500/10 to-cyan-500/5",
    glowColor: "bg-brand/10"
  },
  {
    icon: <Building2 className="w-7 h-7 text-success" />,
    title: "Licensed Operator Network",
    subtitle: "Professional Management Only",
    description: "All short-term rentals must be managed through Reservatior-approved property management companies with verified licenses, insurance, and operational standards.",
    features: [
      "Verified business licenses",
      "Minimum $500K insurance coverage",
      "24/7 professional support staff",
      "Regular compliance audits",
      "Performance score tracking"
    ],
    gradient: "from-blue-500/10 to-blue-500/5",
    glowColor: "bg-success/10"
  },
  {
    icon: <Clock className="w-7 h-7 text-amber-400" />,
    title: "Minimum Stay Requirements",
    subtitle: "Quality Through Duration",
    description: "Enforcing minimum stay durations eliminates party bookings and attracts business travelers, families, and premium tourists who respect the residence.",
    features: [
      "Minimum 3-night standard stay",
      "7-night minimum during peak season",
      "14-night minimum for holidays",
      "Weekly & monthly rate options",
      "Dynamic pricing enforcement"
    ],
    gradient: "from-amber-500/10 to-orange-500/5",
    glowColor: "bg-amber-500/10"
  },
  {
    icon: <Gavel className="w-7 h-7 text-rose-400" />,
    title: "Zero-Tolerance Enforcement",
    subtitle: "Rules Without Exceptions",
    description: "Strict penalty frameworks with escalating fines and a three-strike policy ensure compliance. Fines are levied on owners and operators to create accountability.",
    features: [
      "Noise violation monitoring & fines",
      "Unauthorized occupant penalties",
      "Three-strike license revocation",
      "Security deposit forfeiture",
      "Real-time incident tracking"
    ],
    gradient: "from-rose-500/10 to-pink-500/5",
    glowColor: "bg-rose-500/10"
  }
];

const SAFETY_METRICS = [
  { value: "100%", label: "Guest Verification Rate", color: "text-brand", icon: <ShieldCheck className="w-5 h-5" /> },
  { value: "3+", label: "Minimum Night Stay", color: "text-amber-400", icon: <Clock className="w-5 h-5" /> },
  { value: "24/7", label: "Security Monitoring", color: "text-success", icon: <Bell className="w-5 h-5" /> },
  { value: "$500K", label: "Min Operator Insurance", color: "text-rose-400", icon: <Shield className="w-5 h-5" /> }
];

const VERIFICATION_STEPS = [
  { step: "01", title: "Identity Submission", desc: "Guest submits government ID and personal information through our secure verification portal.", icon: <FileText className="w-5 h-5" /> },
  { step: "02", title: "Document Verification", desc: "AI-powered system validates ID authenticity and cross-references with government databases.", icon: <Camera className="w-5 h-5" /> },
  { step: "03", title: "Background Screening", desc: "Comprehensive background check including criminal records and watchlist screening.", icon: <Eye className="w-5 h-5" /> },
  { step: "04", title: "Review Analysis", desc: "Previous host reviews and ratings are analyzed to establish guest reputation score.", icon: <Star className="w-5 h-5" /> },
  { step: "05", title: "Risk Assessment", desc: "Machine learning model calculates overall risk score and approves or flags for review.", icon: <Target className="w-5 h-5" /> },
  { step: "06", title: "Final Approval", desc: "Guest receives verification badge and can proceed with booking approved properties.", icon: <BadgeCheck className="w-5 h-5" /> }
];

const OPERATOR_REQUIREMENTS = [
  { requirement: "Valid Business License", description: "Current, verifiable business license from local jurisdiction", icon: <Award className="w-5 h-5" /> },
  { requirement: "Insurance Coverage", description: "Minimum $500,000 liability insurance for property damage", icon: <Shield className="w-5 h-5" /> },
  { requirement: "Background Checks", description: "All staff undergo criminal background checks", icon: <UserCheck className="w-5 h-5" /> },
  { requirement: "24/7 Support", description: "Round-the-clock guest support and emergency response", icon: <Phone className="w-5 h-5" /> },
  { requirement: "Quality Standards", description: "Maintain minimum 4.5-star guest rating average", icon: <Star className="w-5 h-5" /> },
  { requirement: "Regular Audits", description: "Quarterly compliance and operational audits", icon: <FileText className="w-5 h-5" /> }
];

const ENFORCEMENT_TIERS = [
  {
    tier: "First Violation",
    penalty: "Warning + Fine",
    amount: "$500 - $1,000",
    description: "Formal warning issued to owner and operator with financial penalty",
    color: "from-amber-500/10 to-yellow-500/5",
    borderColor: "border-amber-500/20"
  },
  {
    tier: "Second Violation",
    penalty: "Escalated Fine",
    amount: "$1,000 - $2,500",
    description: "Increased fine and mandatory operator retraining required",
    color: "from-orange-500/10 to-red-500/5",
    borderColor: "border-warning/20"
  },
  {
    tier: "Third Violation",
    penalty: "License Revocation",
    amount: "Permanent",
    description: "Short-term rental license permanently revoked for the property",
    color: "from-red-500/10 to-rose-500/5",
    borderColor: "border-red-500/20"
  }
];

const REGIONAL_CONFIG = [
  { country: "Turkey", code: "TR", minNights: 3, peakNights: 7, insurance: "$500K", noiseLimit: "55dB" },
  { country: "UAE", code: "AE", minNights: 3, peakNights: 7, insurance: "$1M", noiseLimit: "50dB" },
  { country: "Spain", code: "ES", minNights: 3, peakNights: 7, insurance: "$300K", noiseLimit: "55dB" },
  { country: "United Kingdom", code: "UK", minNights: 3, peakNights: 7, insurance: "$500K", noiseLimit: "50dB" },
  { country: "United States", code: "US", minNights: 3, peakNights: 7, insurance: "$1M", noiseLimit: "55dB" }
];

export default function ShortTermRentalSafety() {
  return (
    <div className="min-h-screen bg-[#fafafa] dark:bg-[#0a0a0c] selection:bg-black selection:text-white dark:selection:bg-card dark:selection:text-black">
      <SEOMetadata
        data={{
          title: "Short-Term Rental Safety | Reservatior",
          description: "Comprehensive security framework for safe short-term rentals. Guest verification, licensed operators, and strict enforcement protect residents while maximizing owner revenue.",
          type: 'ORGANIZATION',
          url: window.location.href
        }}
      />
      

      <main className="max-w-[1400px] mx-auto px-8 lg:px-12 py-24 space-y-32">

        {/* ─── HERO ─────────────────────────────────────────────────────── */}
        <div className="text-center relative">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[600px] bg-brand/8 blur-[160px] pointer-events-none rounded-full" />

          <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6 }}>
            <Badge className="mb-6 bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand border border-brand/60 dark:border-brand/20 px-5 py-1.5 text-xs font-bold tracking-wider rounded-full">
              <Shield className="w-3 h-3 mr-2" /> SHORT-TERM RENTAL SECURITY
            </Badge>
            <h1 className="text-5xl md:text-8xl font-black tracking-tight text-neutral-900 dark:text-white mb-8 leading-[0.9]">
              Safe Hosting, <br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-brand to-brand dark:from-brand dark:to-brand">
                Premium Returns
              </span>
            </h1>
            <p className="text-lg md:text-xl text-neutral-500 dark:text-muted-foreground max-w-3xl mx-auto font-medium leading-relaxed">
              Our comprehensive security framework ensures short-term rentals operate at the highest standards — 
              protecting residents while maximizing owner revenue through quality-focused operations.
            </p>
          </m.div>
        </div>

        {/* ─── SAFETY METRICS BAR ────────────────────────────────────────── */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="grid grid-cols-2 md:grid-cols-4 gap-6"
        >
          {SAFETY_METRICS.map((m, i) => (
            <div key={i} className="bg-white/50 dark:bg-background/50 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-2xl p-8 text-center group hover:bg-white/70 dark:hover:bg-background/70 transition-all">
              <div className={`flex items-center justify-center gap-2 mb-3 ${m.color}`}>
                {m.icon}
              </div>
              <h3 className={`text-4xl md:text-5xl font-black tracking-tight mb-2 ${m.color} group-hover:scale-110 transition-transform`}>
                {m.value}
              </h3>
              <p className="text-xs font-bold text-neutral-500 dark:text-muted-foreground tracking-widest uppercase">{m.label}</p>
            </div>
          ))}
        </m.div>

        {/* ─── SECURITY PILLARS ─────────────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand border border-brand/60 dark:border-brand/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              SECURITY FRAMEWORK
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Four Pillars of Protection
            </h2>
            <p className="text-neutral-500 dark:text-muted-foreground max-w-2xl mx-auto font-medium">
              Every short-term rental on Reservatior must pass through four security layers designed to ensure safety and quality.
            </p>
          </m.div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {SECURITY_PILLARS.map((pillar, idx) => (
              <m.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <Card className="bg-white/50 dark:bg-background/50 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-[2rem] overflow-hidden shadow-xl group h-full hover:bg-white/70 dark:hover:bg-background/70 transition-all duration-500">
                  <CardHeader className="p-8 pb-4">
                    <div className="flex items-start justify-between mb-6">
                      <div className="p-4 rounded-2xl bg-gradient-to-br from-brand to-brand shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                        {pillar.icon}
                      </div>
                      <Badge className="bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand border border-brand/60 dark:border-brand/20 text-xs font-bold tracking-wider rounded-full px-3 py-1">
                        0{idx + 1}
                      </Badge>
                    </div>
                    <p className="text-xs font-bold text-neutral-500 dark:text-muted-foreground tracking-widest uppercase mb-1">{pillar.subtitle}</p>
                    <CardTitle className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight">{pillar.title}</CardTitle>
                  </CardHeader>
                  <CardContent className="p-8 pt-2 space-y-6">
                    <p className="text-sm font-medium text-neutral-600 dark:text-muted-foreground leading-relaxed">{pillar.description}</p>
                    <ul className="space-y-3 pt-4 border-t border-neutral-200 dark:border-border">
                      {pillar.features.map((f, i) => (
                        <li key={i} className="flex items-start gap-3 text-sm font-semibold text-neutral-700 dark:text-muted-foreground transition-colors">
                          <CheckCircle className="w-4 h-4 text-success shrink-0 mt-0.5 shadow-[0_0_8px_#3b82f6]" />
                          {f}
                        </li>
                      ))}
                    </ul>
                  </CardContent>
                </Card>
              </m.div>
            ))}
          </div>
        </section>

        {/* ─── VERIFICATION PROCESS ─────────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand border border-brand/60 dark:border-brand/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              GUEST VERIFICATION
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Six-Step Identity Verification
            </h2>
            <p className="text-neutral-500 dark:text-muted-foreground max-w-2xl mx-auto font-medium">
              Every guest undergoes comprehensive screening before booking approval.
            </p>
          </m.div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {VERIFICATION_STEPS.map((step, idx) => (
              <m.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
                className="relative"
              >
                <div className="bg-white/50 dark:bg-background/50 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-2xl p-8 h-full hover:bg-white/70 dark:hover:bg-background/70 transition-all group">
                  <div className="flex items-center gap-4 mb-6">
                    <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-brand to-brand flex items-center justify-center text-white shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                      {step.icon}
                    </div>
                    <span className="text-3xl font-black text-neutral-200 dark:text-muted-foreground tracking-tight">{step.step}</span>
                  </div>
                  <h3 className="text-lg font-black text-neutral-900 dark:text-white tracking-tight mb-3">{step.title}</h3>
                  <p className="text-sm font-medium text-neutral-500 dark:text-muted-foreground leading-relaxed">{step.desc}</p>
                </div>
              </m.div>
            ))}
          </div>
        </section>

        {/* ─── OPERATOR REQUIREMENTS ───────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand border border-brand/60 dark:border-brand/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              OPERATOR STANDARDS
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Licensed Operator Requirements
            </h2>
            <p className="text-neutral-500 dark:text-muted-foreground max-w-2xl mx-auto font-medium">
              Property management companies must meet strict criteria to operate on our platform.
            </p>
          </m.div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {OPERATOR_REQUIREMENTS.map((req, idx) => (
              <m.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <div className="bg-white/50 dark:bg-background/50 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-2xl p-8 h-full hover:bg-white/70 dark:hover:bg-background/70 transition-all group">
                  <div className="flex items-center gap-4 mb-4">
                    <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-brand to-brand flex items-center justify-center text-white shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                      {req.icon}
                    </div>
                  </div>
                  <h3 className="text-lg font-black text-neutral-900 dark:text-white tracking-tight mb-3">{req.requirement}</h3>
                  <p className="text-sm font-medium text-neutral-500 dark:text-muted-foreground leading-relaxed">{req.description}</p>
                </div>
              </m.div>
            ))}
          </div>
        </section>

        {/* ─── ENFORCEMENT TIERS ───────────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand border border-brand/60 dark:border-brand/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              ENFORCEMENT POLICY
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Three-Strike Penalty System
            </h2>
            <p className="text-neutral-500 dark:text-muted-foreground max-w-2xl mx-auto font-medium">
              Escalating penalties ensure compliance and protect community standards.
            </p>
          </m.div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {ENFORCEMENT_TIERS.map((tier, idx) => (
              <m.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <div className="bg-white/50 dark:bg-background/50 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-2xl p-8 h-full hover:bg-white/70 dark:hover:bg-background/70 transition-all">
                  <div className="text-center mb-6">
                    <Badge className={`mb-4 bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand border border-brand/60 dark:border-brand/20 text-xs font-bold tracking-wider rounded-full px-3 py-1`}>
                      STRIKE {idx + 1}
                    </Badge>
                    <h3 className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight mb-2">{tier.tier}</h3>
                    <p className="text-brand dark:text-brand text-lg font-bold">{tier.penalty}</p>
                    <p className="text-neutral-400 dark:text-muted-foreground text-sm font-medium">{tier.amount}</p>
                  </div>
                  <p className="text-sm font-medium text-neutral-500 dark:text-muted-foreground leading-relaxed text-center">{tier.description}</p>
                </div>
              </m.div>
            ))}
          </div>
        </section>

        {/* ─── REGIONAL CONFIGURATION ───────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand border border-brand/60 dark:border-brand/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              REGIONAL STANDARDS
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Country-Specific Requirements
            </h2>
            <p className="text-neutral-500 dark:text-muted-foreground max-w-2xl mx-auto font-medium">
              Security standards adapted to local regulations and market conditions.
            </p>
          </m.div>

          <m.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="bg-white/50 dark:bg-background/50 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-[2rem] overflow-hidden"
          >
            <div className="grid grid-cols-5 items-center px-8 py-5 bg-neutral-50 dark:bg-white/[0.02]">
              <span className="text-xs font-bold text-neutral-500 dark:text-muted-foreground tracking-widest uppercase">Country</span>
              <span className="text-xs font-bold text-neutral-500 dark:text-muted-foreground tracking-widest uppercase text-center">Min Nights</span>
              <span className="text-xs font-bold text-neutral-500 dark:text-muted-foreground tracking-widest uppercase text-center">Peak Nights</span>
              <span className="text-xs font-bold text-neutral-500 dark:text-muted-foreground tracking-widest uppercase text-center">Insurance</span>
              <span className="text-xs font-bold text-neutral-500 dark:text-muted-foreground tracking-widest uppercase text-center">Noise Limit</span>
            </div>
            {REGIONAL_CONFIG.map((config, idx) => (
              <div key={idx} className={`grid grid-cols-5 items-center px-8 py-5 ${idx % 2 === 0 ? "bg-neutral-50/50 dark:bg-white/[0.01]" : ""} border-t border-neutral-200 dark:border-border hover:bg-neutral-50 dark:hover:bg-white/[0.03] transition-colors`}>
                <span className="text-sm font-semibold text-neutral-700 dark:text-muted-foreground tracking-wide">{config.country}</span>
                <span className="text-sm font-semibold text-neutral-600 dark:text-muted-foreground tracking-wide text-center">{config.minNights}</span>
                <span className="text-sm font-semibold text-neutral-600 dark:text-muted-foreground tracking-wide text-center">{config.peakNights}</span>
                <span className="text-sm font-semibold text-neutral-600 dark:text-muted-foreground tracking-wide text-center">{config.insurance}</span>
                <span className="text-sm font-semibold text-neutral-600 dark:text-muted-foreground tracking-wide text-center">{config.noiseLimit}</span>
              </div>
            ))}
          </m.div>
        </section>

        {/* ─── CTA SECTION ─────────────────────────────────────────────── */}
        <m.section
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center space-y-8"
        >
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-brand to-brand flex items-center justify-center mx-auto shadow-lg shadow-indigo-500/20">
            <Crown className="w-8 h-8 text-white" />
          </div>
          <h2 className="text-3xl md:text-5xl font-black tracking-tight text-neutral-900 dark:text-white">
            Ready to List Safely?
          </h2>
          <p className="text-neutral-500 dark:text-muted-foreground max-w-xl mx-auto font-medium text-sm leading-relaxed">
            Join our network of verified operators and licensed properties. Generate premium revenue while maintaining the highest security standards.
          </p>
          <div className="flex flex-wrap justify-center gap-4 pt-4">
            <Button
              onClick={() => window.location.href = "/property"}
              className="h-14 px-10 rounded-2xl bg-gradient-to-r from-brand to-brand text-white hover:from-brand hover:to-brand shadow-lg shadow-indigo-500/25 font-bold tracking-wider text-xs"
            >
              Explore Properties <ArrowRight className="w-4 h-4 ml-2" />
            </Button>
            <Button
              variant="outline"
              onClick={() => window.location.href = "/hospitality-standards"}
              className="h-14 px-10 rounded-2xl border-brand/60 dark:border-border/60 bg-white/50 dark:bg-background/50 text-neutral-900 dark:text-white hover:bg-white/70 dark:hover:bg-background/70 font-bold tracking-wider text-xs"
            >
              View Hospitality Standards
            </Button>
          </div>
        </m.section>
      </main>

      <CTA />
    </div>
  );
}
