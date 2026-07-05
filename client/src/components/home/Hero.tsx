import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ArrowRight, Play, Star, CheckCircle, PlusCircle, Sparkles } from "lucide-react";
import { useState } from "react";
import { ListingManagementDialog } from "./ListingManagementDialog";
import { useTranslation } from "react-i18next";
import { Link } from "react-router-dom";
export default function Hero() {
  const {
    t
  } = useTranslation();
  const [activeFeature, setActiveFeature] = useState(0);
  const features = [{
    title: t('aiAnalytics'),
    description: t('aiAnalyticsDesc'),
    icon: "🤖",
    stats: t('accuracy94')
  }, {
    title: t('realTime'),
    description: t('realTimeDesc'),
    icon: "📊",
    stats: t('liveData')
  }, {
    title: t('automation'),
    description: t('automationDesc'),
    icon: "⚡",
    stats: t('save80Time')
  }];
  return <section className="relative min-h-screen bg-background text-foreground overflow-hidden flex items-center transition-colors duration-300">
      {/* Background Pattern */}
      <div className="absolute inset-0 bg-black/5 dark:bg-black/20"></div>
      <div className="absolute inset-0">
        <div className="absolute top-0 left-0 w-full h-full bg-linear-to-b from-transparent to-background/50"></div>
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-blue-600 rounded-full filter blur-[120px] opacity-10 dark:opacity-20 animate-pulse"></div>
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-slate-500 rounded-full filter blur-[120px] opacity-5 dark:opacity-10 animate-pulse delay-1000"></div>
      </div>

      <div className="relative z-10 container mx-auto px-6 py-20 mt-16">
        <div className="grid lg:grid-cols-2 gap-12 items-center">
          {/* Left Content */}
          <div className="space-y-8">
            <div className="space-y-4">
              <Badge className="bg-blue-600/10 text-blue-600 dark:text-blue-400 border border-blue-600/20 px-3 py-1 rounded-full text-sm font-medium">
                🚀 {t('heroBadge')}
              </Badge>
              <h1 className="text-3xl lg:text-5xl font-display font-medium leading-[1.2] tracking-wide text-foreground">
                {t('title1')}
                <span className="block text-transparent bg-clip-text bg-linear-to-r from-blue-600 to-blue-500 dark:from-blue-400 dark:to-blue-400 mt-2">
                  {t('title2')}
                </span>
              </h1>
              <p className="text-xl text-muted-foreground leading-relaxed font-medium max-w-lg">
                {t('heroSubtitle')}
              </p>
            </div>

            <div className="flex flex-wrap gap-4">
              <Link to="/auth/signup" className="contents">
                <Button size="lg" className="h-12 px-8 bg-blue-600 hover:bg-blue-700 text-white rounded-xl shadow-lg shadow-blue-600/20 font-bold uppercase italic tracking-widest text-[10px]">
                  {t('Get Started')}
                  <ArrowRight className="w-5 h-5 ml-2" />
                </Button>
              </Link>
              <ListingManagementDialog>
                <Button size="lg" variant="outline" className="h-12 px-8 border-blue-600/30 bg-blue-600/5 hover:bg-blue-600/10 text-foreground rounded-xl font-bold uppercase italic tracking-widest text-[10px] gap-2">
                  <PlusCircle className="w-4 h-4 text-blue-500" />
                  {t('listManage')}
                </Button>
              </ListingManagementDialog>
              <Link to="/trust" className="contents">
                <Button size="lg" variant="ghost" className="h-12 px-8 text-foreground rounded-xl font-bold uppercase italic tracking-widest text-[10px] hover:bg-accent/50 group">
                  <Play className="w-5 h-5 mr-2 text-blue-500 group-hover:scale-110 transition-transform" />
                  {t('watchDemo')}
                </Button>
              </Link>
            </div>

            <div className="flex items-center gap-8 pt-4">
              <div className="flex -space-x-4">
                {[1, 2, 3, 4, 5].map(i => <div key={i} className="w-10 h-10 rounded-full bg-muted border-2 border-background flex items-center justify-center text-xs font-bold text-muted-foreground">
                    {i}
                  </div>)}
              </div>
              <div>
                <div className="flex items-center gap-1">
                  {[1, 2, 3, 4, 5].map(i => <Star key={i} className="w-4 h-4 fill-yellow-400 text-yellow-400" />)}
                </div>
                <p className="text-sm text-muted-foreground">
                  <span className="text-foreground font-semibold">5,000+</span> {t('happyCustomers')}
                </p>
              </div>
            </div>
          </div>

          {/* Right Content - Interactive Feature Showcase */}
          <div className="relative">
            <div className="bg-card/80 backdrop-blur-xl rounded-[32px] p-8 border border-border dark:border-slate-800/50 shadow-2xl">
              <div className="space-y-6">
                <div className="flex gap-2">
                  {features.map((feature, index) => <button key={index} onClick={() => setActiveFeature(index)} className={`px-4 py-2 rounded-lg text-sm font-medium transition-all ${activeFeature === index ? "bg-primary text-primary-foreground" : "bg-muted text-muted-foreground hover:bg-accent/50"}`}>
                      {feature.icon} {feature.title}
                    </button>)}
                </div>

                <div className="bg-background/50 dark:bg-[#14151a] rounded-2xl p-6 border border-border dark:border-slate-800/50">
                  <div className="flex items-center justify-between mb-4">
                    <h3 className="text-xl font-semibold text-foreground">{features[activeFeature].title}</h3>
                    <Badge className="bg-green-500/10 text-green-600 dark:text-green-400 border border-green-500/20">
                      {features[activeFeature].stats}
                    </Badge>
                  </div>
                  <p className="text-muted-foreground mb-6 font-medium">{features[activeFeature].description}</p>
                  
                  <div className="space-y-3">
                    {(t('heroFeatures', {
                    returnObjects: true
                  }) as string[]).map((item, i) => <div key={i} className="flex items-center gap-3">
                        <CheckCircle className="w-5 h-5 text-blue-500" />
                        <span className="text-sm text-foreground/80 font-medium">{item}</span>
                      </div>)}
                  </div>
                </div>
              </div>
            </div>

            {/* Floating Cards */}
            <div className="absolute -top-4 -right-4 bg-blue-600 rounded-2xl p-4 shadow-2xl shadow-blue-600/20 border border-blue-500/30 animate-bounce">
              <div className="text-white">
                <p className="text-2xl font-bold">89%</p>
                <p className="text-xs">{t('roiIncrease')}</p>
              </div>
            </div>

            <div className="absolute -bottom-4 -left-4 bg-muted/80 backdrop-blur-md rounded-2xl p-4 shadow-2xl border border-border animate-bounce delay-500">
              <div className="text-foreground">
                <p className="text-2xl font-bold text-blue-500">{t("client.src.25x")}</p>
                <p className="text-xs text-muted-foreground">{t('fasterGrowth')}</p>
              </div>
            </div>
          </div>
        </div>

        {/* Bottom Stats */}
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-6 mt-20 border-t border-border dark:border-slate-800/50 pt-10">
          {[{
          value: "$2.5M+",
          label: t('propertiesManaged')
        }, {
          value: "15K+",
          label: t('activeUsers')
        }, {
          value: "98%",
          label: t('satisfactionRate')
        }, {
          value: "24/7",
          label: t('supportAvailable')
        }].map((stat, i) => <div key={i} className="text-center">
              <p className="text-2xl font-display font-medium text-foreground mb-2">
                {stat.value}
              </p>
              <p className="text-muted-foreground text-sm font-medium uppercase tracking-wider">{stat.label}</p>
            </div>)}
        </div>
      </div>
    </section>;
}