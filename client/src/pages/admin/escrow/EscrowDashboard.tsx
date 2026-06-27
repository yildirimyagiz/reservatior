import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { ShieldCheck, Lock, Unlock, ArrowRightLeft, DollarSign, Clock, Search, Filter } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

export default function EscrowDashboard() {
  const [searchTerm, setSearchTerm] = useState("");

  const transactions = [
    { id: "ESC-8921", guest: "Ahmet Yılmaz", property: "Sunset Villa", amount: 1250, status: "LOCKED", date: "2026-06-18", releaseDate: "2026-06-25" },
    { id: "ESC-8922", guest: "Sarah Connor", property: "Downtown Studio", amount: 450, status: "LOCKED", date: "2026-06-19", releaseDate: "2026-06-21" },
    { id: "ESC-8923", guest: "John Doe", property: "Sea View Apartment", amount: 890, status: "RELEASED", date: "2026-06-10", releaseDate: "2026-06-15" },
  ];

  return (
    <PageShell title="Escrow Havuz Yönetimi" description="SafeStay™ kapsamında bloke edilen ve serbest bırakılan ödemelerinizi takip edin.">
      <div className="space-y-10 pb-20">
        
        {/* KPI CARDS */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-blue-500/30 border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-blue-500">
              <Lock className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">Blokede Olan Tutar (LOCKED)</p>
              <h3 className="text-3xl font-black text-foreground leading-none">$1,700</h3>
              <p className="text-[10px] font-bold text-blue-400 mt-4 flex items-center gap-1">
                <Clock className="w-3 h-3" /> Konaklama bitimi bekleniyor
              </p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-emerald-500/30 border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
              <Unlock className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">Serbest Kalan (RELEASED)</p>
              <h3 className="text-3xl font-black text-foreground leading-none">$12,450</h3>
              <p className="text-[10px] font-bold text-emerald-400 mt-4 flex items-center gap-1">
                <ArrowRightLeft className="w-3 h-3" /> Hesabınıza aktarıldı
              </p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-orange-500/30 border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
              <ShieldCheck className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">SafeStay™ Güvencesi</p>
              <h3 className="text-xl font-bold text-foreground leading-snug mt-2">Sıfır Dolandırıcılık, %100 Güven</h3>
              <p className="text-xs text-muted-foreground mt-2">Müşteriler Escrow sistemine güvendiği için dönüşüm oranınız yüksektir.</p>
            </CardContent>
          </Card>
        </div>

        {/* DATA TABLE */}
        <div className="space-y-6">
          <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 px-4">
            <div className="relative flex-1 max-w-md group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-blue-500 transition-colors" />
              <Input 
                placeholder="İşlem No, Misafir veya Mülk Ara..." 
                className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-blue-500/20 focus:border-blue-500/40 transition-all font-medium border-l border-t shadow-2xl" 
                value={searchTerm} 
                onChange={e => setSearchTerm(e.target.value)} 
              />
            </div>
            <div className="flex gap-2">
              <Button variant="outline" className="h-14 px-6 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-muted/50 gap-2">
                <Filter className="w-4 h-4" /> Filtrele
              </Button>
            </div>
          </div>

          <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
            <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-blue-600 via-transparent to-transparent opacity-50"></div>
            <CardContent className="p-0">
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader className="bg-muted/50 border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">İŞLEM NO & MİSAFİR</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8">MÜLK</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8">TUTAR</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8">İŞLEM TARİHİ</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8">DURUM & ÇIKIŞ TARİHİ</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {transactions.filter(t => t.guest.toLowerCase().includes(searchTerm.toLowerCase()) || t.property.toLowerCase().includes(searchTerm.toLowerCase())).map((trx) => (
                      <TableRow key={trx.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                        <TableCell className="py-6 px-8">
                          <div className="space-y-1">
                            <span className="font-bold text-foreground block">{trx.guest}</span>
                            <span className="text-xs text-muted-foreground font-mono">{trx.id}</span>
                          </div>
                        </TableCell>
                        <TableCell className="px-8 font-semibold text-sm">{trx.property}</TableCell>
                        <TableCell className="px-8 font-black text-emerald-400">${trx.amount.toLocaleString()}</TableCell>
                        <TableCell className="px-8 text-sm text-muted-foreground">{trx.date}</TableCell>
                        <TableCell className="px-8">
                          <div className="flex flex-col items-start gap-1">
                            {trx.status === "LOCKED" ? (
                              <Badge className="bg-blue-500/20 text-blue-400 border-none gap-1 font-bold">
                                <Lock className="w-3 h-3" /> BLOKEDE
                              </Badge>
                            ) : (
                              <Badge className="bg-emerald-500/20 text-emerald-400 border-none gap-1 font-bold">
                                <Unlock className="w-3 h-3" /> AKTARILDI
                              </Badge>
                            )}
                            <span className="text-[10px] text-muted-foreground mt-1">Serbest Kalma: {trx.releaseDate}</span>
                          </div>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </PageShell>
  );
}
