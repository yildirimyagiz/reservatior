import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useMemo, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Send, Search, Paperclip, Smile, Phone, MoreVertical, Check, CheckCheck, FolderOpen, User, Users, Settings } from 'lucide-react';
import { messagesApi } from '@/lib/api/messages';
import { communicationsApi } from '@/lib/api/communications';
import { cn } from '@/lib/utils';
import { motion, AnimatePresence } from 'framer-motion';
import { useToast } from "@/hooks/use-toast";

// AI Chat Masking Utility
const maskSensitiveData = (text: string) => {
  if (!text) return text;
  
  // Mask Turkish Phone Numbers (e.g., 05XX XXX XX XX)
  let masked = text.replace(/(?:\+90|0)?\s*5\d{2}\s*\d{3}\s*\d{2}\s*\d{2}/g, "📞 [TELEFON GİZLENDİ]");
  
  // Mask IBANs (e.g., TRXX XXXX XXXX XXXX XXXX XXXX XX)
  masked = masked.replace(/TR\d{2}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{2}/gi, "🏦 [IBAN GİZLENDİ - Lütfen Ödemeyi Checkout'tan Yapın]");
  
  return masked;
};

const containsSensitiveData = (text: string) => {
  const hasPhone = /(?:\+90|0)?\s*5\d{2}\s*\d{3}\s*\d{2}\s*\d{2}/.test(text);
  const hasIban = /TR\d{2}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{2}/i.test(text);
  return hasPhone || hasIban;
};
export default function Messages() {
  const {
    t
  } = useTranslation();
  const {
    id
  } = useParams();
  const navigate = useNavigate();
  const { toast } = useToast();
  const [selectedId, setSelectedId] = useState<string | number>(id || '');
  const [message, setMessage] = useState('');
  const [searchQuery, setSearchQuery] = useState('');
  const [activeTab, setActiveTab] = useState<'all' | 'dm' | 'channels'>('all');
  const [conversations, setConversations] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    const loadData = async () => {
      try {
        setLoading(true);
        const [channelsRes, threadsRes] = await Promise.all([communicationsApi.getChannels(), messagesApi.getThreads()]);

        // Handle server response structure { data: [...] }
        const channelsData = (channelsRes as any).data || channelsRes || [];
        const threadsData = (threadsRes as any).data || threadsRes || [];
        const mappedChannels = channelsData.map((c: any) => ({
          id: c.id,
          name: c.name,
          lastMessage: c.description || 'No messages yet',
          time: new Date(c.updatedAt).toLocaleTimeString([], {
            hour: '2-digit',
            minute: '2-digit'
          }),
          unread: c._count?.CommunicationLogs || 0,
          type: 'channel',
          avatar: c.name.charAt(0).toUpperCase()
        }));
        const mappedDMs = threadsData.map((t: any) => ({
          id: t.id,
          name: t.participants?.[0]?.name || 'Unknown',
          lastMessage: t.lastMessage || 'No body',
          time: new Date(t.updatedAt).toLocaleTimeString([], {
            hour: '2-digit',
            minute: '2-digit'
          }),
          unread: t.unreadCount || 0,
          online: true,
          type: 'dm',
          avatar: (t.participants?.[0]?.name || 'U').charAt(0).toUpperCase()
        }));
        setConversations([...mappedChannels, ...mappedDMs]);

        // Auto-select first if none selected
        if ([...mappedChannels, ...mappedDMs].length > 0) {
          setSelectedId([...mappedChannels, ...mappedDMs][0].id);
        }
      } catch (error) {
        console.error("Failed to load messaging data:", error);
      } finally {
        setLoading(false);
      }
    };
    loadData();
  }, []);
  const [messages, setMessages] = useState<any[]>([]);
  useEffect(() => {
    if (!selectedId) return;
    const loadMessages = async () => {
      try {
        const res = await messagesApi.getMessages(selectedId.toString());
        const data = (res as any).data || res || [];
        const mapped = data.map((m: any) => ({
          id: m.id,
          senderId: m.senderId,
          text: maskSensitiveData(m.body || m.content),
          time: new Date(m.createdAt || m.timestamp).toLocaleTimeString([], {
            hour: '2-digit',
            minute: '2-digit'
          }),
          status: m.isRead ? 'read' : 'sent'
        }));
        setMessages(mapped);
      } catch (error) {
        console.error("Failed to load messages:", error);
        // Fallback or empty
        setMessages([]);
      }
    };
    loadMessages();
  }, [selectedId]);
  const filteredList = useMemo(() => {
    let list = conversations;
    if (activeTab === 'dm') list = list.filter(c => c.type === 'dm');
    if (activeTab === 'channels') list = list.filter(c => c.type === 'channel');
    if (searchQuery) {
      list = list.filter(c => c.name.toLowerCase().includes(searchQuery.toLowerCase()));
    }
    return list;
  }, [activeTab, searchQuery, conversations]);
  const selectedChat = conversations.find(c => c.id === selectedId);
  const handleSendMessage = async () => {
    if (message.trim() && selectedId) {
      if (containsSensitiveData(message)) {
        toast({
          title: "⚠️ Reservatior AI Güvenlik Uyarısı",
          description: "Sistem dışı işlem yapmaya çalıştığınız tespit edildi. IBAN veya Telefon numarası paylaşımı yasaktır.",
          variant: "destructive"
        });
      }

      try {
        await messagesApi.sendMessage(selectedId.toString(), message);
        setMessage('');
        // Refresh messages
        const res = await messagesApi.getMessages(selectedId.toString());
        const data = (res as any).data || res || [];
        const mapped = data.map((m: any) => ({
          id: m.id,
          senderId: m.senderId === 'ME' ? 'me' : 'other',
          text: maskSensitiveData(m.body || m.content),
          time: new Date(m.createdAt || m.timestamp).toLocaleTimeString([], {
            hour: '2-digit',
            minute: '2-digit'
          }),
          status: m.isRead ? 'read' : 'sent'
        }));
        setMessages(mapped);
      } catch (error) {
        console.error("Failed to send message:", error);
      }
    }
  };
  return <div className="h-[calc(100vh-64px)] flex bg-[#0e0f13] overflow-hidden">
      {/* Sidebar */}
      <div className="w-[320px] md:w-[400px] border-r border-slate-800/50 flex flex-col bg-[#16171d]">
        {/* Sidebar Header */}
        <div className="p-4 space-y-4 shadow-sm relative z-10">
          <div className="flex items-center justify-between">
            <h2 className="text-xl font-bold text-white tracking-tight">{t("client.src.messages")}</h2>
            <Button variant="ghost" size="icon" className="rounded-full text-slate-400">
              <Settings className="w-5 h-5" />
            </Button>
          </div>
          
          <div className="relative group">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500 group-focus-within:text-primary transition-colors" />
            <Input placeholder={t("client.src.search")} value={searchQuery} onChange={e => setSearchQuery(e.target.value)} className="pl-10 bg-[#1b1c22] border-none text-slate-200 placeholder:text-slate-600 rounded-xl h-10 focus-visible:ring-1 focus-visible:ring-primary/50" />
          </div>

          <div className="flex gap-1 overflow-x-auto pb-1 no-scrollbar">
            {[{
            id: 'all',
            label: t("client.src.all"),
            icon: FolderOpen
          }, {
            id: 'dm',
            label: t("client.src.direct"),
            icon: User
          }, {
            id: 'channels',
            label: t("client.src.channels"),
            icon: Users
          }].map(tab => <button key={tab.id} onClick={() => setActiveTab(tab.id as any)} className={cn("flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold transition-all whitespace-nowrap", activeTab === tab.id ? "bg-primary text-white shadow-lg shadow-primary/20" : "text-slate-400 hover:text-slate-200 hover:bg-white/5")}>
                <tab.icon className="w-3.5 h-3.5" />
                {tab.label}
              </button>)}
          </div>
        </div>

        {/* List */}
        <ScrollArea className="flex-1">
          <div className="p-2 space-y-1">
            {filteredList.map(chat => <motion.div key={chat.id} initial={{
            opacity: 0,
            x: -10
          }} animate={{
            opacity: 1,
            x: 0
          }} onClick={() => {
            setSelectedId(chat.id);
            navigate(`/messages/${chat.id}`);
          }} className={cn("flex items-center gap-3 p-3 rounded-2xl cursor-pointer transition-all relative group", selectedId === chat.id ? "bg-primary text-white shadow-xl shadow-primary/20" : "hover:bg-primary/5 text-slate-300")}>
                <div className="relative shrink-0">
                  <Avatar className={cn("h-12 w-12 rounded-2xl ring-2 transition-all", selectedId === chat.id ? "ring-white/20" : "ring-transparent group-hover:ring-primary/20")}>
                    <AvatarFallback className={cn("font-bold", selectedId === chat.id ? "bg-white/10 text-white" : "bg-primary/10 text-primary")}>
                      {chat.avatar}
                    </AvatarFallback>
                  </Avatar>
                  {chat.online && <span className={cn("absolute -bottom-1 -right-1 h-3.5 w-3.5 rounded-full ring-2", selectedId === chat.id ? "bg-white ring-primary" : "bg-emerald-500 ring-[#16171d]")} />}
                </div>

                <div className="flex-1 min-w-0">
                  <div className="flex items-center justify-between mb-0.5">
                    <span className="font-bold text-sm truncate">{chat.name}</span>
                    <span className={cn("text-[10px]", selectedId === chat.id ? "text-white/70" : "text-slate-500")}>{chat.time}</span>
                  </div>
                  <div className="flex items-center justify-between gap-2">
                    <p className={cn("text-xs truncate", selectedId === chat.id ? "text-white/80" : "text-slate-400")}>
                      {chat.type === 'channel' && <span className="mr-1 opacity-50">#</span>}
                      {chat.lastMessage}
                    </p>
                    {chat.unread > 0 && selectedId !== chat.id && <Badge className="h-5 min-w-[20px] px-1 flex items-center justify-center rounded-full bg-primary text-white text-[10px] animate-in zoom-in">
                        {chat.unread}
                      </Badge>}
                  </div>
                </div>
              </motion.div>)}
          </div>
        </ScrollArea>
      </div>

      {/* Main Chat Area */}
      <div className="flex-1 flex flex-col bg-[#0b0c10] relative">
        {/* Telegram-style Background Pattern Overlay */}
        <div className="absolute inset-0 opacity-[0.03] pointer-events-none" style={{
        backgroundImage: 'radial-gradient(#fff 1px, transparent 1px)',
        backgroundSize: '24px 24px'
      }} />
        
        {selectedChat ? <>
            {/* Chat Header */}
            <div className="h-[72px] px-6 border-b border-slate-800/50 flex items-center justify-between bg-[#16171d]/80 backdrop-blur-md relative z-10">
              <div className="flex items-center gap-3">
                <Avatar className="h-10 w-10 rounded-xl">
                  <AvatarFallback className="bg-primary/10 text-primary font-bold">{selectedChat.avatar}</AvatarFallback>
                </Avatar>
                <div>
                  <h3 className="font-bold text-white text-sm">{selectedChat.name}</h3>
                  <p className="text-[11px] text-emerald-500 font-medium">
                    {selectedChat.online ? 'Online' : 'Offline'}
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-1">
                <Button variant="ghost" size="icon" className="text-slate-400 hover:text-white rounded-full">
                  <Search className="w-5 h-5" />
                </Button>
                <Button variant="ghost" size="icon" className="text-slate-400 hover:text-white rounded-full">
                  <Phone className="w-4 h-4" />
                </Button>
                <Button variant="ghost" size="icon" className="text-slate-400 hover:text-white rounded-full">
                  <MoreVertical className="w-5 h-5" />
                </Button>
              </div>
            </div>

            {/* Messages Area */}
            <ScrollArea className="flex-1 px-6 py-6">
              <div className="max-w-4xl mx-auto space-y-6">
                <AnimatePresence initial={false}>
                  {messages.map((msg: any) => <motion.div key={msg.id} initial={{
                opacity: 0,
                y: 10,
                scale: 0.95
              }} animate={{
                opacity: 1,
                y: 0,
                scale: 1
              }} className={cn("flex flex-col group", msg.senderId === 'me' ? "items-end" : "items-start")}>
                      <div className={cn("max-w-[80%] md:max-w-[70%] p-3 md:p-4 rounded-2xl relative shadow-sm transition-all", msg.senderId === 'me' ? "bg-primary text-white rounded-tr-none" : "bg-[#1f2128] text-slate-200 rounded-tl-none border border-slate-800/50")}>
                        <p className="text-sm leading-relaxed">{msg.text}</p>
                        <div className={cn("flex items-center gap-1.5 mt-2 text-[10px] font-medium", msg.senderId === 'me' ? "text-white/60" : "text-slate-500")}>
                          <span>{msg.time}</span>
                          {msg.senderId === 'me' && (msg.status === 'read' ? <CheckCheck className="w-3 h-3 text-white/90" /> : <Check className="w-3 h-3 text-white/50" />)}
                        </div>
                      </div>
                    </motion.div>)}
                </AnimatePresence>
              </div>
            </ScrollArea>

            {/* Input Area */}
            <div className="p-4 md:p-6 bg-transparent relative z-10">
              <div className="max-w-4xl mx-auto">
                <div className="bg-[#1f2128] border border-slate-800/50 rounded-2xl p-2 flex items-end gap-2 shadow-2xl transition-all focus-within:border-primary/50 focus-within:ring-1 focus-within:ring-primary/20">
                  <Button variant="ghost" size="icon" className="text-slate-400 hover:text-white rounded-xl shrink-0">
                    <Paperclip className="w-5 h-5" />
                  </Button>
                  <textarea rows={1} value={message} onChange={e => setMessage(e.target.value)} placeholder={t("client.src.type_a_message")} className="flex-1 bg-transparent border-none text-slate-200 placeholder:text-slate-600 focus:ring-0 text-sm py-2.5 resize-none min-h-[40px] max-h-[120px] custom-scrollbar" onKeyDown={e => {
                if (e.key === 'Enter' && !e.shiftKey) {
                  e.preventDefault();
                  handleSendMessage();
                }
              }} />
                  <div className="flex items-center gap-1 px-1">
                    <Button variant="ghost" size="icon" className="text-slate-400 hover:text-white rounded-xl">
                      <Smile className="w-5 h-5" />
                    </Button>
                    <Button onClick={handleSendMessage} disabled={!message.trim()} className={cn("h-10 w-10 rounded-xl p-0 transition-all", message.trim() ? "bg-primary text-white scale-100" : "bg-slate-800 text-slate-600 scale-90")}>
                      <Send className="w-5 h-5" />
                    </Button>
                  </div>
                </div>
              </div>
            </div>
          </> : <div className="flex-1 flex flex-col items-center justify-center text-center p-8">
            <div className="w-20 h-20 bg-primary/10 rounded-3xl flex items-center justify-center mb-6 animate-bounce transition-all duration-1000">
              <Send className="w-10 h-10 text-primary" />
            </div>
            <h3 className="text-2xl font-bold text-white mb-2 tracking-tight">{t("client.src.select_a_chat")}</h3>
            <p className="text-slate-500 max-w-sm">{t("client.src.choose_a_contact_or")}</p>
          </div>}
      </div>
    </div>;
}