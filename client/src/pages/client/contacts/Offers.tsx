import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useToast } from "@/hooks/use-toast";
import { offersApi, type Offer, type PropertyOffer } from "@/lib/api/offers";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { contactsApi, type Contact } from "@/lib/api/contacts";
import { Loader2, RefreshCw, Send, CheckCircle2, XCircle, Home, User } from "lucide-react";
import { useQuery } from "@tanstack/react-query";

export default function Offers() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [activeTab, setActiveTab] = useState("property");

  const { data, isLoading: loading, refetch } = useQuery({
    queryKey: ['offersData'],
    queryFn: async () => {
      const [propOffRes, bookOffRes, propRes, contRes] = await Promise.all([
        offersApi.getPropertyOffers(),
        offersApi.getOffers(),
        propertiesApi.getAll(),
        contactsApi.getAll()
      ]);
      return {
        propertyOffers: propOffRes || [],
        bookingOffers: bookOffRes || [],
        properties: propRes || [],
        contacts: Array.isArray(contRes) ? contRes : (contRes as any)?.data || []
      };
    }
  });

  const { propertyOffers = [], bookingOffers = [], properties = [], contacts = [] }: {
    propertyOffers?: PropertyOffer[],
    bookingOffers?: Offer[],
    properties?: Property[],
    contacts?: Contact[]
  } = data || {};

  const getPropName = (id: string) => properties.find(p => p.id === id)?.name || "Unknown Property";
  const getContName = (id: string) => {
    const c = contacts.find(c => c.id === id);
    return c ? `${c.firstName} ${c.lastName}` : "Unknown Contact";
  };
  const getStatusBadge = (status: string) => {
    const s = status.toUpperCase();
    if (s === "ACCEPTED") return <Badge className="bg-green-100 text-green-700 border-0">{t("client.src.accepted")}</Badge>;
    if (s === "REJECTED") return <Badge className="bg-red-100 text-red-700 border-0">{t("client.src.rejected")}</Badge>;
    if (s === "COUNTERED") return <Badge className="bg-blue-100 text-blue-700 border-0">{t("client.src.countered")}</Badge>;
    return <Badge className="bg-yellow-100 text-yellow-700 border-0">{t("client.src.pending")}</Badge>;
  };
  return <PageShell title={t("client.src.offer_management")} description={t("client.src.track_and_manage_property")} actions={<Button variant="outline" size="icon" onClick={() => refetch()} disabled={loading}>
          <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
        </Button>}>
      <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
        <TabsList className="bg-muted/50 p-1">
          <TabsTrigger value="property" className="data-[state=active]:bg-background">{t("client.src.property_sales_offers")}</TabsTrigger>
          <TabsTrigger value="booking" className="data-[state=active]:bg-background">{t("client.src.booking_proposals")}</TabsTrigger>
        </TabsList>

        <TabsContent value="property" className="space-y-4 outline-none">
          <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("client.src.property")}</TableHead>
                  <TableHead>{t("client.src.contact_agent")}</TableHead>
                  <TableHead>{t("client.src.offer_price")}</TableHead>
                  <TableHead>{t("client.src.status")}</TableHead>
                  <TableHead>{t("client.src.submitted_at")}</TableHead>
                  <TableHead className="text-right">{t("client.src.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : propertyOffers.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_property_offers_found")}</TableCell></TableRow> : propertyOffers.map(offer => <TableRow key={offer.id}>
                      <TableCell className="font-medium">
                        <div className="flex items-center gap-2">
                          <Home className="w-4 h-4 text-muted-foreground" />
                          {getPropName(offer.propertyId)}
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <User className="w-4 h-4 text-muted-foreground" />
                          {getContName(offer.contactId)}
                        </div>
                      </TableCell>
                      <TableCell className="font-bold text-primary">${Number(offer.offerPrice).toLocaleString()} {offer.currency}</TableCell>
                      <TableCell>{getStatusBadge(offer.status)}</TableCell>
                      <TableCell className="text-sm text-muted-foreground">{new Date(offer.createdAt).toLocaleDateString()}</TableCell>
                      <TableCell className="text-right">
                        <div className="flex justify-end gap-1">
                          <Button size="icon" variant="ghost" className="h-8 w-8 text-green-600"><CheckCircle2 className="w-4 h-4" /></Button>
                          <Button size="icon" variant="ghost" className="h-8 w-8 text-red-600"><XCircle className="w-4 h-4" /></Button>
                          <Button size="icon" variant="ghost" className="h-8 w-8 text-blue-600"><Send className="w-4 h-4" /></Button>
                        </div>
                      </TableCell>
                    </TableRow>)}
              </TableBody>
            </Table>
          </div>
        </TabsContent>

        <TabsContent value="booking" className="space-y-4 outline-none">
          <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("client.src.property")}</TableHead>
                  <TableHead>{t("client.src.offer_type")}</TableHead>
                  <TableHead>{t("client.src.final_price")}</TableHead>
                  <TableHead>{t("client.src.duration")}</TableHead>
                  <TableHead>{t("client.src.status")}</TableHead>
                  <TableHead className="text-right">{t("client.src.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : bookingOffers.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_booking_proposals_found")}</TableCell></TableRow> : bookingOffers.map(offer => <TableRow key={offer.id}>
                      <TableCell className="font-medium">
                        <div className="flex items-center gap-2">
                          <Home className="w-4 h-4 text-muted-foreground" />
                          {getPropName(offer.propertyId)}
                        </div>
                      </TableCell>
                      <TableCell><Badge variant="outline" className="text-[10px]">{offer.offerType}</Badge></TableCell>
                      <TableCell className="font-bold text-primary">${offer.finalPrice.toLocaleString()}</TableCell>
                      <TableCell className="text-xs text-muted-foreground">
                        {new Date(offer.startDate).toLocaleDateString()} - {new Date(offer.endDate).toLocaleDateString()}
                      </TableCell>
                      <TableCell>{getStatusBadge(offer.status)}</TableCell>
                      <TableCell className="text-right">
                        <div className="flex justify-end gap-1">
                          <Button size="icon" variant="ghost" className="h-8 w-8 text-green-600"><CheckCircle2 className="w-4 h-4" /></Button>
                          <Button size="icon" variant="ghost" className="h-8 w-8 text-red-600"><XCircle className="w-4 h-4" /></Button>
                        </div>
                      </TableCell>
                    </TableRow>)}
              </TableBody>
            </Table>
          </div>
        </TabsContent>
      </Tabs>
    </PageShell>;
}