import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { Sparkles, Building, Users, DollarSign, Brain, Video, TrendingUp, Shield, Home, Search, MapPin, Calculator } from "lucide-react";
import { m } from "framer-motion";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
const services = [{
  icon: Brain,
  title: t("client.src.ai_price_predictions"),
  description: t("client.src.get_instant_aipowered_property"),
  color: "text-purple-500",
  bgColor: "bg-purple-500/10",
  featured: true
}, {
  icon: Video,
  title: t("client.src.video_vendor_network"),
  description: t("client.src.connect_with_professional_videographers"),
  color: "text-blue-500",
  bgColor: "bg-blue-500/10",
  featured: true
}, {
  icon: TrendingUp,
  title: t("client.src.market_intelligence"),
  description: t("client.src.realtime_market_insights_and"),
  color: "text-green-500",
  bgColor: "bg-green-500/10",
  featured: true
}, {
  icon: Shield,
  title: t("client.src.ownership_verification"),
  description: t("client.src.blockchainverified_property_ownership_for"),
  color: "text-orange-500",
  bgColor: "bg-orange-500/10",
  featured: true
}, {
  icon: Sparkles,
  title: t("client.src.ai_virtual_staging"),
  description: t("client.src.transform_empty_spaces_into"),
  color: "text-purple-500",
  bgColor: "bg-purple-500/10"
}, {
  icon: Building,
  title: t("client.src.property_management"),
  description: t("client.src.complete_tools_for_managing"),
  color: "text-blue-500",
  bgColor: "bg-blue-500/10"
}, {
  icon: Users,
  title: t("client.src.lead_generation"),
  description: t("client.src.aipowered_lead_scoring_and"),
  color: "text-green-500",
  bgColor: "bg-green-500/10"
}, {
  icon: DollarSign,
  title: t("client.src.financial_tools"),
  description: t("client.src.track_commissions_escrow_and"),
  color: "text-orange-500",
  bgColor: "bg-orange-500/10"
}, {
  icon: Home,
  title: t("client.src.vacation_rentals"),
  description: t("client.src.manage_shortterm_rentals_with"),
  color: "text-blue-500",
  bgColor: "bg-blue-500/10"
}, {
  icon: Search,
  title: t("client.src.advanced_search"),
  description: t("client.src.aipowered_property_search_with"),
  color: "text-indigo-500",
  bgColor: "bg-indigo-500/10"
}, {
  icon: MapPin,
  title: t("client.src.location_analytics"),
  description: t("client.src.deep_location_insights_and"),
  color: "text-pink-500",
  bgColor: "bg-pink-500/10"
}, {
  icon: Calculator,
  title: t("client.src.investment_analysis"),
  description: t("client.src.roi_calculations_and_investment"),
  color: "text-yellow-500",
  bgColor: "bg-yellow-500/10"
}];
export function Services() {
  const {
    t
  } = useTranslation();
  return <section className="py-24 px-4 md:px-6 container mx-auto">
      <div className="text-center mb-16">
        <h2 className="text-2xl md:text-3xl font-medium tracking-wide mb-4">{t("client.src.aipowered_real_estate_platform")}</h2>
        <p className="text-xl text-muted-foreground max-w-3xl mx-auto">{t("client.src.from_instant_ai_valuations")}</p>
      </div>

      <div className="space-y-12">
        {/* Featured Services */}
        <div>
          <div className="text-center mb-8">
            <h3 className="text-2xl font-bold mb-2">{t("client.src.core_services")}</h3>
            <p className="text-muted-foreground">{t("client.src.our_aipowered_flagship_features")}</p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {services.filter(s => s.featured).map((service, index) => <m.div key={index} initial={{
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
                <Card className="h-full hover:shadow-lg transition-shadow border-primary/20">
                  <CardHeader>
                    <div className={`w-12 h-12 rounded-lg ${service.bgColor} flex items-center justify-center mb-4`}>
                      <service.icon className={`w-6 h-6 ${service.color}`} />
                    </div>
                    <CardTitle className="text-xl">{service.title}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <CardDescription className="text-base">
                      {service.description}
                    </CardDescription>
                  </CardContent>
                </Card>
              </m.div>)}
          </div>
        </div>

        {/* All Services */}
        <div>
          <div className="text-center mb-8">
            <h3 className="text-2xl font-bold mb-2">{t("client.src.complete_platform_features")}</h3>
            <p className="text-muted-foreground">{t("client.src.everything_you_need_for")}</p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {services.filter(s => !s.featured).map((service, index) => <m.div key={index} initial={{
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
                    <div className={`w-12 h-12 rounded-lg ${service.bgColor} flex items-center justify-center mb-4`}>
                      <service.icon className={`w-6 h-6 ${service.color}`} />
                    </div>
                    <CardTitle className="text-xl">{service.title}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <CardDescription className="text-base">
                      {service.description}
                    </CardDescription>
                  </CardContent>
                </Card>
              </m.div>)}
          </div>
        </div>
      </div>
    </section>;
}