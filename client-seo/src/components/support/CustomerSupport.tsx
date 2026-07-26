 "use client"
 import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, useRef } from "react";
import { MessageCircle, X, Send, Paperclip, Smile, Loader2, Minimize2, Maximize2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Card, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Input } from "@/components/ui/input";
import { m, AnimatePresence } from "framer-motion";
interface Message {
  id: string;
  text: string;
  sender: "user" | "agent" | "bot";
  timestamp: string;
}
export function CustomerSupport() {
  const {
    t
  } = useTranslation();
  const [isOpen, setIsOpen] = useState(false);
  const [isMinimized, setIsMinimized] = useState(false);
  const [message, setMessage] = useState("");
  const [messages, setMessages] = useState<Message[]>([{
    id: "1",
    text: t("client.src.hello_i_am_the"),
    sender: "bot",
    timestamp: new Date().toISOString()
  }]);
  const [isTyping, setIsTyping] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);
  useEffect(() => {
    if (scrollRef.current) {
      scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
    }
  }, [messages, isOpen, isTyping]);
  const handleSend = async () => {
    if (!message.trim()) return;
    const userMessage: Message = {
      id: Date.now().toString(),
      text: message,
      sender: "user",
      timestamp: new Date().toISOString()
    };
    setMessages(prev => [...prev, userMessage]);
    setMessage("");
    setIsTyping(true);

    // Simulated bot response
    setTimeout(() => {
      const botResponse: Message = {
        id: (Date.now() + 1).toString(),
        text: t("client.src.your_message_has_been"),
        sender: "bot",
        timestamp: new Date().toISOString()
      };
      setMessages(prev => [...prev, botResponse]);
      setIsTyping(false);
    }, 1500);
  };
  return <div className="fixed bottom-6 right-6 z-100">
      <AnimatePresence>
        {!isOpen && <m.button initial={{
        scale: 0,
        opacity: 0
      }} animate={{
        scale: 1,
        opacity: 1
      }} exit={{
        scale: 0,
        opacity: 0
      }} onClick={() => setIsOpen(true)} className="w-16 h-16 bg-primary rounded-full shadow-2xl flex items-center justify-center text-primary-foreground group hover:scale-110 transition-transform duration-300">
            <MessageCircle className="w-8 h-8 group-hover:rotate-12 transition-transform" />
            <span className="absolute -top-1 -right-1 flex h-4 w-4">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
              <span className="relative inline-flex rounded-full h-4 w-4 bg-green-500"></span>
            </span>
          </m.button>}

        {isOpen && <m.div initial={{
        y: 50,
        opacity: 0,
        scale: 0.9
      }} animate={{
        y: 0,
        opacity: 1,
        scale: 1,
        height: isMinimized ? "64px" : "550px",
        width: "380px"
      }} exit={{
        y: 50,
        opacity: 0,
        scale: 0.9
      }} className="bg-card shadow-2xl rounded-2xl overflow-hidden border border-white/10">
            <Card className="h-full border-none rounded-none flex flex-col">
              <CardHeader className="p-4 bg-primary text-primary-foreground flex flex-row items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="relative">
                    <Avatar className="h-10 w-10 border-2 border-primary-foreground/20">
                      <AvatarImage src="/api/placeholder/support-agent.jpg" />
                      <AvatarFallback className="bg-primary-foreground/10 text-primary-foreground">{t("client.src.rs")}</AvatarFallback>
                    </Avatar>
                    <span className="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-primary"></span>
                  </div>
                  <div>
                    <CardTitle className="text-sm font-bold">{t("client.src.support_center")}</CardTitle>
                    <p className="text-[10px] opacity-70">{t("client.src.online_response_time_2m")}</p>
                  </div>
                </div>
                <div className="flex gap-1">
                  <Button variant="ghost" size="icon" className="h-8 w-8 hover:bg-white/10" onClick={() => setIsMinimized(!isMinimized)} aria-label="Toggle chat size">
                    {isMinimized ? <Maximize2 className="h-4 w-4" /> : <Minimize2 className="h-4 w-4" />}
                  </Button>
                  <Button variant="ghost" size="icon" className="h-8 w-8 hover:bg-white/10" onClick={() => setIsOpen(false)} aria-label="Close support chat">
                    <X className="h-4 w-4" />
                  </Button>
                </div>
              </CardHeader>

              {!isMinimized && <>
                  <ScrollArea className="flex-1 p-4 overflow-y-auto" ref={scrollRef}>
                    <div className="space-y-4">
                      {messages.map(msg => <div key={msg.id} className={`flex ${msg.sender === "user" ? "justify-end" : "justify-start"}`}>
                          <div className={`max-w-[80%] rounded-2xl px-4 py-2 text-sm shadow-sm ${msg.sender === "user" ? "bg-primary text-primary-foreground rounded-tr-none" : "bg-secondary/50 text-foreground rounded-tl-none border border-white/5"}`}>
                            <p className="leading-relaxed">{msg.text}</p>
                            <span className="text-[9px] opacity-50 mt-1 block">
                              {new Date(msg.timestamp).toLocaleTimeString([], {
                        hour: '2-digit',
                        minute: '2-digit'
                      })}
                            </span>
                          </div>
                        </div>)}
                      {isTyping && <div className="flex justify-start">
                          <div className="bg-secondary/50 rounded-2xl px-4 py-2 border border-white/5">
                            <Loader2 className="w-4 h-4 animate-spin text-primary" />
                          </div>
                        </div>}
                    </div>
                  </ScrollArea>
                  <CardFooter className="p-4 pt-2 border-t border-border flex flex-col gap-2">
                    <div className="flex w-full items-center gap-2">
                      <Button variant="ghost" size="icon" className="h-9 w-9 shrink-0 opacity-50 hover:opacity-100" aria-label="Attach file">
                        <Paperclip className="h-4 w-4" />
                      </Button>
                      <Input placeholder={t("client.src.type_a_message")} value={message} onChange={e => setMessage(e.target.value)} onKeyPress={e => e.key === "Enter" && handleSend()} className="h-10 bg-secondary/30 border-none shadow-none focus-visible:ring-1 focus-visible:ring-primary" />
                      <Button variant="ghost" size="icon" className="h-9 w-9 shrink-0 opacity-50 hover:opacity-100" aria-label="Emoji">
                        <Smile className="h-4 w-4" />
                      </Button>
                      <Button size="icon" className="h-9 w-9 shrink-0 bg-primary hover:bg-primary/90" onClick={handleSend} disabled={!message.trim()} aria-label="Send message">
                        <Send className="h-4 w-4" />
                      </Button>
                    </div>
                  </CardFooter>
                </>}
            </Card>
          </m.div>}
      </AnimatePresence>
    </div>;
}