"use client";

import { useState } from "react";
import Link from "next/link";
import {
  Home,
  Calculator,
  FileText,
  ShoppingBag,
  Key,
  CheckCircle,
  ArrowRight,
  Shield,
  TrendingUp,
  Building2,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

const CONVERSION_STEPS = [
  {
    icon: Calculator,
    title: "Analyze",
    desc: "Use our ROI calculator to evaluate investment potential",
    href: "/investment-os/roi-calculator",
  },
  {
    icon: FileText,
    title: "Report",
    desc: "Generate AI-powered investment report with recommendations",
    href: "/investment-os/reports",
  },
  {
    icon: ShoppingBag,
    title: "Purchase",
    desc: "Find and purchase your investment property",
    href: "/client/property-search",
  },
  {
    icon: Key,
    title: "Manage",
    desc: "Let us manage your property with guaranteed occupancy",
    href: "/investment-os/rental-management",
  },
];

const MANAGEMENT_FEATURES = [
  "Tenant screening & verification",
  "Rent collection & accounting",
  "Maintenance coordination",
  "24/7 guest support",
  "Channel management (Airbnb, Booking.com)",
  "Financial reporting & tax summaries",
  "Property inspections",
  "Legal compliance",
];

export function RentalManagementConversion() {
  return (
    <div className="max-w-5xl mx-auto px-4 py-12">
      {/* Conversion Flow */}
      <div className="text-center mb-10">
        <Badge variant="outline" className="mb-3">Complete Investment Journey</Badge>
        <h2 className="text-3xl font-bold mb-3">
          From Analysis to <span className="text-gradient">Property Management</span>
        </h2>
        <p className="text-muted-foreground max-w-xl mx-auto">
          One platform for the entire property investment lifecycle.
          Analyze, purchase, and manage — all with Reservatior.
        </p>
      </div>

      <div className="grid md:grid-cols-4 gap-4 mb-12">
        {CONVERSION_STEPS.map((step, i) => (
          <div key={step.title} className="relative">
            <Link href={step.href}>
              <Card className="hover:border-primary/50 transition-colors cursor-pointer h-full">
                <CardContent className="p-5 text-center">
                  <div className="w-12 h-12 rounded-full bg-primary/20 flex items-center justify-center mx-auto mb-3">
                    <step.icon className="w-6 h-6 text-primary" />
                  </div>
                  <Badge className="mb-2">Step {i + 1}</Badge>
                  <h3 className="font-bold text-lg mb-1">{step.title}</h3>
                  <p className="text-sm text-muted-foreground">{step.desc}</p>
                </CardContent>
              </Card>
            </Link>
            {i < CONVERSION_STEPS.length - 1 && (
              <div className="hidden md:flex absolute top-1/2 -right-4 -translate-y-1/2 z-10">
                <ArrowRight className="w-5 h-5 text-muted-foreground" />
              </div>
            )}
          </div>
        ))}
      </div>

      {/* Management CTA */}
      <Card className="border-primary/30 bg-primary/5">
        <CardContent className="p-8 md:p-12">
          <div className="grid md:grid-cols-2 gap-8 items-center">
            <div>
              <div className="flex items-center gap-2 mb-4">
                <Home className="w-6 h-6 text-primary" />
                <h3 className="text-2xl font-bold">Rental Management OS</h3>
              </div>
              <p className="text-muted-foreground mb-6">
                After your investment analysis and property purchase, let our full-service
                rental management handle everything. From tenant screening to maintenance,
                we maximize your returns while minimizing your involvement.
              </p>
              <ul className="space-y-2 mb-6">
                {MANAGEMENT_FEATURES.map((f) => (
                  <li key={f} className="flex items-center gap-2 text-sm">
                    <CheckCircle className="w-4 h-4 text-success shrink-0" />
                    {f}
                  </li>
                ))}
              </ul>
              <div className="flex gap-3">
                <Link href="/investment-os/rental-management">
                  <Button size="lg">
                    Get Management Quote
                    <ArrowRight className="w-4 h-4 ml-2" />
                  </Button>
                </Link>
                <Link href="/investment-os/roi-calculator">
                  <Button variant="outline" size="lg">
                    <Calculator className="w-4 h-4 mr-2" />
                    Calculate Returns
                  </Button>
                </Link>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              {[
                { label: "Occupancy Rate", value: "95%+", icon: TrendingUp },
                { label: "Avg Management Fee", value: "10-15%", icon: Building2 },
                { label: "Response Time", value: "< 1hr", icon: Shield },
                { label: "Properties Managed", value: "500+", icon: Home },
              ].map((stat) => (
                <div key={stat.label} className="p-4 rounded-lg bg-card border text-center">
                  <stat.icon className="w-5 h-5 mx-auto mb-2 text-primary" />
                  <p className="text-xl font-bold">{stat.value}</p>
                  <p className="text-xs text-muted-foreground">{stat.label}</p>
                </div>
              ))}
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
