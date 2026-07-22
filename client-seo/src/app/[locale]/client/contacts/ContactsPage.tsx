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
  Mail,
  Building2
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Contact {
  id: string;
  name: string;
  email: string;
  phone: string;
  company: string;
  type: "CLIENT" | "AGENT" | "VENDOR" | "TENANT";
  status: "ACTIVE" | "INACTIVE";
}

const mockContacts: Contact[] = [
  { id: "1", name: "John Doe", email: "john@example.com", phone: "+1 555-0101", company: "Acme Corp", type: "CLIENT", status: "ACTIVE" },
  { id: "2", name: "Jane Smith", email: "jane@example.com", phone: "+1 555-0102", company: "Realty Pro", type: "AGENT", status: "ACTIVE" },
  { id: "3", name: "Bob Wilson", email: "bob@example.com", phone: "+1 555-0103", company: "Maintenance Co", type: "VENDOR", status: "ACTIVE" },
  { id: "4", name: "Alice Brown", email: "alice@example.com", phone: "+1 555-0104", company: "Personal", type: "TENANT", status: "INACTIVE" }
];

const TYPE_COLORS: Record<string, string> = {
  CLIENT: "bg-blue-500/20 text-blue-400",
  AGENT: "bg-purple-500/20 text-purple-400",
  VENDOR: "bg-emerald-500/20 text-emerald-400",
  TENANT: "bg-amber-500/20 text-amber-400"
};

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400"
};

export default function ContactsPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredContacts = mockContacts.filter(contact => 
    contact.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    contact.company.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("contacts.contactspage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("contacts.contactspage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("contacts.contactspage.auto_ext_3")}
                                      </Button>
          </div>
        </m.div>

        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search contacts..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-purple-600 hover:bg-purple-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("contacts.contactspage.auto_ext_4")}
                                                  </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Users className="w-5 h-5" />
                {t("contacts.contactspage.auto_ext_5")}{filteredContacts.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredContacts.map((contact) => (
                  <div
                    key={contact.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center text-purple-400 font-bold">
                        {contact.name.split(' ').map(n => n[0]).join('')}
                      </div>
                      <div>
                        <div className="text-white font-medium">{contact.name}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <Building2 className="w-3 h-3" />
                          {contact.company}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="text-sm text-gray-400 flex items-center gap-1">
                        <Mail className="w-3 h-3" />
                        {contact.email}
                      </div>
                      <Badge className={TYPE_COLORS[contact.type]}>{contact.type}</Badge>
                      <Badge className={STATUS_COLORS[contact.status]}>{contact.status}</Badge>
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
        </m.div>
      </div>
    </div>
  );
}
