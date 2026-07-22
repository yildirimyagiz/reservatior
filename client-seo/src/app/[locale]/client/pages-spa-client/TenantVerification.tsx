"use client";

import { Shield, ShieldCheck, Zap, Award, Crown, TrendingUp, Lock, CheckCircle, Star, ArrowRight, User, CreditCard, Phone, Mail, FileText, Building2, Calendar, Users, Clock, Gift, Sparkles, ChevronRight, BadgeCheck, Target, Gem, Heart, Globe, MapPin, Key, Home, Briefcase, Plane, Baby, GraduationCap, CalendarDays } from "lucide-react";
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

const VERIFICATION_TIERS = [
  {
    tier: 'bronze',
    name: 'Quick Start',
    icon: <Zap className="w-8 h-8 text-amber-400" />,
    time: '2 minutes',
    color: 'from-amber-500/10 to-yellow-500/5',
    borderColor: 'border-amber-500/20',
    title: 'Quick Start Verification',
    subtitle: 'Begin your journey in 2 minutes',
    description: 'Basic verification to start browsing properties',
    features: [
      'Email verification',
      'Phone number verification',
      'Browse all properties',
      'Save favorites',
      'Basic search filters'
    ],
    benefits: [
      'Instant access to property listings',
      'No commitment required',
      'Explore at your own pace'
    ],
    conversionGate: false,
    marketingMessage: 'Start browsing properties in under 2 minutes'
  },
  {
    tier: 'silver',
    name: 'Verified Guest',
    icon: <ShieldCheck className="w-8 h-8 text-slate-300" />,
    time: '5 minutes',
    color: 'from-slate-500/10 to-gray-500/5',
    borderColor: 'border-slate-500/20',
    title: 'Verified Guest Status',
    subtitle: 'Book with confidence',
    description: 'Complete identity verification for full booking access',
    features: [
      'Government ID verification',
      'Valid payment method',
      'Emergency contacts',
      'Book any property',
      'Secure messaging'
    ],
    benefits: [
      'Full booking capabilities',
      'Hosts prefer verified guests',
      '24/7 customer support',
      'Secure payment processing'
    ],
    conversionGate: true,
    marketingMessage: 'Book any property with verified identity'
  },
  {
    tier: 'gold',
    name: 'Trusted Traveler',
    icon: <Award className="w-8 h-8 text-amber-400" />,
    time: '10 minutes',
    color: 'from-amber-500/10 to-orange-500/5',
    borderColor: 'border-amber-500/20',
    title: 'Trusted Traveler Program',
    subtitle: 'Unlock premium benefits',
    description: 'Enhanced verification for exclusive property access',
    features: [
      'Security deposit capability',
      'Travel purpose verification',
      'Platform review history',
      'Premium property access',
      'Flexible cancellation'
    ],
    benefits: [
      'Access to premium properties',
      'Priority customer support',
      'Exclusive member discounts',
      'Flexible cancellation policies'
    ],
    conversionGate: false,
    marketingMessage: 'Unlock premium properties and exclusive discounts'
  },
  {
    tier: 'platinum',
    name: 'Elite Member',
    icon: <Crown className="w-8 h-8 text-purple-400" />,
    time: '15 minutes',
    color: 'from-purple-500/10 to-pink-500/5',
    borderColor: 'border-purple-500/20',
    title: 'Elite Membership',
    subtitle: 'VIP treatment awaits',
    description: 'Complete verification for luxury residence access',
    features: [
      'Previous rental history',
      'Professional profile linking',
      'Background verification',
      'Luxury residence access',
      'VIP concierge service'
    ],
    benefits: [
      'Access to all properties including luxury residences',
      'Priority booking and 24/7 concierge',
      'Exclusive discounts and flexible cancellation',
      'VIP treatment and premium support'
    ],
    conversionGate: false,
    marketingMessage: 'Access luxury residences before anyone else'
  }
];

const EVALUATION_CRITERIA = [
  {
    category: 'Identity Verification',
    icon: <User className="w-5 h-5 text-blue-400" />,
    items: [
      { name: 'Government ID', required: true, time: '2 min', benefit: 'Verified identity ensures safe community' },
      { name: 'Email Verification', required: true, time: '1 min', benefit: 'Secure communication channel' },
      { name: 'Phone Verification', required: true, time: '1 min', benefit: 'Instant support access' }
    ]
  },
  {
    category: 'Financial Reliability',
    icon: <CreditCard className="w-5 h-5 text-emerald-400" />,
    items: [
      { name: 'Payment Method', required: true, time: '2 min', benefit: 'Seamless booking experience' },
      { name: 'Security Deposit', required: true, time: '3 min', benefit: 'Protects your stay' },
      { name: 'Income Verification', required: false, time: '5 min', benefit: 'Enables premium access' }
    ]
  },
  {
    category: 'Behavioral History',
    icon: <Star className="w-5 h-5 text-amber-400" />,
    items: [
      { name: 'Rental History', required: false, time: '5 min', benefit: 'Build rental reputation' },
      { name: 'Platform Reviews', required: false, time: '2 min', benefit: 'Great reviews unlock discounts' },
      { name: 'Cancellation History', required: false, time: '0 min', benefit: 'Reliable guests get priority' }
    ]
  },
  {
    category: 'Social Proof',
    icon: <Users className="w-5 h-5 text-rose-400" />,
    items: [
      { name: 'Professional Profile', required: false, time: '3 min', benefit: 'Builds host trust' },
      { name: 'Emergency Contacts', required: true, time: '2 min', benefit: '24/7 safety support' },
      { name: 'Travel Purpose', required: true, time: '1 min', benefit: 'Personalized recommendations' }
    ]
  }
];

const TRAVEL_PURPOSES = [
  { icon: <Briefcase className="w-6 h-6" />, label: 'Business Travel', description: 'Corporate stays and work trips' },
  { icon: <Plane className="w-6 h-6" />, label: 'Leisure Travel', description: 'Vacations and getaways' },
  { icon: <Users className="w-6 h-6" />, label: 'Family Travel', description: 'Family trips and reunions' },
  { icon: <GraduationCap className="w-6 h-6" />, label: 'Education', description: 'Study abroad and courses' },
  { icon: <CalendarDays className="w-6 h-6" />, label: 'Events', description: 'Weddings and celebrations' },
  { icon: <Home className="w-6 h-6" />, label: 'Relocation', description: 'Temporary housing' }
];

const MARKETING_ANGLES = [
  {
    angle: 'Security First',
    title: 'Your Safety is Our Priority',
    description: 'Every guest is verified to ensure a safe community for everyone. Book with peace of mind knowing your neighbors are equally vetted.',
    icon: <Shield className="w-8 h-8 text-emerald-400" />,
    color: 'from-emerald-500/10 to-green-500/5',
    borderColor: 'border-emerald-500/20'
  },
  {
    angle: 'Benefit Driven',
    title: 'Verification Unlocks Benefits',
    description: 'Each verification stage unlocks new properties, better rates, and exclusive perks. The more you verify, the more you gain.',
    icon: <Gift className="w-8 h-8 text-amber-400" />,
    color: 'from-amber-500/10 to-orange-500/5',
    borderColor: 'border-amber-500/20'
  },
  {
    angle: 'Exclusivity',
    title: 'Elite Access for Verified Guests',
    description: 'Luxury residences and premium properties are exclusively available to verified travelers. Stand out from the crowd.',
    icon: <Crown className="w-8 h-8 text-purple-400" />,
    color: 'from-purple-500/10 to-pink-500/5',
    borderColor: 'border-purple-500/20'
  },
  {
    angle: 'Trust Building',
    title: 'Build Trust, Get Booked',
    description: 'Hosts prefer verified guests. Your reliability score builds trust and leads to better acceptance rates and preferred treatment.',
    icon: <TrendingUp className="w-8 h-8 text-blue-400" />,
    color: 'from-blue-500/10 to-cyan-500/5',
    borderColor: 'border-blue-500/20'
  }
];

const TRUST_METRICS = [
  { value: '2 min', label: 'Quick Start Time', color: 'text-amber-400', icon: <Clock className="w-5 h-5" /> },
  { value: '4 stages', label: 'Verification Levels', color: 'text-blue-400', icon: <Target className="w-5 h-5" /> },
  { value: '100%', label: 'Host Preference', color: 'text-emerald-400', icon: <Heart className="w-5 h-5" /> },
  { value: 'VIP', label: 'Elite Benefits', color: 'text-purple-400', icon: <Gem className="w-5 h-5" /> }
];

export default function TenantVerification() {
  return (
    <div className="min-h-screen bg-[#fafafa] dark:bg-[#0a0a0c] selection:bg-black selection:text-white dark:selection:bg-white dark:selection:text-black">
      <SEOMetadata
        data={{
          title: "Tenant Verification | Reservatior",
          description: "Progressive verification system that balances security with convenience. Start in 2 minutes, unlock premium benefits as you verify.",
          type: 'ORGANIZATION',
          url: window.location.href
        }}
      />
      

      <main className="max-w-[1400px] mx-auto px-8 lg:px-12 py-24 space-y-32">

        {/* ─── HERO ─────────────────────────────────────────────────────── */}
        <div className="text-center relative">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[600px] bg-indigo-500/8 blur-[160px] pointer-events-none rounded-full" />

          <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6 }}>
            <Badge className="mb-6 bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-5 py-1.5 text-xs font-bold tracking-wider rounded-full">
              <Sparkles className="w-3 h-3 mr-2" /> PROGRESSIVE VERIFICATION
            </Badge>
            <h1 className="text-5xl md:text-8xl font-black tracking-tight text-neutral-900 dark:text-white mb-8 leading-[0.9]">
              Verify as You Go, <br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-purple-500 dark:from-indigo-400 dark:to-purple-400">
                Unlock as You Grow
              </span>
            </h1>
            <p className="text-lg md:text-xl text-neutral-500 dark:text-slate-400 max-w-3xl mx-auto font-medium leading-relaxed">
              Start browsing in 2 minutes. Add verification when you&apos;re ready to book. 
              Each step unlocks better properties, lower rates, and exclusive benefits.
            </p>
          </m.div>
        </div>

        {/* ─── TRUST METRICS ─────────────────────────────────────────────── */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="grid grid-cols-2 md:grid-cols-4 gap-6"
        >
          {TRUST_METRICS.map((m, i) => (
            <div key={i} className="bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-2xl p-8 text-center group hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all">
              <div className={`flex items-center justify-center gap-2 mb-3 ${m.color}`}>
                {m.icon}
              </div>
              <h3 className={`text-4xl md:text-5xl font-black tracking-tight mb-2 ${m.color} group-hover:scale-110 transition-transform`}>
                {m.value}
              </h3>
              <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">{m.label}</p>
            </div>
          ))}
        </m.div>

        {/* ─── MARKETING ANGLES ──────────────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              WHY VERIFY?
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Security as a Benefit
            </h2>
            <p className="text-neutral-500 dark:text-slate-400 max-w-2xl mx-auto font-medium">
              We&apos;ve designed verification to enhance your experience, not restrict it.
            </p>
          </m.div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {MARKETING_ANGLES.map((angle, idx) => (
              <m.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <Card className="bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-[2rem] overflow-hidden shadow-xl group h-full hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all duration-500">
                  <CardHeader className="p-8 pb-4">
                    <div className="flex items-start justify-between mb-6">
                      <div className="p-4 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                        {angle.icon}
                      </div>
                      <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 text-xs font-bold tracking-wider rounded-full px-3 py-1">
                        0{idx + 1}
                      </Badge>
                    </div>
                    <CardTitle className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight">{angle.title}</CardTitle>
                  </CardHeader>
                  <CardContent className="p-8 pt-2">
                    <p className="text-sm font-medium text-neutral-600 dark:text-slate-400 leading-relaxed">{angle.description}</p>
                  </CardContent>
                </Card>
              </m.div>
            ))}
          </div>
        </section>

        {/* ─── VERIFICATION TIERS ───────────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              PROGRESSION PATH
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Four Stages to Elite
            </h2>
            <p className="text-neutral-500 dark:text-slate-400 max-w-2xl mx-auto font-medium">
              Start simple, add more verification as you need. Each stage unlocks new benefits.
            </p>
          </m.div>

          <div className="space-y-6">
            {VERIFICATION_TIERS.map((tier, idx) => (
              <m.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <Card className="bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-[2rem] overflow-hidden shadow-xl group hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all duration-500">
                  <div className="p-8">
                    <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-8">
                      <div className="flex items-center gap-6">
                        <div className="p-4 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                          {tier.icon}
                        </div>
                        <div>
                          <div className="flex items-center gap-3 mb-2">
                            <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 text-xs font-bold tracking-wider rounded-full px-3 py-1">
                              STAGE {idx + 1}
                            </Badge>
                            <span className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">{tier.time}</span>
                          </div>
                          <h3 className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight">{tier.name}</h3>
                          <p className="text-sm font-medium text-neutral-500 dark:text-slate-400">{tier.subtitle}</p>
                        </div>
                      </div>
                      {tier.conversionGate && (
                        <Badge className="bg-rose-500/10 text-rose-400 border border-rose-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
                          REQUIRED TO BOOK
                        </Badge>
                      )}
                    </div>

                    <p className="text-sm font-medium text-neutral-600 dark:text-slate-400 leading-relaxed mb-8">{tier.description}</p>

                    <div className="grid md:grid-cols-2 gap-8">
                      <div>
                        <h4 className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase mb-4">Features</h4>
                        <ul className="space-y-3">
                          {tier.features.map((f, i) => (
                            <li key={i} className="flex items-start gap-3 text-sm font-semibold text-neutral-700 dark:text-slate-300 transition-colors">
                              <CheckCircle className="w-4 h-4 text-emerald-500 shrink-0 mt-0.5 shadow-[0_0_8px_#10b981]" />
                              {f}
                            </li>
                          ))}
                        </ul>
                      </div>
                      <div>
                        <h4 className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase mb-4">Benefits</h4>
                        <ul className="space-y-3">
                          {tier.benefits.map((b, i) => (
                            <li key={i} className="flex items-start gap-3 text-sm font-semibold text-neutral-700 dark:text-slate-300 transition-colors">
                              <Gift className="w-4 h-4 text-amber-500 shrink-0 mt-0.5" />
                              {b}
                            </li>
                          ))}
                        </ul>
                      </div>
                    </div>

                    <div className="mt-8 p-4 bg-neutral-50 dark:bg-white/[0.02] rounded-2xl border border-neutral-200 dark:border-slate-800">
                      <p className="text-xs font-bold text-emerald-600 dark:text-emerald-400 tracking-wide text-center">
                        {tier.marketingMessage}
                      </p>
                    </div>
                  </div>
                </Card>
              </m.div>
            ))}
          </div>
        </section>

        {/* ─── EVALUATION CRITERIA ─────────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              EVALUATION CRITERIA
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              What We Evaluate
            </h2>
            <p className="text-neutral-500 dark:text-slate-400 max-w-2xl mx-auto font-medium">
              Clear, transparent criteria with visible benefits for each verification step.
            </p>
          </m.div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {EVALUATION_CRITERIA.map((category, idx) => (
              <m.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <Card className="bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-2xl overflow-hidden group hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all">
                  <CardHeader className="p-6 pb-4">
                    <div className="flex items-center gap-4 mb-4">
                      <div className="p-3 rounded-xl bg-gradient-to-br from-indigo-500 to-purple-600 shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                        {category.icon}
                      </div>
                      <CardTitle className="text-lg font-black text-neutral-900 dark:text-white tracking-tight">{category.category}</CardTitle>
                    </div>
                  </CardHeader>
                  <CardContent className="p-6 pt-2 space-y-4">
                    {category.items.map((item, i) => (
                      <div key={i} className="flex items-start justify-between p-4 bg-neutral-50/50 dark:bg-white/[0.02] rounded-xl border border-neutral-200/60 dark:border-slate-800/60 hover:bg-neutral-50 dark:hover:bg-white/[0.04] transition-colors">
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-1">
                            {item.required && <Badge className="bg-rose-500/10 text-rose-400 border border-rose-500/20 text-xs font-bold tracking-wider rounded-full px-2 py-0.5">REQUIRED</Badge>}
                            <span className="text-sm font-semibold text-neutral-700 dark:text-white tracking-wide">{item.name}</span>
                          </div>
                          <p className="text-xs font-medium text-emerald-600 dark:text-emerald-400 tracking-wide">{item.benefit}</p>
                        </div>
                        <span className="text-xs font-bold text-neutral-500 dark:text-slate-400">{item.time}</span>
                      </div>
                    ))}
                  </CardContent>
                </Card>
              </m.div>
            ))}
          </div>
        </section>

        {/* ─── TRAVEL PURPOSES ─────────────────────────────────────────── */}
        <section>
          <m.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
              PERSONALIZATION
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black tracking-tight text-neutral-900 dark:text-white">
              Tell Us Your Purpose
            </h2>
            <p className="text-neutral-500 dark:text-slate-400 max-w-2xl mx-auto font-medium">
              Your travel purpose helps us match you with the perfect property and provide personalized recommendations.
            </p>
          </m.div>

          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {TRAVEL_PURPOSES.map((purpose, idx) => (
              <m.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
                className="bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 rounded-2xl p-6 text-center hover:bg-white/70 dark:hover:bg-[#14151a]/70 transition-all group cursor-pointer"
              >
                <div className="p-3 rounded-xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center text-white mx-auto mb-4 shadow-lg shadow-indigo-500/20 group-hover:scale-110 transition-transform">
                  {purpose.icon}
                </div>
                <h3 className="text-sm font-bold text-neutral-900 dark:text-white tracking-tight mb-2">{purpose.label}</h3>
                <p className="text-xs font-medium text-neutral-500 dark:text-slate-400 leading-relaxed">{purpose.description}</p>
              </m.div>
            ))}
          </div>
        </section>

        {/* ─── CTA SECTION ─────────────────────────────────────────────── */}
        <m.section
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center space-y-8"
        >
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center mx-auto shadow-lg shadow-indigo-500/20">
            <Zap className="w-8 h-8 text-white" />
          </div>
          <h2 className="text-3xl md:text-5xl font-black tracking-tight text-neutral-900 dark:text-white">
            Ready to Get Started?
          </h2>
          <p className="text-neutral-500 dark:text-slate-400 max-w-xl mx-auto font-medium text-sm leading-relaxed">
            Begin your verification journey in just 2 minutes. Browse properties, save favorites, and unlock benefits as you go.
          </p>
          <div className="flex flex-wrap justify-center gap-4 pt-4">
            <Button
              onClick={() => window.location.href = "/property"}
              className="h-14 px-10 rounded-2xl bg-gradient-to-r from-indigo-600 to-purple-600 text-white hover:from-indigo-700 hover:to-purple-700 shadow-lg shadow-indigo-500/25 font-bold tracking-wider text-xs"
            >
              Start Browsing <ArrowRight className="w-4 h-4 ml-2" />
            </Button>
            <Button
              variant="outline"
              onClick={() => window.location.href = "/short-term-rental-safety"}
              className="h-14 px-10 rounded-2xl border-indigo-200/60 dark:border-slate-800/60 bg-white/50 dark:bg-[#14151a]/50 text-neutral-900 dark:text-white hover:bg-white/70 dark:hover:bg-[#14151a]/70 font-bold tracking-wider text-xs"
            >
              Learn About Security
            </Button>
          </div>
        </m.section>
      </main>

      <CTA />
    </div>
  );
}
