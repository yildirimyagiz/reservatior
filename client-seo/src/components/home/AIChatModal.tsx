import React, { useState, useRef, useEffect } from "react";
import Image from "next/image";
import { useRouter, useParams } from "next/navigation";
import { m, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import GeminiClient from "@/lib/ai/gemini-client";
import {
  Sparkles,
  X,
  MoreVertical,
  Copy,
  Share2,
  Archive,
  Edit2,
  Trash2,
  MapPin,
  Bed,
  Bath,
  ArrowRight,
  Mic,
  Send,
  Maximize2
} from "lucide-react";

interface Property {
  image: string;
  title: string;
  price: string;
  location: string;
  beds: string;
  baths: string;
}

interface Message {
  id: string;
  role: "user" | "ai";
  text: string;
  properties?: Property[];
}

export function AIChatModal({ isOpen, onClose }: { isOpen: boolean; onClose: () => void }) {
  const { t } = useTranslation();
  const router = useRouter();
  const params = useParams();
  
  const [aiMessages, setAiMessages] = useState<Message[]>([]);
  const [aiInput, setAiInput] = useState("");
  const [aiIsLoading, setAiIsLoading] = useState(false);
  const aiMessagesEndRef = useRef<HTMLDivElement>(null);
  const [editingMessageId, setEditingMessageId] = useState<string | null>(null);
  const [editingText, setEditingText] = useState("");
  const [messageMenuOpen, setMessageMenuOpen] = useState<string | null>(null);

  const scrollToBottom = () => {
    aiMessagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [aiMessages, aiIsLoading]);

  const handleAISend = async () => {
    if (!aiInput.trim() || aiIsLoading) return;

    const userMessage: Message = { id: Date.now().toString(), role: "user", text: aiInput };
    setAiMessages((prev) => [...prev, userMessage]);
    setAiInput("");
    setAiIsLoading(true);

    try {
      const aiResponse = await GeminiClient.processSearchQuery(userMessage.text);
      
      setAiMessages((prev) => [...prev, {
        id: (Date.now() + 1).toString(),
        role: "ai",
        text: aiResponse.text,
        properties: aiResponse.suggestions && aiResponse.suggestions.length > 0 ? aiResponse.suggestions.map(s => ({
          image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&q=80",
          title: s.text,
          price: "Contact for price",
          location: "Various locations",
          beds: "Varies",
          baths: "Varies"
        })) : undefined
      }]);
    } catch {
      setAiMessages((prev) => [...prev, { id: Date.now().toString(), role: "ai", text: t("client.src.connection_error_please_try_again", "Connection error, please try again") }]);
    } finally {
      setAiIsLoading(false);
    }
  };

  // Message Actions
  const copyMessage = (text: string) => {
    navigator.clipboard.writeText(text);
    setMessageMenuOpen(null);
  };

  const shareMessage = (text: string) => {
    if (navigator.share) {
      navigator.share({ title: "Reservatior AI Sohbeti", text });
    } else {
      copyMessage(text);
    }
    setMessageMenuOpen(null);
  };

  const archiveMessage = (messageId: string) => {
    const archived = JSON.parse(localStorage.getItem("archived_ai_messages") || "[]");
    const message = aiMessages.find(m => m.id === messageId);
    if (message) {
      archived.push({ ...message, archivedAt: new Date().toISOString() });
      localStorage.setItem("archived_ai_messages", JSON.stringify(archived));
    }
    setMessageMenuOpen(null);
  };

  const deleteMessage = (messageId: string) => {
    setAiMessages(prev => prev.filter(m => m.id !== messageId));
    setMessageMenuOpen(null);
  };

  const startEditMessage = (messageId: string, text: string) => {
    setEditingMessageId(messageId);
    setEditingText(text);
    setMessageMenuOpen(null);
  };

  const saveEdit = () => {
    if (editingMessageId) {
      setAiMessages(prev => prev.map(m => m.id === editingMessageId ? { ...m, text: editingText } : m));
    }
    setEditingMessageId(null);
    setEditingText("");
  };

  const cancelEdit = () => {
    setEditingMessageId(null);
    setEditingText("");
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <m.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-neutral-900/40 dark:bg-black/60 backdrop-blur-sm"
        >
          <m.div
            initial={{ scale: 0.95, y: 20, opacity: 0 }}
            animate={{ scale: 1, y: 0, opacity: 1 }}
            exit={{ scale: 0.95, y: 20, opacity: 0 }}
            className="w-full max-w-4xl h-[85vh] bg-[#fafafa] dark:bg-[#0a0a0c] rounded-3xl shadow-2xl overflow-hidden relative flex flex-col border border-white/60 dark:border-border"
          >
            {/* Header */}
            <div className="flex-none p-6 flex justify-between items-center border-b border-white/40 dark:border-border/40 bg-white/30 dark:bg-background/30 backdrop-blur-xl">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand to-brand flex items-center justify-center shadow-lg shadow-indigo-500/30">
                  <Sparkles className="w-5 h-5 text-white" />
                </div>
                <span className="font-bold text-2xl tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-brand to-neutral-800 dark:from-white dark:to-slate-300">
                  Reservatior AI
                </span>
              </div>
              <div className="flex items-center gap-2">
                <button 
                  onClick={() => {
                    onClose();
                    const currentLocale = params?.locale ? `/${params.locale}` : "";
                    router.push(`${currentLocale}/chat`);
                  }}
                  title={t("ai_modal_maximize_hint", { defaultValue: "Tam Ekran Özel Sayfaya Geç" }) as string}
                  aria-label="Maximize to dedicated AI page"
                  className="p-2.5 rounded-2xl bg-indigo-500/15 hover:bg-indigo-500/25 text-indigo-400 border border-indigo-500/30 transition-all flex items-center gap-2 font-bold text-xs px-4 shadow-sm group"
                >
                  <Maximize2 className="w-4 h-4 transition-transform group-hover:scale-110 text-indigo-400" />
                  <span className="hidden sm:inline-block tracking-wide">Tam Ekranda Aç</span>
                </button>
                <button 
                  onClick={onClose} 
                  aria-label="Close chat" 
                  className="p-2 rounded-2xl hover:bg-neutral-200 dark:hover:bg-white/10 transition-colors border border-transparent hover:border-white/10"
                >
                  <X className="w-6 h-6 text-neutral-600 dark:text-muted-foreground" />
                </button>
              </div>
            </div>

            {/* Chat Area */}
            <div className="flex-1 overflow-y-auto p-4 md:p-8 scroll-smooth">
              <div className="max-w-4xl mx-auto space-y-8 pb-10">
                {aiMessages.length === 0 && (
                  <div className="flex flex-col items-center justify-center h-[40vh] text-center space-y-8">
                    <div className="relative group">
                      <div className="absolute -inset-4 bg-gradient-to-r from-brand to-brand rounded-full blur-xl opacity-30 group-hover:opacity-50 transition duration-1000 animate-pulse" />
                      <div className="relative w-20 h-20 bg-white/80 dark:bg-background/80 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-3xl flex items-center justify-center shadow-2xl">
                        <Sparkles className="w-10 h-10 text-brand dark:text-brand" />
                      </div>
                    </div>

                    <div className="space-y-4">
                      <h2 className="text-5xl md:text-6xl font-extrabold tracking-tight text-neutral-900 dark:text-white drop-shadow-sm">
                        Hayalinizdeki Evi <span className="text-transparent bg-clip-text bg-gradient-to-r from-brand to-brand dark:from-brand dark:to-brand">AI ile Bulun</span>
                      </h2>
                      <p className="text-neutral-500 dark:text-muted-foreground text-xl max-w-2xl mx-auto font-medium">
                        Filtrelerle uğraşmayın. İhtiyaçlarınızı doğal dilde tarif edin, AI sizin için mükemmel seçenekleri bulsun.
                      </p>
                    </div>

                    <div className="space-y-3 mt-8 max-w-3xl">
                      <p className="text-sm font-bold text-neutral-400 dark:text-muted-foreground uppercase tracking-widest">Örnek sorular:</p>
                      <div className="flex flex-wrap justify-center gap-3">
                        {[
                          "İstanbul'da deniz manzaralı 2+1 daire",
                          "Ankara'da site içinde 3+1 ev",
                          "İzmir'de bahçeli müstakil villa",
                          "Antalya'da lüks tatil villası",
                          "Merkezi konumda modern ofis",
                          "Yatırımlık uygun fiyatlı daire"
                        ].map((suggestion) => (
                          <button
                            key={suggestion}
                            onClick={() => setAiInput(suggestion)}
                            className="px-5 py-3 bg-white/60 dark:bg-muted/40 backdrop-blur-md border border-white dark:border-border hover:border-brand/30 dark:hover:border-brand/50 rounded-2xl text-sm font-semibold text-neutral-700 dark:text-muted-foreground hover:text-brand dark:hover:text-brand hover:bg-white/90 dark:hover:bg-muted/80 hover:shadow-lg hover:shadow-indigo-500/10 dark:hover:shadow-indigo-500/5 transition-all active:scale-95"
                          >
                            {suggestion}
                          </button>
                        ))}
                      </div>
                    </div>
                  </div>
                )}

                {aiMessages.map((msg) => (
                  <div key={msg.id} className={`flex flex-col ${msg.role === "user" ? "items-end" : "items-start"} group`}>
                    <div className={`relative ${msg.role === "user" ? "flex flex-col items-end" : "flex flex-col items-start"}`}>
                      {/* Message Menu Button */}
                      <button
                        onClick={() => setMessageMenuOpen(messageMenuOpen === msg.id ? null : msg.id)}
                        aria-label="More options"
                        className="absolute -top-2 right-0 p-1.5 rounded-full bg-white/80 dark:bg-muted/80 backdrop-blur-sm border border-white/60 dark:border-border/60 opacity-0 group-hover:opacity-100 transition-opacity z-10 hover:bg-card dark:hover:bg-muted"
                      >
                        <MoreVertical className="w-4 h-4 text-neutral-600 dark:text-muted-foreground" />
                      </button>

                      {/* Message Menu Dropdown */}
                      <AnimatePresence>
                        {messageMenuOpen === msg.id && (
                          <m.div
                            initial={{ opacity: 0, scale: 0.95 }}
                            animate={{ opacity: 1, scale: 1 }}
                            exit={{ opacity: 0, scale: 0.95 }}
                            className={`absolute ${msg.role === "user" ? "right-0" : "left-0"} top-0 mt-8 bg-card dark:bg-muted rounded-2xl shadow-2xl border border-white/60 dark:border-border/60 py-2 z-20 min-w-[180px]`}
                          >
                            <button onClick={() => copyMessage(msg.text)} className="w-full px-4 py-2.5 flex items-center gap-3 hover:bg-muted dark:hover:bg-muted/50 transition-colors text-left">
                              <Copy className="w-4 h-4 text-neutral-500 dark:text-muted-foreground" />
                              <span className="text-sm font-medium text-neutral-700 dark:text-muted-foreground">Kopyala</span>
                            </button>
                            <button onClick={() => shareMessage(msg.text)} className="w-full px-4 py-2.5 flex items-center gap-3 hover:bg-muted dark:hover:bg-muted/50 transition-colors text-left">
                              <Share2 className="w-4 h-4 text-neutral-500 dark:text-muted-foreground" />
                              <span className="text-sm font-medium text-neutral-700 dark:text-muted-foreground">Paylaş</span>
                            </button>
                            <button onClick={() => archiveMessage(msg.id)} className="w-full px-4 py-2.5 flex items-center gap-3 hover:bg-muted dark:hover:bg-muted/50 transition-colors text-left">
                              <Archive className="w-4 h-4 text-neutral-500 dark:text-muted-foreground" />
                              <span className="text-sm font-medium text-neutral-700 dark:text-muted-foreground">Arşivle</span>
                            </button>
                            {msg.role === "user" && (
                              <button onClick={() => startEditMessage(msg.id, msg.text)} className="w-full px-4 py-2.5 flex items-center gap-3 hover:bg-muted dark:hover:bg-muted/50 transition-colors text-left">
                                <Edit2 className="w-4 h-4 text-neutral-500 dark:text-muted-foreground" />
                                <span className="text-sm font-medium text-neutral-700 dark:text-muted-foreground">Düzenle</span>
                              </button>
                            )}
                            <button onClick={() => deleteMessage(msg.id)} className="w-full px-4 py-2.5 flex items-center gap-3 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors text-left">
                              <Trash2 className="w-4 h-4 text-red-500" />
                              <span className="text-sm font-medium text-red-600 dark:text-red-400">Sil</span>
                            </button>
                          </m.div>
                        )}
                      </AnimatePresence>

                      {/* Message Bubble */}
                      <div className={`
                        max-w-[85%] md:max-w-[70%] rounded-4xl p-5 px-6 shadow-sm
                        ${msg.role === "user"
                          ? "bg-gradient-to-br from-brand to-brand text-white rounded-br-md shadow-indigo-500/20"
                          : "bg-white/80 dark:bg-muted/60 backdrop-blur-xl border border-white/80 dark:border-border/80 text-neutral-800 dark:text-foreground rounded-bl-md shadow-neutral-200/50 dark:shadow-none"}
                      `}>
                        {editingMessageId === msg.id ? (
                          <div className="space-y-3">
                            <textarea
                              value={editingText}
                              onChange={(e) => setEditingText(e.target.value)}
                              className="w-full bg-white/20 dark:bg-black/20 border border-white/30 dark:border-white/10 rounded-xl p-3 text-sm resize-none focus:outline-none focus:ring-2 focus:ring-white/50"
                              rows={3}
                            />
                            <div className="flex gap-2">
                              <button onClick={saveEdit} className="px-4 py-1.5 bg-white/20 hover:bg-white/30 rounded-lg text-xs font-bold transition-colors">
                                Kaydet
                              </button>
                              <button onClick={cancelEdit} className="px-4 py-1.5 bg-white/10 hover:bg-white/20 rounded-lg text-xs font-bold transition-colors">
                                İptal
                              </button>
                            </div>
                          </div>
                        ) : (
                          <p className="leading-relaxed whitespace-pre-wrap font-medium text-[15px]">{msg.text}</p>
                        )}
                      </div>
                    </div>

                    {/* Render Properties if AI suggested any */}
                    {msg.properties && (
                      <div className="mt-6 flex flex-col md:flex-row gap-5 w-full max-w-4xl overflow-x-auto pb-6 pt-2 pl-2 snap-x">
                        {msg.properties.map((prop, idx) => (
                          <div key={idx} className="flex-none w-80 bg-white/70 dark:bg-background/70 backdrop-blur-xl border border-white/80 dark:border-border/80 rounded-4xl overflow-hidden group cursor-pointer shadow-xl shadow-neutral-200/40 dark:shadow-none hover:shadow-2xl hover:shadow-indigo-500/20 dark:hover:shadow-indigo-500/10 transition-all hover:-translate-y-1 snap-center">
                            <div className="h-48 overflow-hidden relative m-2 rounded-3xl">
                              <Image src={prop.image} alt={prop.title} fill className="object-cover group-hover:scale-105 transition-transform duration-700 ease-out" loading="lazy" sizes="(max-width: 768px) 100vw, 400px" />
                              <div className="absolute top-3 right-3 px-3 py-1.5 bg-black/40 backdrop-blur-md rounded-full text-white text-sm font-bold border border-white/20">
                                {prop.price}
                              </div>
                            </div>
                            <div className="p-5 pt-3">
                              <h3 className="font-bold text-lg text-neutral-900 dark:text-white truncate mb-2 group-hover:text-brand dark:group-hover:text-brand transition-colors">{prop.title}</h3>
                              <div className="flex items-center gap-1.5 text-neutral-500 dark:text-muted-foreground mb-4 text-sm font-medium">
                                <MapPin className="w-4 h-4 text-brand dark:text-brand" />
                                <span className="truncate">{prop.location}</span>
                              </div>

                              <div className="h-px w-full bg-gradient-to-r from-transparent via-neutral-200 dark:via-slate-700 to-transparent mb-4" />

                              <div className="flex items-center justify-between text-neutral-600 dark:text-muted-foreground text-sm font-semibold">
                                <div className="flex gap-4">
                                  <span className="flex items-center gap-1.5 bg-neutral-100/80 dark:bg-muted/80 px-2.5 py-1 rounded-lg"><Bed className="w-4 h-4 text-neutral-400 dark:text-muted-foreground"/> {prop.beds}</span>
                                  <span className="flex items-center gap-1.5 bg-neutral-100/80 dark:bg-muted/80 px-2.5 py-1 rounded-lg"><Bath className="w-4 h-4 text-neutral-400 dark:text-muted-foreground"/> {prop.baths}</span>
                                </div>
                                <button aria-label="Go to property" className="w-8 h-8 rounded-full bg-brand/10 dark:bg-brand/30 text-brand dark:text-brand flex items-center justify-center group-hover:bg-primary text-primary-foreground dark:group-hover:bg-brand/100 group-hover:text-white transition-colors">
                                  <ArrowRight className="w-4 h-4" />
                                </button>
                              </div>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                ))}

                {aiIsLoading && (
                  <div className="flex items-start">
                    <div className="bg-white/80 dark:bg-muted/60 backdrop-blur-xl border border-white/80 dark:border-border/80 rounded-4xl rounded-bl-md p-5 px-6 flex items-center gap-2 shadow-sm dark:shadow-none">
                      <div className="flex gap-1.5">
                        <div className="w-2.5 h-2.5 bg-brand rounded-full animate-bounce" />
                        <div className="w-2.5 h-2.5 bg-brand/100 rounded-full animate-bounce delay-150" />
                        <div className="w-2.5 h-2.5 bg-primary text-primary-foreground rounded-full animate-bounce delay-300" />
                      </div>
                    </div>
                  </div>
                )}
                <div ref={aiMessagesEndRef} className="h-4" />
              </div>
            </div>

            {/* Floating Input Area */}
            <div className="flex-none p-4 md:p-8 bg-gradient-to-t from-[#fafafa] via-[#fafafa]/80 dark:from-[#0a0a0c] dark:via-[#0a0a0c]/80 to-transparent">
              <div className="max-w-4xl mx-auto relative group">
                <div className="absolute -inset-2 bg-gradient-to-r from-brand/20 to-brand/20 rounded-[2.5rem] blur-xl opacity-0 group-focus-within:opacity-100 transition duration-500"></div>

                <div className="relative flex items-center bg-white/70 dark:bg-background/70 backdrop-blur-2xl border border-white dark:border-border shadow-2xl shadow-indigo-900/5 dark:shadow-none rounded-[2.5rem] p-2 focus-within:bg-white/90 dark:focus-within:bg-background/90 transition-all">

                  <button aria-label="Voice input" className="p-4 text-neutral-400 dark:text-muted-foreground hover:text-brand dark:hover:text-brand transition-colors">
                    <Mic className="w-6 h-6" />
                  </button>

                  <textarea
                    value={aiInput}
                    onChange={(e) => setAiInput(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === "Enter" && !e.shiftKey) {
                        e.preventDefault();
                        handleAISend();
                      }
                    }}
                    placeholder="Aradığınız özellikleri Türkçe olarak tarif edin..."
                    className="flex-1 max-h-32 min-h-[60px] bg-transparent border-none focus:ring-0 resize-none py-4 px-2 text-neutral-900 dark:text-white placeholder:text-neutral-400 dark:placeholder:text-muted-foreground font-medium text-[17px]"
                    rows={1}
                  />

                  <button
                    onClick={handleAISend}
                    disabled={!aiInput.trim() || aiIsLoading}
                    aria-label="Send message"
                    className="m-1.5 p-4 bg-gradient-to-br from-brand to-brand hover:from-brand hover:to-brand disabled:from-neutral-300 disabled:to-neutral-300 disabled:text-neutral-500 dark:disabled:from-slate-800 dark:disabled:to-slate-800 dark:disabled:text-muted-foreground text-white rounded-[1.8rem] transition-all shrink-0 shadow-md shadow-indigo-500/25 dark:shadow-none active:scale-95"
                  >
                    <Send className="w-5 h-5 ml-0.5" />
                  </button>
                </div>
              </div>
              <p className="text-center text-[11px] font-medium text-neutral-400 dark:text-muted-foreground mt-4 tracking-wide uppercase">
                Reservatior AI hata yapabilir. Bilgileri doğrulayınız.
              </p>
            </div>
          </m.div>
        </m.div>
      )}
    </AnimatePresence>
  );
}
