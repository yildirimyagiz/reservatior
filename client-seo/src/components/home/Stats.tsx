import { t } from "i18next";
import { Building, Users, Calendar, TrendingUp } from "lucide-react";
import { m } from "framer-motion";
const stats = [{
  icon: Building,
  label: t("client.src.properties_listed"),
  value: "50,000+",
  color: "text-blue-500"
}, {
  icon: Users,
  label: t("client.src.active_users"),
  value: "10,000+",
  color: "text-green-500"
}, {
  icon: Calendar,
  label: t("client.src.bookings_this_month"),
  value: "2,500+",
  color: "text-purple-500"
}, {
  icon: TrendingUp,
  label: t("client.src.success_rate"),
  value: "98%",
  color: "text-orange-500"
}];
export function Stats() {
  return <section className="py-16 px-4 md:px-6 bg-primary/5 border-y border-border">
      <div className="container mx-auto">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
          {stats.map((stat, index) => <m.div key={index} initial={{
          opacity: 0,
          scale: 0.9
        }} whileInView={{
          opacity: 1,
          scale: 1
        }} viewport={{
          once: true
        }} transition={{
          delay: index * 0.1
        }} className="text-center">
              <div className={`w-12 h-12 rounded-full bg-background flex items-center justify-center mx-auto mb-4 shadow-sm`}>
                <stat.icon className={`w-6 h-6 ${stat.color}`} />
              </div>
              <div className="text-3xl font-bold mb-2">{stat.value}</div>
              <div className="text-sm text-muted-foreground">{stat.label}</div>
            </m.div>)}
        </div>
      </div>
    </section>;
}