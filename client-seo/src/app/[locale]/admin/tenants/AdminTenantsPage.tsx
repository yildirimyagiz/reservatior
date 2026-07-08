"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Users,
  Search,
  Plus,
  Home,
  Phone,
  Mail,
  Calendar,
  ArrowUpRight,
  Edit,
  Trash2,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Tenant {
  id: string;
  name: string;
  email: string;
  phone: string;
  property: string;
  leaseStart: string;
  leaseEnd: string;
  status: "ACTIVE" | "NOTICE" | "PAST_DUE" | "TERMINATED";
}

const mockTenants: Tenant[] = [
  { id: "1", name: "Alice Johnson", email: "alice@example.com", phone: "+44 7700 100001", property: "Luxury Villa", leaseStart: "2024-01-01", leaseEnd: "2025-01-01", status: "ACTIVE" },
  { id: "2", name: "Bob Williams", email: "bob@example.com", phone: "+44 7700 100002", property: "Downtown Apartment", leaseStart: "2023-06-01", leaseEnd: "2024-06-01", status: "NOTICE" },
  { id: "3", name: "Carol Martinez", email: "carol@example.com", phone: "+44 7700 100003", property: "Beachfront Condo", leaseStart: "2024-03-01", leaseEnd: "2025-03-01", status: "PAST_DUE" },
  { id: "4", name: "Daniel Taylor", email: "daniel@example.com", phone: "+44 7700 100004", property: "Studio Loft", leaseStart: "2022-09-01", leaseEnd: "2023-09-01", status: "TERMINATED" },
  { id: "5", name: "Eve Anderson", email: "eve@example.com", phone: "+44 7700 100005", property: "Penthouse Suite", leaseStart: "2024-02-01", leaseEnd: "2025-02-01", status: "ACTIVE" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  NOTICE: "bg-yellow-500/20 text-yellow-400",
  PAST_DUE: "bg-red-500/20 text-red-400",
  TERMINATED: "bg-gray-500/20 text-gray-400",
};

export default function AdminTenantsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");

  const filtered = mockTenants.filter(tenant =>
    tenant.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    tenant.property.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_tenants_title")}</h1>
              <p className="text-muted-foreground">{t("admin_tenants_description")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_tenants_back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_tenants_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-muted/30 border-border text-foreground placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_tenants_add_tenant")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Users className="w-5 h-5" />
                {t("admin_tenants_list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((tenant) => (
                  <div key={tenant.id} className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center text-muted-foreground font-bold">
                        {tenant.name.split(" ").map(n => n[0]).join("")}
                      </div>
                      <div>
                        <div className="text-foreground font-medium">{tenant.name}</div>
                        <div className="text-sm text-muted-foreground flex items-center gap-2">
                          <Home className="w-3 h-3" />
                          {tenant.property}
                        </div>
                        <div className="text-xs text-muted-foreground/70 flex items-center gap-3 mt-1">
                          <span className="flex items-center gap-1"><Mail className="w-3 h-3" />{tenant.email}</span>
                          <span className="flex items-center gap-1"><Phone className="w-3 h-3" />{tenant.phone}</span>
                          <span className="flex items-center gap-1"><Calendar className="w-3 h-3" />{tenant.leaseStart} - {tenant.leaseEnd}</span>
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={STATUS_COLORS[tenant.status]}>{tenant.status.replace("_", " ")}</Badge>
                      <div className="flex gap-2">
                        <Button variant="ghost" size="icon" className="h-8 w-8"><Edit className="w-4 h-4" /></Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400"><Trash2 className="w-4 h-4" /></Button>
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
