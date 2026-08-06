import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useRef } from "react";
import { X, Send, Sparkles, Bot, User, ArrowRightLeft, Paperclip, Minimize2 } from "lucide-react";
import { m } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { ScrollArea } from "@/components/ui/scroll-area";
import { ticketsApi } from "@/lib/api/tickets";
import { useToast } from "@/hooks/use-toast";
interface Message {
  role: 'USER' | 'ASSISTANT';
  content: string;
  isAI?: boolean;
}
export default function AIChatWindow({
  onClose
}: {
  onClose?: () => void;
}) {
  const {
    t
  } = useTranslation();
  const [messages, setMessages] = useState<Message[]>([{
    role: 'ASSISTANT',
    content: "Hello! I'm your AI Boutique assistant. How can I help you find your dream property today?",
    isAI: true
  }]);
  const [input, setInput] = useState("");
  const [isTyping, setIsTyping] = useState(false);
  const [isMinimized, setIsMinimized] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);
  const {
    toast
  } = useToast();
  const [isEscalated, setIsEscalated] = useState(false);
  const handleEscalate = async () => {
    setIsTyping(true);
    try {
      await ticketsApi.createTicket({
        subject: "Support Request from AI Chat",
        description: `User requested manual assistance. Current chat history:\n${messages.map(m => `${m.role}: ${m.content}`).join('\n')}`
      });
      setIsEscalated(true);
      setMessages(prev => [...prev, {
        role: 'ASSISTANT',
        content: "I've created a support ticket for you. A human agent will join this conversation shortly. How else can I help you while you wait?",
        isAI: true
      }]);
      toast({
        title: t("client.src.support_ticket_created"),
        description: t("client.src.an_agent_will_review")
      });
    } catch (error) {
      toast({
        title: t("client.src.escalation_failed"),
        description: t("client.src.could_not_create_a"),
        variant: "destructive"
      });
    } finally {
      setIsTyping(false);
    }
  };
  const handleSend = async () => {
    if (!input.trim()) return;
    const userMessage = input;
    setInput("");
    setMessages(prev => [...prev, {
      role: 'USER',
      content: userMessage
    }]);
    setIsTyping(true);
    try {
      // Real API call would go here
      // const response = await aiChatApi.sendMessage(sessionId, userMessage);

      // Simulated AI response
      setTimeout(() => {
        setMessages(prev => [...prev, {
          role: 'ASSISTANT',
          content: "I'm processing your request. Our system identifies this as a high-priority inquiry. Would you like me to connect you with a live agent?",
          isAI: true
        }]);
        setIsTyping(false);
      }, 1500);
    } catch (error) {
      console.error("AI Chat failed:", error);
      setIsTyping(false);
    }
  };
  if (isMinimized) {
    return <m.div layoutId="chat-window" className="fixed bottom-4 right-4 z-50">
        <Button onClick={() => setIsMinimized(false)} className="rounded-full w-14 h-14 bg-purple-600 hover:bg-purple-700 shadow-xl border-none p-0 flex items-center justify-center group">
          <Sparkles className="w-6 h-6 text-white group-hover:scale-110 transition-transform" />
          <Badge className="absolute -top-1 -right-1 bg-red-500 border-none w-5 h-5 p-0 flex items-center justify-center">1</Badge>
        </Button>
      </m.div>;
  }
  return <m.div layoutId="chat-window" initial={{
    opacity: 0,
    y: 20,
    scale: 0.95
  }} animate={{
    opacity: 1,
    y: 0,
    scale: 1
  }} exit={{
    opacity: 0,
    y: 20,
    scale: 0.95
  }} className="fixed bottom-4 right-4 w-[400px] h-[600px] bg-white rounded-2xl shadow-2xl z-50 border ring-1 ring-black/5 flex flex-col overflow-hidden">
      {/* Header */}
      <div className="p-4 bg-purple-600 text-white flex items-center justify-between shadow-lg relative z-10">
        <div className="flex items-center gap-3">
          <div className="relative">
            <Avatar className="w-10 h-10 border-2 border-white/20">
              <AvatarFallback className="bg-purple-500 text-white">
                <Sparkles className="w-5 h-5" />
              </AvatarFallback>
            </Avatar>
            <div className="absolute bottom-0 right-0 w-3 h-3 bg-blue-400 border-2 border-purple-600 rounded-full"></div>
          </div>
          <div>
            <h3 className="font-bold text-sm">{t("client.src.ai_boutique")}</h3>
            <p className="text-[10px] text-purple-100 uppercase tracking-widest font-semibold flex items-center gap-1">
              <span className="w-1 h-1 rounded-full bg-blue-400"></span>{t("client.src.virtual_concierge")}</p>
          </div>
        </div>
        <div className="flex items-center gap-1">
          <Button variant="ghost" size="icon" aria-label={t("common.collapse")} className="w-8 h-8 text-white hover:bg-white/10" onClick={() => setIsMinimized(true)}>
            <Minimize2 className="w-4 h-4" />
          </Button>
          <Button variant="ghost" size="icon" aria-label={t("common.close")} className="w-8 h-8 text-white hover:bg-white/10" onClick={onClose}>
            <X className="w-4 h-4" />
          </Button>
        </div>
      </div>

      {/* Messages area */}
      <ScrollArea className="flex-1 p-4 bg-gray-50/50" ref={scrollRef}>
        <div className="space-y-4">
          {messages.map((msg, i) => <div key={i} className={`flex gap-3 ${msg.role === 'USER' ? 'flex-row-reverse' : ''}`}>
              <Avatar className="w-8 h-8 shrink-0 mt-1">
                <AvatarFallback className={msg.role === 'USER' ? 'bg-purple-100 text-purple-700' : 'bg-white text-purple-600 border'}>
                  {msg.role === 'USER' ? <User className="w-4 h-4" /> : <Bot className="w-4 h-4" />}
                </AvatarFallback>
              </Avatar>
              <div className={`max-w-[80%] p-3 rounded-2xl shadow-sm text-sm ${msg.role === 'USER' ? 'bg-purple-600 text-white rounded-tr-none' : 'bg-white text-gray-800 rounded-tl-none ring-1 ring-gray-100'}`}>
                {msg.content}
              </div>
            </div>)}
          {isTyping && <div className="flex gap-3">
              <Avatar className="w-8 h-8 shrink-0 mt-1">
                <AvatarFallback className="bg-white text-purple-600 border">
                  <Bot className="w-4 h-4" />
                </AvatarFallback>
              </Avatar>
              <div className="bg-white p-4 rounded-2xl rounded-tl-none ring-1 ring-gray-100 flex gap-1 items-center">
                <span className="w-1.5 h-1.5 bg-gray-300 rounded-full animate-bounce"></span>
                <span className="w-1.5 h-1.5 bg-gray-300 rounded-full animate-bounce delay-75"></span>
                <span className="w-1.5 h-1.5 bg-gray-300 rounded-full animate-bounce delay-150"></span>
              </div>
            </div>}
        </div>
      </ScrollArea>

      {/* Input area */}
      <div className="p-4 border-t bg-white">
        {/* Suggestion tags */}
        <div className="flex gap-2 mb-3 overflow-x-auto pb-1 scrollbar-hide">
          <Badge variant="outline" className={`cursor-pointer transition-colors ${isEscalated ? 'bg-blue-50 text-blue-700 border-blue-200' : 'hover:bg-purple-50 text-purple-600 border-purple-100'}`} onClick={!isEscalated ? handleEscalate : undefined}>
            {isEscalated ? 'Agent Notified' : 'Escalate to Agent'}
          </Badge>
          <Badge variant="outline" className="cursor-pointer hover:bg-purple-50 text-purple-600 border-purple-100" onClick={() => setInput("Schedule a viewing")}>{t("client.src.schedule_viewing")}</Badge>
          <Badge variant="outline" className="cursor-pointer hover:bg-purple-50 text-purple-600 border-purple-100" onClick={() => setInput("Property pricing details")}>{t("client.src.inquiry_about_price")}</Badge>
        </div>
        
        <div className="flex items-center gap-2">
          <Button variant="ghost" size="icon" aria-label={t("common.attach")} className="w-9 h-9 text-gray-400 hover:text-purple-600">
            <Paperclip className="w-5 h-5" />
          </Button>
          <div className="relative flex-1">
            <Input value={input} onChange={e => setInput(e.target.value)} onKeyDown={e => e.key === 'Enter' && handleSend()} placeholder={t("client.src.type_your_message")} className="pr-10 bg-gray-50 border-none ring-1 ring-gray-200 focus:ring-2 focus:ring-purple-500 rounded-xl" />
            <Sparkles className="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4 text-purple-400 opacity-50" />
          </div>
          <Button onClick={handleSend} disabled={!input.trim()} className="w-9 h-9 p-0 bg-purple-600 hover:bg-purple-700 rounded-xl shadow-lg shadow-purple-200" aria-label={t("common.send")}>
            <Send className="w-4 h-4" />
          </Button>
        </div>
        <div className="mt-3 flex items-center justify-between">
          <p className="text-[10px] text-muted-foreground">{t("client.src.powered_by_atlasvs_ai")}</p>
          <Button variant="ghost" size="sm" className={`h-6 text-[10px] items-center gap-1 font-bold hover:bg-purple-50 ${isEscalated ? 'text-blue-600' : 'text-purple-600'}`} onClick={!isEscalated ? handleEscalate : undefined} disabled={isEscalated}>
            <ArrowRightLeft className="w-3 h-3" /> 
            {isEscalated ? 'Handoff Active' : 'Handoff to Human'}
          </Button>
        </div>
      </div>
    </m.div>;
}