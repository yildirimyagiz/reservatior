import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { Brain, Video, TrendingUp, Shield, Zap, Users, DollarSign, Target } from "lucide-react";
import { m } from "framer-motion";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
const features = [{
  icon: Brain,
  title: t("client.src.ai_price_predictions"),
  description: t("client.src.instant_property_valuations_with"),
  highlights: ["Instant Results", "95%+ Accuracy", "Market Analysis"],
  color: "text-brand",
  bgColor: "bg-brand/10",
  featured: true
}, {
  icon: Video,
  title: t("client.src.video_vendor_network"),
  description: t("client.src.connect_with_professional_videographers"),
  highlights: ["Professional Videos", "Virtual Tours", "Quick Turnaround"],
  color: "text-brand",
  bgColor: "bg-brand/10",
  featured: true
}, {
  icon: TrendingUp,
  title: t("client.src.market_intelligence"),
  description: t("client.src.realtime_market_insights_and"),
  highlights: ["Live Data", "Trend Analysis", "Investment Insights"],
  color: "text-blue-500",
  bgColor: "bg-blue-500/10",
  featured: true
}, {
  icon: Shield,
  title: t("client.src.ownership_verification"),
  description: t("client.src.blockchainverified_property_ownership_for"),
  highlights: ["Blockchain Security", "Fraud Prevention", "Instant Verification"],
  color: "text-orange-500",
  bgColor: "bg-warning/10",
  featured: true
}, {
  icon: Zap,
  title: t("client.src.lead_generation"),
  description: t("client.src.aipowered_lead_scoring_and"),
  highlights: ["AI Scoring", "Conversion Tracking", "Automated Follow-up"],
  color: "text-yellow-500",
  bgColor: "bg-yellow-500/10"
}, {
  icon: Users,
  title: t("client.src.agent_collaboration"),
  description: t("client.src.team_management_tools_for"),
  highlights: ["Team Management", "Commission Tracking", "Performance Analytics"],
  color: "text-brand",
  bgColor: "bg-brand/10"
}, {
  icon: DollarSign,
  title: t("client.src.financial_management"),
  description: t("client.src.complete_financial_tools_for"),
  highlights: ["Transaction Management", "Escrow Services", "Financial Reports"],
  color: "text-success",
  bgColor: "bg-success/10"
}, {
  icon: Target,
  title: t("client.src.vacation_rentals"),
  description: t("client.src.automated_booking_system_with"),
  highlights: ["AI Pricing", "Automated Booking", "Revenue Optimization"],
  color: "text-pink-500",
  bgColor: "bg-pink-500/10"
}];
export function Features() {
  const {
    t
  } = useTranslation();
  return <section className="py-24 px-4 md:px-6 bg-gradient-to-b from-background to-secondary/20">
      <div className="container mx-auto">
        <div className="text-center mb-16">
          <Badge className="mb-4">{t("client.src.platform_features")}</Badge>
          <h2 className="text-2xl md:text-3xl font-medium tracking-wide mb-4">{t("client.src.everything_you_need_for")}</h2>
          <p className="text-xl text-muted-foreground max-w-3xl mx-auto">{t("client.src.our_comprehensive_platform_combines")}</p>
        </div>

        <div className="space-y-16">
          {/* Featured Features */}
          <div>
            <div className="text-center mb-12">
              <h3 className="text-2xl font-bold mb-2">{t("client.src.core_ai_features")}</h3>
              <p className="text-muted-foreground">{t("client.src.our_flagship_aipowered_capabilities")}</p>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              {features.filter(f => f.featured).map((feature, index) => <m.div key={index} initial={{
              opacity: 0,
              y: 20
            }} whileInView={{
              opacity: 1,
              y: 0
            }} viewport={{
              once: true
            }} transition={{
              delay: index * 0.1
            }}>
                  <Card className="h-full hover:shadow-lg transition-all duration-300 border-primary/20 bg-gradient-to-br from-card to-card/50">
                    <CardHeader className="pb-4">
                      <div className="flex items-start justify-between">
                        <div className={`w-16 h-16 rounded-2xl ${feature.bgColor} flex items-center justify-center mb-4`}>
                          <feature.icon className={`w-8 h-8 ${feature.color}`} />
                        </div>
                        <Badge variant="secondary">{t("client.src.ai_powered")}</Badge>
                      </div>
                      <CardTitle className="text-2xl">{feature.title}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <CardDescription className="text-lg leading-relaxed">
                        {feature.description}
                      </CardDescription>
                      <div className="flex flex-wrap gap-2">
                        {feature.highlights.map((highlight, idx) => <Badge key={idx} variant="outline" className="text-xs">
                            {highlight}
                          </Badge>)}
                      </div>
                    </CardContent>
                  </Card>
                </m.div>)}
            </div>
          </div>

          {/* Additional Features */}
          <div>
            <div className="text-center mb-12">
              <h3 className="text-2xl font-bold mb-2">{t("client.src.complete_platform_features")}</h3>
              <p className="text-muted-foreground">{t("client.src.additional_tools_to_enhance")}</p>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              {features.filter(f => !f.featured).map((feature, index) => <m.div key={index} initial={{
              opacity: 0,
              y: 20
            }} whileInView={{
              opacity: 1,
              y: 0
            }} viewport={{
              once: true
            }} transition={{
              delay: index * 0.05
            }}>
                  <Card className="h-full hover:shadow-lg transition-shadow">
                    <CardHeader>
                      <div className={`w-12 h-12 rounded-lg ${feature.bgColor} flex items-center justify-center mb-4`}>
                        <feature.icon className={`w-6 h-6 ${feature.color}`} />
                      </div>
                      <CardTitle className="text-lg">{feature.title}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <CardDescription className="text-sm leading-relaxed">
                        {feature.description}
                      </CardDescription>
                      <div className="flex flex-wrap gap-1 mt-3">
                        {feature.highlights.slice(0, 2).map((highlight, idx) => <Badge key={idx} variant="outline" className="text-xs">
                            {highlight}
                          </Badge>)}
                      </div>
                    </CardContent>
                  </Card>
                </m.div>)}
            </div>
          </div>
        </div>

        {/* Stats Section */}
        <div className="mt-24 text-center">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <m.div initial={{
            opacity: 0,
            scale: 0.9
          }} whileInView={{
            opacity: 1,
            scale: 1
          }} viewport={{
            once: true
          }}>
              <div className="text-4xl font-bold text-primary mb-2">95%</div>
              <div className="text-muted-foreground">{t("client.src.ai_prediction_accuracy")}</div>
            </m.div>
            <m.div initial={{
            opacity: 0,
            scale: 0.9
          }} whileInView={{
            opacity: 1,
            scale: 1
          }} viewport={{
            once: true
          }} transition={{
            delay: 0.1
          }}>
              <div className="text-4xl font-bold text-primary mb-2">500+</div>
              <div className="text-muted-foreground">{t("client.src.video_vendors")}</div>
            </m.div>
            <m.div initial={{
            opacity: 0,
            scale: 0.9
          }} whileInView={{
            opacity: 1,
            scale: 1
          }} viewport={{
            once: true
          }} transition={{
            delay: 0.2
          }}>
              <div className="text-4xl font-bold text-primary mb-2">{t("client.src.1m")}</div>
              <div className="text-muted-foreground">{t("client.src.properties_analyzed")}</div>
            </m.div>
            <m.div initial={{
            opacity: 0,
            scale: 0.9
          }} whileInView={{
            opacity: 1,
            scale: 1
          }} viewport={{
            once: true
          }} transition={{
            delay: 0.3
          }}>
              <div className="text-4xl font-bold text-primary mb-2">24/7</div>
              <div className="text-muted-foreground">{t("client.src.ai_support")}</div>
            </m.div>
          </div>
        </div>
      </div>
    </section>;
}