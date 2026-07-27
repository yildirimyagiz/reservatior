#!/usr/bin/env node

/**
 * Intelligence Dashboard Translation Key Generator
 * 
 * Scans intelligence dashboard files for hardcoded English strings,
 * generates translation keys, and adds them to all locale JSON files.
 * 
 * Usage: node scripts/generate-intelligence-translations.mjs
 */

import { readFileSync, writeFileSync, readdirSync } from 'fs';
import { join } from 'path';

const LOCALES_DIR = join(process.cwd(), 'public/locales');
const DASHBOARD_DIRS = [
  'src/app/[locale]/admin/property-passport',
  'src/app/[locale]/admin/market-passport',
  'src/app/[locale]/admin/agent-passport',
  'src/app/[locale]/admin/user-passport',
  'src/app/[locale]/admin/decision-engine',
  'src/app/[locale]/admin/feedback-loop',
  'src/app/[locale]/admin/content-publisher',
  'src/app/[locale]/admin/intelligence-graph',
  'src/app/[locale]/property-intelligence',
  'src/app/[locale]/market-intelligence',
  'src/app/[locale]/investment-calculator',
];

// ── Intelligence Translation Keys ─────────────────────────────────────────
const INTELLIGENCE_TRANSLATIONS = {
  // ── Navigation ──────────────────────────────────────────────────────────
  "nav.intelligence_ai": "Intelligence & AI",
  "nav.property_passport": "Property Passport",
  "nav.market_passport": "Market Passport",
  "nav.user_passport": "User Passport",
  "nav.agent_passport": "Agent Passport",
  "nav.decision_engine": "Decision Engine",
  "nav.feedback_loop": "Feedback Loop",
  "nav.content_publisher": "Content Publisher",
  "nav.revenue_intelligence": "Revenue Intelligence",
  "nav.intelligence_graph": "Intelligence Graph",
  "nav.seo_generator": "SEO Generator",

  // ── Property Passport ───────────────────────────────────────────────────
  "property_passport.title": "Property Passport",
  "property_passport.subtitle": "6-dimensional intelligence profile for every property",
  "property_passport.export": "Export Passport",
  "property_passport.search_placeholder": "Search properties…",
  "property_passport.select_property": "Select a property…",
  "property_passport.empty_title": "Select a property to view its Intelligence Passport",
  "property_passport.empty_subtitle": "Choose from the dropdown above or search by name",
  "property_passport.overall_score": "Overall Score",
  "property_passport.calibration": "Calibration",
  "property_passport.physical_identity": "Physical Identity",
  "property_passport.physical_desc": "Structure, area, rooms, condition",
  "property_passport.financial_identity": "Financial Identity",
  "property_passport.financial_desc": "Valuation, rental yield, ROI",
  "property_passport.market_identity": "Market Identity",
  "property_passport.market_desc": "Demand index, competition, trend",
  "property_passport.investment_identity": "Investment Identity",
  "property_passport.investment_desc": "Cap rate, appreciation, risk",
  "property_passport.lifestyle_identity": "Lifestyle Identity",
  "property_passport.lifestyle_desc": "Walkability, amenities, transit",
  "property_passport.ai_strategy": "AI Strategy",
  "property_passport.ai_strategy_desc": "Content, SEO, pricing decision",
  "property_passport.investment_decision": "Investment Decision",
  "property_passport.recommendation": "Recommendation",
  "property_passport.expected_roi": "Expected ROI",
  "property_passport.risk_level": "Risk Level",
  "property_passport.confidence": "Confidence",
  "property_passport.payback_period": "Payback Period",
  "property_passport.pipeline_status": "Pipeline Status",
  "property_passport.data_collection": "Data Collection",
  "property_passport.analysis_scoring": "Analysis & Scoring",
  "property_passport.digital_twin_generated": "Digital Twin Generated",
  "property_passport.content_generated": "Content Generated",
  "property_passport.published_channels": "Published to 5 Channels",
  "property_passport.feedback_loop": "Feedback Loop",
  "property_passport.learning_updated": "Learning Updated",

  // ── Market Passport ─────────────────────────────────────────────────────
  "market_passport.title": "Market Passport",
  "market_passport.subtitle": "Market-level intelligence with demand, supply, and yield analysis",
  "market_passport.avg_price_sqm": "Avg Price/sqm",
  "market_passport.demand_index": "Demand Index",
  "market_passport.supply_ratio": "Supply Ratio",
  "market_passport.avg_yield": "Avg Yield",
  "market_passport.active_listings": "Active Listings",
  "market_passport.avg_dom": "Avg DOM",
  "market_passport.district_intelligence": "District Intelligence",
  "market_passport.district": "District",
  "market_passport.avg_price": "Avg Price",
  "market_passport.yield": "Yield",
  "market_passport.demand": "Demand",
  "market_passport.trend": "Trend",
  "market_passport.market_health_score": "Market Health Score",
  "market_passport.liquidity": "Liquidity",
  "market_passport.stability": "Stability",
  "market_passport.growth_potential": "Growth Potential",
  "market_passport.risk": "Risk",
  "market_passport.ai_marketing_strategy": "AI Marketing Strategy",
  "market_passport.target_audience": "Target Audience",
  "market_passport.recommended_channels": "Recommended Channels",
  "market_passport.content_focus": "Content Focus",

  // ── Agent Passport ──────────────────────────────────────────────────────
  "agent_passport.title": "Agent Passport",
  "agent_passport.subtitle": "Agent performance intelligence with AI coaching recommendations",
  "agent_passport.search_placeholder": "Search agents…",
  "agent_passport.select_agent": "Select an agent…",
  "agent_passport.empty_title": "Select an agent to view their Intelligence Passport",
  "agent_passport.overall_score": "Overall Score",
  "agent_passport.deals_closed": "Deals Closed",
  "agent_passport.revenue_generated": "Revenue Generated",
  "agent_passport.active_listings": "Active Listings",
  "agent_passport.avg_response": "Avg Response",
  "agent_passport.ranking": "Ranking",
  "agent_passport.performance_radar": "Performance Radar",
  "agent_passport.conversion_rate": "Conversion Rate",
  "agent_passport.response_time": "Response Time",
  "agent_passport.client_satisfaction": "Client Satisfaction",
  "agent_passport.listing_quality": "Listing Quality",
  "agent_passport.market_knowledge": "Market Knowledge",
  "agent_passport.negotiation_skill": "Negotiation Skill",
  "agent_passport.ai_coaching": "AI Coaching",
  "agent_passport.strength": "Strength",
  "agent_passport.opportunity": "Opportunity",
  "agent_passport.action_plan": "Action Plan",
  "agent_passport.territory": "Territory",

  // ── User Passport ───────────────────────────────────────────────────────
  "user_passport.title": "User Passport",
  "user_passport.subtitle": "User intelligence profile with behavior analysis & intent prediction",
  "user_passport.search_placeholder": "Search users…",
  "user_passport.select_user": "Select a user…",
  "user_passport.empty_title": "Select a user to view their Intelligence Passport",
  "user_passport.engagement_score": "Engagement Score",
  "user_passport.properties_viewed": "Properties Viewed",
  "user_passport.saved_properties": "Saved Properties",
  "user_passport.budget_range": "Budget Range",
  "user_passport.intent_score": "Intent Score",
  "user_passport.session_count": "Session Count",
  "user_passport.preferences_ai": "Preferences (AI-inferred)",
  "user_passport.property_type": "Property Type",
  "user_passport.bedrooms": "Bedrooms",
  "user_passport.location": "Location",
  "user_passport.max_budget": "Max Budget",
  "user_passport.min_yield": "Min Yield",
  "user_passport.lifestyle_priority": "Lifestyle Priority",
  "user_passport.intent_signals": "Intent Signals",
  "user_passport.activity_timeline": "Activity Timeline",
  "user_passport.ai_recommendation": "AI Recommendation Engine",
  "user_passport.next_best_action": "Next Best Action",
  "user_passport.predicted_outcome": "Predicted Outcome",
  "user_passport.engagement_tip": "Engagement Tip",

  // ── Decision Engine ─────────────────────────────────────────────────────
  "decision_engine.title": "Decision Engine Console",
  "decision_engine.subtitle": "Live AI decision monitoring — proposal → action → outcome → learning",
  "decision_engine.total_decisions": "Total Decisions",
  "decision_engine.accepted": "Accepted",
  "decision_engine.pending": "Pending",
  "decision_engine.avg_confidence": "Avg Confidence",
  "decision_engine.success_rate": "Success Rate",
  "decision_engine.revenue_impact": "Revenue Impact",
  "decision_engine.recent_decisions": "Recent Decisions",
  "decision_engine.type": "Type",
  "decision_engine.property": "Property",
  "decision_engine.recommendation": "Recommendation",
  "decision_engine.confidence": "Confidence",
  "decision_engine.status": "Status",
  "decision_engine.impact": "Impact",
  "decision_engine.when": "When",
  "decision_engine.lifecycle_flow": "Decision Lifecycle Flow",
  "decision_engine.ai_proposes": "AI Proposes",
  "decision_engine.owner_notified": "Owner Notified",
  "decision_engine.accept_reject": "Accept/Reject",
  "decision_engine.action_executed": "Action Executed",
  "decision_engine.outcome_monitored": "Outcome Monitored",
  "decision_engine.learning_updated": "Learning Updated",
  "decision_engine.all_status": "All Status",
  "decision_engine.price_reduction": "Price Reduction",
  "decision_engine.marketing_boost": "Marketing Boost",
  "decision_engine.listing_refresh": "Listing Refresh",
  "decision_engine.agent_reassignment": "Agent Reassignment",
  "decision_engine.investment_recommendation": "Investment Recommendation",
  "decision_engine.monitoring": "Monitoring",
  "decision_engine.rejected": "Rejected",

  // ── Feedback Loop ───────────────────────────────────────────────────────
  "feedback_loop.title": "Feedback Loop Monitor",
  "feedback_loop.subtitle": "Prediction → Outcome → Calibration → Better Prediction",
  "feedback_loop.total_calibrations": "Total Calibrations",
  "feedback_loop.prediction_accuracy": "Prediction Accuracy",
  "feedback_loop.model_health": "Model Health",
  "feedback_loop.content_refreshes": "Content Refreshes",
  "feedback_loop.upward": "Upward ↑",
  "feedback_loop.downward": "Downward ↓",
  "feedback_loop.price_prediction_accuracy": "Price Prediction Accuracy",
  "feedback_loop.rental_yield_accuracy": "Rental Yield Accuracy",
  "feedback_loop.dom_accuracy": "Days on Market Accuracy",
  "feedback_loop.vs_last_period": "vs last period",
  "feedback_loop.predicted_vs_actual": "Revenue: Predicted vs Actual",
  "feedback_loop.predicted_commission": "Predicted Commission",
  "feedback_loop.actual_commission": "Actual Commission",
  "feedback_loop.predicted_rental": "Predicted Rental",
  "feedback_loop.actual_rental": "Actual Rental",
  "feedback_loop.recent_calibrations": "Recent Calibration Events",
  "feedback_loop.property": "Property",
  "feedback_loop.direction": "Direction",
  "feedback_loop.delta": "Delta",
  "feedback_loop.reason": "Reason",
  "feedback_loop.when": "When",
  "feedback_loop.learning_loop": "Intelligence Learning Loop",

  // ── Content Publisher ───────────────────────────────────────────────────
  "content_publisher.title": "Content Publisher",
  "content_publisher.subtitle": "Multi-channel AI content publishing & SEO performance",
  "content_publisher.published": "Published",
  "content_publisher.pending_review": "Pending Review",
  "content_publisher.active_channels": "Active Channels",
  "content_publisher.avg_seo_score": "Avg SEO Score",
  "content_publisher.total_views": "Total Views",
  "content_publisher.conversion": "Conversion",
  "content_publisher.channel_performance": "Channel Performance",
  "content_publisher.channel": "Channel",
  "content_publisher.views": "Views",
  "content_publisher.seo_score": "SEO Score",
  "content_publisher.recent_content": "Recent Content",
  "content_publisher.title_col": "Title",
  "content_publisher.type": "Type",
  "content_publisher.channels": "Channels",
  "content_publisher.pipeline": "AI Content Pipeline",
  "content_publisher.brief_generated": "Brief Generated",
  "content_publisher.content_created": "Content Created",
  "content_publisher.seo_optimized": "SEO Optimized",
  "content_publisher.review_approve": "Review & Approve",
  "content_publisher.multi_channel_publish": "Multi-Channel Publish",
  "content_publisher.performance_track": "Performance Track",

  // ── Intelligence Graph ──────────────────────────────────────────────────
  "intelligence_graph.title": "Intelligence Graph",
  "intelligence_graph.subtitle": "Saga orchestration observability — pipelines, DLQ, timelines",
  "intelligence_graph.total_sagas": "Total Sagas",
  "intelligence_graph.active_now": "Active Now",
  "intelligence_graph.completed_today": "Completed Today",
  "intelligence_graph.failed_today": "Failed Today",
  "intelligence_graph.dlq_pending": "DLQ Pending",
  "intelligence_graph.pipeline_health": "Pipeline Health",
  "intelligence_graph.overview": "Overview",
  "intelligence_graph.saga_registry": "Saga Registry",
  "intelligence_graph.dead_letter_queue": "Dead Letter Queue",
  "intelligence_graph.timeline": "Timeline",
  "intelligence_graph.platform_architecture": "Platform Architecture",
  "intelligence_graph.intelligence_flow": "Intelligence Flow",
  "intelligence_graph.saga_type": "Saga Type",
  "intelligence_graph.active": "Active",
  "intelligence_graph.completed": "Completed",
  "intelligence_graph.failed": "Failed",
  "intelligence_graph.avg_duration": "Avg Duration",
  "intelligence_graph.pending_dead_letters": "Pending Dead Letters",
  "intelligence_graph.replay_all": "Replay All",
  "intelligence_graph.saga": "Saga",
  "intelligence_graph.step": "Step",
  "intelligence_graph.error": "Error",
  "intelligence_graph.retries": "Retries",
  "intelligence_graph.when": "When",
  "intelligence_graph.actions": "Actions",
  "intelligence_graph.replay": "Replay",
  "intelligence_graph.discard": "Discard",
  "intelligence_graph.entity": "Entity",
  "intelligence_graph.progress": "Progress",
  "intelligence_graph.duration": "Duration",
  "intelligence_graph.status": "Status",

  // ── Public: Property Intelligence ──────────────────────────────────────
  "property_intelligence.title": "Property Intelligence",
  "property_intelligence.subtitle": "AI-powered scoring and analysis for any property",
  "property_intelligence.search_placeholder": "Enter property ID or address…",
  "property_intelligence.analyze": "Analyze",
  "property_intelligence.overall_score": "Overall Intelligence Score",
  "property_intelligence.based_on_dimensions": "Based on 6 AI-analyzed dimensions",
  "property_intelligence.location_score": "Location Score",
  "property_intelligence.location_desc": "Transit, amenities, schools",
  "property_intelligence.value_score": "Value Score",
  "property_intelligence.value_desc": "Price vs comparable properties",
  "property_intelligence.investment_score": "Investment Score",
  "property_intelligence.investment_desc": "ROI potential, appreciation",
  "property_intelligence.lifestyle_score": "Lifestyle Score",
  "property_intelligence.lifestyle_desc": "Quality of life indicators",
  "property_intelligence.growth_score": "Growth Score",
  "property_intelligence.growth_desc": "Area development forecast",
  "property_intelligence.safety_score": "Safety Score",
  "property_intelligence.safety_desc": "Crime rates, security",
  "property_intelligence.ai_insights": "AI Insights",
  "property_intelligence.strengths": "Strengths",
  "property_intelligence.considerations": "Considerations",
  "property_intelligence.investment_outlook": "Investment Outlook",
  "property_intelligence.neighborhood_trend": "Neighborhood Trend",

  // ── Public: Market Intelligence ─────────────────────────────────────────
  "market_intelligence.title": "Market Intelligence",
  "market_intelligence.subtitle": "AI-driven real estate market analysis across global cities",
  "market_intelligence.avg_price_sqm": "Avg Price / sqm",
  "market_intelligence.demand_index": "Demand Index",
  "market_intelligence.avg_rental_yield": "Avg Rental Yield",
  "market_intelligence.active_listings": "Active Listings",
  "market_intelligence.days_on_market": "Days on Market",
  "market_intelligence.price_growth_1y": "Price Growth (1Y)",
  "market_intelligence.zone_analysis": "Zone Analysis",
  "market_intelligence.zone": "Zone",
  "market_intelligence.avg_price": "Avg Price",
  "market_intelligence.yield": "Yield",
  "market_intelligence.demand": "Demand",
  "market_intelligence.growth": "Growth",
  "market_intelligence.ai_market_outlook": "AI Market Outlook",
  "market_intelligence.short_term": "Short-Term (6 months)",
  "market_intelligence.medium_term": "Medium-Term (1-3 years)",
  "market_intelligence.long_term": "Long-Term (5+ years)",

  // ── Public: Investment Calculator ───────────────────────────────────────
  "investment_calculator.title": "Investment Calculator",
  "investment_calculator.subtitle": "AI-powered ROI projections and risk analysis",
  "investment_calculator.parameters": "Investment Parameters",
  "investment_calculator.purchase_price": "Purchase Price",
  "investment_calculator.down_payment": "Down Payment",
  "investment_calculator.interest_rate": "Interest Rate",
  "investment_calculator.loan_term": "Loan Term",
  "investment_calculator.monthly_rent": "Monthly Rent",
  "investment_calculator.annual_appreciation": "Annual Appreciation",
  "investment_calculator.annual_expenses": "Annual Expenses",
  "investment_calculator.vacancy": "Vacancy",
  "investment_calculator.gross_yield": "Gross Yield",
  "investment_calculator.net_yield": "Net Yield",
  "investment_calculator.cap_rate": "Cap Rate",
  "investment_calculator.cash_on_cash": "Cash-on-Cash",
  "investment_calculator.monthly_cashflow": "Monthly Cashflow",
  "investment_calculator.payback_period": "Payback Period",
  "investment_calculator.monthly_breakdown": "Monthly Breakdown",
  "investment_calculator.gross_rent": "Gross Rent",
  "investment_calculator.vacancy_loss": "Vacancy Loss",
  "investment_calculator.expenses": "Expenses",
  "investment_calculator.mortgage_payment": "Mortgage Payment",
  "investment_calculator.net_monthly_cashflow": "Net Monthly Cashflow",
  "investment_calculator.ai_risk_assessment": "AI Risk Assessment",
  "investment_calculator.market_risk": "Market Risk",
  "investment_calculator.cashflow_risk": "Cashflow Risk",
  "investment_calculator.leverage_risk": "Leverage Risk",
  "investment_calculator.interest_rate_risk": "Interest Rate Risk",
  "investment_calculator.vacancy_risk": "Vacancy Risk",
  "investment_calculator.projection_10y": "10-Year Projection",
  "investment_calculator.year": "Year",
  "investment_calculator.property_value": "Property Value",
  "investment_calculator.annual_cashflow": "Annual Cashflow",
  "investment_calculator.cumulative_cashflow": "Cumulative Cashflow",
  "investment_calculator.total_equity": "Total Equity",
  "investment_calculator.total_return": "Total Return",

  // ── Common ──────────────────────────────────────────────────────────────
  "common.export": "Export",
  "common.export_report": "Export Report",
  "common.last_7_days": "Last 7 Days",
  "common.last_30_days": "Last 30 Days",
  "common.last_90_days": "Last 90 Days",
  "common.last_year": "Last Year",
  "common.low": "LOW",
  "common.medium": "MEDIUM",
  "common.high": "HIGH",
  "common.running": "Running",
  "common.completed": "Completed",
  "common.pending": "Pending",
  "common.failed": "Failed",
};

// ── Simple Translation Map for Major Locales ──────────────────────────────
const LOCALE_TRANSLATIONS = {
  tr: {
    "nav.intelligence_ai": "Yapay Zeka & İstihbarat",
    "nav.property_passport": "Mülk Pasaportu",
    "nav.market_passport": "Piyasa Pasaportu",
    "nav.user_passport": "Kullanıcı Pasaportu",
    "nav.agent_passport": "Danışman Pasaportu",
    "nav.decision_engine": "Karar Motoru",
    "nav.feedback_loop": "Geri Bildirim Döngüsü",
    "nav.content_publisher": "İçerik Yayıncı",
    "nav.revenue_intelligence": "Gelir İstihbaratı",
    "nav.intelligence_graph": "İstihbarat Grafiği",
    "nav.seo_generator": "SEO Oluşturucu",
    "property_passport.title": "Mülk Pasaportu",
    "property_passport.subtitle": "Her mülk için 6 boyutlu istihbarat profili",
    "property_passport.overall_score": "Genel Puan",
    "property_passport.physical_identity": "Fiziksel Kimlik",
    "property_passport.financial_identity": "Finansal Kimlik",
    "property_passport.market_identity": "Piyasa Kimliği",
    "property_passport.investment_identity": "Yatırım Kimliği",
    "property_passport.lifestyle_identity": "Yaşam Tarzı Kimliği",
    "property_passport.ai_strategy": "AI Stratejisi",
    "property_passport.investment_decision": "Yatırım Kararı",
    "property_passport.recommendation": "Öneri",
    "property_passport.pipeline_status": "Pipeline Durumu",
    "decision_engine.title": "Karar Motoru Konsolu",
    "decision_engine.subtitle": "Canlı AI karar izleme — öneri → aksiyon → sonuç → öğrenme",
    "feedback_loop.title": "Geri Bildirim Döngüsü İzleyici",
    "feedback_loop.subtitle": "Tahmin → Sonuç → Kalibrasyon → Daha İyi Tahmin",
    "content_publisher.title": "İçerik Yayıncı",
    "content_publisher.subtitle": "Çok kanallı AI içerik yayınlama ve SEO performansı",
    "intelligence_graph.title": "İstihbarat Grafiği",
    "intelligence_graph.subtitle": "Saga orkestrasyon gözlemlenebilirliği",
    "market_passport.title": "Piyasa Pasaportu",
    "agent_passport.title": "Danışman Pasaportu",
    "user_passport.title": "Kullanıcı Pasaportu",
    "investment_calculator.title": "Yatırım Hesaplayıcı",
    "investment_calculator.subtitle": "AI destekli ROI projeksiyonları ve risk analizi",
    "property_intelligence.title": "Mülk İstihbaratı",
    "market_intelligence.title": "Piyasa İstihbaratı",
    "common.export": "Dışa Aktar",
    "common.low": "DÜŞÜK",
    "common.medium": "ORTA",
    "common.high": "YÜKSEK",
    "common.running": "Çalışıyor",
    "common.completed": "Tamamlandı",
    "common.pending": "Beklemede",
    "common.failed": "Başarısız",
  },
  de: {
    "nav.intelligence_ai": "Intelligenz & KI",
    "property_passport.title": "Immobilien-Pass",
    "decision_engine.title": "Entscheidungsmotor-Konsole",
    "feedback_loop.title": "Feedback-Schleife Monitor",
    "content_publisher.title": "Inhalts-Publisher",
    "intelligence_graph.title": "Intelligenz-Graph",
    "investment_calculator.title": "Investitionsrechner",
    "common.export": "Exportieren",
    "common.low": "NIEDRIG",
    "common.medium": "MITTEL",
    "common.high": "HOCH",
  },
  fr: {
    "nav.intelligence_ai": "Intelligence & IA",
    "property_passport.title": "Passeport Immobilier",
    "decision_engine.title": "Console Moteur de Décision",
    "feedback_loop.title": "Moniteur Boucle de Rétroaction",
    "content_publisher.title": "Éditeur de Contenu",
    "intelligence_graph.title": "Graphe d'Intelligence",
    "investment_calculator.title": "Calculateur d'Investissement",
    "common.export": "Exporter",
    "common.low": "FAIBLE",
    "common.medium": "MOYEN",
    "common.high": "ÉLEVÉ",
  },
  es: {
    "nav.intelligence_ai": "Inteligencia & IA",
    "property_passport.title": "Pasaporte de Propiedad",
    "decision_engine.title": "Consola del Motor de Decisiones",
    "feedback_loop.title": "Monitor de Retroalimentación",
    "content_publisher.title": "Publicador de Contenido",
    "intelligence_graph.title": "Gráfico de Inteligencia",
    "investment_calculator.title": "Calculadora de Inversión",
    "common.export": "Exportar",
  },
  ar: {
    "nav.intelligence_ai": "الذكاء والذكاء الاصطناعي",
    "property_passport.title": "جواز سفر العقار",
    "decision_engine.title": "وحدة تحكم محرك القرار",
    "investment_calculator.title": "حاسبة الاستثمار",
    "common.export": "تصدير",
  },
};

// ── Main ──────────────────────────────────────────────────────────────────
function main() {
  const localeFiles = readdirSync(LOCALES_DIR).filter(f => f.endsWith('.json'));
  
  console.log(`\n🔍 Found ${localeFiles.length} locale files`);
  console.log(`📝 Adding ${Object.keys(INTELLIGENCE_TRANSLATIONS).length} intelligence translation keys\n`);

  let totalAdded = 0;

  for (const file of localeFiles) {
    const filePath = join(LOCALES_DIR, file);
    const locale = file.replace('.json', '');
    
    try {
      const content = JSON.parse(readFileSync(filePath, 'utf-8'));
      const existingCount = Object.keys(content).length;
      let addedCount = 0;

      for (const [key, enValue] of Object.entries(INTELLIGENCE_TRANSLATIONS)) {
        if (content[key]) continue; // Skip if key already exists

        // Use locale-specific translation if available, otherwise use English
        const localeTranslations = LOCALE_TRANSLATIONS[locale];
        const value = localeTranslations?.[key] || enValue;
        
        content[key] = value;
        addedCount++;
      }

      if (addedCount > 0) {
        writeFileSync(filePath, JSON.stringify(content, null, 2) + '\n', 'utf-8');
        console.log(`  ✅ ${file}: +${addedCount} keys (${existingCount} → ${existingCount + addedCount})`);
        totalAdded += addedCount;
      } else {
        console.log(`  ⏭️  ${file}: all keys exist, skipped`);
      }
    } catch (err) {
      console.error(`  ❌ ${file}: ${err.message}`);
    }
  }

  console.log(`\n✨ Done! Added ${totalAdded} translation entries across ${localeFiles.length} locales.\n`);

  // ── Summary Report ───────────────────────────────────────────────────────
  console.log('📊 Key Breakdown:');
  const categories = {};
  for (const key of Object.keys(INTELLIGENCE_TRANSLATIONS)) {
    const cat = key.split('.')[0];
    categories[cat] = (categories[cat] || 0) + 1;
  }
  for (const [cat, count] of Object.entries(categories).sort((a, b) => b[1] - a[1])) {
    console.log(`   ${cat}: ${count} keys`);
  }
}

main();
