"use client";

import { useState, useRef, useEffect } from "react";
import { MessageSquare, Send, Bot, User, Loader2, TrendingUp, Building2, MapPin } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { MARKET_DATA, CITY_COMPARISONS } from "@/lib/seo/market-data";

interface Message {
  role: "user" | "assistant";
  content: string;
  timestamp: string;
}

const PRESET_QUESTIONS = [
  "What is the best city for property investment?",
  "Compare Dubai vs Istanbul yields",
  "Should I buy with cash or mortgage?",
  "What is a good rental yield?",
  "How do I calculate ROI?",
];

function generateAIResponse(query: string): string {
  const q = query.toLowerCase();

  if (q.includes("best city") || q.includes("where to invest")) {
    return `Based on current market data, here are the top investment cities:

**Dubai, UAE** - 7.2% gross yield, 8.5% appreciation, 0% income tax
**Istanbul, Turkey** - 6.5% gross yield, 35% appreciation (TRY-denominated), citizenship by investment
**Miami, USA** - 5.8% gross yield, 8% appreciation, strong rental demand

For stability + yield: Dubai
For high growth potential: Istanbul
For Western market exposure: Miami`;
  }

  if (q.includes("dubai") && q.includes("istanbul")) {
    return `**Dubai vs Istanbul Comparison:**

| Metric | Dubai | Istanbul |
|--------|-------|----------|
| Gross Yield | 7.2% | 6.5% |
| Appreciation | 8.5%/yr | 35%/yr (TRY) |
| Risk Level | Medium | High |
| Tax | 0% | 15% |
| Citizenship | Golden Visa | Direct Citizenship |
| Currency | AED (pegged to USD) | TRY (volatile) |

**Summary:** Dubai offers stable, dollar-pegged returns with 0% tax. Istanbul offers explosive TRY-denominated growth but with significant currency risk. For conservative investors: Dubai. For risk-tolerant investors: Istanbul.`;
  }

  if (q.includes("cash") && q.includes("mortgage")) {
    return `**Cash vs Mortgage Purchase:**

**Cash Purchase Pros:**
- Higher ROI per dollar invested
- No interest payments
- Complete ownership from day 1
- Better negotiating position

**Mortgage Pros:**
- Leverage: control more property with less capital
- Tax-deductible interest in some jurisdictions
- Preserve capital for other investments
- Can invest in multiple properties

**Rule of thumb:** If mortgage rate < expected appreciation + rental yield, leverage with mortgage. If rates are high (7%+), cash purchases often win.

Current Dubai rates (~4.99%) make mortgages attractive for leveraged returns.`;
  }

  if (q.includes("rental yield") || q.includes("good yield")) {
    return `**What is a good rental yield?**

- **Below 3%**: Overpriced market, likely pure appreciation play
- **3-5%**: Typical for developed cities (London, Paris, NYC)
- **5-7%**: Good yield for balanced markets (Miami, Barcelona)
- **7-10%**: Strong yield markets (Dubai, parts of Istanbul)
- **10%+**: High yield, but verify data - may indicate risk

**Remember:** Gross yield doesn't tell the full story. Always calculate NET yield after:
- Service charges
- Vacancy allowance (5-15%)
- Maintenance
- Management fees
- Mortgage payments

Dubai's 7.2% gross typically becomes 5.8% net after expenses.`;
  }

  if (q.includes("roi") || q.includes("return on investment")) {
    return `**How to Calculate Property ROI:**

**Simple Formula:**
ROI = (Net Annual Income + Appreciation) / Total Investment × 100

**Comprehensive Formula (what our calculator uses):**
1. Annual Rental Income - Vacancy Losses
2. minus Mortgage Payments
3. minus Operating Costs (maintenance, service charges)
4. = Net Cash Flow
5. Add: Property Appreciation over holding period
6. Add: Mortgage Principal Paydown (equity built)
7. Divide by Total Cash Invested

**Example:**
- Purchase: AED 1,500,000 (20% down = AED 300,000)
- Annual Rent: AED 114,000
- Expenses: AED 20,000/year
- Appreciation: 8%/year
- 10-year total ROI: ~180%

Use our calculator for precise projections with your numbers.`;
  }

  if (q.includes("damac")) {
    return `**DAMAC Property Investment Analysis:**

DAMAC Properties is one of Dubai's largest developers with projects across the city.

**Popular Investment Properties:**
- DAMAC Hills: 6-7% yield, family community
- DAMAC Towers by Paramount: 7-8% yield, hotel-managed
- DAMAC Riverside: 8-9% yield, newer development

**Pros:**
- Guaranteed rental returns (some projects)
- Premium finishes and amenities
- Strong brand recognition
- Good resale market

**Cons:**
- Higher service charges than independent properties
- Some projects underperformed historically
- Off-plan risks if under construction

**Recommendation:** Focus on completed projects with established rental track records.`;
  }

  return `Great question! Here's what I can help with:

**Market Analysis:**
- Compare cities (Dubai, Istanbul, London, Miami, Paris)
- District-level yield data
- Market trends and forecasts

**Investment Calculations:**
- ROI calculations
- Rental yield analysis
- Cash flow projections
- Mortgage vs cash comparisons

**Property Intelligence:**
- DAMAC, Emaar, and other developer analysis
- Location scoring
- Risk assessment

Try asking about specific cities, investment strategies, or property comparisons!`;
}

export function InvestmentAIAssistant() {
  const [messages, setMessages] = useState<Message[]>([
    {
      role: "assistant",
      content: "Hello! I'm your Real Estate Investment AI Assistant. I can help you with market analysis, ROI calculations, property comparisons, and investment recommendations. What would you like to know?",
      timestamp: new Date().toISOString(),
    },
  ]);
  const [input, setInput] = useState("");
  const [isTyping, setIsTyping] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  const handleSend = async (text?: string) => {
    const query = text || input;
    if (!query.trim()) return;

    const userMsg: Message = {
      role: "user",
      content: query,
      timestamp: new Date().toISOString(),
    };
    setMessages((prev) => [...prev, userMsg]);
    setInput("");
    setIsTyping(true);

    // Simulate AI delay
    await new Promise((r) => setTimeout(r, 800 + Math.random() * 1200));

    const response = generateAIResponse(query);
    const assistantMsg: Message = {
      role: "assistant",
      content: response,
      timestamp: new Date().toISOString(),
    };
    setMessages((prev) => [...prev, assistantMsg]);
    setIsTyping(false);
  };

  return (
    <div className="max-w-3xl mx-auto">
      <Card className="h-[600px] flex flex-col">
        <CardHeader className="border-b">
          <CardTitle className="flex items-center gap-2">
            <Bot className="w-5 h-5 text-primary" />
            Investment AI Assistant
          </CardTitle>
        </CardHeader>
        <CardContent className="flex-1 overflow-y-auto p-4 space-y-4">
          {messages.map((msg, i) => (
            <div
              key={i}
              className={`flex gap-3 ${msg.role === "user" ? "justify-end" : ""}`}
            >
              {msg.role === "assistant" && (
                <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center shrink-0">
                  <Bot className="w-4 h-4 text-primary" />
                </div>
              )}
              <div
                className={`max-w-[80%] rounded-lg p-3 text-sm ${
                  msg.role === "user"
                    ? "bg-primary text-primary-foreground"
                    : "bg-muted"
                }`}
              >
                <div className="whitespace-pre-wrap">{msg.content}</div>
              </div>
              {msg.role === "user" && (
                <div className="w-8 h-8 rounded-full bg-muted flex items-center justify-center shrink-0">
                  <User className="w-4 h-4" />
                </div>
              )}
            </div>
          ))}
          {isTyping && (
            <div className="flex gap-3">
              <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center shrink-0">
                <Bot className="w-4 h-4 text-primary" />
              </div>
              <div className="bg-muted rounded-lg p-3">
                <Loader2 className="w-4 h-4 animate-spin" />
              </div>
            </div>
          )}
          <div ref={messagesEndRef} />
        </CardContent>
        <div className="border-t p-4">
          {messages.length <= 1 && (
            <div className="flex flex-wrap gap-2 mb-3">
              {PRESET_QUESTIONS.map((q) => (
                <button
                  key={q}
                  onClick={() => handleSend(q)}
                  className="px-3 py-1.5 text-xs rounded-full bg-muted hover:bg-accent transition-colors"
                >
                  {q}
                </button>
              ))}
            </div>
          )}
          <div className="flex gap-2">
            <Input
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyDown={(e) => e.key === "Enter" && handleSend()}
              placeholder="Ask about property investment..."
              disabled={isTyping}
            />
            <Button onClick={() => handleSend()} disabled={isTyping || !input.trim()}>
              <Send className="w-4 h-4" />
            </Button>
          </div>
        </div>
      </Card>
    </div>
  );
}
