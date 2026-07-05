/**
 * App Router Migration Script
 * 
 * Step 1: Add "use client" to all pages-spa components that use hooks
 * Step 2: Rewrite (spa)/[route]/page.tsx as server components with metadata
 */

import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");
const PAGES_SPA = path.join(ROOT, "src/pages-spa");
const SPA_ROUTES = path.join(ROOT, "src/app/[locale]/(spa)");

// ─── Route → Metadata mapping ───────────────────────────────────────────────
function routeToTitle(route) {
  return route
    .replace(/-/g, " ")
    .replace(/\b\w/g, c => c.toUpperCase())
    .replace(/\bAi\b/g, "AI")
    .replace(/\bApi\b/g, "API")
    .replace(/\bMls\b/g, "MLS")
    .replace(/\bCrm\b/g, "CRM")
    .replace(/\bSeo\b/g, "SEO")
    .replace(/\bId\b/g, "ID")
    .replace(/\bOs\b/g, "OS")
    .replace(/\b1099\b/g, "1099");
}

const META_OVERRIDES = {
  "agencies":             { title: "Agencies", desc: "Manage real estate agencies and partnerships on Reservatior." },
  "analytics":            { title: "Analytics Dashboard", desc: "Comprehensive analytics and insights for your real estate portfolio." },
  "ai-studio":            { title: "AI Studio", desc: "Powerful AI tools for property analysis, OCR, translation and video processing." },
  "ai-dashboard":         { title: "AI Dashboard", desc: "Monitor and manage AI models and automation systems." },
  "ai-valuation":         { title: "AI Valuation", desc: "AI-powered property valuation and market analysis tools." },
  "bookings":             { title: "Bookings", desc: "Manage all property bookings, reservations and scheduling." },
  "calendar":             { title: "Calendar", desc: "Manage availability, appointments and property scheduling." },
  "contracts":            { title: "Contracts", desc: "Digital contract management with e-signatures and automation." },
  "dashboard":            { title: "Dashboard", desc: "Your Reservatior dashboard — overview of properties, bookings and performance." },
  "explore":              { title: "Explore Properties", desc: "Discover premium properties worldwide with AI-powered search." },
  "financial":            { title: "Financial Overview", desc: "Track revenues, expenses, payouts and financial performance." },
  "leases":               { title: "Leases", desc: "Manage tenancy agreements, lease renewals and rent schedules." },
  "listings":             { title: "My Listings", desc: "Manage your active property listings across all channels." },
  "maintenance":          { title: "Maintenance", desc: "Schedule and track property maintenance tasks and work orders." },
  "messages":             { title: "Messages", desc: "Communicate with guests, tenants and team members." },
  "payments":             { title: "Payments", desc: "Process payments, view transaction history and manage payouts." },
  "pricing":              { title: "Pricing Plans", desc: "Flexible pricing plans for property managers, agents and investors." },
  "properties":           { title: "Properties", desc: "Browse and manage your property portfolio on Reservatior." },
  "reservations":         { title: "Reservations", desc: "Track and manage all property reservations and check-ins." },
  "settings":             { title: "Settings", desc: "Configure your Reservatior account, notifications and preferences." },
  "tenants":              { title: "Tenants", desc: "Manage tenant profiles, applications and communications." },
  "contact":              { title: "Contact Us", desc: "Get in touch with the Reservatior team for support and inquiries." },
  "login":                { title: "Sign In", desc: "Sign in to your Reservatior account." },
  "signup":               { title: "Get Started", desc: "Create your Reservatior account and start managing properties." },
  "privacy":              { title: "Privacy Policy", desc: "Reservatior's privacy policy and data protection information." },
  "terms":                { title: "Terms of Service", desc: "Reservatior's terms of service and usage agreements." },
  "trust-center":         { title: "Trust & Safety Center", desc: "Our commitment to security, safety and verified listings." },
  "escrow":               { title: "Escrow Management", desc: "Secure escrow accounts for property transactions and deposits." },
  "loyalty":              { title: "Loyalty & Rewards", desc: "Earn and redeem loyalty points across the Reservatior platform." },
  "marketplace":          { title: "Marketplace", desc: "Discover services, integrations and tools for property professionals." },
  "agent-os":             { title: "Agent OS", desc: "Comprehensive agent management and performance tracking system." },
  "finance-os":           { title: "Finance OS", desc: "Complete financial operating system for real estate portfolios." },
  "booking-os":           { title: "Booking OS", desc: "Centralized booking management and reservation operating system." },
  "listing-os":           { title: "Listing OS", desc: "Property listing management and inventory operating system." },
};

// ─── Step 1: Add "use client" to pages-spa components ───────────────────────
function addUseClientToSpa() {
  let added = 0, skipped = 0;
  
  function walk(dir) {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    for (const entry of entries) {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) { walk(full); continue; }
      if (!entry.name.endsWith(".tsx") && !entry.name.endsWith(".ts")) continue;
      
      const content = fs.readFileSync(full, "utf-8");
      
      // Skip layout/context files that should remain flexible
      if (entry.name.includes("Layout") || entry.name.includes("Provider") || entry.name.includes("Context")) {
        skipped++;
        continue;
      }
      
      // Skip if already has "use client"
      if (content.startsWith('"use client"') || content.startsWith("'use client'")) {
        skipped++;
        continue;
      }
      
      // Only add if it uses hooks (client-only APIs)
      const usesHooks = /\buse(State|Effect|Ref|Query|Mutation|Callback|Memo|Router|Toast|Context|Translation|Params|PathName|InView|Search|Scroll|IntersectionObserver)\b/.test(content);
      const usesBrowserAPI = /\bwindow\b|\bdocument\b|\blocalStorage\b|\bnavigator\b/.test(content);
      
      if (usesHooks || usesBrowserAPI) {
        fs.writeFileSync(full, '"use client";\n\n' + content);
        added++;
      } else {
        skipped++;
      }
    }
  }
  
  walk(PAGES_SPA);
  console.log(`✅ Step 1 done: added "use client" to ${added} files (${skipped} skipped)`);
}

// ─── Step 2: Rewrite page.tsx as proper server components ───────────────────
function rewritePageTsx() {
  let updated = 0, skipped = 0;
  
  function walkRoutes(dir, routePrefix = "") {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    
    for (const entry of entries) {
      const full = path.join(dir, entry.name);
      
      if (entry.isDirectory()) {
        const segment = entry.name.replace(/^\(|\)$/g, ""); // strip route group parens
        walkRoutes(full, routePrefix ? `${routePrefix}/${entry.name}` : entry.name);
        continue;
      }
      
      if (entry.name !== "page.tsx") continue;
      
      const content = fs.readFileSync(full, "utf-8");
      
      // Skip files that already have metadata (already migrated)
      if (content.includes("export const metadata") || content.includes("export const revalidate")) {
        skipped++;
        continue;
      }
      
      // Skip redirects — they're already server components
      if (content.includes("redirect(") && !content.includes("import Component")) {
        skipped++;
        continue;
      }
      
      // Extract component import path
      const importMatch = content.match(/import Component from ["'](@\/pages-spa\/[^"']+)["']/);
      if (!importMatch) {
        skipped++;
        continue;
      }
      
      const componentPath = importMatch[1];
      
      // Derive route name from directory path
      const relativePath = path.relative(SPA_ROUTES, path.dirname(full));
      const routeParts = relativePath.split(path.sep).filter(p => p && !p.startsWith("["));
      const routeName = routeParts[routeParts.length - 1] || "page";
      
      const override = META_OVERRIDES[routeName];
      const title = override?.title || routeToTitle(routeName);
      const desc = override?.desc || `Manage ${title.toLowerCase()} on the Reservatior platform.`;
      
      // Write new server component page
      const newContent = `import type { Metadata } from "next";
import dynamic from "next/dynamic";

export const metadata: Metadata = {
  title: "${title} | Reservatior",
  description: "${desc}",
  openGraph: {
    title: "${title} | Reservatior",
    description: "${desc}",
    type: "website",
  },
};

export const revalidate = 3600;

const PageContent = dynamic(
  () => import("${componentPath}"),
  { ssr: false }
);

export default function Page(props: any) {
  return <PageContent {...props} />;
}
`;
      
      fs.writeFileSync(full, newContent);
      updated++;
    }
  }
  
  walkRoutes(SPA_ROUTES);
  console.log(`✅ Step 2 done: rewrote ${updated} page.tsx as server components (${skipped} skipped)`);
}

// ─── Run ────────────────────────────────────────────────────────────────────
console.log("🚀 Starting App Router migration...\n");
addUseClientToSpa();
rewritePageTsx();
console.log("\n✅ Migration complete!");
