import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Award, Gift, Star, Users, Zap, CheckCircle2, ChevronRight, Sparkles, Trophy, Target, Heart } from "lucide-react";
import { Progress } from "@/components/ui/progress";
interface LoyaltyAccount {
  points: number;
  level: 'BRONZE' | 'SILVER' | 'GOLD' | 'PLATINUM';
  nextLevelPoints: number;
}
interface Achievement {
  id: string;
  title: string;
  description: string;
  unlockedAt?: string;
  points: number;
  icon: any;
}
const MOCK_ACHIEVEMENTS: Achievement[] = [{
  id: "a1",
  title: t("client.src.first_listing"),
  description: t("client.src.successfully_published_your_first"),
  unlockedAt: "2024-01-10",
  points: 500,
  icon: Sparkles
}, {
  id: "a2",
  title: t("client.src.review_master"),
  description: t("client.src.received_10_fivestar_reviews"),
  unlockedAt: "2024-02-15",
  points: 1200,
  icon: Trophy
}, {
  id: "a3",
  title: t("client.src.quick_responder"),
  description: t("client.src.maintained_1hr_response_time"),
  points: 800,
  icon: Zap
}, {
  id: "a4",
  title: t("client.src.community_star"),
  description: t("client.src.referred_3_new_agents"),
  points: 2000,
  icon: Heart
}];
export default function LoyaltyRewards() {
  const {
    t
  } = useTranslation();
  const [account] = useState<LoyaltyAccount>({
    points: 2450,
    level: 'SILVER',
    nextLevelPoints: 5000
  });
  return <PageShell title={t("client.src.loyalty_rewards")} description={t("client.src.track_your_achievements_earn")}>
      <div className="space-y-6">
        {/* Tier Status Card */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <Card className="lg:col-span-2 bg-linear-to-br from-slate-900 via-slate-800 to-indigo-900 text-white border-none shadow-2xl overflow-hidden relative">
            <div className="absolute top-0 right-0 p-12 opacity-10 rotate-12">
               <Award className="w-64 h-64" />
            </div>
            <CardContent className="p-8 relative z-10">
              <div className="flex justify-between items-start">
                 <div>
                   <Badge className="bg-indigo-500 text-white border-none mb-4 px-4 py-1 text-xs font-black tracking-tighter shadow-lg shadow-indigo-500/20">
                     {account.level}{t("client.src.member")}</Badge>
                   <h2 className="text-5xl font-black tracking-tight">{account.points.toLocaleString()} <span className="text-indigo-400 text-2xl">{t("client.src.points")}</span></h2>
                 </div>
                 <div className="text-right">
                    <p className="text-slate-400 text-xs font-bold tracking-widest mb-1">{t("client.src.status_progress")}</p>
                    <p className="text-sm font-bold">{(account.nextLevelPoints - account.points).toLocaleString()}{t("client.src.more_to")}<span className="text-amber-400 font-black">{t("client.src.gold")}</span></p>
                 </div>
              </div>

              <div className="mt-12 space-y-4">
                 <div className="flex justify-between text-xs font-black text-slate-400">
                    <span>{t("client.src.silver")}</span>
                    <span>{t("client.src.gold")}</span>
                 </div>
                 <Progress value={account.points / account.nextLevelPoints * 100} className="h-3 bg-white/10" />
                 <p className="text-[10px] text-center text-slate-500 font-bold tracking-widest">{t("client.src.maximize_your_reach_to")}</p>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-white border-2 border-slate-100 shadow-xl flex flex-col justify-between overflow-hidden group">
            <CardHeader className="bg-slate-50 border-b pb-4">
               <CardTitle className="text-lg font-black text-slate-800 flex items-center">
                  <Gift className="w-5 h-5 mr-3 text-indigo-600" />{t("client.src.redeems_available")}</CardTitle>
            </CardHeader>
            <CardContent className="pt-6 space-y-4 flex-1">
               <div className="p-4 rounded-2xl bg-indigo-50/50 border border-indigo-100 hover:bg-indigo-50 transition-colors cursor-pointer">
                  <p className="font-black text-indigo-900 text-sm">{t("client.src.50_amazon_gift_card")}</p>
                  <p className="text-xs text-indigo-600 font-bold mt-1">{t("client.src.5000_points_required")}</p>
               </div>
               <div className="p-4 rounded-2xl bg-amber-50/50 border border-amber-100 hover:bg-amber-50 transition-colors cursor-pointer">
                  <p className="font-black text-amber-900 text-sm">{t("client.src.1month_pro_upgrade")}</p>
                  <p className="text-xs text-amber-600 font-bold mt-1">{t("client.src.2500_points_required")}</p>
               </div>
            </CardContent>
            <Button className="m-4 bg-indigo-600 hover:bg-indigo-700 font-black py-6 shadow-lg shadow-indigo-200">{t("client.src.visit_rewards_shop")}</Button>
          </Card>
        </div>

        {/* Missions & Achievements */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
           <div className="space-y-4">
              <h3 className="text-2xl font-black text-slate-800 tracking-tight flex items-center">
                 <Target className="w-6 h-6 mr-3 text-indigo-600" />{t("client.src.active_missions")}</h3>
              <div className="space-y-3">
                 {[1, 2].map(i => <Card key={i} className="border-none shadow-sm bg-slate-50/50 hover:bg-white hover:shadow-md transition-all">
                      <CardContent className="p-5 flex items-center gap-4">
                         <div className="w-12 h-12 bg-white rounded-2xl shadow-sm border flex items-center justify-center">
                            <Zap className="w-6 h-6 text-amber-500" />
                         </div>
                         <div className="flex-1">
                            <p className="font-black text-slate-800 text-sm">{t("client.src.complete_5_checkins")}</p>
                            <Progress value={60} className="h-1.5 mt-2" />
                            <p className="text-[10px] text-slate-400 mt-1 font-bold">{t("client.src.35_completed")}</p>
                         </div>
                         <div className="text-right">
                            <p className="text-xs font-black text-indigo-600">{t("client.src.250_pts")}</p>
                         </div>
                      </CardContent>
                   </Card>)}
              </div>
           </div>

           <div className="space-y-4">
              <h3 className="text-2xl font-black text-slate-800 tracking-tight flex items-center">
                 <Trophy className="w-6 h-6 mr-3 text-amber-500" />{t("client.src.recent_trophies")}</h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                 {MOCK_ACHIEVEMENTS.map(ach => <Card key={ach.id} className={`border-2 transition-all group ${ach.unlockedAt ? 'border-indigo-100 bg-indigo-50/20' : 'border-slate-100 bg-slate-50/20 grayscale opacity-60'}`}>
                      <CardContent className="p-4 flex flex-col items-center text-center h-full">
                         <div className={`w-14 h-14 rounded-full flex items-center justify-center mb-3 shadow-inner ${ach.unlockedAt ? 'bg-white text-indigo-600' : 'bg-slate-200 text-slate-400'}`}>
                            <ach.icon className="w-7 h-7" />
                         </div>
                         <h4 className="font-black text-sm tracking-tighter text-slate-800 group-hover:text-indigo-600 transition-colors">{ach.title}</h4>
                         <p className="text-[10px] text-slate-500 font-medium mt-1 leading-tight">{ach.description}</p>
                         {ach.unlockedAt ? <div className="mt-3 flex items-center text-[10px] font-black text-indigo-500">
                              <CheckCircle2 className="w-3 h-3 mr-1" />{t("client.src.unlocked")}</div> : <div className="mt-3 text-[10px] font-black text-slate-400">
                              {ach.points}{t("client.src.pts_reward")}</div>}
                      </CardContent>
                   </Card>)}
              </div>
           </div>
        </div>

        {/* Earning History */}
        <Card className="border-none shadow-xl bg-white overflow-hidden">
           <CardHeader className="border-b bg-slate-50/50 px-8 py-6">
              <div className="flex justify-between items-center">
                 <CardTitle className="text-xl font-black text-slate-800 tracking-tighter">{t("client.src.earnings_history")}</CardTitle>
                 <Button variant="ghost" size="sm" className="font-black text-xs text-indigo-600">{t("client.src.view_all_activities")}<ChevronRight className="w-4 h-4 ml-1" /></Button>
              </div>
           </CardHeader>
           <CardContent className="p-0">
               <div className="divide-y">
                  {[{
              type: 'REFERRAL',
              desc: 'Successful referral: Mark Stevenson',
              pts: '+2000',
              date: 'Today'
            }, {
              type: 'BOOKING',
              desc: 'Guest Check-in: Sunset Heights',
              pts: '+50',
              date: 'Yesterday'
            }, {
              type: 'REVIEW',
              desc: '5-Star Review received',
              pts: '+100',
              date: 'March 24'
            }].map((row, i) => <div key={i} className="flex items-center justify-between px-8 py-5 hover:bg-slate-50/50 transition-colors">
                       <div className="flex items-center gap-4">
                          <div className={`p-2 rounded-xl ${row.type === 'REFERRAL' ? 'bg-indigo-100 text-indigo-600' : 'bg-emerald-100 text-emerald-600'}`}>
                             {row.type === 'REFERRAL' ? <Users className="w-5 h-5" /> : <Star className="w-5 h-5" />}
                          </div>
                          <div>
                             <p className="font-black text-slate-800 text-sm tracking-tight">{row.desc}</p>
                             <p className="text-[10px] text-slate-400 font-bold">{row.date}</p>
                          </div>
                       </div>
                       <p className={`text-lg font-black ${row.pts.startsWith('+') ? 'text-emerald-500' : 'text-slate-900'}`}>{row.pts}</p>
                    </div>)}
               </div>
           </CardContent>
        </Card>
      </div>
    </PageShell>;
}