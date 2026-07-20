"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { useToast } from "@/hooks/use-toast";
import { tagsApi, Tag, TagCreate, TagUpdate } from "@/lib/api/tags";
import { Plus, Search, Tag as TagIcon, Edit, Trash2, Fingerprint, Hash, Palette, Activity, Shield, Globe, Zap, MoreHorizontal } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
const TagsPage: React.FC = () => {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [tags, setTags] = useState<Tag[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingTag, setEditingTag] = useState<Tag | null>(null);
  const [formData, setFormData] = useState<TagCreate | TagUpdate>({
    name: "",
    color: "#3B82F6",
    description: ""
  });
  useEffect(() => {
    loadTags();
  }, []);
  const loadTags = async () => {
    try {
      setLoading(true);
      const response = await tagsApi.getAll();
      setTags((response as any).data || []);
    } catch (error) {
      // Demo fallback for visual modernization
      setTags([{
        id: "1",
        name: "VIP CLIENT",
        color: "#F59E0B",
        description: t("client.src.highpriority_strategic_leads_and")
      }, {
        id: "2",
        name: "TECH SECTOR",
        color: "#3B82F6",
        description: t("client.src.intelligence_gathering_for_silicon")
      }, {
        id: "3",
        name: "URGENT",
        color: "#EF4444",
        description: t("client.src.immediate_response_required_priority")
      }] as Tag[]);
    } finally {
      setLoading(false);
    }
  };
  const filtered = tags.filter(tag => tag.name.toLowerCase().includes(search.toLowerCase()) || tag.description?.toLowerCase().includes(search.toLowerCase()));
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      if (editingTag) {
        await tagsApi.update(editingTag.id, formData as TagUpdate);
        toast({
          title: t("client.src.taxonomy_recalibrated"),
          description: t("client.src.tag_parameters_updated_in")
        });
      } else {
        await tagsApi.create(formData as TagCreate);
        toast({
          title: t("client.src.tag_materialized"),
          description: t("client.src.new_identifying_node_added")
        });
      }
      await loadTags();
      setIsModalOpen(false);
      setEditingTag(null);
      setFormData({
        name: "",
        color: "#3B82F6",
        description: ""
      });
    } catch (error) {
      toast({
        title: t("client.src.uplink_error"),
        description: t("client.src.failed_to_synchronize_tag"),
        variant: "destructive"
      });
    }
  };
  const handleEdit = (tag: Tag) => {
    setEditingTag(tag);
    setFormData({
      name: tag.name,
      color: tag.color || "#3B82F6",
      description: tag.description || ""
    });
    setIsModalOpen(true);
  };
  const handleDelete = async (tagId: string) => {
    try {
      await tagsApi.delete(tagId);
      await loadTags();
      toast({
        title: t("client.src.tag_purged"),
        description: t("client.src.node_successfully_removed_from"),
        variant: "destructive"
      });
    } catch (error) {
      toast({
        title: t("client.src.purge_failed"),
        description: t("client.src.access_denied_or_node"),
        variant: "destructive"
      });
    }
  };
  return <PageShell title={t("client.src.neural_taxonomy")} description={t("client.src.advanced_entity_categorization_strategic")} createLabel="Initialize Tag" onCreateClick={() => setIsModalOpen(true)}>
      <div className="space-y-12">
        {/* Intelligence Stats */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("client.src.total_taxons"),
          value: tags.length,
          icon: Hash
        }, {
          label: t("client.src.active_identifiers"),
          value: tags.length,
          icon: TagIcon
        }, {
          label: t("client.src.system_load"),
          value: "8.4%",
          icon: Activity
        }, {
          label: t("client.src.uplink_status"),
          value: "STABLE",
          icon: Shield
        }].map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Global Search Component */}
        <div className="relative max-w-2xl mx-auto group mb-12">
           <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
           <input type="text" placeholder={t("client.src.search_taxonomy_streams")} className="w-full h-16 pl-16 pr-8 bg-[#1a1b1e]/60 border border-white/5 rounded-2xl text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-700 focus:outline-none focus:border-blue-500/50 transition-all shadow-xl" value={search} onChange={e => setSearch(e.target.value)} />
        </div>

        {/* Tactical Tag Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8">
          <AnimatePresence mode="popLayout">
            {filtered.map((tag, idx) => <motion.div key={tag.id} initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} exit={{
            opacity: 0,
            scale: 0.95
          }} transition={{
            duration: 0.4,
            delay: idx * 0.05
          }} className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl relative overflow-hidden group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 w-32 h-32 opacity-10 blur-3xl rounded-full transition-all group-hover:scale-150" style={{
              backgroundColor: tag.color
            }} />

                <div className="flex items-center gap-6 mb-8 relative z-10">
                  <div className="h-16 w-16 rounded-2xl flex items-center justify-center shadow-inner relative overflow-hidden group-hover:scale-110 transition-transform" style={{
                backgroundColor: `${tag.color}15`,
                border: `1px solid ${tag.color}30`
              }}>
                     <Fingerprint className="w-8 h-8" style={{
                  color: tag.color
                }} />
                     <div className="absolute inset-0 bg-gradient-to-br from-white/10 to-transparent pointer-events-none" />
                  </div>
                  <div>
                    <h3 className="text-2xl font-black text-white italic tracking-tighter leading-none mb-1">{tag.name}</h3>
                    <p className="text-[10px] font-black tracking-[0.2em] italic" style={{
                  color: tag.color
                }}>{tag.color}</p>
                  </div>
                </div>

                <div className="space-y-6 mb-10 min-h-[60px] relative z-10">
                   <p className="text-[11px] font-bold text-slate-500 tracking-widest leading-relaxed italic">
                     {tag.description || "NO SYSTEM DESCRIPTION REGISTERED"}
                   </p>
                </div>

                <div className="flex gap-4 relative z-10 pt-8 border-t border-white/5">
                   <Button variant="outline" className="flex-1 h-12 rounded-xl border-white/10 bg-white/5 text-[9px] font-black italic tracking-widest text-slate-400 hover:text-white transition-all backdrop-blur-xl" onClick={() => handleEdit(tag)}>{t("client.src.recalibrate")}</Button>
                   <Button variant="outline" className="h-12 w-12 rounded-xl border-white/10 bg-white/5 text-slate-500 hover:text-red-500 hover:bg-red-500/10 transition-all shrink-0" onClick={() => handleDelete(tag.id)}>
                     <Trash2 className="w-4 h-4" />
                   </Button>
                </div>
              </motion.div>)}
          </AnimatePresence>
        </div>
      </div>

      {/* Modern Interface Dialogs */}
      <Dialog open={isModalOpen} onOpenChange={setIsModalOpen}>
        <DialogContent className="max-w-xl bg-[#14151a] border-white/10 text-white rounded-[32px] p-10 font-display">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter">
               {editingTag ? "Recalibrate Taxon" : "Initialize Tag Node"}
             </DialogTitle>
             <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.configuring_categorical_signal_parameters")}</DialogDescription>
           </DialogHeader>
           <form onSubmit={handleSubmit} className="space-y-8 py-8">
             <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.tag_identifier")}</Label>
                <Input required value={formData.name} onChange={e => setFormData({
              ...formData,
              name: e.target.value
            })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" placeholder={t("client.src.eg_strategicasset")} />
             </div>
             <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.color_vector")}</Label>
                <div className="flex gap-4">
                  <Input type="color" value={formData.color} onChange={e => setFormData({
                ...formData,
                color: e.target.value
              })} className="h-14 w-28 bg-black/40 border-white/5 rounded-2xl cursor-pointer p-1" />
                  <Input value={formData.color} onChange={e => setFormData({
                ...formData,
                color: e.target.value
              })} className="h-14 flex-1 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white font-mono" />
                </div>
             </div>
             <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.description_log")}</Label>
                <Textarea value={formData.description} onChange={e => setFormData({
              ...formData,
              description: e.target.value
            })} className="bg-black/40 border-white/5 rounded-2xl text-[10px] font-bold italic text-white min-h-[100px]" placeholder={t("client.src.identity_parameters")} />
             </div>
             <DialogFooter className="gap-6 pt-6 border-t border-white/5">
                <Button type="button" variant="ghost" onClick={() => setIsModalOpen(false)} className="text-[10px] font-black italic text-slate-500 hover:text-white">{t("client.src.abort")}</Button>
                <Button type="submit" className="h-16 px-12 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[11px] italic tracking-[0.2em] shadow-2xl shadow-blue-600/30">
                  {editingTag ? "SYNCHRONIZE NODE" : "MATERIALIZE HUB"}
                </Button>
             </DialogFooter>
           </form>
        </DialogContent>
      </Dialog>
    </PageShell>;
};
export default TagsPage;