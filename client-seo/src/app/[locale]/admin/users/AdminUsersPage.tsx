"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  Users, 
  Search, 
  Plus, 
  Edit, 
  Trash2, 
  ArrowUpRight,
  Mail
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface User {
  id: string;
  name: string;
  email: string;
  role: "ADMIN" | "USER" | "AGENT" | "TENANT";
  status: "ACTIVE" | "INACTIVE" | "PENDING";
  createdAt: string;
}

const mockUsers: User[] = [
  { id: "1", name: "John Doe", email: "john@example.com", role: "ADMIN", status: "ACTIVE", createdAt: "2024-01-15" },
  { id: "2", name: "Jane Smith", email: "jane@example.com", role: "AGENT", status: "ACTIVE", createdAt: "2024-02-20" },
  { id: "3", name: "Bob Wilson", email: "bob@example.com", role: "USER", status: "ACTIVE", createdAt: "2024-03-10" },
  { id: "4", name: "Alice Brown", email: "alice@example.com", role: "TENANT", status: "PENDING", createdAt: "2024-03-25" },
  { id: "5", name: "Charlie Davis", email: "charlie@example.com", role: "USER", status: "INACTIVE", createdAt: "2024-04-01" }
];

const ROLE_COLORS: Record<string, string> = {
  ADMIN: "bg-slate-500/20 text-slate-400",
  USER: "bg-slate-500/20 text-slate-400",
  AGENT: "bg-emerald-500/20 text-emerald-400",
  TENANT: "bg-amber-500/20 text-amber-400"
};

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  PENDING: "bg-yellow-500/20 text-yellow-400"
};

export default function AdminUsersPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredUsers = mockUsers.filter(user => 
    user.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    user.email.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.users.title")}</h1>
              <p className="text-gray-400">{t("admin.users.description")}</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-slate-600 hover:bg-slate-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.users.back_to_dashboard")}
                                      </Button>
          </div>
        </motion.div>

        {/* Toolbar */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder={t("admin.users.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.users.add_user")}
                                                  </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Users List */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Users className="w-5 h-5" />
                {t("admin.users.list_title")}{filteredUsers.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredUsers.map((user) => (
                  <div
                    key={user.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-slate-500/20 flex items-center justify-center text-slate-400 font-bold">
                        {user.name.split(' ').map(n => n[0]).join('')}
                      </div>
                      <div>
                        <div className="text-white font-medium">{user.name}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <Mail className="w-3 h-3" />
                          {user.email}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={ROLE_COLORS[user.role]}>{user.role}</Badge>
                      <Badge className={STATUS_COLORS[user.status]}>{user.status}</Badge>
                      <div className="flex gap-2">
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <Edit className="w-4 h-4" />
                        </Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400">
                          <Trash2 className="w-4 h-4" />
                        </Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
