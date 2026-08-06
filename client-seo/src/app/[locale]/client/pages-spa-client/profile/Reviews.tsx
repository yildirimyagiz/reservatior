"use client";

import { useState } from "react";
import { 
  Star, 
  MessageSquare, 
  Building,
  CheckCircle2,
  AlertCircle,
  ArrowLeft,
  Activity,
  Zap,
  MessageCircle,
  Quote
} from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
import { useTranslation } from "react-i18next";
import { useNavigate } from "@/lib/react-router-shim";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";

export default function Reviews() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState("received");

  const reviews = [
    {
      id: "1",
      user: { name: "Sarah Miller", avatar: "SM" },
      property: "Luxury Villa in Beverly Hills",
      rating: 5,
      comment: "Absolutely stunning property! The video tour was very accurate and the communication with the agent was top-notch.",
      date: "2 days ago",
      type: "received"
    },
    {
      id: "2",
      user: { name: "Robert Wilson", avatar: "RW" },
      property: "Modern Apartment in Downtown",
      rating: 4,
      comment: "The place is great, exactly as described. Only issue was a slight delay in the key handoff.",
      date: "1 week ago",
      type: "received"
    },
    {
      id: "3",
      user: { name: "Agent John", avatar: "AJ" },
      property: "Cozy Studio in Brooklyn",
      rating: 5,
      comment: "Excellent tenant, very responsive and kept the property in perfect condition.",
      date: "2 weeks ago",
      type: "given"
    }
  ];

  const renderStars = (rating: number) => {
    return Array.from({ length: 5 }).map((_, i) => (
      <Star 
        key={i} 
        className={cn(
          "w-3.5 h-3.5 transition-all duration-500",
          i < rating ? 'fill-blue-500 text-brand shadow-[0_0_10px_rgba(59,130,246,0.3)]' : 'text-foreground'
        )} 
      />
    ));
  };

  return (
    <div className="min-h-screen bg-background p-8 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-brand/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

      <div className="max-w-5xl mx-auto space-y-12 relative z-10">
        {/* Header HUD */}
        <m.div 
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col md:flex-row md:items-center justify-between gap-8"
        >
          <div className="flex items-center gap-8">
            <Button
              variant="ghost"
              size="sm"
              onClick={() => navigate(-1)}
              className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-muted-foreground font-black italic text-[10px] tracking-[0.25em] transition-all group"
            >
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t('back')}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="space-y-1">
              <h1 className="text-4xl font-black italic tracking-tighter leading-none text-white">{t('reviewsTitle')}</h1>
              <p className="text-[10px] font-black text-muted-foreground tracking-[0.3em] italic">{t('reviewsSubtitle')}</p>
            </div>
          </div>

          <m.div 
             initial={{ opacity: 0, scale: 0.95 }}
             animate={{ opacity: 1, scale: 1 }}
             className="px-8 py-5 bg-card/60 border border-white/10 rounded-[32px] backdrop-blur-3xl shadow-3xl flex items-center gap-8"
          >
            <div className="space-y-1 text-center">
               <p className="text-[10px] font-black text-muted-foreground italic tracking-widest leading-none">{t('ratingTitle')}</p>
               <div className="flex items-center gap-4">
                  <span className="text-4xl font-black text-white italic tracking-tighter leading-none">4.9</span>
                  <div className="flex gap-1">{renderStars(5)}</div>
               </div>
            </div>
            <Separator orientation="vertical" className="h-12 bg-white/5" />
            <div className="space-y-1">
               <p className="text-[10px] font-black text-brand italic tracking-widest leading-none">{t('reviewCount', { count: 128 })}</p>
               <p className="text-[10px] font-black text-success italic tracking-widest leading-none">{t('newThisMonth', { count: 12 })}</p>
            </div>
          </m.div>
        </m.div>

        <Tabs defaultValue="received" onValueChange={setActiveTab} className="space-y-10">
          <TabsList className="bg-card/60 p-2 border border-white/5 h-16 w-full md:w-fit rounded-2xl backdrop-blur-xl">
            <TabsTrigger value="received" className="rounded-xl data-[state=active]:bg-blue-600 data-[state=active]:text-white px-10 h-full text-[10px] font-black italic tracking-widest transition-all shadow-2xl">
              {t('received')}
            </TabsTrigger>
            <TabsTrigger value="given" className="rounded-xl data-[state=active]:bg-blue-600 data-[state=active]:text-white px-10 h-full text-[10px] font-black italic tracking-widest transition-all shadow-2xl">
              {t('given')}
            </TabsTrigger>
          </TabsList>

          <div className="grid gap-8">
            <AnimatePresence mode="popLayout">
              {reviews
                .filter(r => r.type === activeTab)
                .map((review, index) => (
                  <m.div
                    key={review.id}
                    layout
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, scale: 0.95 }}
                    transition={{ delay: index * 0.1 }}
                  >
                    <Card className="bg-card/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden backdrop-blur-3xl group hover:bg-white/5 transition-all shadow-2xl relative">
                       <div className="absolute top-0 left-0 w-full h-full opacity-[0.02] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
                       
                       <CardContent className="p-10 relative z-10">
                        <div className="flex flex-col md:flex-row gap-12">
                          <div className="flex md:flex-col items-center md:items-start gap-6">
                            <div className="relative group/avatar">
                               <div className="absolute inset-0 bg-brand/20 blur-xl opacity-0 group-hover/avatar:opacity-100 transition-opacity" />
                               <Avatar className="w-20 h-20 border border-white/10 shadow-2xl ring-4 ring-blue-500/5 hov">
                                <AvatarFallback className="bg-background text-brand font-black italic text-xl">{review.user.avatar}</AvatarFallback>
                              </Avatar>
                            </div>
                            <div className="space-y-1">
                              <p className="font-black text-white italic tracking-tighter text-xl leading-none">{review.user.name}</p>
                              <p className="text-[10px] font-black text-muted-foreground italic tracking-widest leading-none">{review.date}</p>
                            </div>
                          </div>
                          
                          <div className="flex-1 space-y-6">
                            <div className="flex flex-wrap items-center justify-between gap-6">
                              <div className="flex gap-1.5">{renderStars(review.rating)}</div>
                              <Badge className="bg-blue-600/10 text-brand border border-blue-500/20 text-[8px] font-black italic tracking-widest px-4 py-2 rounded-full gap-2 shadow-xl">
                                <Building className="w-3.5 h-3.5" />
                                {review.property}
                              </Badge>
                            </div>
                            
                            <div className="relative group/quote">
                               <Quote className="absolute -top-4 -left-6 w-12 h-12 text-white/5 -rotate-12 transition-transform group-hover/quote:scale-110" />
                               <p className="text-xl font-black text-muted-foreground leading-tight italic tracking-tight relative z-10 ml-2">
                                 &quot;{review.comment}&quot;
                               </p>
                            </div>
                            
                            <div className="flex flex-wrap items-center gap-8 pt-4">
                              <Button variant="ghost" className="h-10 px-0 hover:bg-transparent text-muted-foreground hover:text-brand text-[10px] font-black italic tracking-widest flex items-center gap-3 transition-colors">
                                <MessageCircle className="w-5 h-5 opacity-40 group-hover:opacity-100" />
                                {t('reply')}
                              </Button>
                              <Button variant="ghost" className="h-10 px-0 hover:bg-transparent text-muted-foreground hover:text-red-500 text-[10px] font-black italic tracking-widest flex items-center gap-3 transition-colors">
                                <AlertCircle className="w-5 h-5 opacity-40 group-hover:opacity-100" />
                                {t('report')}
                              </Button>
                              
                              {activeTab === 'received' && (
                                <div className="ml-auto flex items-center gap-3 px-6 py-2.5 bg-success/10 border border-success/20 rounded-full shadow-2xl">
                                  <div className="h-4 w-4 rounded-full bg-success/20 flex items-center justify-center">
                                     <CheckCircle2 className="w-3 h-3 text-success" />
                                  </div>
                                  <span className="text-[10px] font-black text-success italic tracking-widest">{t('reviewsVerified')}</span>
                                </div>
                              )}
                            </div>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  </m.div>
                ))}
            </AnimatePresence>
            
            {reviews.filter(r => r.type === activeTab).length === 0 && (
               <m.div 
                 initial={{ opacity: 0 }}
                 animate={{ opacity: 1 }}
                 className="text-center py-24 bg-card/40 rounded-[64px] border-2 border-dashed border-white/5"
               >
                 <Zap className="w-12 h-12 text-foreground mx-auto mb-6" />
                 <p className="text-[10px] font-black text-muted-foreground italic tracking-widest">{t('noReviews')}</p>
               </m.div>
            )}
          </div>
        </Tabs>
      </div>
    </div>
  );
}
