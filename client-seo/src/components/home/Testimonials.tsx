import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Star, Quote } from "lucide-react";
import { useState } from "react";
export default function Testimonials() {
  const {
    t
  } = useTranslation();
  const [activeTestimonial, setActiveTestimonial] = useState(0);
  const testimonials = [{
    id: 1,
    name: "Sarah Johnson",
    role: "Property Manager",
    company: "Sunset Properties LLC",
    avatar: "SJ",
    rating: 5,
    content: "This platform has completely transformed how we manage our properties. The AI insights alone have increased our ROI by 35% in just 6 months.",
    metrics: {
      roi: "+35%",
      time: "-80%",
      satisfaction: "98%"
    },
    category: "Property Management"
  }, {
    id: 2,
    name: "Michael Chen",
    role: "Real Estate Investor",
    company: "Urban Investments Inc",
    avatar: "MC",
    rating: 5,
    content: "The predictive analytics and market insights are game-changers. I can now make investment decisions with confidence, knowing I have data-driven insights.",
    metrics: {
      roi: "+42%",
      accuracy: "94%",
      properties: "150+"
    },
    category: "Investment"
  }, {
    id: 3,
    name: "Emily Rodriguez",
    role: "Portfolio Manager",
    company: "Ocean View Management",
    avatar: "ER",
    rating: 5,
    content: "The automation features have saved us countless hours. What used to take days now takes minutes. Our team can focus on growth instead of paperwork.",
    metrics: {
      time: "-90%",
      efficiency: "+300%",
      growth: "+25%"
    },
    category: "Portfolio Management"
  }, {
    id: 4,
    name: "David Kim",
    role: "CEO",
    company: "Metro Real Estate Group",
    avatar: "DK",
    rating: 5,
    content: "Best investment we've made in our tech stack. The platform integrates seamlessly with our existing tools and provides insights we never had before.",
    metrics: {
      integration: "100%",
      insights: "+200%",
      revenue: "+28%"
    },
    category: "Enterprise"
  }];
  const categories = ["All", "Property Management", "Investment", "Portfolio Management", "Enterprise"];
  const [selectedCategory, setSelectedCategory] = useState("All");
  const filteredTestimonials = selectedCategory === "All" ? testimonials : testimonials.filter(t => t.category === selectedCategory);
  return <section className="py-20 bg-gradient-to-b from-white to-gray-50">
      <div className="container mx-auto px-6">
        <div className="text-center mb-16">
          <Badge className="mb-4">{t("client.src.customer_success_stories")}</Badge>
          <h2 className="text-4xl font-bold mb-4">{t("client.src.trusted_by")}<span className="text-brand">{t("client.src.industry_leaders")}</span>
          </h2>
          <p className="text-xl text-muted-foreground max-w-3xl mx-auto">{t("client.src.see_how_real_estate")}</p>
        </div>

        {/* Category Filter */}
        <div className="flex justify-center mb-12">
          <div className="inline-flex bg-card rounded-lg shadow-sm border p-1">
            {categories.map(category => <button key={category} onClick={() => setSelectedCategory(category)} className={`px-4 py-2 rounded-md text-sm font-medium transition-all ${selectedCategory === category ? "bg-brand text-white" : "text-muted-foreground hover:text-foreground"}`}>
                {category}
              </button>)}
          </div>
        </div>

        {/* Main Testimonial Display */}
        <div className="grid lg:grid-cols-3 gap-8 mb-16">
          <div className="lg:col-span-2">
            <Card className="h-full bg-gradient-to-br from-brand to-pink-50 border-purple-200">
              <CardContent className="p-8 h-full flex flex-col justify-between">
                <div>
                  <Quote className="w-12 h-12 text-brand mb-6" />
                  <p className="text-xl text-foreground leading-relaxed mb-8">
                    {filteredTestimonials[activeTestimonial].content}
                  </p>
                  
                  <div className="flex items-center gap-4 mb-8">
                    <div className="w-16 h-16 rounded-full bg-gradient-to-br from-brand to-pink-600 flex items-center justify-center text-white font-bold text-xl">
                      {filteredTestimonials[activeTestimonial].avatar}
                    </div>
                    <div>
                      <p className="font-semibold text-foreground">
                        {filteredTestimonials[activeTestimonial].name}
                      </p>
                      <p className="text-muted-foreground">
                        {filteredTestimonials[activeTestimonial].role}{t("client.src.at")}{filteredTestimonials[activeTestimonial].company}
                      </p>
                      <div className="flex items-center gap-1 mt-1">
                        {[...Array(filteredTestimonials[activeTestimonial].rating)].map((_, i) => <Star key={i} className="w-4 h-4 fill-yellow-400 text-yellow-400" />)}
                      </div>
                    </div>
                  </div>
                </div>

                {/* Metrics */}
                <div className="grid grid-cols-3 gap-4 pt-6 border-t border-purple-200">
                  {Object.entries(filteredTestimonials[activeTestimonial].metrics).map(([key, value]) => <div key={key} className="text-center">
                      <p className="text-2xl font-bold text-brand">{value}</p>
                      <p className="text-sm text-muted-foreground capitalize">{key}</p>
                    </div>)}
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Testimonial List */}
          <div className="space-y-4">
            {filteredTestimonials.map((testimonial, index) => <Card key={testimonial.id} className={`cursor-pointer transition-all ${activeTestimonial === index ? "ring-2 ring-purple-600 bg-brand/10" : "hover:shadow-md"}`} onClick={() => setActiveTestimonial(index)}>
                <CardContent className="p-6">
                  <div className="flex items-start gap-4">
                    <div className="w-12 h-12 rounded-full bg-gradient-to-br from-brand to-pink-600 flex items-center justify-center text-white font-bold flex-shrink-0">
                      {testimonial.avatar}
                    </div>
                    <div className="flex-1">
                      <p className="font-semibold text-foreground">{testimonial.name}</p>
                      <p className="text-sm text-muted-foreground mb-2">{testimonial.role}</p>
                      <p className="text-sm text-muted-foreground line-clamp-3">{testimonial.content}</p>
                      <div className="flex items-center justify-between mt-3">
                        <div className="flex items-center gap-1">
                          {[...Array(testimonial.rating)].map((_, i) => <Star key={i} className="w-3 h-3 fill-yellow-400 text-yellow-400" />)}
                        </div>
                        <Badge variant="outline" className="text-xs">
                          {testimonial.category}
                        </Badge>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>)}
          </div>
        </div>

        {/* Overall Stats */}
        <div className="bg-gradient-to-r from-brand to-pink-600 rounded-3xl p-8 text-white text-center">
          <h3 className="text-2xl font-bold mb-8">{t("client.src.join_5000_real_estate")}</h3>
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-8">
            {[{
            value: "5,000+",
            label: t("client.src.active_users")
          }, {
            value: "$2.5B+",
            label: t("client.src.properties_managed")
          }, {
            value: "98%",
            label: t("client.src.satisfaction_rate")
          }, {
            value: "35%",
            label: t("client.src.average_roi_increase")
          }].map((stat, i) => <div key={i}>
                <p className="text-3xl font-bold mb-1">{stat.value}</p>
                <p className="text-brand">{stat.label}</p>
              </div>)}
          </div>
        </div>
      </div>
    </section>;
}