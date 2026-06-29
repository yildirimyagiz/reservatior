import { useState, useRef, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Send, Sparkles, MapPin, Bed, Bath, ArrowRight, Mic, Zap } from "lucide-react";
import { useTranslation } from "react-i18next";
import { Link } from "react-router-dom";

// Note: Gemini API call is now proxied securely through the backend
const API_URL = import.meta.env.VITE_API_URL || "http://localhost:3000";

interface Message {
  id: string;
  role: "user" | "ai";
  text: string;
  properties?: any[];
}

export const HomeChat = () => {
  const { t } = useTranslation();
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

      // Kalan kredi bilgisini güncelle
      if (data.creditsRemaining !== undefined) {
        setCreditsRemaining(data.creditsRemaining);
      }
    } catch (error) {
      setMessages((prev) => [...prev, { id: Date.now().toString(), role: "ai", text: "Bağlantı hatası oluştu. Lütfen tekrar deneyin." }]);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="flex flex-col h-screen font-sans relative overflow-hidden bg-[#fafafa]">
      
      {/* Premium Background Mesh */}
      <div className="absolute inset-0 z-0 pointer-events-none overflow-hidden">
        <div className="absolute -top-[20%] -left-[10%] w-[50%] h-[50%] rounded-full bg-indigo-400/20 blur-[120px] mix-blend-multiply" />
        <div className="absolute top-[20%] -right-[10%] w-[40%] h-[60%] rounded-full bg-purple-400/20 blur-[120px] mix-blend-multiply" />
        <div className="absolute -bottom-[20%] left-[20%] w-[60%] h-[50%] rounded-full bg-blue-400/10 blur-[120px] mix-blend-multiply" />
      </div>

      {/* Top Navbar (Glass) */}
      <header className="flex-none p-6 flex justify-between items-center z-10 border-b border-white/40 bg-white/30 backdrop-blur-xl">
        <Link to="/" className="flex items-center gap-3 group">
          <div className="w-10 h-10 rounded-xl bg-linear-to-br from-indigo-500 to-purple-600 flex items-center justify-center shadow-lg shadow-indigo-500/30 group-hover:scale-105 transition-transform">
            <Sparkles className="w-5 h-5 text-white" />
          </div>
          <span className="font-bold text-2xl tracking-tight bg-clip-text text-transparent bg-linear-to-r from-indigo-950 to-neutral-800">
            Reservatior AI
          </span>
        </Link>
        <div className="flex items-center gap-3">
          {creditsRemaining !== null && (
            <div className="flex items-center gap-1.5 px-4 py-2 rounded-full bg-linear-to-r from-amber-50 to-orange-50 border border-amber-200/60 shadow-sm">
              <Zap className="w-4 h-4 text-amber-500" />
              <span className="text-sm font-bold text-amber-700">{creditsRemaining}</span>
              <span className="text-xs font-medium text-amber-500">kredi</span>
            </div>
          )}
          <Link to="/" className="px-5 py-2.5 rounded-full bg-white/50 hover:bg-white/80 border border-white/60 text-sm font-semibold text-neutral-700 hover:text-indigo-600 shadow-sm backdrop-blur-md transition-all">
            Ana Sayfaya Dön
          </Link>
        </div>
      </header>

      {/* Chat Area */}
      <div className="flex-1 overflow-y-auto p-4 md:p-8 z-10 scroll-smooth">
        <div className="max-w-4xl mx-auto space-y-8 pb-10">
          
          {messages.length === 0 && (
            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, ease: "easeOut" }}
              className="flex flex-col items-center justify-center h-[55vh] text-center space-y-8"
            >
              <div className="relative group">
                <div className="absolute -inset-4 bg-linear-to-r from-indigo-500 to-purple-500 rounded-full blur-xl opacity-30 group-hover:opacity-50 transition duration-1000 animate-pulse" />
                <div className="relative w-20 h-20 bg-white/80 backdrop-blur-xl border border-white/60 rounded-3xl flex items-center justify-center shadow-2xl">
                  <Sparkles className="w-10 h-10 text-indigo-600" />
                </div>
              </div>
              
              <div className="space-y-4">
                <h1 className="text-5xl md:text-6xl font-extrabold tracking-tight text-neutral-900 drop-shadow-sm">
                  Nasıl bir yer <span className="text-transparent bg-clip-text bg-linear-to-r from-indigo-600 to-purple-500">arıyorsunuz?</span>
                </h1>
                <p className="text-neutral-500 text-xl max-w-2xl mx-auto font-medium">
                  Filtrelerle uğraşmayın. Hayalinizdeki evi veya yatırımı sadece kendi cümlelerinizle tarif edin.
                </p>
              </div>
              
              <div className="flex flex-wrap justify-center gap-3 mt-8 max-w-3xl">
                {["Kadıköy'de 35.000 TL'ye kadar kiralık 2+1", "10 kişilik, mangal yapılabilen günlük kiralık villa", "Bodrum'da denize sıfır, sigara içilebilen ev", "Site içerisinde, havuzlu 3+1 daire"].map((suggestion, i) => (
                  <motion.button 
                    key={suggestion}
                    initial={{ opacity: 0, scale: 0.9 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ delay: i * 0.1 }}
                    onClick={() => setInput(suggestion)}
                    className="px-5 py-3 bg-white/60 backdrop-blur-md border border-white hover:border-indigo-200 rounded-2xl text-sm font-semibold text-neutral-700 hover:text-indigo-700 hover:bg-white/90 hover:shadow-lg hover:shadow-indigo-500/10 transition-all active:scale-95"
                  >
                    {suggestion}
                  </motion.button>
                ))}
              </div>
            </motion.div>
          )}

          <AnimatePresence initial={false}>
            {messages.map((msg) => (
              <motion.div
                key={msg.id}
                initial={{ opacity: 0, y: 15, scale: 0.98 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                className={`flex flex-col ${msg.role === "user" ? "items-end" : "items-start"}`}
              >
                <div className={`
                  max-w-[85%] md:max-w-[70%] rounded-4xl p-5 px-6 shadow-sm
                  ${msg.role === "user" 
                    ? "bg-linear-to-br from-indigo-600 to-purple-600 text-white rounded-br-md shadow-indigo-500/20" 
                    : "bg-white/80 backdrop-blur-xl border border-white/80 text-neutral-800 rounded-bl-md shadow-neutral-200/50"}
                `}>
                  <p className="leading-relaxed whitespace-pre-wrap font-medium text-[15px]">{msg.text}</p>
                </div>

                {/* Render Properties if AI suggested any */}
                {msg.properties && (
                  <div className="mt-6 flex flex-col md:flex-row gap-5 w-full max-w-4xl overflow-x-auto pb-6 pt-2 pl-2 snap-x">
                    {msg.properties.map((prop, idx) => (
                      <motion.div 
                        key={idx}
                        initial={{ opacity: 0, x: 20 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: idx * 0.1 }}
                        className="flex-none w-80 bg-white/70 backdrop-blur-xl border border-white/80 rounded-4xl overflow-hidden group cursor-pointer shadow-xl shadow-neutral-200/40 hover:shadow-2xl hover:shadow-indigo-500/20 transition-all hover:-translate-y-1 snap-center"
                      >
                        <div className="h-48 overflow-hidden relative m-2 rounded-3xl">
                          <img src={prop.image} alt={prop.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700 ease-out" />
                          <div className="absolute top-3 right-3 px-3 py-1.5 bg-black/40 backdrop-blur-md rounded-full text-white text-sm font-bold border border-white/20">
                            {prop.price}
                          </div>
                        </div>
                        <div className="p-5 pt-3">
                          <h3 className="font-bold text-lg text-neutral-900 truncate mb-2 group-hover:text-indigo-600 transition-colors">{prop.title}</h3>
                          <div className="flex items-center gap-1.5 text-neutral-500 mb-4 text-sm font-medium">
                            <MapPin className="w-4 h-4 text-indigo-500" />
                            <span className="truncate">{prop.location}</span>
                          </div>
                          
                          <div className="h-px w-full bg-linear-to-r from-transparent via-neutral-200 to-transparent mb-4" />
                          
                          <div className="flex items-center justify-between text-neutral-600 text-sm font-semibold">
                            <div className="flex gap-4">
                              <span className="flex items-center gap-1.5 bg-neutral-100/80 px-2.5 py-1 rounded-lg"><Bed className="w-4 h-4 text-neutral-400"/> {prop.beds}</span>
                              <span className="flex items-center gap-1.5 bg-neutral-100/80 px-2.5 py-1 rounded-lg"><Bath className="w-4 h-4 text-neutral-400"/> {prop.baths}</span>
                            </div>
                            <button 
                              onClick={() => setSelectedPropertyForBooking(prop)}
                              className="w-8 h-8 rounded-full bg-indigo-50 text-indigo-600 flex items-center justify-center group-hover:bg-indigo-600 group-hover:text-white transition-colors"
                            >
                              <ArrowRight className="w-4 h-4" />
                            </button>
                          </div>
                        </div>
                      </motion.div>
                    ))}
                  </div>
                )}
              </motion.div>
            ))}
          </AnimatePresence>

          {isLoading && (
            <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="flex items-start">
              <div className="bg-white/80 backdrop-blur-xl border border-white/80 rounded-4xl rounded-bl-md p-5 px-6 flex items-center gap-2 shadow-sm">
                <div className="flex gap-1.5">
                  <div className="w-2.5 h-2.5 bg-indigo-400 rounded-full animate-bounce" />
                  <div className="w-2.5 h-2.5 bg-indigo-500 rounded-full animate-bounce delay-150" />
                  <div className="w-2.5 h-2.5 bg-indigo-600 rounded-full animate-bounce delay-300" />
                </div>
              </div>
            </motion.div>
          )}
          <div ref={messagesEndRef} className="h-4" />
        </div>
      </div>

      {/* Floating Input Area */}
      <div className="flex-none p-4 md:p-8 z-20 bg-linear-to-t from-[#fafafa] via-[#fafafa]/80 to-transparent">
        <div className="max-w-4xl mx-auto relative group">
          <div className="absolute -inset-2 bg-linear-to-r from-indigo-500/20 to-purple-500/20 rounded-[2.5rem] blur-xl opacity-0 group-focus-within:opacity-100 transition duration-500"></div>
          
          <div className="relative flex items-center bg-white/70 backdrop-blur-2xl border border-white shadow-2xl shadow-indigo-900/5 rounded-[2.5rem] p-2 focus-within:bg-white/90 transition-all">
            
            <button className="p-4 text-neutral-400 hover:text-indigo-600 transition-colors">
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
              placeholder="Yapay zekaya ne aradığınızı anlatın..."
              className="flex-1 max-h-32 min-h-[60px] bg-transparent border-none focus:ring-0 resize-none py-4 px-2 text-neutral-900 placeholder:text-neutral-400 font-medium text-[17px]"
              rows={1}
            />

            <button 
              onClick={handleSend}
              disabled={!input.trim() || isLoading}
              className="m-1.5 p-4 bg-linear-to-br from-indigo-600 to-purple-600 hover:from-indigo-500 hover:to-purple-500 disabled:from-neutral-300 disabled:to-neutral-300 disabled:text-neutral-500 text-white rounded-[1.8rem] transition-all shrink-0 shadow-md shadow-indigo-500/25 active:scale-95"
            >
              <Send className="w-5 h-5 ml-0.5" />
            </button>
          </div>
        </div>
        <p className="text-center text-[11px] font-medium text-neutral-400 mt-4 tracking-wide uppercase">
          Reservatior AI Hata Yapabilir • Bilgileri Doğrulayın
        </p>
      </div>

      {/* Pre-Booking Requirements Form Modal */}
      <AnimatePresence>
        {selectedPropertyForBooking && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-neutral-900/40 backdrop-blur-sm"
          >
            <motion.div
              initial={{ scale: 0.95, y: 20, opacity: 0 }}
              animate={{ scale: 1, y: 0, opacity: 1 }}
              exit={{ scale: 0.95, y: 20, opacity: 0 }}
              className="bg-white rounded-[2rem] shadow-2xl overflow-hidden w-full max-w-lg border border-white/60 relative"
            >
              {/* Header */}
              <div className="bg-linear-to-br from-indigo-600 to-purple-600 p-6 text-white text-center relative overflow-hidden">
                <div className="absolute top-0 right-0 -mt-4 -mr-4 w-24 h-24 bg-white/10 rounded-full blur-2xl" />
                <h2 className="text-2xl font-bold mb-1 relative z-10">Konaklama Ön Başvurusu</h2>
                <p className="text-indigo-100 text-sm font-medium relative z-10">
                  {selectedPropertyForBooking.title} için talebinizi hazırlayalım
                </p>
              </div>

              {/* Form Content */}
              <div className="p-6 space-y-6 bg-neutral-50/50">
                
                {/* Guest Count */}
                <div>
                  <label className="block text-sm font-bold text-neutral-700 mb-2">Konaklayacak Kişi Sayısı</label>
                  <div className="flex items-center gap-4 bg-white p-2 rounded-2xl border border-neutral-200 shadow-sm">
                    <button 
                      onClick={() => setBookingForm(p => ({ ...p, guestCount: Math.max(1, p.guestCount - 1) }))}
                      className="w-10 h-10 rounded-xl bg-neutral-100 text-neutral-600 hover:bg-neutral-200 hover:text-neutral-900 transition-colors flex items-center justify-center font-bold text-xl"
                    >-</button>
                    <div className="flex-1 text-center font-black text-xl text-indigo-950">{bookingForm.guestCount} Kişi</div>
                    <button 
                      onClick={() => setBookingForm(p => ({ ...p, guestCount: p.guestCount + 1 }))}
                      className="w-10 h-10 rounded-xl bg-indigo-50 text-indigo-600 hover:bg-indigo-100 hover:text-indigo-700 transition-colors flex items-center justify-center font-bold text-xl"
                    >+</button>
                  </div>
                </div>

                {/* Toggles */}
                <div className="grid grid-cols-2 gap-4">
                  <button 
                    onClick={() => setBookingForm(p => ({ ...p, smoking: !p.smoking }))}
                    className={`flex flex-col items-center justify-center p-4 rounded-2xl border-2 transition-all ${
                      bookingForm.smoking 
                        ? "border-indigo-500 bg-indigo-50 text-indigo-700 shadow-md shadow-indigo-500/10" 
                        : "border-neutral-200 bg-white text-neutral-500 hover:border-neutral-300 hover:bg-neutral-50"
                    }`}
                  >
                    <div className={`w-3 h-3 rounded-full mb-2 ${bookingForm.smoking ? "bg-indigo-500" : "bg-neutral-300"}`} />
                    <span className="font-bold text-sm">Sigara Kullanımı</span>
                    <span className="text-[11px] font-medium opacity-70">Ev içinde / Balkonda</span>
                  </button>

                  <button 
                    onClick={() => setBookingForm(p => ({ ...p, bbq: !p.bbq }))}
                    className={`flex flex-col items-center justify-center p-4 rounded-2xl border-2 transition-all ${
                      bookingForm.bbq 
                        ? "border-orange-500 bg-orange-50 text-orange-700 shadow-md shadow-orange-500/10" 
                        : "border-neutral-200 bg-white text-neutral-500 hover:border-neutral-300 hover:bg-neutral-50"
                    }`}
                  >
                    <div className={`w-3 h-3 rounded-full mb-2 ${bookingForm.bbq ? "bg-orange-500" : "bg-neutral-300"}`} />
                    <span className="font-bold text-sm">Mangal / Barbekü</span>
                    <span className="text-[11px] font-medium opacity-70">Bahçe veya Terasta</span>
                  </button>
                </div>

                {/* Details */}
                <div>
                  <label className="block text-sm font-bold text-neutral-700 mb-2">Misafir Profili & Ziyaret Amacı</label>
                  <textarea 
                    value={bookingForm.guestDetails}
                    onChange={(e) => setBookingForm(p => ({ ...p, guestDetails: e.target.value }))}
                    placeholder="Örn: 2 aile tatil için geliyoruz. 2 çocuğumuz var. Sessiz, sakin bir konaklama arıyoruz..."
                    className="w-full h-28 p-4 rounded-2xl bg-white border border-neutral-200 focus:border-indigo-500 focus:ring-4 focus:ring-indigo-500/10 outline-none resize-none transition-all text-sm font-medium text-neutral-800 placeholder:text-neutral-400 shadow-sm"
                  />
                </div>
              </div>

              {/* Footer Actions */}
              <div className="p-6 bg-white border-t border-neutral-100 flex gap-3">
                <button 
                  onClick={() => setSelectedPropertyForBooking(null)}
                  className="flex-1 py-3.5 rounded-xl font-bold text-neutral-600 bg-neutral-100 hover:bg-neutral-200 transition-colors"
                >
                  İptal
                </button>
                <button 
                  onClick={() => {
                    // Send this application data to backend via AI or direct
                    setInput(`${selectedPropertyForBooking.title} için kiralama başvurusunu tamamla. Kişi: ${bookingForm.guestCount}, Sigara: ${bookingForm.smoking?'Var':'Yok'}, Mangal: ${bookingForm.bbq?'İstiyorum':'İstemiyorum'}, Detaylar: ${bookingForm.guestDetails || 'Belirtilmedi'}`);
                    setSelectedPropertyForBooking(null);
                    setTimeout(handleSend, 100);
                  }}
                  className="flex-[2] py-3.5 rounded-xl font-bold text-white bg-linear-to-r from-indigo-600 to-purple-600 hover:from-indigo-500 hover:to-purple-500 shadow-lg shadow-indigo-500/25 active:scale-95 transition-all"
                >
                  Talebi Gönder
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};

export default HomeChat;
