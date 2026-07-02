"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { 
  MessageSquare, 
  Search, 
  Send, 
  ArrowUpRight,
  Clock,
  CheckCheck
} from "lucide-react";
import { motion } from "framer-motion";

interface Message {
  id: string;
  sender: string;
  avatar: string;
  lastMessage: string;
  time: string;
  unread: number;
}

const mockMessages: Message[] = [
  { id: "1", sender: "John Doe", avatar: "JD", lastMessage: "I'm interested in the property...", time: "2 min ago", unread: 2 },
  { id: "2", sender: "Jane Smith", avatar: "JS", lastMessage: "Can we schedule a viewing?", time: "1 hour ago", unread: 0 },
  { id: "3", sender: "Bob Wilson", avatar: "BW", lastMessage: "Thanks for the information", time: "3 hours ago", unread: 1 },
  { id: "4", sender: "Alice Brown", avatar: "AB", lastMessage: "The contract looks good", time: "1 day ago", unread: 0 }
];

export default function MessagesPage() {
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedMessage, setSelectedMessage] = useState<Message | null>(null);
  const [newMessage, setNewMessage] = useState("");

  const filteredMessages = mockMessages.filter(msg => 
    msg.sender.toLowerCase().includes(searchTerm.toLowerCase()) ||
    msg.lastMessage.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">Messages</h1>
              <p className="text-gray-400">Communicate with clients and partners</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              Dashboard
            </Button>
          </div>
        </motion.div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Messages List */}
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardHeader>
                <div className="relative">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                  <Input
                    placeholder="Search messages..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                  />
                </div>
              </CardHeader>
              <CardContent>
                <div className="space-y-2">
                  {filteredMessages.map((msg) => (
                    <div
                      key={msg.id}
                      onClick={() => setSelectedMessage(msg)}
                      className={`p-4 rounded-lg cursor-pointer transition-colors ${
                        selectedMessage?.id === msg.id ? 'bg-purple-600' : 'bg-white/5 hover:bg-white/10'
                      }`}
                    >
                      <div className="flex items-center gap-3">
                        <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center text-purple-400 font-bold">
                          {msg.avatar}
                        </div>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center justify-between">
                            <div className="text-white font-medium">{msg.sender}</div>
                            <div className="text-xs text-gray-400 flex items-center gap-1">
                              <Clock className="w-3 h-3" />
                              {msg.time}
                            </div>
                          </div>
                          <div className="text-sm text-gray-400 truncate">{msg.lastMessage}</div>
                        </div>
                        {msg.unread > 0 && (
                          <div className="w-5 h-5 bg-purple-600 rounded-full flex items-center justify-center text-xs text-white">
                            {msg.unread}
                          </div>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </motion.div>

          {/* Message View */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.2 }}
            className="lg:col-span-2"
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20 h-full">
              {selectedMessage ? (
                <>
                  <CardHeader>
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center text-purple-400 font-bold">
                        {selectedMessage.avatar}
                      </div>
                      <div>
                        <CardTitle className="text-white">{selectedMessage.sender}</CardTitle>
                        <div className="text-sm text-gray-400">Online</div>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="flex flex-col h-[calc(100%-80px)]">
                    <div className="flex-1 space-y-4 mb-4 overflow-y-auto">
                      <div className="flex justify-start">
                        <div className="bg-white/10 p-3 rounded-lg max-w-xs">
                          <div className="text-white">{selectedMessage.lastMessage}</div>
                          <div className="text-xs text-gray-400 mt-1">{selectedMessage.time}</div>
                        </div>
                      </div>
                      <div className="flex justify-end">
                        <div className="bg-purple-600 p-3 rounded-lg max-w-xs">
                          <div className="text-white">I&apos;ll get back to you shortly</div>
                          <div className="text-xs text-purple-200 mt-1 flex items-center gap-1 justify-end">
                            <CheckCheck className="w-3 h-3" />
                            Just now
                          </div>
                        </div>
                      </div>
                    </div>
                    <div className="flex gap-2">
                      <Input
                        placeholder="Type a message..."
                        value={newMessage}
                        onChange={(e) => setNewMessage(e.target.value)}
                        className="flex-1 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                      />
                      <Button className="bg-purple-600 hover:bg-purple-700">
                        <Send className="w-4 h-4" />
                      </Button>
                    </div>
                  </CardContent>
                </>
              ) : (
                <CardContent className="flex items-center justify-center h-full">
                  <div className="text-center text-gray-400">
                    <MessageSquare className="w-16 h-16 mx-auto mb-4 opacity-50" />
                    <p>Select a message to start chatting</p>
                  </div>
                </CardContent>
              )}
            </Card>
          </motion.div>
        </div>
      </div>
    </div>
  );
}
