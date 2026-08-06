"use client";

import { useTranslation } from "react-i18next";
import { m } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Briefcase, MapPin, Clock, ChevronRight, Users, Globe, Zap } from "lucide-react";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import Link from "next/link";

const jobs = [
  {
    id: "senior-fullstack-engineer",
    title: "Senior Full-Stack Engineer",
    department: "Engineering",
    location: "Remote / Istanbul",
    type: "Full-time",
    description: "Build and scale our AI-powered real estate platform. Work with Next.js, Rust, PostgreSQL, and eBPF security systems.",
  },
  {
    id: "ai-ml-engineer",
    title: "AI/ML Engineer",
    department: "Intelligence",
    location: "Remote",
    type: "Full-time",
    description: "Design and train property valuation models, fraud detection systems, and natural language interfaces for our platform.",
  },
  {
    id: "real-estate-agent",
    title: "Real Estate Agent",
    department: "Operations",
    location: "Istanbul, Turkey",
    type: "Full-time",
    description: "Join our growing real estate team. Manage property listings, client relationships, and deal closures across Istanbul's premium markets.",
  },
  {
    id: "product-designer",
    title: "Product Designer",
    department: "Design",
    location: "Remote",
    type: "Full-time",
    description: "Craft beautiful, intuitive interfaces for our operating system. Own the design process from research to high-fidelity prototypes.",
  },
  {
    id: "devops-engineer",
    title: "DevOps / Platform Engineer",
    department: "Infrastructure",
    location: "Remote",
    type: "Full-time",
    description: "Manage our cloud infrastructure, CI/CD pipelines, and security monitoring. Experience with Kubernetes and Rust preferred.",
  },
  {
    id: "content-strategist",
    title: "Content Strategist",
    department: "Marketing",
    location: "Remote",
    type: "Full-time",
    description: "Develop and execute content strategies across blog, social media, and documentation. Real estate or PropTech experience a plus.",
  },
];

const benefits = [
  { icon: Globe, title: "Remote-First", desc: "Work from anywhere in the world" },
  { icon: Zap, title: "Cutting-Edge Tech", desc: "Rust, eBPF, AI/ML, and more" },
  { icon: Users, title: "Small Team, Big Impact", desc: "Every voice matters at Reservatior" },
];

export function CareersContent() {
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-background text-foreground">
      <AppHeader />

      {/* Hero Section */}
      <section className="relative py-20 px-4">
        <div className="absolute inset-0 z-0">
          <Image
            src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=2070&auto=format&fit=crop"
            alt=""
            fill
            sizes="100vw"
            priority
            className="object-cover"
          />
          <div className="absolute inset-0 bg-gradient-to-b from-black/60 via-black/50 to-background" />
        </div>
        <div className="relative z-10 max-w-6xl mx-auto text-center">
          <h1 className="text-5xl md:text-7xl font-black text-white mb-6 drop-shadow-lg">
            {t("careers.title", { defaultValue: "Join Our Team" })}
          </h1>
          <p className="text-xl md:text-2xl text-white/90 max-w-3xl mx-auto drop-shadow-md">
            {t("careers.subtitle", { defaultValue: "We're building the future of AI-powered real estate. Come shape it with us." })}
          </p>
        </div>
      </section>

      {/* Benefits */}
      <section className="py-16 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="grid md:grid-cols-3 gap-6">
            {benefits.map((b, i) => (
              <m.div key={b.title} initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: i * 0.1 }}
                className="bg-card border border-border rounded-3xl p-8 text-center">
                <b.icon className="w-10 h-10 text-indigo-500 dark:text-indigo-400 mx-auto mb-4" />
                <h3 className="text-xl font-bold mb-2">{b.title}</h3>
                <p className="text-muted-foreground text-sm">{b.desc}</p>
              </m.div>
            ))}
          </div>
        </div>
      </section>

      {/* Job Listings */}
      <section className="py-16 px-4">
        <div className="max-w-4xl mx-auto">
          <h2 className="text-3xl font-black mb-8">
            {t("careers.openings", { defaultValue: "Open Positions" })}
          </h2>
          <div className="space-y-4">
            {jobs.map((job, i) => (
              <m.div key={job.id} initial={{ opacity: 0, x: -20 }} whileInView={{ opacity: 1, x: 0 }} viewport={{ once: true }} transition={{ delay: i * 0.05 }}>
                <Link href={`/careers/${job.id}`} className="block bg-card border border-border rounded-2xl p-6 hover:border-indigo-500/50 hover:shadow-lg transition-all group">
                  <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-2">
                        <Briefcase className="w-5 h-5 text-indigo-500 dark:text-indigo-400" />
                        <h3 className="text-xl font-bold group-hover:text-indigo-500 dark:group-hover:text-indigo-400 transition-colors">{job.title}</h3>
                      </div>
                      <p className="text-muted-foreground text-sm mb-3 line-clamp-2">{job.description}</p>
                      <div className="flex flex-wrap gap-3 text-xs font-medium text-muted-foreground">
                        <span className="flex items-center gap-1"><MapPin className="w-3 h-3" />{job.location}</span>
                        <span className="flex items-center gap-1"><Clock className="w-3 h-3" />{job.type}</span>
                        <span className="px-2 py-0.5 rounded-full bg-indigo-500/10 text-indigo-600 dark:text-indigo-400">{job.department}</span>
                      </div>
                    </div>
                    <ChevronRight className="w-5 h-5 text-muted-foreground group-hover:text-indigo-500 transition-colors hidden md:block" />
                  </div>
                </Link>
              </m.div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-20 px-4">
        <div className="max-w-3xl mx-auto text-center">
          <h2 className="text-3xl md:text-4xl font-black mb-6">
            {t("careers.cta_title", { defaultValue: "Don't see your role?" })}
          </h2>
          <p className="text-muted-foreground text-lg mb-8">
            {t("careers.cta_desc", { defaultValue: "We're always looking for exceptional people. Send us your resume and tell us how you'd contribute." })}
          </p>
          <Button size="lg" className="rounded-full px-8 h-14 bg-primary text-primary-foreground hover:bg-primary/90 font-bold" asChild>
            <a href="mailto:careers@reservatior.com">
              {t("careers.cta_button", { defaultValue: "Send Your Resume" })}
            </a>
          </Button>
        </div>
      </section>

      <Footer />
    </div>
  );
}
