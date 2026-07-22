"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useRef, useEffect } from "react";
import { format } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Input } from "@/components/ui/input";
import { MessageSquare, Send, Bell, Plus, Users, Clock, CheckCircle, XCircle, Star, Search, Settings, Zap, Activity, Shield, Terminal, ChevronRight, MoreVertical, Hash, Paperclip, Smile, Phone, Video } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { m, AnimatePresence } from "framer-motion";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { communicationsApi, Channel } from "@/lib/api/communications";
import { cn } from "@/lib/utils";
export default function Communications() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const queryClient = useQueryClient();
  const [selectedChannel, setSelectedChannel] = useState<Channel | null>(null);
  const [messageInput, setMessageInput] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType] = useState<string>("all");
  const [, setShowNewMessageDialog] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const [mounted, setMounted] = useState(false);
  useEffect(() => {
    setMounted(true);
  }, []);

  // Queries
  const {
    data: channels = [],
    isLoading: isLoadingChannels
  } = useQuery({
    queryKey: ["communications", "channels"],
    queryFn: () => communicationsApi.getChannels(),
    enabled: mounted
  });
  const {
    data: messages = []
  } = useQuery({
    queryKey: ["communications", "messages", selectedChannel?.id],
    queryFn: () => communicationsApi.getChannelMessages(selectedChannel!.id),
    enabled: !!selectedChannel?.id && mounted
  });
  const {
    data: notifications = []
  } = useQuery({
    queryKey: ["communications", "notifications"],
    queryFn: () => communicationsApi.getAllMessages({
      type: "NOTIFICATION",
      isRead: false
    }),
    enabled: mounted
  });
  const sendMessageMutation = useMutation({
    mutationFn: communicationsApi.sendMessage,
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: ["communications", "messages", selectedChannel?.id]
      });
      setMessageInput("");
    }
  });
  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({
      behavior: "smooth"
    });
  }, [messages]);
  const getStatusIcon = (status: string) => {
    switch (status) {
      case "SENT":
        return <CheckCircle className="w-3 h-3 text-slate-500" />;
      case "DELIVERED":
        return <CheckCircle className="w-3 h-3 text-blue-400 shadow-[0_0_8px_rgba(59,130,246,0.3)]" />;
      case "READ":
        return <CheckCircle className="w-3 h-3 text-emerald-400 shadow-[0_0_8px_rgba(16,185,129,0.3)]" />;
      case "FAILED":
        return <XCircle className="w-3 h-3 text-red-500 shadow-[0_0_8px_rgba(239,68,68,0.3)]" />;
      default:
        return <Clock className="w-3 h-3 text-slate-600" />;
    }
  };
  const formatTimestamp = (timestamp: string) => {
    const date = new Date(timestamp);
    const now = new Date();
    const diffInHours = (now.getTime() - date.getTime()) / (1000 * 60 * 60);
    if (diffInHours < 1) return "Just now";
    if (diffInHours < 24) return format(date, "h:mm a");
    if (diffInHours < 24 * 7) return format(date, "EEE");
    return format(date, "MMM d");
  };
  const filteredChannels = channels.filter(c => {
    const matchesSearch = c.name?.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesType = filterType === "all" || c.type === filterType;
    return matchesSearch && matchesType;
  });
  const handleSendMessage = () => {
    if (messageInput.trim() && selectedChannel) {
      sendMessageMutation.mutate({
        channelId: selectedChannel.id,
        content: messageInput,
        type: "MESSAGE"
      });
    }
  };
  if (!mounted) return null;
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 space-y-10 overflow-x-hidden">
      
      {/* Cinematic Nexus Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-8 relative">
         <div className="absolute top-0 left-0 w-32 h-32 bg-blue-600/10 blur-[100px] pointer-events-none rounded-full"></div>
         <div className="relative z-10 flex items-center gap-6">
            <div className="h-16 w-16 rounded-[24px] bg-[#1a1b1e]/60 border border-white/5 border-l border-t flex items-center justify-center shadow-3xl group">
              <MessageSquare className="w-8 h-8 text-blue-500 group-hover:scale-110 transition-transform" />
            </div>
            <div>
              <h1 className="text-4xl font-black text-white italic tracking-tighter leading-none">{t("client.src.neural_signal_nexus")}</h1>
              <p className="text-[10px] font-black text-slate-500 tracking-widest italic mt-2 flex items-center gap-2">
                 <Activity className="w-3 h-3 text-emerald-500 animate-pulse" />{t("client.src.secure_commlink_cluster_active")}</p>
            </div>
         </div>

        <div className="flex items-center gap-4 relative z-10">
          <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/5 bg-white/5 text-slate-400 hover:text-white transition-all shadow-xl">
            <Settings className="w-5 h-5" />
          </Button>
          <Button onClick={() => setShowNewMessageDialog(true)} className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] tracking-widest italic shadow-xl shadow-blue-600/20 gap-3">
            <Plus className="w-4 h-4" />{t("client.src.broadcast_signal")}</Button>
        </div>
      </div>

      {/* Intelligence Dashboard Widgets */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
        {[{
        label: t("client.src.connected_nodes"),
        value: channels.length,
        icon: Users,
        color: "text-blue-400"
      }, {
        label: t("client.src.unread_pulses"),
        value: notifications.length,
        icon: Bell,
        color: "text-purple-400"
      }, {
        label: t("client.src.starred_symbols"),
        value: "14",
        icon: Star,
        color: "text-orange-400"
      }, {
        label: t("client.src.signal_latency"),
        value: "24ms",
        icon: Zap,
        color: "text-emerald-400"
      }].map((stat, i) => <Card key={i} className="bg-[#1a1b1e]/60 border-white/5 rounded-[32px] p-6 shadow-2xl relative overflow-hidden group border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-5 group-hover:opacity-10 transition-all text-blue-500">
               <stat.icon className="w-12 h-12" />
            </div>
            <div className="space-y-1">
               <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{stat.label}</p>
               <h3 className="text-3xl font-black text-white italic tracking-tighter mt-1">{stat.value}</h3>
            </div>
          </Card>)}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 h-[750px]">
        {/* Signal Channels Sidebar */}
        <div className="lg:col-span-4 h-full">
          <Card className="h-full bg-[#1a1b1e]/40 border-white/5 rounded-[40px] overflow-hidden shadow-3xl border-l border-t flex flex-col">
            <CardHeader className="p-8 pb-4">
              <div className="relative group">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                <Input placeholder={t("client.src.filtering_signals")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="bg-black/40 border-white/5 rounded-2xl pl-12 h-14 text-white focus:ring-blue-500/20 text-[10px] font-black tracking-widest italic border-l border-t" />
              </div>
            </CardHeader>
            <CardContent className="flex-1 p-0 overflow-y-auto custom-scrollbar">
              <div className="px-4 space-y-2">
                {isLoadingChannels ? <div className="p-10 text-center space-y-4 opacity-40">
                     <Activity className="w-10 h-10 mx-auto text-slate-600 animate-spin" />
                     <p className="text-[10px] font-black tracking-widest italic text-slate-500">{t("client.src.scanning_frequencies")}</p>
                  </div> : filteredChannels.map(channel => <m.div key={channel.id} layoutId={`channel-${channel.id}`} className={cn("p-5 rounded-[28px] cursor-pointer transition-all relative group flex items-start gap-5", selectedChannel?.id === channel.id ? "bg-blue-600/10 border border-blue-500/30 shadow-2xl" : "hover:bg-white/5 border border-transparent")} onClick={() => setSelectedChannel(channel)}>
                    <div className="relative">
                       <Avatar className="w-14 h-14 border-2 border-white/5 rounded-[18px] p-0.5 group-hover:scale-105 transition-transform">
                          <AvatarFallback className="bg-slate-900 text-blue-500 font-black italic rounded-[16px]"><Users className="w-6 h-6" /></AvatarFallback>
                       </Avatar>
                       <div className="absolute -top-1 -right-1 w-3.5 h-3.5 rounded-full bg-blue-500 border-2 border-[#1a1b1e] shadow-[0_0_8px_#3b82f6]" />
                    </div>
                    <div className="flex-1 min-w-0 space-y-1">
                      <div className="flex items-center justify-between">
                        <h3 className="text-sm font-black text-white italic tracking-tighter truncate">{channel.name}</h3>
                        <span className="text-[9px] font-black text-slate-600 italic whitespace-nowrap">{formatTimestamp(channel.updatedAt)}</span>
                      </div>
                      <p className="text-[10px] font-bold text-slate-500 tracking-widest italic truncate">{channel.type}{t("client.src.channel")}</p>
                    </div>
                    {selectedChannel?.id === channel.id && <div className="absolute right-0 top-1/2 -translate-y-1/2 w-1 h-8 bg-blue-500 rounded-l-full shadow-[0_0_15px_#3b82f6]" />}
                  </m.div>)}
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Central Signal Processor (Chat) */}
        <div className="lg:col-span-8 h-full">
          <Card className="h-full bg-[#1a1b1e]/60 border-white/5 rounded-[40px] shadow-3xl border-l border-t flex flex-col relative overflow-hidden">
            {selectedChannel ? <>
                <CardHeader className="p-8 border-b border-white/5 bg-black/20 backdrop-blur-3xl sticky top-0 z-10">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-6">
                      <div className="relative">
                         <Avatar className="w-16 h-16 border-2 border-white/5 rounded-[22px] p-0.5 animate-pulse-slow">
                            <AvatarFallback className="bg-slate-900 text-blue-400 font-black italic rounded-[20px] text-xl">#</AvatarFallback>
                         </Avatar>
                         <div className="absolute -bottom-1 -right-1 w-4 h-4 rounded-full bg-emerald-500 border-4 border-[#1a1b1e] shadow-[0_0_10px_#10b981]" />
                      </div>
                      <div>
                        <h3 className="text-2xl font-black text-white italic tracking-tighter leading-none">{selectedChannel.name}</h3>
                        <p className="text-[10px] font-black text-slate-500 tracking-widest italic mt-2 flex items-center gap-2">
                           <Hash className="w-3 h-3 text-blue-500" /> {selectedChannel.type}{t("client.src.protocol_secure")}</p>
                      </div>
                    </div>
                    
                    <div className="flex items-center gap-3">
                       <Button variant="outline" className="h-12 w-12 rounded-xl border-white/5 bg-white/5 text-slate-400 hover:text-white">
                          <Phone className="w-4 h-4" />
                       </Button>
                       <Button variant="outline" className="h-12 w-12 rounded-xl border-white/5 bg-white/5 text-slate-400 hover:text-white">
                          <Video className="w-4 h-4" />
                       </Button>
                       <Button variant="ghost" size="icon" className="h-12 w-12 rounded-xl text-slate-500 hover:text-white">
                          <MoreVertical className="w-5 h-5" />
                       </Button>
                    </div>
                  </div>
                </CardHeader>

                <CardContent className="flex-1 p-8 overflow-y-auto custom-scrollbar space-y-8">
                  <div className="text-center py-10 opacity-20 relative">
                     <div className="h-px w-full bg-gradient-to-r from-transparent via-slate-500 to-transparent absolute top-1/2 left-0 -translate-y-1/2"></div>
                     <span className="bg-[#1a1b1e] px-6 relative z-10 text-[9px] font-black tracking-[0.3em] text-slate-500">{t("client.src.signal_uplink_established")}</span>
                  </div>
                  
                  <div className="space-y-10">
                    <AnimatePresence>
                      {messages.map((message, idx) => {
                    const isMe = message.sender?.id === user?.id;
                    return <m.div key={message.id} initial={{
                      opacity: 0,
                      y: 10,
                      scale: 0.95
                    }} animate={{
                      opacity: 1,
                      y: 0,
                      scale: 1
                    }} transition={{
                      delay: idx * 0.05
                    }} className={cn("flex group", isMe ? "justify-end" : "justify-start")}>
                            <div className={cn("flex flex-col max-w-[75%]", isMe ? "items-end" : "items-start")}>
                              <div className="flex items-center gap-3 mb-2">
                                 {!isMe && <Avatar className="w-6 h-6 border border-white/10">
                                       <AvatarFallback className="bg-slate-800 text-[8px] font-black italic">{message.sender?.firstName?.slice(0, 1) || "S"}</AvatarFallback>
                                    </Avatar>}
                                 <span className="text-[10px] font-black text-slate-500 italic tracking-widest">
                                    {isMe ? "IDENTITY_ME" : message.sender?.firstName || "SYSTEM_OPERATOR"}
                                 </span>
                              </div>
                              
                              <div className={cn("p-5 rounded-[24px] shadow-2xl relative border-l border-t", isMe ? "bg-blue-600 text-white rounded-tr-none shadow-blue-500/20 border-white/10" : "bg-black/40 text-slate-200 rounded-tl-none border-white/5")}>
                                <p className={cn("text-sm font-medium leading-relaxed italic tracking-tight", isMe ? "text-white" : "text-slate-200")}>{message.content}</p>
                              </div>
                              
                              <div className={cn("flex items-center gap-2 mt-2")}>
                                <span className="text-[9px] font-black text-slate-600 italic tracking-tighter">{formatTimestamp(message.createdAt)}</span>
                                {isMe && getStatusIcon(message.status)}
                              </div>
                            </div>
                          </m.div>;
                  })}
                    </AnimatePresence>
                    <div ref={messagesEndRef} />
                  </div>
                </CardContent>

                <div className="p-8 border-t border-white/5 bg-black/40 backdrop-blur-3xl relative">
                  <div className="flex items-center gap-4 bg-black/40 border border-white/5 rounded-[28px] p-2 pl-6 focus-within:border-blue-500/40 transition-all shadow-inner border-l border-t relative overflow-hidden">
                     <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl text-slate-500 hover:text-white">
                        <Paperclip className="w-5 h-5" />
                     </Button>
                    <Input placeholder={t("client.src.broadcast_signal_content")} value={messageInput} onChange={e => setMessageInput(e.target.value)} onKeyPress={e => e.key === "Enter" && handleSendMessage()} className="flex-1 bg-transparent border-none text-white focus:ring-0 text-[11px] font-black italic tracking-widest" disabled={sendMessageMutation.isPending} />
                    <div className="flex items-center gap-2">
                       <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl text-slate-500 hover:text-white">
                          <Smile className="w-5 h-5" />
                       </Button>
                       <Button size="lg" onClick={handleSendMessage} disabled={sendMessageMutation.isPending || !messageInput.trim()} className="h-14 w-14 rounded-[22px] bg-blue-600 hover:bg-blue-500 text-white shadow-xl shadow-blue-600/20 active:scale-95 transition-all">
                         <Send className="w-6 h-6" />
                       </Button>
                    </div>
                    {sendMessageMutation.isPending && <div className="absolute bottom-0 left-0 h-[2px] bg-blue-400 animate-progress w-full"></div>}
                  </div>
                </div>
              </> : <CardContent className="flex-1 flex flex-col items-center justify-center p-20 space-y-8 opacity-40">
                <div className="relative">
                   <div className="absolute inset-0 bg-blue-600/20 blur-[60px] rounded-full animate-pulse-slow"></div>
                   <div className="w-24 h-24 rounded-[32px] bg-white/2 border border-white/5 flex items-center justify-center relative z-10">
                      <MessageSquare className="w-10 h-10 text-slate-600" />
                   </div>
                </div>
                <div className="text-center space-y-2">
                  <h3 className="text-xl font-black text-white italic tracking-tighter leading-none">{t("client.src.awaiting_signal_selection")}</h3>
                  <p className="text-[10px] font-black text-slate-500 tracking-widest italic leading-relaxed">{t("client.src.choose_a_node_identifier")}</p>
                </div>
              </CardContent>}
          </Card>
        </div>
      </div>
    </div>;
}