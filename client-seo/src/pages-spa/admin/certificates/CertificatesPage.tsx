"use client";

import React, { useState } from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Award, ShieldCheck, Download, Search, Plus, CheckCircle2, AlertCircle, Calendar, RefreshCw } from "lucide-react";
import { useTranslation } from "react-i18next";

interface Certificate {
  id: string;
  title: string;
  issuer: string;
  category: string;
  issueDate: string;
  expiryDate: string;
  status: "ACTIVE" | "PENDING" | "EXPIRED";
  serialNumber: string;
}

const MOCK_CERTIFICATES: Certificate[] = [
  {
    id: "CERT-7701",
    title: "7464 Konut Kiralama İzin Belgesi",
    issuer: "T.C. Kültür ve Turizm Bakanlığı",
    category: "Turizm Kiralama",
    issueDate: "2025-01-15",
    expiryDate: "2026-01-15",
    status: "ACTIVE",
    serialNumber: "TR-TUR-2025-7701"
  },
  {
    id: "CERT-9920",
    title: "Taşınmaz Ticareti Yetki Belgesi",
    issuer: "T.C. Ticaret Bakanlığı",
    category: "Emlak Lisansı",
    issueDate: "2024-06-10",
    expiryDate: "2029-06-10",
    status: "ACTIVE",
    serialNumber: "3400812-001"
  },
  {
    id: "CERT-3304",
    title: "ISO 27001 Bilgi Güvenliği Sertifikası",
    issuer: "TÜRKAK / ISO Audit",
    category: "Sistem & Güvenlik",
    issueDate: "2024-11-01",
    expiryDate: "2025-11-01",
    status: "ACTIVE",
    serialNumber: "ISO-27001-2024-RES"
  },
  {
    id: "CERT-1102",
    title: "SSL/TLS Extended Validation Lisansı",
    issuer: "DigiCert Inc.",
    category: "Web & API Güvenliği",
    issueDate: "2023-12-01",
    expiryDate: "2024-12-01",
    status: "EXPIRED",
    serialNumber: "DC-EV-99281-EXP"
  }
];

export default function CertificatesPage() {
  const { t } = useTranslation();
  const [search, setSearch] = useState("");
  const [certificates] = useState<Certificate[]>(MOCK_CERTIFICATES);

  const filtered = certificates.filter(c => 
    c.title.toLowerCase().includes(search.toLowerCase()) || 
    c.serialNumber.toLowerCase().includes(search.toLowerCase()) ||
    c.issuer.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <PageShell
      title={t("admin_certificates_title", "Sertifikalar & Lisanslar")}
      description={t("admin_certificates_desc", "Yasal izin belgeleri, turizm lisansları, ISO standartları ve dijital sertifikalar")}
    >
      <div className="space-y-6">
        {/* Top Header & Search */}
        <div className="flex flex-col sm:flex-row items-center justify-between gap-4 bg-card p-4 rounded-xl border border-border">
          <div className="relative w-full sm:w-80">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
            <Input
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder={t("admin_certificates_search_placeholder", "Belge adı, seri no veya kurum ara...")}
              className="pl-9"
            />
          </div>
          <Button className="w-full sm:w-auto bg-primary hover:bg-primary/90 text-primary-foreground">
            <Plus className="w-4 h-4 mr-2" />
            {t("admin_certificates_add_button", "+ Yeni Lisans & Belge Ekle")}
          </Button>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <Card className="bg-card border-border">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_certificates_active_certificates", "Aktif Sertifikalar")}</CardTitle>
              <ShieldCheck className="w-5 h-5 text-success" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{t("admin_certificates_active_count", "3 Belge")}</div>
              <p className="text-xs text-muted-foreground mt-1">{t("admin_certificates_fully_compliant", "%100 Mevzuat Uyumlu")}</p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_certificates_expiring_soon", "Süresi Yaklaşanlar")}</CardTitle>
              <Calendar className="w-5 h-5 text-amber-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{t("admin_certificates_expiring_count", "1 Belge")}</div>
              <p className="text-xs text-muted-foreground mt-1">{t("admin_certificates_renewal_period", "Yenileme Süresi: 30 Gün")}</p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_certificates_verification_status", "Doğrulama Durumu")}</CardTitle>
              <Award className="w-5 h-5 text-brand" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{t("admin_certificates_official_approved", "Resmi Onaylı")}</div>
              <p className="text-xs text-muted-foreground mt-1">{t("admin_certificates_edevlet_integrated", "E-Devlet & Bakanlık Entegre")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Certificates Table */}
        <Card className="bg-card border-border">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Award className="w-5 h-5 text-primary" />
              {t("admin_certificates_list_title", "Sistem Lisansları ve Bakanlık İzin Belgeleri")}
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="divide-y divide-border">
              {filtered.map((cert) => (
                <div key={cert.id} className="py-4 flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
                  <div className="flex items-start gap-3">
                    <div className="p-2.5 rounded-lg bg-primary/10 text-primary mt-0.5">
                      <Award className="w-5 h-5" />
                    </div>
                    <div>
                      <h4 className="font-semibold text-foreground">{cert.title}</h4>
                      <p className="text-xs text-muted-foreground mt-0.5">
                        {t("admin_certificates_issuer_label", "Veren Kurum:")} <span className="font-medium text-foreground">{cert.issuer}</span> {t("admin_certificates_category_label", "• Kategori:")} <span className="font-medium text-foreground">{cert.category}</span>
                      </p>
                      <p className="text-xs font-mono text-muted-foreground/80 mt-1">
                        {t("admin_certificates_serial_label", "Seri No:")} {cert.serialNumber}
                      </p>
                    </div>
                  </div>

                  <div className="flex items-center gap-4 w-full md:w-auto justify-between md:justify-end">
                    <div className="text-right">
                      <p className="text-xs text-muted-foreground">{t("admin_certificates_validity_date", "Geçerlilik Tarihi")}</p>
                      <p className="text-sm font-medium text-foreground">{cert.expiryDate}</p>
                    </div>

                    <Badge variant={cert.status === "ACTIVE" ? "default" : cert.status === "PENDING" ? "secondary" : "destructive"}>
                      {cert.status === "ACTIVE" && <CheckCircle2 className="w-3.5 h-3.5 mr-1" />}
                      {cert.status === "EXPIRED" && <AlertCircle className="w-3.5 h-3.5 mr-1" />}
                      {cert.status === "ACTIVE" ? t("admin_certificates_status_active", "Aktif & Geçerli") : cert.status === "PENDING" ? t("admin_certificates_status_pending", "Onay Bekliyor") : t("admin_certificates_status_expired", "Süresi Doldu")}
                    </Badge>

                    <Button variant="outline" size="sm" className="hidden sm:flex items-center gap-1.5">
                      <Download className="w-3.5 h-3.5" />
                      {t("admin_certificates_download", "İndir")}
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </PageShell>
  );
}
