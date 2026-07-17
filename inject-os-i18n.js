const fs = require('fs');
const path = require('path');

const localesDir = path.join(__dirname, 'client-seo', 'public', 'locales');
const locales = fs.readdirSync(localesDir).filter(f => f.endsWith('.json'));

const newKeys = {
  "agent_os.total_leads": "Total Leads Handled",
  "agent_os.leads_trend": "+28 this week",
  "agent_os.avg_response": "Avg Response Latency",
  "agent_os.sla_compliant": "SLA compliant",
  "agent_os.conversion_rate": "Conversion Rate",
  "agent_os.conversion_trend": "vs 28% industry avg",
  "agent_os.commission_revenue": "Commission Revenue",
  "agent_os.revenue_trend": "+14.7% vs last month",
  "agent_os.title": "Agent OS",
  "agent_os.subtitle": "Behavioral Data Intake · Commission Engine · AI Decision Graph",
  "agent_os.monitoring": "MONITORING",
  "agent_os.revenue_chart_title": "Commission Revenue Stream (7d)",
  "agent_os.revenue_chart_desc": "Daily revenue contribution from closed agent deals.",
  "agent_os.revenue": "Revenue",
  "agent_os.commissions": "Commissions",
  "agent_os.matrix_title": "Behavioral Score Matrix",
  "agent_os.matrix_desc": "Live AI signals feeding into the Revenue DAG.",

  "booking_os.title": "Booking OS Dashboard",
  "booking_os.subtitle": "Reservations & Live Operations",
  "booking_os.active_bookings": "Active Bookings",
  "booking_os.confirmed_checked_in": "Confirmed & Checked-In",
  "booking_os.pending_check_ins": "Pending Check-Ins",
  "booking_os.arriving_today": "Arriving today",
  "booking_os.pending_check_outs": "Pending Check-Outs",
  "booking_os.departing_today": "Departing today",
  "booking_os.todays_revenue": "Today's Revenue",
  "booking_os.from_financial_records": "From Financial Records",
  "booking_os.live_ops_feed": "Live Operations Feed",
  "booking_os.live_ops_feed_desc": "Real-time status updates from smart locks and property IoT.",
  "booking_os.loading_feed": "Loading feed...",
  "booking_os.no_live_ops": "No live operations today.",
  "booking_os.property": "Property",
  "booking_os.access_granted": "Access granted successfully.",
  "booking_os.access_failed": "Access attempt failed.",
  "booking_os.pricing_engine": "Pricing Engine",
  "booking_os.pricing_engine_desc": "AI optimized dynamic pricing trends over time.",
  "booking_os.loading_pricing": "Loading pricing data...",
  "booking_os.no_pricing": "No pricing data available.",
  "booking_os.base_rate": "Base Rate",
  "booking_os.optimized_rate": "Optimized Rate",

  "finance_os.total_escrow_value": "Total Escrow Value",
  "finance_os.escrow_sub": "Locked in smart state machine",
  "finance_os.pending_payouts": "Pending Payouts",
  "finance_os.payouts_sub": "Ready for settlement",
  "finance_os.active_contracts": "Active Contracts",
  "finance_os.contracts_sub": "State machine currently active",
  "finance_os.contracts_trend": "+3 this week",
  "finance_os.title": "Finance OS",
  "finance_os.subtitle": "Settlement Truth · Escrow Engine · Revenue DAG",
  "finance_os.live": "LIVE",
  "finance_os.revenue_stream": "Revenue Execution Stream",
  "finance_os.revenue_stream_desc": "Real-time settlement data feeding from the DAG.",
  "finance_os.settlement": "Settlement",
  "finance_os.recent_disbursements": "Recent Disbursements",
  "finance_os.recent_disbursements_desc": "Latest funds released from escrow."
};

locales.forEach(locale => {
  const filePath = path.join(localesDir, locale);
  try {
    const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    
    // Add keys only if they don't exist
    let modified = false;
    for (const [key, value] of Object.entries(newKeys)) {
      if (!data[key]) {
        data[key] = value; // Defaulting to english for now to prevent app break
        modified = true;
      }
    }
    
    if (modified) {
      fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
      console.log(`Updated ${locale}`);
    } else {
      console.log(`${locale} is already up to date`);
    }
  } catch(e) {
    console.error(`Error processing ${locale}:`, e);
  }
});
