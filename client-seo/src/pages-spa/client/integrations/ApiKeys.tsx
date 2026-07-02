import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from "react";
import { apiKeysApi, ApiKey, ApiKeyCreate } from "@/lib/api/api-keys";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Key, ShieldCheck, Power, RefreshCw, Trash2, Edit3, Terminal, Lock, Cpu, Activity, Shield, Zap, MoreHorizontal, ChevronRight, Copy } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";

const ApiKeysPage: React.FC = () => {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const queryClient = useQueryClient();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingApiKey, setEditingApiKey] = useState<ApiKey | null>(null);
  const [formData, setFormData] = useState<ApiKeyCreate>({
    userId: "",
    name: "",
    permissions: [],
    isActive: true
  });

  const { data: rawApiKeys = [] } = useQuery({
    queryKey: ['api-keys'],
    queryFn: async () => {
      const response = await apiKeysApi.getAll();
      return (response as any).data || response || [];
    }
  });

  const apiKeys = Array.isArray(rawApiKeys) ? rawApiKeys : [];

  const createMutation = useMutation({
    mutationFn: (data: ApiKeyCreate) => apiKeysApi.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['api-keys'] });
      setIsModalOpen(false);
      setEditingApiKey(null);
      setFormData({ userId: "", name: "", permissions: [], isActive: true });
      toast({ title: t("client.src.secret_materialized"), description: t("client.src.new_api_key_successfully") });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: ApiKeyCreate }) => apiKeysApi.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['api-keys'] });
      setIsModalOpen(false);
      setEditingApiKey(null);
      setFormData({ userId: "", name: "", permissions: [], isActive: true });
      toast({ title: t("client.src.cipher_realigned"), description: t("client.src.api_key_parameters_successfully") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => apiKeysApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['api-keys'] });
      toast({ title: t("client.src.secret_eradicated"), description: t("client.src.api_key_has_been") });
    }
  });

  const regenerateMutation = useMutation({
    mutationFn: (id: string) => apiKeysApi.regenerateKey(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['api-keys'] });
      toast({ title: t("client.src.cipher_regenerated"), description: t("client.src.new_cryptographic_signature_issued") });
    }
  });

  const toggleStatusMutation = useMutation({
    mutationFn: async (apiKey: ApiKey) => {
      if (apiKey.isActive) {
        return apiKeysApi.deactivateKey(apiKey.id);
      } else {
        return apiKeysApi.activateKey(apiKey.id);
      }
    },
    onSuccess: (_, variables) => {
      queryClient.invalidateQueries({ queryKey: ['api-keys'] });
      toast({
        title: variables.isActive ? t("client.src.accessrevoked") : t("client.src.accessrestored"),
        description: variables.isActive ? t("client.src.api_key_deactivated_logic") : t("client.src.api_key_activated_logic")
      });
    }
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingApiKey) {
      updateMutation.mutate({ id: editingApiKey.id, data: formData });
    } else {
      createMutation.mutate(formData);
    }
  };

  const handleEdit = (apiKey: ApiKey) => {
    setEditingApiKey(apiKey);
    setFormData({
      userId: apiKey.userId,
      name: apiKey.name,
      permissions: apiKey.permissions,
      isActive: apiKey.isActive
    });
    setIsModalOpen(true);
  };

  const handleDelete = (apiKeyId: string) => {
    if (confirm("TERMINATE_SECRET_KEY: Confirm permanent erasure from the encrypted grid?")) {
      deleteMutation.mutate(apiKeyId);
    }
  };

  const handleRegenerate = (apiKeyId: string) => {
    if (confirm("REGENERATION_PROTOCOL: Old cipher will be invalidated. Proceed?")) {
      regenerateMutation.mutate(apiKeyId);
    }
  };

  const toggleApiKeyStatus = (apiKey: ApiKey) => {
    toggleStatusMutation.mutate(apiKey);
  };
  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text);
    toast({
      title: t("client.src.secret_copied"),
      description: t("client.src.cipher_buffered_to_clipboard")
    });
  };
  return <PageShell title={t("client.src.neural_secrets")} description={t("client.src.cryptographic_api_gateway_access")}>
      <div className="space-y-12">
        {/* Intelligence Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("client.src.active_ciphers"),
          value: apiKeys.filter(k => k.isActive).length,
          icon: Key
        }, {
          label: t("client.src.grid_security"),
          value: "ENHANCED",
          icon: ShieldCheck
        }, {
          label: t("client.src.uptime"),
          value: "99.999%",
          icon: Activity
        }, {
          label: t("client.src.threatlvl"),
          value: "MINIMAL",
          icon: Shield
        }].map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Global Control Bar */}
        <div className="flex flex-col sm:flex-row items-center justify-between gap-6 bg-[#1a1b1e]/60 border border-white/5 p-6 rounded-[28px] backdrop-blur-xl">
           <div className="flex items-center gap-4">
              <div className="h-12 w-12 rounded-xl bg-blue-600/20 border border-blue-500/30 flex items-center justify-center">
                 <Terminal className="w-5 h-5 text-blue-400" />
              </div>
              <div>
                 <h4 className="text-[10px] font-black text-white tracking-widest italic">{t("client.src.encrypted_gateway")}</h4>
                 <p className="text-[8px] font-bold text-slate-500 italic">{t("client.src.active_buffer")}{apiKeys.length}{t("client.src.nodes")}</p>
              </div>
           </div>
           <Button onClick={() => {
          setEditingApiKey(null);
          setFormData({
            userId: "",
            name: "",
            permissions: [],
            isActive: true
          });
          setIsModalOpen(true);
        }} className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] italic tracking-widest shadow-xl shadow-blue-600/30">
             <Zap className="w-4 h-4 mr-2" />{t("client.src.generate_cipher")}</Button>
        </div>

        {/* Key Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          <AnimatePresence mode="popLayout">
            {apiKeys.map((apiKey, idx) => <motion.div key={apiKey.id} initial={{
            opacity: 0,
            x: -20
          }} animate={{
            opacity: 1,
            x: 0
          }} exit={{
            opacity: 0,
            scale: 0.9
          }} transition={{
            duration: 0.4,
            delay: idx * 0.05
          }} className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl relative overflow-hidden group hover:bg-white/5 transition-all">
                {/* Background Decor */}
                <div className="absolute -bottom-10 -right-10 opacity-[0.02] text-white pointer-events-none transition-transform group-hover:scale-110">
                   <Lock className="w-64 h-64" />
                </div>

                <div className="flex items-start justify-between mb-8 relative z-10">
                  <div className="flex items-center gap-6">
                    <div className={cn("h-16 w-16 rounded-2xl border flex items-center justify-center shadow-2xl transition-all", apiKey.isActive ? "bg-emerald-500/10 border-emerald-500/30 text-emerald-400 shadow-emerald-500/10" : "bg-red-500/10 border-red-500/30 text-red-400 shadow-red-500/10")}>
                       <Shield className="w-8 h-8" />
                    </div>
                    <div>
                      <h3 className="text-2xl font-black text-white italic tracking-tighter leading-none mb-2">{apiKey.name}</h3>
                      <div className="flex items-center gap-2">
                         <span className="text-[9px] font-black text-slate-500 tracking-widest italic">{apiKey.user?.email || "SYSTEM_OPERATIVE"}</span>
                      </div>
                    </div>
                  </div>
                  <Badge className={cn("px-4 py-1.5 rounded-full border text-[9px] font-black  tracking-widest italic", apiKey.isActive ? "bg-emerald-500/10 text-emerald-400 border-emerald-500/20" : "bg-red-500/10 text-red-400 border-red-500/20")}>
                     {apiKey.isActive ? "SYNCHRONIZED" : "DEACTIVATED"}
                  </Badge>
                </div>

                <div className="bg-black/40 border border-white/5 rounded-2xl p-6 mb-8 relative group/key">
                   <div className="flex items-center justify-between mb-4">
                      <p className="text-[8px] font-black text-slate-600 italic tracking-widest">{t("client.src.cipherfragment")}</p>
                      <Button variant="ghost" size="sm" className="h-6 px-2 text-slate-600 hover:text-blue-400" onClick={() => copyToClipboard(apiKey.key)}>
                         <Copy className="w-3 h-3 mr-1.5" /> <span className="text-[8px] font-black italic">{t("client.src.copy")}</span>
                      </Button>
                   </div>
                   <code className="text-xs font-mono text-blue-500/80 tracking-widest block bg-blue-500/5 p-3 rounded-lg border border-blue-500/10 decoration-wavy">
                      {apiKey.key.substring(0, 12)}••••••••••••••••{apiKey.key.substring(apiKey.key.length - 8)}
                   </code>
                </div>

                <div className="flex flex-wrap gap-2 mb-10 pt-6 border-t border-white/5 relative z-10">
                   {apiKey.permissions.map((perm: string) => <Badge key={perm} className="bg-white/2 border-white/5 text-[8px] font-black text-slate-400 italic px-3 py-1">{t("client.src.scope")}{perm}
                     </Badge>)}
                </div>

                <div className="flex gap-4 relative z-10">
                   <Button className="flex-1 h-14 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[10px] transition-all" onClick={() => handleEdit(apiKey)}>{t("client.src.reconfignode")}</Button>
                   <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/10 bg-white/5 text-slate-500 hover:text-yellow-500 hover:bg-yellow-500/10 transition-all shrink-0" onClick={() => toggleApiKeyStatus(apiKey)}>
                     <Power className="w-5 h-5" />
                   </Button>
                   <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/10 bg-white/5 text-slate-500 hover:text-blue-500 hover:bg-blue-500/10 transition-all shrink-0" onClick={() => handleRegenerate(apiKey.id)}>
                     <RefreshCw className="w-5 h-5" />
                   </Button>
                   <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/10 bg-white/5 text-slate-500 hover:text-red-500 hover:bg-red-500/10 transition-all shrink-0" onClick={() => handleDelete(apiKey.id)}>
                     <Trash2 className="w-5 h-5" />
                   </Button>
                </div>
              </motion.div>)}
          </AnimatePresence>
        </div>
      </div>

      {/* Modern Interface Dialogs */}
      <Dialog open={isModalOpen} onOpenChange={setIsModalOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-white/10 text-white rounded-[32px] p-10 font-display shadow-3xl">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter">
                {editingApiKey ? "Recalibrate Cipher" : "Materialize New Secret"}
             </DialogTitle>
             <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic mt-2">{t("client.src.provisioning_highentropy_cryptographic_credentials")}</DialogDescription>
           </DialogHeader>
           <form onSubmit={handleSubmit} className="space-y-10 py-10">
             <div className="space-y-8">
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.operativeid")}</Label>
                   <Input required value={formData.userId} onChange={e => setFormData({
                ...formData,
                userId: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" placeholder={t("client.src.eg_user77delta")} />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.secretalias")}</Label>
                   <Input required value={formData.name} onChange={e => setFormData({
                ...formData,
                name: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" placeholder={t("client.src.eg_webportaluplink")} />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.permissionsarray_csv")}</Label>
                   <Input required value={formData.permissions.join(", ")} onChange={e => setFormData({
                ...formData,
                permissions: e.target.value.split(",").map(p => p.trim()).filter(p => p)
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" placeholder={t("client.src.read_write_delete")} />
                </div>
             </div>
             <DialogFooter className="gap-6 pt-6 border-t border-white/5">
                <Button type="button" variant="ghost" onClick={() => setIsModalOpen(false)} className="text-[10px] font-black italic text-slate-500 hover:text-white">{t("client.src.abort_protocol")}</Button>
                <Button type="submit" className="h-16 px-12 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[11px] italic tracking-[0.2em] shadow-2xl shadow-blue-600/30">
                   {editingApiKey ? "SYNCHRONIZE NODE" : "MATERIALIZE HUB"}
                </Button>
             </DialogFooter>
           </form>
        </DialogContent>
      </Dialog>
    </PageShell>;
};
export default ApiKeysPage;