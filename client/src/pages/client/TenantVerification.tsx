import { Shield, ShieldCheck, Zap, Award, Crown, TrendingUp, Lock, CheckCircle, Star, ArrowRight, User, CreditCard, Phone, Mail, FileText, Building2, Calendar, Users, Clock, Gift, Sparkles, ChevronRight, BadgeCheck, Target, Gem, Heart, Globe, MapPin, Key, Home, Briefcase, Plane, Baby, GraduationCap, CalendarDays } from "lucide-react";
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
    <div className="min-h-screen bg-[#14151a]">
      <SEOMetadata
        data={{
          title: "Tenant Verification | Reservatior",
          description: "Progressive verification system that balances security with convenience. Start in 2 minutes, unlock premium benefits as you verify.",
          type: 'ORGANIZATION',
          url: window.location.href
        }}
      />
      <Header />

      <main className="max-w-[1400px] mx-auto px-8 lg:px-12 py-24 space-y-32">

        {/* ─── HERO ─────────────────────────────────────────────────────── */}
        <div className="text-center relative">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[600px] bg-blue-500/8 blur-[160px] pointer-events-none rounded-full" />

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6 }}>
            <Badge className="mb-6 bg-blue-500/10 text-blue-400 border border-blue-500/20 px-6 py-1 text-[10px] font-black tracking-[0.2em] italic">
              <Sparkles className="w-3 h-3 mr-2" /> PROGRESSIVE VERIFICATION
            </Badge>
            <h1 className="text-5xl md:text-8xl font-black text-white tracking-tighter mb-8 italic leading-[0.9]">
              Verify as You Go, <br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-400 via-cyan-400 to-emerald-400">
                Unlock as You Grow
              </span>
            </h1>
            <p className="text-lg md:text-xl text-slate-500 max-w-3xl mx-auto font-bold tracking-wide italic leading-relaxed">
              Start browsing in 2 minutes. Add verification when you're ready to book. 
              Each step unlocks better properties, lower rates, and exclusive benefits.
            </p>
          </motion.div>
        </div>

        {/* ─── TRUST METRICS ─────────────────────────────────────────────── */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="grid grid-cols-2 md:grid-cols-4 gap-6"
        >
          {TRUST_METRICS.map((m, i) => (
            <div key={i} className="bg-[#1a1b1e]/60 backdrop-blur-3xl border border-white/5 rounded-3xl p-8 text-center group hover:border-white/10 transition-all border-l border-t">
              <div className={`flex items-center justify-center gap-2 mb-3 ${m.color}`}>
                {m.icon}
              </div>
              <h3 className={`text-4xl md:text-5xl font-black italic tracking-tighter mb-2 ${m.color} group-hover:scale-110 transition-transform`}>
                {m.value}
              </h3>
              <p className="text-[10px] font-black text-slate-500 tracking-widest italic uppercase">{m.label}</p>
            </div>
          ))}
        </motion.div>

        {/* ─── MARKETING ANGLES ──────────────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-white/5 text-white border border-white/10 px-4 py-1 text-[9px] font-black tracking-widest italic">
              WHY VERIFY?
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">
              Security as a Benefit
            </h2>
            <p className="text-slate-500 max-w-2xl mx-auto font-bold italic tracking-wide">
              We've designed verification to enhance your experience, not restrict it.
            </p>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {MARKETING_ANGLES.map((angle, idx) => (
              <motion.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <Card className={`bg-gradient-to-br ${angle.color} border ${angle.borderColor} rounded-[40px] overflow-hidden shadow-3xl border-l border-t group h-full hover:border-white/10 transition-all duration-500`}>
                  <CardHeader className="p-10 pb-4">
                    <div className="flex items-start justify-between mb-6">
                      <div className="p-4 rounded-2xl bg-black/40 border border-white/5 shadow-inner group-hover:scale-110 transition-transform">
                        {angle.icon}
                      </div>
                      <Badge className="bg-white/5 text-white/40 border-white/5 text-[8px] font-black tracking-widest italic">
                        0{idx + 1}
                      </Badge>
                    </div>
                    <CardTitle className="text-2xl font-black text-white italic tracking-tighter">{angle.title}</CardTitle>
                  </CardHeader>
                  <CardContent className="p-10 pt-2">
                    <p className="text-sm font-bold text-slate-400 tracking-tight italic leading-relaxed">{angle.description}</p>
                  </CardContent>
                </Card>
              </motion.div>
            ))}
          </div>
        </section>

        {/* ─── VERIFICATION TIERS ───────────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-amber-500/10 text-amber-400 border border-amber-500/20 px-4 py-1 text-[9px] font-black tracking-widest italic">
              PROGRESSION PATH
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">
              Four Stages to Elite
            </h2>
            <p className="text-slate-500 max-w-2xl mx-auto font-bold italic tracking-wide">
              Start simple, add more verification as you need. Each stage unlocks new benefits.
            </p>
          </motion.div>

          <div className="space-y-6">
            {VERIFICATION_TIERS.map((tier, idx) => (
              <motion.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <Card className={`bg-gradient-to-br ${tier.color} border ${tier.borderColor} rounded-[40px] overflow-hidden shadow-3xl border-l border-t group hover:border-white/10 transition-all duration-500`}>
                  <div className="p-10">
                    <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-8">
                      <div className="flex items-center gap-6">
                        <div className="p-4 rounded-2xl bg-black/40 border border-white/5 shadow-inner group-hover:scale-110 transition-transform">
                          {tier.icon}
                        </div>
                        <div>
                          <div className="flex items-center gap-3 mb-2">
                            <Badge className={`${tier.borderColor} text-white/60 text-[8px] font-black tracking-widest italic`}>
                              STAGE {idx + 1}
                            </Badge>
                            <span className="text-[10px] font-black text-slate-500 tracking-widest italic uppercase">{tier.time}</span>
                          </div>
                          <h3 className="text-2xl font-black text-white italic tracking-tighter">{tier.name}</h3>
                          <p className="text-sm font-bold text-slate-400 italic tracking-wide">{tier.subtitle}</p>
                        </div>
                      </div>
                      {tier.conversionGate && (
                        <Badge className="bg-rose-500/10 text-rose-400 border border-rose-500/20 px-4 py-1 text-[9px] font-black tracking-widest italic">
                          REQUIRED TO BOOK
                        </Badge>
                      )}
                    </div>

                    <p className="text-sm font-bold text-slate-400 tracking-tight italic leading-relaxed mb-8">{tier.description}</p>

                    <div className="grid md:grid-cols-2 gap-8">
                      <div>
                        <h4 className="text-[10px] font-black text-slate-500 tracking-widest italic uppercase mb-4">Features</h4>
                        <ul className="space-y-3">
                          {tier.features.map((f, i) => (
                            <li key={i} className="flex items-start gap-3 text-[11px] font-black text-white/70 italic tracking-wide group-hover:text-white/90 transition-colors">
                              <CheckCircle className="w-4 h-4 text-emerald-500 shrink-0 mt-0.5 shadow-[0_0_8px_#10b981]" />
                              {f}
                            </li>
                          ))}
                        </ul>
                      </div>
                      <div>
                        <h4 className="text-[10px] font-black text-slate-500 tracking-widest italic uppercase mb-4">Benefits</h4>
                        <ul className="space-y-3">
                          {tier.benefits.map((b, i) => (
                            <li key={i} className="flex items-start gap-3 text-[11px] font-black text-white/70 italic tracking-wide group-hover:text-white/90 transition-colors">
                              <Gift className="w-4 h-4 text-amber-500 shrink-0 mt-0.5" />
                              {b}
                            </li>
                          ))}
                        </ul>
                      </div>
                    </div>

                    <div className="mt-8 p-4 bg-black/40 rounded-2xl border border-white/5">
                      <p className="text-[10px] font-black text-emerald-400 italic tracking-wide text-center">
                        {tier.marketingMessage}
                      </p>
                    </div>
                  </div>
                </Card>
              </motion.div>
            ))}
          </div>
        </section>

        {/* ─── EVALUATION CRITERIA ─────────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/20 px-4 py-1 text-[9px] font-black tracking-widest italic">
              EVALUATION CRITERIA
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">
              What We Evaluate
            </h2>
            <p className="text-slate-500 max-w-2xl mx-auto font-bold italic tracking-wide">
              Clear, transparent criteria with visible benefits for each verification step.
            </p>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {EVALUATION_CRITERIA.map((category, idx) => (
              <motion.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
              >
                <Card className="bg-[#1a1b1e]/60 backdrop-blur-3xl border border-white/5 rounded-3xl overflow-hidden border-l border-t group hover:border-white/10 transition-all">
                  <CardHeader className="p-8 pb-4">
                    <div className="flex items-center gap-4 mb-4">
                      <div className="p-3 rounded-xl bg-black/40 border border-white/5 group-hover:scale-110 transition-transform">
                        {category.icon}
                      </div>
                      <CardTitle className="text-lg font-black text-white italic tracking-tight">{category.category}</CardTitle>
                    </div>
                  </CardHeader>
                  <CardContent className="p-8 pt-2 space-y-4">
                    {category.items.map((item, i) => (
                      <div key={i} className="flex items-start justify-between p-4 bg-white/[0.02] rounded-xl border border-white/5 hover:bg-white/[0.04] transition-colors">
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-1">
                            {item.required && <Badge className="bg-rose-500/10 text-rose-400 border border-rose-500/20 text-[8px] font-black tracking-widest italic px-2 py-0.5">REQUIRED</Badge>}
                            <span className="text-xs font-black text-white italic tracking-wide">{item.name}</span>
                          </div>
                          <p className="text-[10px] font-bold text-emerald-400 italic tracking-wide">{item.benefit}</p>
                        </div>
                        <span className="text-[10px] font-black text-slate-500 italic">{item.time}</span>
                      </div>
                    ))}
                  </CardContent>
                </Card>
              </motion.div>
            ))}
          </div>
        </section>

        {/* ─── TRAVEL PURPOSES ─────────────────────────────────────────── */}
        <section>
          <motion.div initial={{ opacity: 0 }} whileInView={{ opacity: 1 }} viewport={{ once: true }} className="text-center mb-16 space-y-4">
            <Badge className="bg-purple-500/10 text-purple-400 border border-purple-500/20 px-4 py-1 text-[9px] font-black tracking-widest italic">
              PERSONALIZATION
            </Badge>
            <h2 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">
              Tell Us Your Purpose
            </h2>
            <p className="text-slate-500 max-w-2xl mx-auto font-bold italic tracking-wide">
              Your travel purpose helps us match you with the perfect property and provide personalized recommendations.
            </p>
          </motion.div>

          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {TRAVEL_PURPOSES.map((purpose, idx) => (
              <motion.div
                key={idx}
                custom={idx}
                initial="hidden"
                whileInView="visible"
                viewport={{ once: true }}
                variants={fadeUp}
                className="bg-[#1a1b1e]/60 backdrop-blur-3xl border border-white/5 rounded-3xl p-6 text-center hover:border-white/10 transition-all group cursor-pointer border-l border-t"
              >
                <div className="p-3 rounded-xl bg-purple-500/10 border border-purple-500/20 flex items-center justify-center text-purple-400 mx-auto mb-4 group-hover:scale-110 transition-transform">
                  {purpose.icon}
                </div>
                <h3 className="text-xs font-black text-white italic tracking-tight mb-2">{purpose.label}</h3>
                <p className="text-[10px] font-bold text-slate-500 italic leading-relaxed">{purpose.description}</p>
              </motion.div>
            ))}
          </div>
        </section>

        {/* ─── CTA SECTION ─────────────────────────────────────────────── */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center space-y-8"
        >
          <Zap className="w-12 h-12 text-white/20 mx-auto" />
          <h2 className="text-3xl md:text-5xl font-black text-white italic tracking-tighter">
            Ready to Get Started?
          </h2>
          <p className="text-slate-500 max-w-xl mx-auto font-bold italic tracking-wide text-sm">
            Begin your verification journey in just 2 minutes. Browse properties, save favorites, and unlock benefits as you go.
          </p>
          <div className="flex flex-wrap justify-center gap-4 pt-4">
            <Button
              onClick={() => window.location.href = "/properties"}
              className="h-14 px-10 rounded-2xl bg-white text-black hover:bg-slate-200 font-black tracking-widest text-xs"
            >
              Start Browsing <ArrowRight className="w-4 h-4 ml-2" />
            </Button>
            <Button
              variant="outline"
              onClick={() => window.location.href = "/short-term-rental-safety"}
              className="h-14 px-10 rounded-2xl border-white/10 bg-white/5 text-white hover:bg-white/10 font-black tracking-widest text-xs"
            >
              Learn About Security
            </Button>
          </div>
        </motion.section>
      </main>

      <CTA />
    </div>
  );
}
