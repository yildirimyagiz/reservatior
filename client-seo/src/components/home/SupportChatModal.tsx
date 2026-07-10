import React, { useState, useRef, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Sparkles, X, Send, Paperclip } from "lucide-react";

interface SupportMessage {
  id: string;
  role: "user" | "support" | "ai";
  text: string;
  attachments?: string[];
  metadata?: {
    category?: string;
    priority?: string;
    assignedTeam?: string;
    suggestedSolution?: string;
    responseTime?: string;
    escalation?: any;
    fileAnalysis?: any[];
    aiAnalyzed?: boolean;
    confidence?: number;
    detectedLanguage?: string;
    localizedGreeting?: string;
  };
}

export function SupportChatModal({ isOpen, onClose }: { isOpen: boolean; onClose: () => void }) {
  const [supportMessages, setSupportMessages] = useState<SupportMessage[]>([]);
  const [supportInput, setSupportInput] = useState("");
  const [supportIsLoading, setSupportIsLoading] = useState(false);
  const [attachments, setAttachments] = useState<string[]>([]);
  const supportMessagesEndRef = useRef<HTMLDivElement>(null);

  const scrollToSupportBottom = () => {
    supportMessagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToSupportBottom();
  }, [supportMessages]);

  const handleSupportSend = async () => {
    if (!supportInput.trim() && attachments.length === 0) return;

    const userMessage: SupportMessage = {
      id: Date.now().toString(),
      role: "user",
      text: supportInput,
      attachments: attachments.length > 0 ? attachments : undefined
    };
    setSupportMessages((prev) => [...prev, userMessage]);
    setSupportInput("");
    setAttachments([]);
    setSupportIsLoading(true);

    try {
      const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000";
      const response = await fetch(`${API_URL}/tickets/ai-suggest`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message: userMessage.text, attachments: userMessage.attachments })
      });

      const data = await response.json();

      setSupportMessages((prev) => [...prev, {
        id: (Date.now() + 1).toString(),
        role: "ai",
        text: data.suggestion || "Sorununuzu anladım. Size yardımcı olmak için bir destek talebi oluşturuluyor...",
        metadata: {
          category: data.category,
          priority: data.priority,
          assignedTeam: data.assigned_team,
          suggestedSolution: data.suggested_solution,
          responseTime: data.response_time,
          escalation: data.escalation,
          fileAnalysis: data.file_analysis,
          aiAnalyzed: data.ai_analyzed,
          confidence: data.confidence,
          detectedLanguage: data.detected_language,
          localizedGreeting: data.localized_greeting
        }
      }]);

      if (data.createTicket) {
        const ticketResponse = await fetch(`${API_URL}/tickets`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            subject: data.subject || "Destek Talebi",
            description: userMessage.text,
            priority: data.priority || "MEDIUM"
          })
        });
        const ticketData = await ticketResponse.json();

        setSupportMessages((prev) => [...prev, {
          id: (Date.now() + 2).toString(),
          role: "support",
          text: `Talebiniz oluşturuldu. Ticket ID: ${ticketData.data?.id || ticketData.id}. En kısa sürede size dönüş yapacağız.`
        }]);
      }
    } catch {
      setSupportMessages((prev) => [...prev, {
        id: (Date.now() + 1).toString(),
        role: "support",
        text: "Şu anda bağlantı sorunu yaşıyoruz. Lütfen daha sonra tekrar deneyin veya destek@reservatior.com adresine e-posta gönderin."
      }]);
    } finally {
      setSupportIsLoading(false);
    }
  };

  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;

    const file = files[0];
    const formData = new FormData();
    formData.append("file", file);

    try {
      const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000";
      const response = await fetch(`${API_URL}/api/v1/ticket/upload`, {
        method: "POST",
        body: formData
      });

      const data = await response.json();
      setAttachments(prev => [...prev, data.url]);
    } catch {
      alert("Dosya yüklenirken hata oluştu");
    }
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          initial={{ opacity: 0, scale: 0.8, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.8, y: 20 }}
          className="fixed bottom-24 right-6 z-[100] w-[380px] h-[500px] bg-white dark:bg-[#0a0a0c] rounded-3xl shadow-2xl overflow-hidden flex flex-col border border-white/60 dark:border-slate-800"
        >
          {/* Header */}
          <div className="flex-none p-4 flex justify-between items-center border-b border-slate-200 dark:border-slate-800 bg-slate-50 dark:bg-[#14151a]">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-blue-500 to-cyan-500 flex items-center justify-center">
                <Sparkles className="w-5 h-5 text-white" />
              </div>
              <div>
                <span className="font-bold text-slate-900 dark:text-white">AI Support</span>
                <p className="text-xs text-green-500 font-medium">● Online</p>
              </div>
            </div>
            <button onClick={onClose} className="p-2 rounded-full hover:bg-slate-200 dark:hover:bg-slate-800 transition-colors">
              <X className="w-5 h-5 text-slate-600 dark:text-slate-400" />
            </button>
          </div>

          {/* Chat Area */}
          <div className="flex-1 overflow-y-auto p-4 space-y-4">
            {supportMessages.length === 0 && (
              <div className="flex flex-col items-center justify-center h-full text-center space-y-4">
                <div className="w-16 h-16 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center">
                  <Sparkles className="w-8 h-8 text-blue-600 dark:text-blue-400" />
                </div>
                <div>
                  <p className="font-bold text-slate-900 dark:text-white">How can I help you?</p>
                  <p className="text-sm text-slate-500 dark:text-slate-400 mt-1">Describe your issue, share files</p>
                </div>
              </div>
            )}

            {supportMessages.map((msg) => (
              <div key={msg.id} className={`flex ${msg.role === "user" ? "justify-end" : "justify-start"}`}>
                <div className={`max-w-[80%] rounded-2xl p-3 ${
                  msg.role === "user"
                    ? "bg-blue-600 text-white rounded-br-md"
                    : msg.role === "ai"
                    ? "bg-gradient-to-br from-purple-500 to-indigo-600 text-white rounded-bl-md"
                    : "bg-slate-100 dark:bg-slate-800 text-slate-900 dark:text-slate-100 rounded-bl-md"
                }`}>
                  {msg.role === "ai" && (
                    <div className="flex items-center gap-2 mb-2">
                      <Sparkles className="w-3 h-3" />
                      <span className="text-xs font-bold opacity-80">AI Assistant</span>
                      {msg.metadata?.detectedLanguage && (
                        <span className="text-xs bg-white/20 px-2 py-0.5 rounded-full uppercase">
                          {msg.metadata.detectedLanguage}
                        </span>
                      )}
                      {msg.metadata?.aiAnalyzed && (
                        <span className="text-xs bg-white/20 px-2 py-0.5 rounded-full">
                          {msg.metadata.confidence && `${Math.round(msg.metadata.confidence * 100)}% confidence`}
                        </span>
                      )}
                    </div>
                  )}
                  <p className="text-sm">{msg.metadata?.localizedGreeting || msg.text}</p>
                  {msg.metadata && (
                    <div className="mt-2 space-y-1">
                      {msg.metadata.category && (
                        <div className="text-xs bg-white/20 rounded px-2 py-1">
                          Category: <span className="font-semibold">{msg.metadata.category}</span>
                        </div>
                      )}
                      {msg.metadata.priority && (
                        <div className={`text-xs rounded px-2 py-1 ${
                          msg.metadata.priority === 'CRITICAL' ? 'bg-red-500/30' :
                          msg.metadata.priority === 'HIGH' ? 'bg-orange-500/30' :
                          msg.metadata.priority === 'MEDIUM' ? 'bg-yellow-500/30' :
                          'bg-green-500/30'
                        }`}>
                          Priority: <span className="font-semibold">{msg.metadata.priority}</span>
                        </div>
                      )}
                      {msg.metadata.assignedTeam && (
                        <div className="text-xs bg-white/20 rounded px-2 py-1">
                          Assigned to: <span className="font-semibold">{msg.metadata.assignedTeam}</span>
                        </div>
                      )}
                      {msg.metadata.responseTime && (
                        <div className="text-xs bg-white/20 rounded px-2 py-1">
                          Response time: <span className="font-semibold">{msg.metadata.responseTime}</span>
                        </div>
                      )}
                      {msg.metadata.suggestedSolution && (
                        <div className="text-xs bg-white/10 rounded px-2 py-1 mt-2">
                          <span className="font-semibold">Suggested:</span> {msg.metadata.suggestedSolution}
                        </div>
                      )}
                    </div>
                  )}
                  {msg.attachments && msg.attachments.length > 0 && (
                    <div className="mt-2 space-y-1">
                      {msg.attachments.map((url, idx) => (
                        <div key={idx} className="text-xs bg-white/20 rounded px-2 py-1">
                          📎 File attached
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              </div>
            ))}

            {supportIsLoading && (
              <div className="flex justify-start">
                <div className="bg-slate-100 dark:bg-slate-800 rounded-2xl rounded-bl-md p-3">
                  <div className="flex gap-1">
                    <div className="w-2 h-2 bg-blue-500 rounded-full animate-bounce" />
                    <div className="w-2 h-2 bg-blue-500 rounded-full animate-bounce delay-100" />
                    <div className="w-2 h-2 bg-blue-500 rounded-full animate-bounce delay-200" />
                  </div>
                </div>
              </div>
            )}

            <div ref={supportMessagesEndRef} />
          </div>

          {/* Input Area */}
          <div className="flex-none p-4 border-t border-slate-200 dark:border-slate-800">
            {attachments.length > 0 && (
              <div className="flex gap-2 mb-2 overflow-x-auto">
                {attachments.map((url, idx) => (
                  <div key={idx} className="flex items-center gap-1 bg-slate-100 dark:bg-slate-800 rounded-full px-3 py-1 text-xs">
                    <span>📎 File</span>
                    <button onClick={() => setAttachments(prev => prev.filter((_, i) => i !== idx))} className="text-red-500 hover:text-red-700">×</button>
                  </div>
                ))}
              </div>
            )}
            <div className="flex gap-2">
              <label className="p-2 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors cursor-pointer">
                <input type="file" onChange={handleFileUpload} className="hidden" />
                <Paperclip className="w-5 h-5 text-slate-500" />
              </label>
              <input
                type="text"
                value={supportInput}
                onChange={(e) => setSupportInput(e.target.value)}
                onKeyDown={(e) => e.key === "Enter" && handleSupportSend()}
                placeholder="Describe your issue..."
                className="flex-1 px-4 py-2 rounded-full border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-900 text-slate-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
              <button
                onClick={handleSupportSend}
                disabled={supportIsLoading}
                className="px-4 py-2 bg-blue-600 hover:bg-blue-700 disabled:bg-slate-400 text-white rounded-full transition-colors"
              >
                <Send className="w-4 h-4" />
              </button>
            </div>
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
