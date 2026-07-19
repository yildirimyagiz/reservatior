"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Smartphone,
  Search,
  ScanLine,
  FileText,
  DollarSign,
  TrendingUp,
  Home,
  MapPin,
  Bed,
  Maximize2,
  Clock,
  AlertCircle,
  Shield,
  Star,
  ShoppingCart,
  ArrowRight,
  BadgeCheck,
  Percent,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";

const mockScannedProperties = [
  {
    propertyId: "prop-001",
    address: "123 Oak Avenue, Suite 4B",
    city: "New York",
    bedrooms: 3,
    squareMeters: 120,
    estimatedValue: 750000,
    estimatedRent: 3500,
    occupancyRate: 92,
    certificateTier: "GOLD",
    trustScore: 88,
  },
  {
    propertyId: "prop-002",
    address: "456 Maple Street",
    city: "Los Angeles",
    bedrooms: 2,
    squareMeters: 85,
    estimatedValue: 520000,
    estimatedRent: 2800,
    occupancyRate: 85,
    certificateTier: "SILVER",
    trustScore: 75,
  },
  {
    propertyId: "prop-003",
    address: "789 Pine Road, Unit 12",
    city: "Chicago",
    bedrooms: 4,
    squareMeters: 160,
    estimatedValue: 620000,
    estimatedRent: 4100,
    occupancyRate: 95,
    certificateTier: "PLATINUM",
    trustScore: 94,
  },
  {
    propertyId: "prop-004",
    address: "321 Elm Boulevard",
    city: "Miami",
    bedrooms: 1,
    squareMeters: 55,
    estimatedValue: 310000,
    estimatedRent: 1900,
    occupancyRate: 78,
    certificateTier: "BRONZE",
    trustScore: 62,
  },
  {
    propertyId: "prop-005",
    address: "555 Birch Lane, Floor 3",
    city: "New York",
    bedrooms: 2,
    squareMeters: 95,
    estimatedValue: 680000,
    estimatedRent: 3200,
    occupancyRate: 90,
    certificateTier: "GOLD",
    trustScore: 85,
  },
];

const mockOffers = [
  {
    id: "off-001",
    agentId: "agent-001",
    propertyId: "prop-001",
    offerType: "STANDARD",
    bundleId: undefined,
    amount: 750000,
    commission: 45000,
    commissionRate: 6,
    status: "ACCEPTED",
    validUntil: "2026-08-15",
    notes: "Premium property with high occupancy",
    createdAt: "2026-07-01",
  },
  {
    id: "off-002",
    agentId: "agent-001",
    propertyId: "prop-002",
    offerType: "BUNDLE",
    bundleId: "bundle-003",
    amount: 520000,
    commission: 26000,
    commissionRate: 5,
    status: "SENT",
    validUntil: "2026-07-30",
    notes: "Includes staging package",
    createdAt: "2026-07-10",
  },
  {
    id: "off-003",
    agentId: "agent-001",
    propertyId: "prop-003",
    offerType: "PREMIUM",
    bundleId: "bundle-005",
    amount: 620000,
    commission: 43400,
    commissionRate: 7,
    status: "DRAFT",
    validUntil: "2026-09-01",
    notes: "",
    createdAt: "2026-07-15",
  },
  {
    id: "off-004",
    agentId: "agent-001",
    propertyId: "prop-005",
    offerType: "STANDARD",
    amount: 680000,
    commission: 34000,
    commissionRate: 5,
    status: "REJECTED",
    validUntil: "2026-07-01",
    notes: "Client declined",
    createdAt: "2026-06-20",
  },
  {
    id: "off-005",
    agentId: "agent-001",
    propertyId: "prop-004",
    offerType: "STANDARD",
    amount: 310000,
    commission: 15500,
    commissionRate: 5,
    status: "EXPIRED",
    validUntil: "2026-06-15",
    notes: "",
    createdAt: "2026-05-10",
  },
];

const mockDashboard = {
  totalOrders: 127,
  totalRevenue: 2840000,
  totalCommissions: 168500,
  pendingCommissions: 32000,
  activeOffers: 14,
  propertiesScanned: 89,
  recentOrders: [
    { id: "ord-001", property: "123 Oak Avenue", amount: 750000, commission: 45000, date: "2026-07-15", status: "COMPLETED" },
    { id: "ord-002", property: "789 Pine Road", amount: 620000, commission: 43400, date: "2026-07-12", status: "COMPLETED" },
    { id: "ord-003", property: "456 Maple Street", amount: 520000, commission: 26000, date: "2026-07-10", status: "PENDING" },
    { id: "ord-004", property: "555 Birch Lane", amount: 680000, commission: 34000, date: "2026-07-08", status: "COMPLETED" },
  ],
  topProperties: [
    { propertyId: "prop-001", address: "123 Oak Avenue", orders: 23, revenue: 450000 },
    { propertyId: "prop-003", address: "789 Pine Road", orders: 18, revenue: 380000 },
    { propertyId: "prop-005", address: "555 Birch Lane", orders: 15, revenue: 310000 },
    { propertyId: "prop-002", address: "456 Maple Street", orders: 12, revenue: 220000 },
  ],
};

const OFFER_STATUS_COLORS: Record<string, string> = {
  DRAFT: "bg-gray-500/20 text-gray-400",
  SENT: "bg-blue-500/20 text-blue-400",
  ACCEPTED: "bg-green-500/20 text-green-400",
  REJECTED: "bg-red-500/20 text-red-400",
  EXPIRED: "bg-amber-500/20 text-amber-400",
};

const ORDER_STATUS_COLORS: Record<string, string> = {
  COMPLETED: "bg-green-500/20 text-green-400",
  PENDING: "bg-amber-500/20 text-amber-400",
  CANCELLED: "bg-red-500/20 text-red-400",
};

const CERT_TIER_COLORS: Record<string, string> = {
  PLATINUM: "bg-purple-500/20 text-purple-400 border-purple-500/30",
  GOLD: "bg-amber-500/20 text-amber-400 border-amber-500/30",
  SILVER: "bg-gray-400/20 text-gray-300 border-gray-400/30",
  BRONZE: "bg-orange-500/20 text-orange-400 border-orange-500/30",
};

function TrustScoreBadge({ score }: { score: number }) {
  const color =
    score >= 80
      ? "text-green-400"
      : score >= 60
      ? "text-amber-400"
      : "text-red-400";
  return (
    <div className={`flex items-center gap-1 text-xs font-medium ${color}`}>
      <Shield className="w-3 h-3" />
      {score}
    </div>
  );
}

export default function AgentMobilePage() {
  const { t } = useTranslation();
  const [activeTab, setActiveTab] = useState("scanner");
  const [searchAddress, setSearchAddress] = useState("");
  const [searchCity, setSearchCity] = useState("");
  const [minBedrooms, setMinBedrooms] = useState("any");
  const [maxPrice, setMaxPrice] = useState("");
  const [isScanning, setIsScanning] = useState(false);
  const [scanResults, setScanResults] = useState(mockScannedProperties);
  const [offerDialogOpen, setOfferDialogOpen] = useState(false);
  const [selectedPropertyForOffer, setSelectedPropertyForOffer] = useState<any>(null);
  const [offerType, setOfferType] = useState("STANDARD");
  const [offerAmount, setOfferAmount] = useState("");
  const [offerNotes, setOfferNotes] = useState("");
  const [offers, setOffers] = useState(mockOffers);
  const [dashboard] = useState(mockDashboard);
  const [filters, setFilters] = useState({ offerStatus: "all" });

  const handleScan = () => {
    setIsScanning(true);
    setTimeout(() => {
      setIsScanning(false);
      setScanResults(mockScannedProperties);
    }, 1200);
  };

  const handleGenerateOffer = (property: any) => {
    setSelectedPropertyForOffer(property);
    setOfferAmount(String(property.estimatedValue));
    setOfferDialogOpen(true);
  };

  const handleSubmitOffer = () => {
    if (!selectedPropertyForOffer) return;
    const newOffer = {
      id: `off-${Date.now()}`,
      agentId: "agent-001",
      propertyId: selectedPropertyForOffer.propertyId,
      offerType,
      amount: Number(offerAmount),
      commission: Math.round(Number(offerAmount) * 0.06),
      commissionRate: 6,
      status: "DRAFT",
      validUntil: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split("T")[0],
      notes: offerNotes,
      createdAt: new Date().toISOString().split("T")[0],
    };
    setOffers((prev) => [newOffer, ...prev]);
    setOfferDialogOpen(false);
    setSelectedPropertyForOffer(null);
    setOfferNotes("");
  };

  const filteredOffers = offers.filter((o) => {
    if (filters.offerStatus === "all") return true;
    return o.status === filters.offerStatus;
  });

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-6 md:py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-6 md:mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl md:text-3xl font-bold text-foreground mb-1 md:mb-2 flex items-center gap-2">
                <Smartphone className="w-6 h-6 md:w-7 md:h-7 text-primary" />
                {t("admin_agent_mobile_title", "Agent Mobile Commerce")}
              </h1>
              <p className="text-sm md:text-muted-foreground">
                {t(
                  "admin_agent_mobile_description",
                  "Mobile-optimized commerce: scan properties, generate offers, track commissions"
                )}
              </p>
            </div>
          </div>
        </motion.div>

        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
          <TabsList className="bg-card border border-border p-1 h-auto w-full md:w-auto flex overflow-x-auto">
            <TabsTrigger
              value="scanner"
              className="flex items-center gap-2 text-xs md:text-sm data-[state=active]:bg-primary data-[state=active]:text-primary-foreground flex-1 md:flex-none"
            >
              <ScanLine className="w-4 h-4" />
              <span className="hidden sm:inline">{t("admin_agent_mobile_scan_tab", "Property Scanner")}</span>
              <span className="sm:hidden">{t("admin_agent_mobile_scan_tab", "Scanner")}</span>
            </TabsTrigger>
            <TabsTrigger
              value="offers"
              className="flex items-center gap-2 text-xs md:text-sm data-[state=active]:bg-primary data-[state=active]:text-primary-foreground flex-1 md:flex-none"
            >
              <FileText className="w-4 h-4" />
              <span className="hidden sm:inline">{t("admin_agent_mobile_offers_tab", "My Offers")}</span>
              <span className="sm:hidden">{t("admin_agent_mobile_offers_tab", "Offers")}</span>
            </TabsTrigger>
            <TabsTrigger
              value="commission"
              className="flex items-center gap-2 text-xs md:text-sm data-[state=active]:bg-primary data-[state=active]:text-primary-foreground flex-1 md:flex-none"
            >
              <DollarSign className="w-4 h-4" />
              <span className="hidden sm:inline">{t("admin_agent_mobile_commission_tab", "Commission Dashboard")}</span>
              <span className="sm:hidden">{t("admin_agent_mobile_commission_tab", "Commissions")}</span>
            </TabsTrigger>
          </TabsList>

          {/* TAB 1: Property Scanner */}
          <TabsContent value="scanner" className="space-y-6">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
            >
              <Card className="bg-card border-border">
                <CardHeader className="pb-3">
                  <CardTitle className="text-foreground flex items-center gap-2 text-base md:text-lg">
                    <Search className="w-4 h-4 md:w-5 md:h-5" />
                    {t("admin_agent_mobile_scan_tab", "Property Scanner")}
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
                    <div className="sm:col-span-2 lg:col-span-1">
                      <Label className="text-xs text-muted-foreground mb-1 block">
                        {t("admin_agent_mobile_scan_placeholder", "Search by address or city...")}
                      </Label>
                      <div className="relative">
                        <MapPin className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                        <Input
                          placeholder={t("admin_agent_mobile_scan_placeholder", "Search by address or city...")}
                          value={searchAddress}
                          onChange={(e) => setSearchAddress(e.target.value)}
                          className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                        />
                      </div>
                    </div>
                    <div>
                      <Label className="text-xs text-muted-foreground mb-1 block">City</Label>
                      <Input
                        placeholder="City"
                        value={searchCity}
                        onChange={(e) => setSearchCity(e.target.value)}
                        className="bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                      />
                    </div>
                    <div>
                      <Label className="text-xs text-muted-foreground mb-1 block">
                        {t("admin_agent_mobile_bedrooms", "Bedrooms")}
                      </Label>
                      <Select value={minBedrooms} onValueChange={setMinBedrooms}>
                        <SelectTrigger className="bg-white/5 border-white/10 text-foreground">
                          <SelectValue placeholder="Any" />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="any">Any</SelectItem>
                          <SelectItem value="1">1+</SelectItem>
                          <SelectItem value="2">2+</SelectItem>
                          <SelectItem value="3">3+</SelectItem>
                          <SelectItem value="4">4+</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    <div>
                      <Label className="text-xs text-muted-foreground mb-1 block">Max Price</Label>
                      <Input
                        type="number"
                        placeholder="e.g. 500000"
                        value={maxPrice}
                        onChange={(e) => setMaxPrice(e.target.value)}
                        className="bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                      />
                    </div>
                  </div>
                  <div className="mt-4">
                    <Button
                      onClick={handleScan}
                      disabled={isScanning}
                      className="bg-primary hover:bg-primary/90 w-full sm:w-auto"
                    >
                      {isScanning ? (
                        <motion.div
                          animate={{ rotate: 360 }}
                          transition={{ repeat: Infinity, duration: 1, ease: "linear" }}
                          className="w-4 h-4 border-2 border-primary-foreground border-t-transparent rounded-full mr-2"
                        />
                      ) : (
                        <ScanLine className="w-4 h-4 mr-2" />
                      )}
                      {t("admin_agent_mobile_scan_button", "Scan")}
                    </Button>
                  </div>
                </CardContent>
              </Card>
            </motion.div>

            {/* Scan Results */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 }}
            >
              {scanResults.length === 0 ? (
                <Card className="bg-card border-border">
                  <CardContent className="p-8 text-center">
                    <ScanLine className="w-12 h-12 text-muted-foreground mx-auto mb-3 opacity-50" />
                    <p className="text-sm text-muted-foreground">
                      {t("admin_agent_mobile_no_results", "No properties found matching your criteria")}
                    </p>
                  </CardContent>
                </Card>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
                  {scanResults.map((property, index) => (
                    <motion.div
                      key={property.propertyId}
                      initial={{ opacity: 0, y: 20 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: 0.1 + index * 0.05 }}
                    >
                      <Card className="bg-card border-border hover:border-primary/30 transition-colors h-full flex flex-col">
                        <CardContent className="p-4 flex flex-col flex-1">
                          <div className="flex items-start justify-between mb-3">
                            <div className="flex-1 min-w-0">
                              <h3 className="text-sm font-semibold text-foreground truncate">
                                {property.address}
                              </h3>
                              <p className="text-xs text-muted-foreground flex items-center gap-1 mt-0.5">
                                <MapPin className="w-3 h-3" />
                                {property.city}
                              </p>
                            </div>
                            {property.certificateTier && (
                              <Badge
                                className={`text-[10px] ml-2 shrink-0 border ${
                                  CERT_TIER_COLORS[property.certificateTier] || ""
                                }`}
                              >
                                {property.certificateTier}
                              </Badge>
                            )}
                          </div>

                          <div className="grid grid-cols-2 gap-2 mb-3">
                            <div className="flex items-center gap-1.5 text-xs">
                              <Bed className="w-3.5 h-3.5 text-muted-foreground" />
                              <span className="text-muted-foreground">
                                {t("admin_agent_mobile_bedrooms", "Bedrooms")}:
                              </span>
                              <span className="text-foreground font-medium">{property.bedrooms}</span>
                            </div>
                            <div className="flex items-center gap-1.5 text-xs">
                              <Maximize2 className="w-3.5 h-3.5 text-muted-foreground" />
                              <span className="text-muted-foreground">
                                {t("admin_agent_mobile_sqm", "Area (m\u00B2)")}:
                              </span>
                              <span className="text-foreground font-medium">{property.squareMeters}</span>
                            </div>
                          </div>

                          <div className="space-y-1.5 mb-3">
                            <div className="flex items-center justify-between text-xs">
                              <span className="text-muted-foreground">
                                {t("admin_agent_mobile_property_value", "Est. Value")}
                              </span>
                              <span className="text-foreground font-semibold">
                                ${property.estimatedValue.toLocaleString()}
                              </span>
                            </div>
                            <div className="flex items-center justify-between text-xs">
                              <span className="text-muted-foreground">
                                {t("admin_agent_mobile_property_rent", "Est. Monthly Rent")}
                              </span>
                              <span className="text-foreground font-medium">
                                ${property.estimatedRent.toLocaleString()}/mo
                              </span>
                            </div>
                            <div className="flex items-center justify-between text-xs">
                              <span className="text-muted-foreground">
                                {t("admin_agent_mobile_property_occupancy", "Occupancy")}
                              </span>
                              <div className="flex items-center gap-2">
                                <div className="w-16 h-1.5 bg-muted rounded-full overflow-hidden">
                                  <div
                                    className={`h-full rounded-full ${
                                      property.occupancyRate >= 90
                                        ? "bg-green-500"
                                        : property.occupancyRate >= 75
                                        ? "bg-amber-500"
                                        : "bg-red-500"
                                    }`}
                                    style={{ width: `${property.occupancyRate}%` }}
                                  />
                                </div>
                                <span className="text-foreground font-medium">{property.occupancyRate}%</span>
                              </div>
                            </div>
                            {property.trustScore !== undefined && (
                              <div className="flex items-center justify-between text-xs">
                                <span className="text-muted-foreground">
                                  {t("admin_agent_mobile_trust_score", "Trust Score")}
                                </span>
                                <TrustScoreBadge score={property.trustScore} />
                              </div>
                            )}
                          </div>

                          <div className="mt-auto pt-2 border-t border-border/50">
                            <Button
                              onClick={() => handleGenerateOffer(property)}
                              size="sm"
                              className="w-full bg-primary hover:bg-primary/90 text-xs"
                            >
                              <FileText className="w-3.5 h-3.5 mr-1.5" />
                              {t("admin_agent_mobile_generate_offer", "Generate Offer")}
                              <ArrowRight className="w-3.5 h-3.5 ml-1.5" />
                            </Button>
                          </div>
                        </CardContent>
                      </Card>
                    </motion.div>
                  ))}
                </div>
              )}
            </motion.div>
          </TabsContent>

          {/* TAB 2: My Offers */}
          <TabsContent value="offers" className="space-y-6">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
            >
              <Card className="bg-card border-border">
                <CardHeader className="pb-3">
                  <div className="flex items-center justify-between">
                    <CardTitle className="text-foreground flex items-center gap-2 text-base md:text-lg">
                      <FileText className="w-4 h-4 md:w-5 md:h-5" />
                      {t("admin_agent_mobile_offers_tab", "My Offers")} ({filteredOffers.length})
                    </CardTitle>
                    <Select
                      value={filters.offerStatus}
                      onValueChange={(v) => setFilters({ offerStatus: v })}
                    >
                      <SelectTrigger className="w-[130px] bg-white/5 border-white/10 text-foreground text-xs">
                        <SelectValue placeholder="Status" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="all">All</SelectItem>
                        <SelectItem value="DRAFT">Draft</SelectItem>
                        <SelectItem value="SENT">Sent</SelectItem>
                        <SelectItem value="ACCEPTED">Accepted</SelectItem>
                        <SelectItem value="REJECTED">Rejected</SelectItem>
                        <SelectItem value="EXPIRED">Expired</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
                    {filteredOffers.map((offer, index) => (
                      <motion.div
                        key={offer.id}
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.1 + index * 0.05 }}
                      >
                        <Card className="bg-card border-border hover:border-primary/20 transition-colors">
                          <CardContent className="p-4">
                            <div className="flex items-start justify-between mb-3">
                              <div>
                                <p className="text-xs text-muted-foreground font-mono">{offer.id}</p>
                                <p className="text-xs text-muted-foreground mt-1">{offer.offerType}</p>
                              </div>
                              <Badge className={`text-[10px] ${OFFER_STATUS_COLORS[offer.status]}`}>
                                {offer.status}
                              </Badge>
                            </div>

                            <div className="space-y-2 mb-3">
                              <div className="flex items-center justify-between text-sm">
                                <span className="text-muted-foreground flex items-center gap-1">
                                  <DollarSign className="w-3.5 h-3.5" />
                                  {t("admin_agent_mobile_offer_amount", "Offer Amount")}
                                </span>
                                <span className="text-foreground font-bold">
                                  ${offer.amount.toLocaleString()}
                                </span>
                              </div>
                              <div className="flex items-center justify-between text-sm">
                                <span className="text-muted-foreground flex items-center gap-1">
                                  <Percent className="w-3.5 h-3.5" />
                                  {t("admin_agent_mobile_offer_commission", "Commission")}
                                </span>
                                <span className="text-green-400 font-semibold">
                                  ${offer.commission.toLocaleString()} ({offer.commissionRate}%)
                                </span>
                              </div>
                            </div>

                            <div className="flex items-center justify-between text-xs text-muted-foreground pt-2 border-t border-border/50">
                              <span className="flex items-center gap-1">
                                <Clock className="w-3 h-3" />
                                {t("admin_agent_mobile_offer_valid_until", "Valid Until")}: {offer.validUntil}
                              </span>
                            </div>

                            {offer.notes && (
                              <p className="text-xs text-muted-foreground mt-2 italic truncate">
                                {offer.notes}
                              </p>
                            )}
                          </CardContent>
                        </Card>
                      </motion.div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          </TabsContent>

          {/* TAB 3: Commission Dashboard */}
          <TabsContent value="commission" className="space-y-6">
            {/* Summary Cards */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
              className="grid grid-cols-2 lg:grid-cols-4 gap-3 md:gap-4"
            >
              <Card className="bg-card border-border">
                <CardContent className="p-3 md:p-4">
                  <div className="flex items-center gap-2 md:gap-3">
                    <div className="p-1.5 md:p-2 rounded-lg bg-blue-500/10">
                      <ShoppingCart className="w-4 h-4 md:w-5 md:h-5 text-blue-500" />
                    </div>
                    <div>
                      <p className="text-[10px] md:text-sm text-muted-foreground">
                        {t("admin_agent_mobile_total_orders", "Total Orders")}
                      </p>
                      <p className="text-lg md:text-2xl font-bold text-foreground">
                        {dashboard.totalOrders}
                      </p>
                    </div>
                  </div>
                </CardContent>
              </Card>
              <Card className="bg-card border-border">
                <CardContent className="p-3 md:p-4">
                  <div className="flex items-center gap-2 md:gap-3">
                    <div className="p-1.5 md:p-2 rounded-lg bg-green-500/10">
                      <TrendingUp className="w-4 h-4 md:w-5 md:h-5 text-green-500" />
                    </div>
                    <div>
                      <p className="text-[10px] md:text-sm text-muted-foreground">
                        {t("admin_agent_mobile_total_revenue", "Total Revenue")}
                      </p>
                      <p className="text-lg md:text-2xl font-bold text-foreground">
                        ${(dashboard.totalRevenue / 1000).toFixed(0)}k
                      </p>
                    </div>
                  </div>
                </CardContent>
              </Card>
              <Card className="bg-card border-border">
                <CardContent className="p-3 md:p-4">
                  <div className="flex items-center gap-2 md:gap-3">
                    <div className="p-1.5 md:p-2 rounded-lg bg-amber-500/10">
                      <DollarSign className="w-4 h-4 md:w-5 md:h-5 text-amber-500" />
                    </div>
                    <div>
                      <p className="text-[10px] md:text-sm text-muted-foreground">
                        {t("admin_agent_mobile_total_commissions", "Total Commissions")}
                      </p>
                      <p className="text-lg md:text-2xl font-bold text-foreground">
                        ${(dashboard.totalCommissions / 1000).toFixed(1)}k
                      </p>
                    </div>
                  </div>
                </CardContent>
              </Card>
              <Card className="bg-card border-border">
                <CardContent className="p-3 md:p-4">
                  <div className="flex items-center gap-2 md:gap-3">
                    <div className="p-1.5 md:p-2 rounded-lg bg-red-500/10">
                      <AlertCircle className="w-4 h-4 md:w-5 md:h-5 text-red-500" />
                    </div>
                    <div>
                      <p className="text-[10px] md:text-sm text-muted-foreground">
                        {t("admin_agent_mobile_pending_commissions", "Pending")}
                      </p>
                      <p className="text-lg md:text-2xl font-bold text-foreground">
                        ${(dashboard.pendingCommissions / 1000).toFixed(1)}k
                      </p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </motion.div>

            {/* Secondary Stats */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.15 }}
              className="grid grid-cols-2 gap-3 md:gap-4"
            >
              <Card className="bg-card border-border">
                <CardContent className="p-3 md:p-4">
                  <div className="flex items-center gap-2 md:gap-3">
                    <div className="p-1.5 md:p-2 rounded-lg bg-purple-500/10">
                      <BadgeCheck className="w-4 h-4 md:w-5 md:h-5 text-purple-500" />
                    </div>
                    <div>
                      <p className="text-[10px] md:text-sm text-muted-foreground">
                        {t("admin_agent_mobile_active_offers", "Active Offers")}
                      </p>
                      <p className="text-lg md:text-2xl font-bold text-foreground">
                        {dashboard.activeOffers}
                      </p>
                    </div>
                  </div>
                </CardContent>
              </Card>
              <Card className="bg-card border-border">
                <CardContent className="p-3 md:p-4">
                  <div className="flex items-center gap-2 md:gap-3">
                    <div className="p-1.5 md:p-2 rounded-lg bg-cyan-500/10">
                      <Home className="w-4 h-4 md:w-5 md:h-5 text-cyan-500" />
                    </div>
                    <div>
                      <p className="text-[10px] md:text-sm text-muted-foreground">
                        {t("admin_agent_mobile_properties_scanned", "Properties Scanned")}
                      </p>
                      <p className="text-lg md:text-2xl font-bold text-foreground">
                        {dashboard.propertiesScanned}
                      </p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </motion.div>

            {/* Recent Orders */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 }}
            >
              <Card className="bg-card border-border">
                <CardHeader className="pb-3">
                  <CardTitle className="text-foreground flex items-center gap-2 text-base md:text-lg">
                    <ShoppingCart className="w-4 h-4 md:w-5 md:h-5" />
                    Recent Orders
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="overflow-x-auto">
                    <table className="w-full text-sm">
                      <thead>
                        <tr className="border-b border-border">
                          <th className="text-left py-2 md:py-3 px-3 md:px-4 text-muted-foreground font-medium text-xs">
                            Order
                          </th>
                          <th className="text-left py-2 md:py-3 px-3 md:px-4 text-muted-foreground font-medium text-xs">
                            Property
                          </th>
                          <th className="text-right py-2 md:py-3 px-3 md:px-4 text-muted-foreground font-medium text-xs">
                            Amount
                          </th>
                          <th className="text-right py-2 md:py-3 px-3 md:px-4 text-muted-foreground font-medium text-xs">
                            Commission
                          </th>
                          <th className="text-left py-2 md:py-3 px-3 md:px-4 text-muted-foreground font-medium text-xs hidden sm:table-cell">
                            Date
                          </th>
                          <th className="text-left py-2 md:py-3 px-3 md:px-4 text-muted-foreground font-medium text-xs">
                            Status
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        {dashboard.recentOrders.map((order) => (
                          <tr
                            key={order.id}
                            className="border-b border-border/50 hover:bg-muted/30 transition-colors"
                          >
                            <td className="py-2 md:py-3 px-3 md:px-4 font-mono text-xs text-muted-foreground">
                              {order.id}
                            </td>
                            <td className="py-2 md:py-3 px-3 md:px-4 text-foreground font-medium text-xs md:text-sm">
                              {order.property}
                            </td>
                            <td className="py-2 md:py-3 px-3 md:px-4 text-right font-medium text-foreground text-xs md:text-sm">
                              ${order.amount.toLocaleString()}
                            </td>
                            <td className="py-2 md:py-3 px-3 md:px-4 text-right text-green-400 font-medium text-xs md:text-sm">
                              ${order.commission.toLocaleString()}
                            </td>
                            <td className="py-2 md:py-3 px-3 md:px-4 text-muted-foreground text-xs hidden sm:table-cell">
                              {order.date}
                            </td>
                            <td className="py-2 md:py-3 px-3 md:px-4">
                              <Badge
                                className={`text-[10px] ${
                                  ORDER_STATUS_COLORS[order.status] || ""
                                }`}
                              >
                                {order.status}
                              </Badge>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </CardContent>
              </Card>
            </motion.div>

            {/* Top Properties */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.25 }}
            >
              <Card className="bg-card border-border">
                <CardHeader className="pb-3">
                  <CardTitle className="text-foreground flex items-center gap-2 text-base md:text-lg">
                    <Star className="w-4 h-4 md:w-5 md:h-5" />
                    Top Performing Properties
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    {dashboard.topProperties.map((prop, index) => (
                      <div
                        key={prop.propertyId}
                        className="flex items-center gap-3 p-3 rounded-lg bg-muted/20 border border-border/50 hover:bg-muted/30 transition-colors"
                      >
                        <div className="w-7 h-7 md:w-8 md:h-8 rounded-full bg-primary/10 flex items-center justify-center shrink-0">
                          <span className="text-xs md:text-sm font-bold text-primary">
                            {index + 1}
                          </span>
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-medium text-foreground truncate">
                            {prop.address}
                          </p>
                          <p className="text-xs text-muted-foreground">
                            {prop.orders} orders
                          </p>
                        </div>
                        <div className="text-right shrink-0">
                          <p className="text-sm font-bold text-foreground">
                            ${prop.revenue.toLocaleString()}
                          </p>
                          <p className="text-xs text-muted-foreground">revenue</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          </TabsContent>
        </Tabs>
      </div>

      {/* Generate Offer Dialog */}
      <Dialog open={offerDialogOpen} onOpenChange={setOfferDialogOpen}>
        <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">
              {t("admin_agent_mobile_generate_offer", "Generate Offer")}
            </DialogTitle>
            <DialogDescription className="text-muted-foreground">
              {selectedPropertyForOffer
                ? `${selectedPropertyForOffer.address}, ${selectedPropertyForOffer.city}`
                : ""}
            </DialogDescription>
          </DialogHeader>
          <div className="grid gap-4 py-4">
            {selectedPropertyForOffer && (
              <div className="grid grid-cols-2 gap-3 p-3 rounded-lg bg-muted/20 border border-border/50">
                <div>
                  <p className="text-xs text-muted-foreground">
                    {t("admin_agent_mobile_property_value", "Est. Value")}
                  </p>
                  <p className="text-sm font-bold text-foreground">
                    ${selectedPropertyForOffer.estimatedValue.toLocaleString()}
                  </p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">
                    {t("admin_agent_mobile_property_rent", "Est. Monthly Rent")}
                  </p>
                  <p className="text-sm font-medium text-foreground">
                    ${selectedPropertyForOffer.estimatedRent.toLocaleString()}/mo
                  </p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">
                    {t("admin_agent_mobile_bedrooms", "Bedrooms")}
                  </p>
                  <p className="text-sm font-medium text-foreground">
                    {selectedPropertyForOffer.bedrooms}
                  </p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">
                    {t("admin_agent_mobile_sqm", "Area (m\u00B2)")}
                  </p>
                  <p className="text-sm font-medium text-foreground">
                    {selectedPropertyForOffer.squareMeters} m&sup2;
                  </p>
                </div>
              </div>
            )}
            <div className="grid grid-cols-4 items-center gap-4">
              <Label className="text-right text-foreground text-sm">
                {t("admin_agent_mobile_offer_status", "Type")}
              </Label>
              <div className="col-span-3">
                <Select value={offerType} onValueChange={setOfferType}>
                  <SelectTrigger className="bg-white/5 border-white/10 text-foreground">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="STANDARD">Standard</SelectItem>
                    <SelectItem value="PREMIUM">Premium</SelectItem>
                    <SelectItem value="BUNDLE">Bundle</SelectItem>
                    <SelectItem value="FLASH">Flash Sale</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label className="text-right text-foreground text-sm">
                {t("admin_agent_mobile_offer_amount", "Amount")}
              </Label>
              <Input
                type="number"
                value={offerAmount}
                onChange={(e) => setOfferAmount(e.target.value)}
                className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
              />
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label className="text-right text-foreground text-sm">Notes</Label>
              <Input
                value={offerNotes}
                onChange={(e) => setOfferNotes(e.target.value)}
                placeholder="Optional notes..."
                className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
              />
            </div>
            {offerAmount && (
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right text-foreground text-sm">
                  {t("admin_agent_mobile_offer_commission", "Commission")}
                </Label>
                <div className="col-span-3">
                  <p className="text-sm text-green-400 font-semibold">
                    ${Math.round(Number(offerAmount) * 0.06).toLocaleString()} (6%)
                  </p>
                </div>
              </div>
            )}
          </div>
          <DialogFooter className="pt-4 border-t border-white/10">
            <Button
              variant="outline"
              onClick={() => setOfferDialogOpen(false)}
              className="border-border text-foreground"
            >
              {t("admin_action_cancel", "Cancel")}
            </Button>
            <Button
              onClick={handleSubmitOffer}
              className="bg-primary hover:bg-primary/90"
            >
              {t("admin_agent_mobile_generate_offer", "Generate Offer")}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
