import Image from "next/image";
import { useTranslation } from "react-i18next";
import { m } from "framer-motion";
import { Play, Wand2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Link } from "wouter";
import { propertiesApi } from "@/lib/api/properties";
import { useQuery } from "@tanstack/react-query";
import { useLanguage } from "@/lib/languages";
export function Hero() {
  const {
    t
  } = useLanguage();
  const {
    data: propertiesData
  } = useQuery({
    queryKey: ["/api/properties"],
    queryFn: () => propertiesApi.getAll()
  });
  const featuredProp = propertiesData && propertiesData.length > 0 ? propertiesData[0] : null;
  const coverImage = featuredProp?.photos?.find(p => p.isPrimary)?.url || featuredProp?.photos?.[0]?.url || "";
  if (!featuredProp) {
    return <div className="relative min-h-screen flex items-center justify-center overflow-hidden pt-20 bg-background">
        <div className="text-center text-muted-foreground">{t("client.src.loading")}</div>
      </div>;
  }
  return <div className="relative min-h-screen flex items-center justify-center overflow-hidden pt-20">
      {/* Background with Overlay */}
      <div className="absolute inset-0 z-0">
        <Image src={coverImage} alt={t("client.src.hero_background")} fill className="object-cover" sizes="(max-width: 768px) 100vw, (max-width: 1200px) 100vw, 1920px" priority fetchPriority="high" />
        <div className="absolute inset-0 bg-gradient-to-t from-background via-background/80 to-background/40" />
        <div className="absolute inset-0 bg-black/40" />
      </div>

      {/* Content */}
      <div className="container relative z-10 px-4 md:px-6 flex flex-col items-center text-center max-w-4xl mx-auto">
        <m.div initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        duration: 0.6
      }}>
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/10 border border-white/20 backdrop-blur-md mb-6">
            <span className="flex h-2 w-2 rounded-full bg-green-500 animate-pulse" />
            <span className="text-xs font-medium text-white/90">
              {t("hero.new")}
            </span>
          </div>
        </m.div>

        <m.h1 initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        duration: 0.6,
        delay: 0.1
      }} className="text-4xl md:text-6xl lg:text-7xl font-display font-bold text-white leading-[1.1] tracking-tight mb-6">
          {t("hero.title")}
        </m.h1>

        <m.p initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        duration: 0.6,
        delay: 0.2
      }} className="text-lg md:text-xl text-gray-300 max-w-2xl mb-10">
          {t("heroSubtitle")}
        </m.p>

        <m.div initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        duration: 0.6,
        delay: 0.3
      }} className="flex flex-col sm:flex-row gap-4 w-full sm:w-auto">
          <Link href={`/stage/${featuredProp.id}`}>
            <Button data-testid="button-demo" size="lg" className="h-12 px-8 rounded-full text-base bg-white text-black hover:bg-gray-200 border-0">
              <Play className="mr-2 h-4 w-4 fill-current" />
              {t("cta.demo")}
            </Button>
          </Link>
          <Link href="/studio">
            <Button data-testid="button-create" size="lg" variant="outline" className="h-12 px-8 rounded-full text-base backdrop-blur-md bg-white/5 border-white/20 text-white hover:bg-white/10 hover:text-white">
              <Wand2 className="mr-2 h-4 w-4" />
              {t("cta.create")}
            </Button>
          </Link>
        </m.div>
      </div>

      {/* Decorative Bottom Fade */}
      <div className="absolute bottom-0 inset-x-0 h-32 bg-gradient-to-t from-background to-transparent z-10" />
    </div>;
}