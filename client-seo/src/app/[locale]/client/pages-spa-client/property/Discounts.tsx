"use client";

import { useState, useEffect } from "react";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { financialsApi, type Discount } from "@/lib/api/financials";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { Tag, Plus, RefreshCw, Loader2, Check, X, Percent as PercentIcon, DollarSign, Search, ArrowLeft, Building2, Ticket, Activity, Edit } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useNavigate } from "@/lib/react-router-shim";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { Card, CardContent } from "@/components/ui/card";
export default function Discounts({ propertyId }: { propertyId?: string }) {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const [discounts, setDiscounts] = useState<Discount[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const fetchData = async () => {
    try {
      setLoading(true);
      const [discRes, propRes] = await Promise.all([financialsApi.getDiscounts(), propertiesApi.getAll()]);
      let list = discRes || [{
        id: "d1",
        propertyId: "prop1",
        name: "Early Bird",
        code: "EARLY20",
        value: 20,
        type: "PERCENTAGE",
        isActive: true
      }, {
        id: "d2",
        propertyId: "prop2",
        name: "Summer Sale",
        code: "SUMMER50",
        value: 50,
        type: "FIXED",
        isActive: true
      }, {
        id: "d3",
        propertyId: "prop1",
        name: "Loyalty Discount",
        value: 10,
        type: "PERCENTAGE",
        isActive: false
      }];
      if (propertyId) {
        list = list.filter((item: any) => item.propertyId === propertyId);
      }
      setDiscounts(list);
      setProperties(propRes || []);
    } catch (error) {
      console.error("API error, using mock data");
      setDiscounts([{
        id: "d1",
        propertyId: "prop1",
        name: "Early Bird",
        code: "EARLY20",
        value: 20,
        type: "PERCENTAGE",
        isActive: true
      }, {
        id: "d2",
        propertyId: "prop2",
        name: "Summer Sale",
        code: "SUMMER50",
        value: 50,
        type: "FIXED",
        isActive: true
      }]);
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchData();
  }, []);
  const filtered = discounts.filter(d => d.name.toLowerCase().includes(search.toLowerCase()) || (d.code || "").toLowerCase().includes(search.toLowerCase()));
  const getPropertyName = (id: string) => properties.find(p => p.id === id)?.name || "All Properties";
  return <div className="min-h-screen bg-background p-8 lg:p-12 relative overflow-hidden">
      {/* Background HUD Layer */}
      <div className="absolute inset-0 pointer-events-none opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px] z-0" />
      
      <div className="max-w-[1600px] mx-auto space-y-12 relative z-10">
        {/* Header HUD */}
        <m.div initial={{
        opacity: 0,
        y: -20
      }} animate={{
        opacity: 1,
        y: 0
      }} className="flex flex-col md:flex-row md:items-center justify-between gap-10">
          <div className="flex items-center gap-8">
            <Button variant="ghost" size="sm" onClick={() => navigate(-1)} className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-muted-foreground font-black italic text-[10px] tracking-[0.25em] transition-all group">
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t('back', {
              defaultValue: 'BACK'
            })}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="space-y-1.5">
              <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-brand/10 border border-blue-500/20 text-brand text-[9px] font-black tracking-[0.2em] italic">
                <Ticket className="w-3.5 h-3.5" />{t("client.src.promoenginev4")}</div>
              <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter leading-none">{t('client.property.discounts.title')}</h1>
              <p className="text-muted-foreground text-sm font-black tracking-widest italic">{t('client.property.discounts.subtitle')}</p>
            </div>
          </div>
          <div className="flex items-center gap-4">
             <Button variant="ghost" onClick={fetchData} disabled={loading} className="h-16 w-16 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-muted-foreground hover:text-white transition-all shadow-xl" aria-label={t("common.refresh")}>
               <RefreshCw className={cn("w-5 h-5", loading ? "animate-spin" : "")} />
             </Button>
             <Button className="h-16 px-10 rounded-2xl bg-blue-600 hover:bg-brand/100 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95">
               <Plus className="w-5 h-5 mr-3" /> {t('client.property.discounts.create')}
             </Button>
          </div>
        </m.div>

        {/* Filter Surface */}
        <m.div initial={{
        opacity: 0,
        scale: 0.98
      }} animate={{
        opacity: 1,
        scale: 1
      }}>
          <Card className="bg-card/40 border-white/5 border-l border-t rounded-[40px] p-8 backdrop-blur-3xl shadow-3xl">
            <div className="relative group">
               <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground group-focus-within:text-brand transition-colors" />
                <input placeholder={t('client.property.discounts.search')} aria-label="Search discounts" className="w-full pl-16 h-16 bg-black/40 border border-white/5 rounded-[24px] text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-foreground" value={search} onChange={e => setSearch(e.target.value)} />
            </div>
          </Card>
        </m.div>

        {/* Table Surface */}
        <m.div initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }}>
          <Card className="bg-card/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
            <Table>
              <TableHeader className="bg-white/2 border-b border-white/5">
                <TableRow className="hover:bg-transparent border-none">
                  <TableHead className="text-muted-foreground text-[10px] font-black tracking-[0.2em] px-10 py-8 italic">{t('client.property.discounts.name')}</TableHead>
                  <TableHead className="text-muted-foreground text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.discounts.property')}</TableHead>
                  <TableHead className="text-muted-foreground text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.discounts.value')}</TableHead>
                  <TableHead className="text-muted-foreground text-[10px] font-black tracking-[0.2em] px-10 italic">{t('code')}</TableHead>
                  <TableHead className="text-muted-foreground text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.discounts.status')}</TableHead>
                  <TableHead className="text-muted-foreground text-[10px] font-black tracking-[0.2em] px-10 text-right italic">{t('client.property.discounts.actions')}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loading ? <TableRow><TableCell colSpan={6} className="text-center py-40"><Activity className="w-12 h-12 text-brand animate-spin mx-auto opacity-20" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-40 text-foreground font-black italic tracking-widest text-xs">{t('client.property.discounts.noFound')}</TableCell></TableRow> : filtered.map(disc => <TableRow key={disc.id} className="border-b border-white/5 hover:bg-white/2 transition-all group/row">
                      <TableCell className="px-10 py-8">
                        <div className="flex items-center gap-6">
                           <div className="w-14 h-14 rounded-2xl bg-white/5 border border-white/5 flex items-center justify-center group-hover/row:scale-110 transition-transform duration-500">
                              <Tag className="w-5 h-5 text-brand" />
                           </div>
                           <div className="space-y-1.5">
                              <p className="font-black text-white text-lg italic tracking-tighter leading-none group-hover/row:text-brand transition-colors">{disc.name}</p>
                              <p className="text-[9px] font-black text-muted-foreground tracking-widest italic">{t('limitedTime')}</p>
                           </div>
                        </div>
                      </TableCell>
                      <TableCell className="px-10">
                        <div className="flex items-center gap-3">
                           <Building2 className="w-4 h-4 text-muted-foreground shadow-xl" />
                           <span className="font-black text-muted-foreground text-[10px] italic tracking-widest">{getPropertyName(disc.propertyId)}</span>
                        </div>
                      </TableCell>
                      <TableCell className="px-10 font-black text-white italic tracking-tighter text-xl">
                        {disc.type === "PERCENTAGE" ? <div className="flex items-center gap-2 text-brand"><PercentIcon className="w-4 h-4" /> {disc.value}%</div> : <div className="flex items-center gap-2 text-success"><DollarSign className="w-4 h-4" /> ${disc.value}</div>}
                      </TableCell>
                      <TableCell className="px-10">
                        {disc.code ? <code className="px-4 py-2 rounded-xl bg-black/40 border border-white/5 text-[10px] font-black text-white tracking-widest italic shadow-inner">
                            {disc.code}
                          </code> : <span className="text-[10px] text-muted-foreground font-black italic tracking-widest opacity-50">{t('automatic')}</span>}
                      </TableCell>
                      <TableCell className="px-10">
                        {disc.isActive ? <Badge className="bg-blue-600/10 text-success border-blue-600/20 px-4 h-7 text-[8px] font-black tracking-widest rounded-full italic gap-2"><Check className="w-3 h-3" /> {t('active')}</Badge> : <Badge className="bg-rose-600/10 text-rose-500 border-rose-600/20 px-4 h-7 text-[8px] font-black tracking-widest rounded-full italic gap-2"><X className="w-3 h-3" /> {t('client.property.discounts.paused')}</Badge>}
                      </TableCell>
                      <TableCell className="px-10 text-right">
                        <Button variant="ghost" className="h-12 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-brand hover:text-white text-muted-foreground font-black italic text-[10px] tracking-widest transition-all shadow-xl group/btn">
                          {t('commonEdit', {
                      defaultValue: 'EDIT'
                    })}
                          <Edit className="w-4 h-4 ml-3 group-hover/btn:translate-x-1 transition-transform" />
                        </Button>
                      </TableCell>
                    </TableRow>)}
              </TableBody>
            </Table>
          </Card>
        </m.div>
      </div>
    </div>;
}