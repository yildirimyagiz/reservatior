"use client";

import Image from "next/image";
import { useState, useRef, useEffect, useCallback } from "react";
import { m, AnimatePresence } from "framer-motion";
import { Send, Sparkles, MapPin, Bed, Bath, ArrowRight, Mic, Zap } from "lucide-react";
import { useTranslation } from "react-i18next";
import Link from "next/link";

const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000";

interface Message {
  id: string;
  role: "user" | "ai";
  text: string;
  properties?: any[];
}

export function AIChatContent() {
  const { t, i18n } = useTranslation();
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [creditsRemaining, setCreditsRemaining] = useState<number | null>(null);
  const [selectedPropertyForBooking, setSelectedPropertyForBooking] = useState<any | null>(null);
  const [bookingForm, setBookingForm] = useState({
    guestCount: 2,
    smoking: false,
    bbq: false,
    guestDetails: ""
  });
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages, isLoading]);

  useEffect(() => {
    const handleLanguageChange = () => {
      window.scrollTo(0, 0);
    };
    i18n.on("languageChanged", handleLanguageChange);
    return () => {
      i18n.off("languageChanged", handleLanguageChange);
    };
  }, []);

  const handleSend = async () => {
    if (!input.trim() || isLoading) return;

    const userMessage: Message = { id: Date.now().toString(), role: "user", text: input };
    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setIsLoading(true);

    try {
      const response = await fetch(`${API_URL}/api/v1/ai-search`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ query: userMessage.text })
      });

      const data = await response.json();

      if (data.error) throw new Error(data.error);

      setMessages((prev) => [...prev, {
        id: (Date.now() + 1).toString(),
        role: "ai",
        text: data.text,
        properties: data.properties?.length > 0 ? data.properties : undefined
      }]);

      if (data.creditsRemaining !== undefined) {
        setCreditsRemaining(data.creditsRemaining);
      }
    } catch (error) {
      setMessages((prev) => [...prev, { id: Date.now().toString(), role: "ai", text: t("client.src.connection_error_please_try_again") }]);
    } finally {
      setIsLoading(false);
    }
  };

  const suggestions = [
    t("client.src.suggestion_1"),
    t("client.src.suggestion_2"),
    t("client.src.suggestion_3"),
    t("client.src.suggestion_4")
  ];

  return (
    <div className="flex flex-col h-full font-sans relative overflow-hidden bg-[#fafafa] dark:bg-[#0a0a0c]">

      {/* Premium Background Mesh */}
      <div className="absolute inset-0 z-0 pointer-events-none overflow-hidden">
        <div className="absolute -top-[20%] -left-[10%] w-[50%] h-[50%] rounded-full bg-brand/20 dark:bg-brand/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
        <div className="absolute top-[20%] -right-[10%] w-[40%] h-[60%] rounded-full bg-brand/20 dark:bg-brand/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
        <div className="absolute -bottom-[20%] left-[20%] w-[60%] h-[50%] rounded-full bg-blue-400/10 dark:bg-blue-600/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
      </div>

      {/* Top Navbar (Glass) */}
      <header className="flex-none p-6 flex justify-between items-center z-10 border-b border-white/40 dark:border-border/40 bg-white/30 dark:bg-background/30 backdrop-blur-xl">
        <Link href="/" className="flex items-center gap-3 group">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand to-brand flex items-center justify-center shadow-lg shadow-indigo-500/30 group-hover:scale-105 transition-transform">
            <Sparkles className="w-5 h-5 text-white" />
          </div>
          <span className="font-bold text-2xl tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-brand to-neutral-800 dark:from-white dark:to-slate-300">
            {t("chat.aichatcontent.auto_ext_1")}
                                </span>
        </Link>
        <div className="flex items-center gap-3">
          {creditsRemaining !== null && (
            <div className="flex items-center gap-1.5 px-4 py-2 rounded-full bg-gradient-to-r from-amber-50 to-orange-50 dark:from-amber-900/20 dark:to-orange-900/20 border border-amber-200/60 dark:border-amber-700/30 shadow-sm">
              <Zap className="w-4 h-4 text-amber-500 dark:text-amber-400" />
              <span className="text-sm font-bold text-amber-700 dark:text-amber-400">{creditsRemaining}</span>
              <span className="text-xs font-medium text-amber-500 dark:text-amber-500/80">{t("client.src.credit")}</span>
            </div>
          )}
          <Link href="/" className="px-5 py-2.5 rounded-full bg-white/50 dark:bg-muted/50 hover:bg-white/80 dark:hover:bg-muted/80 border border-white/60 dark:border-border/60 text-sm font-semibold text-neutral-700 dark:text-muted-foreground hover:text-brand dark:hover:text-brand shadow-sm backdrop-blur-md transition-all">
            {t("client.src.return_to_home")}
          </Link>
        </div>
      </header>

      {/* Chat Area */}
      <div className="flex-1 overflow-y-auto p-4 md:p-8 z-10 scroll-smooth">
        <div className="max-w-4xl mx-auto space-y-8 pb-10">

          {messages.length === 0 && (
            <m.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, ease: "easeOut" }}
              className="flex flex-col items-center justify-center h-[55vh] text-center space-y-8"
            >
              <div className="relative group">
                <div className="absolute -inset-4 bg-gradient-to-r from-brand to-brand rounded-full blur-xl opacity-30 group-hover:opacity-50 transition duration-1000 animate-pulse" />
                <div className="relative w-20 h-20 bg-white/80 dark:bg-background/80 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-3xl flex items-center justify-center shadow-2xl">
                  <Sparkles className="w-10 h-10 text-brand dark:text-brand" />
                </div>
              </div>

              <div className="space-y-4">
                <h1 className="text-5xl md:text-6xl font-extrabold tracking-tight text-neutral-900 dark:text-white drop-shadow-sm">
                  {t("client.src.what_kind_of_place_are_you_looking_for").split(" ")[0]} <span className="text-transparent bg-clip-text bg-gradient-to-r from-brand to-brand dark:from-brand dark:to-brand">{t("client.src.what_kind_of_place_are_you_looking_for").split(" ").slice(1).join(" ")}</span>
                </h1>
                <p className="text-neutral-500 dark:text-muted-foreground text-xl max-w-2xl mx-auto font-medium">
                  {t("client.src.dont_bother_with_filters_describe_your_dream_home")}
                </p>
              </div>

              <div className="flex flex-wrap justify-center gap-3 mt-8 max-w-3xl">
                {suggestions.map((suggestion, i) => (
                  <m.button
                    key={suggestion}
                    initial={{ opacity: 0, scale: 0.9 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ delay: i * 0.1 }}
                    onClick={() => setInput(suggestion)}
                    className="px-5 py-3 bg-white/60 dark:bg-muted/40 backdrop-blur-md border border-white dark:border-border hover:border-brand/30 dark:hover:border-brand/50 rounded-2xl text-sm font-semibold text-neutral-700 dark:text-muted-foreground hover:text-brand dark:hover:text-brand hover:bg-white/90 dark:hover:bg-muted/80 hover:shadow-lg hover:shadow-indigo-500/10 dark:hover:shadow-indigo-500/5 transition-all active:scale-95"
                  >
                    {suggestion}
                  </m.button>
                ))}
              </div>
            </m.div>
          )}

          <AnimatePresence initial={false}>
            {messages.map((msg) => (
              <m.div
                key={msg.id}
                initial={{ opacity: 0, y: 15, scale: 0.98 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                className={`flex flex-col ${msg.role === "user" ? "items-end" : "items-start"}`}
              >
                <div className={`
                  max-w-[85%] md:max-w-[70%] rounded-4xl p-5 px-6 shadow-sm
                  ${msg.role === "user"
                    ? "bg-gradient-to-br from-brand to-brand text-white rounded-br-md shadow-indigo-500/20"
                    : "bg-white/80 dark:bg-muted/60 backdrop-blur-xl border border-white/80 dark:border-border/80 text-neutral-800 dark:text-foreground rounded-bl-md shadow-neutral-200/50 dark:shadow-none"}
                `}>
                  <p className="leading-relaxed whitespace-pre-wrap font-medium text-[15px]">{msg.text}</p>
                </div>

                {msg.properties && (
                  <div className="mt-6 flex flex-col md:flex-row gap-5 w-full max-w-4xl overflow-x-auto pb-6 pt-2 pl-2 snap-x">
                    {msg.properties.map((prop, idx) => (
                      <m.div
                        key={idx}
                        initial={{ opacity: 0, x: 20 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: idx * 0.1 }}
                        className="flex-none w-80 bg-white/70 dark:bg-background/70 backdrop-blur-xl border border-white/80 dark:border-border/80 rounded-4xl overflow-hidden group cursor-pointer shadow-xl shadow-neutral-200/40 dark:shadow-none hover:shadow-2xl hover:shadow-indigo-500/20 dark:hover:shadow-indigo-500/10 transition-all hover:-translate-y-1 snap-center"
                      >
                        <div className="h-48 overflow-hidden relative m-2 rounded-3xl">
                          <Image src={prop.image} alt={prop.title} fill loading="lazy" className="object-cover group-hover:scale-105 transition-transform duration-700 ease-out" sizes="320px" />
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
                            <button
                              onClick={() => setSelectedPropertyForBooking(prop)}
                              aria-label="Book property"
                              className="w-8 h-8 rounded-full bg-brand/10 dark:bg-brand/30 text-brand dark:text-brand flex items-center justify-center group-hover:bg-brand dark:group-hover:bg-brand/100 group-hover:text-white transition-colors"
                            >
                              <ArrowRight className="w-4 h-4" />
                            </button>
                          </div>
                        </div>
                      </m.div>
                    ))}
                  </div>
                )}
              </m.div>
            ))}
          </AnimatePresence>

          {isLoading && (
            <m.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="flex items-start">
              <div className="bg-white/80 dark:bg-muted/60 backdrop-blur-xl border border-white/80 dark:border-border/80 rounded-4xl rounded-bl-md p-5 px-6 flex items-center gap-2 shadow-sm dark:shadow-none">
                <div className="flex gap-1.5">
                  <div className="w-2.5 h-2.5 bg-brand rounded-full animate-bounce" />
                  <div className="w-2.5 h-2.5 bg-brand/100 rounded-full animate-bounce delay-150" />
                  <div className="w-2.5 h-2.5 bg-brand rounded-full animate-bounce delay-300" />
                </div>
              </div>
            </m.div>
          )}
          <div ref={messagesEndRef} className="h-4" />
        </div>
      </div>

      {/* Floating Input Area */}
      <div className="flex-none p-4 md:p-8 z-20 bg-gradient-to-t from-[#fafafa] via-[#fafafa]/80 dark:from-[#0a0a0c] dark:via-[#0a0a0c]/80 to-transparent">
        <div className="max-w-4xl mx-auto relative group">
          <div className="absolute -inset-2 bg-gradient-to-r from-brand/20 to-brand/20 rounded-[2.5rem] blur-xl opacity-0 group-focus-within:opacity-100 transition duration-500"></div>

          <div className="relative flex items-center bg-white/70 dark:bg-background/70 backdrop-blur-2xl border border-white dark:border-border shadow-2xl shadow-indigo-900/5 dark:shadow-none rounded-[2.5rem] p-2 focus-within:bg-white/90 dark:focus-within:bg-background/90 transition-all">

            <button aria-label="Voice input" className="p-4 text-neutral-400 dark:text-muted-foreground hover:text-brand dark:hover:text-brand transition-colors">
              <Mic className="w-6 h-6" />
            </button>

            <textarea
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === "Enter" && !e.shiftKey) {
                  e.preventDefault();
                  handleSend();
                }
              }}
              placeholder={t("client.src.tell_ai_what_you_are_looking_for")}
              className="flex-1 max-h-32 min-h-[60px] bg-transparent border-none focus:ring-0 resize-none py-4 px-2 text-neutral-900 dark:text-white placeholder:text-neutral-400 dark:placeholder:text-muted-foreground font-medium text-[17px]"
              rows={1}
            />

            <button
              onClick={handleSend}
              disabled={!input.trim() || isLoading}
              aria-label="Send message"
              className="m-1.5 p-4 bg-gradient-to-br from-brand to-brand hover:from-brand hover:to-brand disabled:from-neutral-300 disabled:to-neutral-300 disabled:text-neutral-500 dark:disabled:from-slate-800 dark:disabled:to-slate-800 dark:disabled:text-muted-foreground text-white rounded-[1.8rem] transition-all shrink-0 shadow-md shadow-indigo-500/25 dark:shadow-none active:scale-95"
            >
              <Send className="w-5 h-5 ml-0.5" />
            </button>
          </div>
        </div>
        <p className="text-center text-[11px] font-medium text-neutral-400 dark:text-muted-foreground mt-4 tracking-wide uppercase">
          {t("client.src.reservatior_ai_can_make_mistakes_verify_information")}
        </p>
      </div>

      {/* Pre-Booking Requirements Form Modal */}
      <AnimatePresence>
        {selectedPropertyForBooking && (
          <m.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-neutral-900/40 dark:bg-black/60 backdrop-blur-sm"
          >
            <m.div
              initial={{ scale: 0.95, y: 20, opacity: 0 }}
              animate={{ scale: 1, y: 0, opacity: 1 }}
              exit={{ scale: 0.95, y: 20, opacity: 0 }}
              className="bg-card dark:bg-background rounded-4xl shadow-2xl overflow-hidden w-full max-w-lg border border-white/60 dark:border-border relative"
            >
              {/* Header */}
              <div className="bg-gradient-to-br from-brand to-brand p-6 text-white text-center relative overflow-hidden">
                <div className="absolute top-0 right-0 -mt-4 -mr-4 w-24 h-24 bg-white/10 rounded-full blur-2xl" />
                <h2 className="text-2xl font-bold mb-1 relative z-10">{t("client.src.accommodation_pre_application")}</h2>
                <p className="text-brand text-sm font-medium relative z-10">
                  {selectedPropertyForBooking.title} {t("client.src.let_us_prepare_your_request_for")}
                </p>
              </div>

              {/* Form Content */}
              <div className="p-6 space-y-6 bg-neutral-50/50 dark:bg-transparent">

                {/* Guest Count */}
                <div>
                  <label className="block text-sm font-bold text-neutral-700 dark:text-muted-foreground mb-2">{t("client.src.number_of_guests")}</label>
                  <div className="flex items-center gap-4 bg-card dark:bg-[#0a0a0c] p-2 rounded-2xl border border-neutral-200 dark:border-border shadow-sm">
                    <button
                      onClick={() => setBookingForm(p => ({ ...p, guestCount: Math.max(1, p.guestCount - 1) }))}
                      className="w-10 h-10 rounded-xl bg-neutral-100 dark:bg-muted text-neutral-600 dark:text-muted-foreground hover:bg-neutral-200 dark:hover:bg-muted hover:text-neutral-900 dark:hover:text-white transition-colors flex items-center justify-center font-bold text-xl"
                    >-</button>
                    <div className="flex-1 text-center font-black text-xl text-brand dark:text-brand">{bookingForm.guestCount} {t("client.src.person")}</div>
                    <button
                      onClick={() => setBookingForm(p => ({ ...p, guestCount: p.guestCount + 1 }))}
                      className="w-10 h-10 rounded-xl bg-brand/10 dark:bg-brand/30 text-brand dark:text-brand hover:bg-brand/15 dark:hover:bg-brand/50 hover:text-brand dark:hover:text-brand transition-colors flex items-center justify-center font-bold text-xl"
                    >+</button>
                  </div>
                </div>

                {/* Toggles */}
                <div className="grid grid-cols-2 gap-4">
                  <button
                    onClick={() => setBookingForm(p => ({ ...p, smoking: !p.smoking }))}
                    className={`flex flex-col items-center justify-center p-4 rounded-2xl border-2 transition-all ${
                      bookingForm.smoking
                        ? "border-brand/30 bg-brand/10 dark:bg-brand/20 text-brand dark:text-brand shadow-md shadow-indigo-500/10 dark:shadow-none"
                        : "border-neutral-200 dark:border-border bg-card dark:bg-[#0a0a0c] text-neutral-500 dark:text-muted-foreground hover:border-neutral-300 dark:hover:border-border hover:bg-neutral-50 dark:hover:bg-card/50"
                    }`}
                  >
                    <div className={`w-3 h-3 rounded-full mb-2 ${bookingForm.smoking ? "bg-brand/100" : "bg-neutral-300 dark:bg-muted"}`} />
                    <span className="font-bold text-sm">{t("client.src.smoking")}</span>
                    <span className="text-[11px] font-medium opacity-70">{t("client.src.indoors_on_balcony")}</span>
                  </button>

                  <button
                    onClick={() => setBookingForm(p => ({ ...p, bbq: !p.bbq }))}
                    className={`flex flex-col items-center justify-center p-4 rounded-2xl border-2 transition-all ${
                      bookingForm.bbq
                        ? "border-orange-500 bg-orange-50 dark:bg-orange-900/20 text-orange-700 dark:text-orange-300 shadow-md shadow-orange-500/10 dark:shadow-none"
                        : "border-neutral-200 dark:border-border bg-card dark:bg-[#0a0a0c] text-neutral-500 dark:text-muted-foreground hover:border-neutral-300 dark:hover:border-border hover:bg-neutral-50 dark:hover:bg-card/50"
                    }`}
                  >
                    <div className={`w-3 h-3 rounded-full mb-2 ${bookingForm.bbq ? "bg-orange-500" : "bg-neutral-300 dark:bg-muted"}`} />
                    <span className="font-bold text-sm">{t("client.src.bbq_grill")}</span>
                    <span className="text-[11px] font-medium opacity-70">{t("client.src.in_garden_or_terrace")}</span>
                  </button>
                </div>

                {/* Details */}
                <div>
                  <label className="block text-sm font-bold text-neutral-700 dark:text-muted-foreground mb-2">{t("client.src.guest_profile_visit_purpose")}</label>
                  <textarea
                    value={bookingForm.guestDetails}
                    onChange={(e) => setBookingForm(p => ({ ...p, guestDetails: e.target.value }))}
                    placeholder={t("client.src.guest_profile_placeholder")}
                    className="w-full h-28 p-4 rounded-2xl bg-card dark:bg-[#0a0a0c] border border-neutral-200 dark:border-border focus:border-brand/30 dark:focus:border-brand/30 focus:ring-4 focus:ring-indigo-500/10 outline-none resize-none transition-all text-sm font-medium text-neutral-800 dark:text-foreground placeholder:text-neutral-400 dark:placeholder:text-muted-foreground shadow-sm"
                  />
                </div>
              </div>

              {/* Footer Actions */}
              <div className="p-6 bg-card dark:bg-background border-t border-neutral-100 dark:border-border flex gap-3">
                <button
                  onClick={() => setSelectedPropertyForBooking(null)}
                  className="flex-1 py-3.5 rounded-xl font-bold text-neutral-600 dark:text-muted-foreground bg-neutral-100 dark:bg-muted hover:bg-neutral-200 dark:hover:bg-muted transition-colors"
                >
                  {t("common.cancel")}
                </button>
                <button
                  onClick={() => {
                    setInput(`${selectedPropertyForBooking.title} ${t("client.src.complete_rental_application_for_person")} ${bookingForm.guestCount}, ${t("client.src.smoking_label")} ${bookingForm.smoking?t("client.src.yes"):t("client.src.no")}, ${t("client.src.bbq_label")} ${bookingForm.bbq?t("client.src.i_want"):t("client.src.i_dont_want")}, ${t("client.src.details_label")} ${bookingForm.guestDetails || t("client.src.not_specified")}`);
                    setSelectedPropertyForBooking(null);
                    setTimeout(handleSend, 100);
                  }}
                  className="flex-2 py-3.5 rounded-xl font-bold text-white bg-gradient-to-r from-brand to-brand hover:from-brand hover:to-brand shadow-lg shadow-indigo-500/25 dark:shadow-none active:scale-95 transition-all"
                >
                  {t("client.src.submit_request")}
                </button>
              </div>
            </m.div>
          </m.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export default AIChatContent;
