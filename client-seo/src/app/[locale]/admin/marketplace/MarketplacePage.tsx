"use client";

import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Store,
  Search,
  TrendingUp,
  DollarSign,
  Star,
  Shield,
  Eye,
  Building2,
  Award,
  Filter,
  X,
  Home,
  ArrowUpRight,
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useAssetMarketplaceStore } from "@/lib/store/asset-marketplace-store";
import { assetMarketplaceApi, type AssetListing, type InvestmentOpportunity, type PropertyMarketData } from "@/lib/api/asset-marketplace";

const CERTIFICATE_TIERS = ["MOVE_IN_READY", "INCOME_READY", "INVESTMENT_READY"];
const SORT_OPTIONS = [
  { value: "price_desc", label: "Price: High to Low" },
  { value: "price_asc", label: "Price: Low to High" },
  { value: "yield_desc", label: "Yield: High to Low" },
  { value: "trust_desc", label: "Trust Score: High to Low" },
  { value: "income_desc", label: "Income: High to Low" },
];

function formatCurrency(amount: number, currency: string = "USD") {
  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency,
    maximumFractionDigits: 0,
  }).format(amount);
}

function YieldBadge({ yieldRate }: { yieldRate: number }) {
  if (yieldRate > 6)
    return (
      <Badge className="bg-green-500/20 text-green-400 border-green-500/30">
        {yieldRate.toFixed(1)}% yield
      </Badge>
    );
  if (yieldRate > 4)
    return (
      <Badge className="bg-amber-500/20 text-amber-400 border-amber-500/30">
        {yieldRate.toFixed(1)}% yield
      </Badge>
    );
  return (
    <Badge className="bg-red-500/20 text-red-400 border-red-500/30">
      {yieldRate.toFixed(1)}% yield
    </Badge>
  );
}

function TrustScoreDisplay({ score }: { score: number }) {
  return (
    <div className="flex items-center gap-1">
      <Star className="w-3.5 h-3.5 fill-amber-400 text-amber-400" />
      <span className="text-sm font-medium text-foreground">{(score / 10).toFixed(1)}</span>
    </div>
  );
}

function CertificateTierBadge({ tier }: { tier?: string }) {
  if (!tier) return <Badge variant="outline" className="text-xs">None</Badge>;
  const colors: Record<string, string> = {
    MOVE_IN_READY: "bg-blue-500/20 text-blue-400 border-blue-500/30",
    INCOME_READY: "bg-emerald-500/20 text-emerald-400 border-emerald-500/30",
    INVESTMENT_READY: "bg-purple-500/20 text-purple-400 border-purple-500/30",
  };
  const labels: Record<string, string> = {
    MOVE_IN_READY: "Move-In Ready",
    INCOME_READY: "Income Ready",
    INVESTMENT_READY: "Investment Ready",
  };
  return (
    <Badge className={`text-xs ${colors[tier] || "bg-gray-500/20 text-gray-400"}`}>
      {labels[tier] || tier}
    </Badge>
  );
}

function RiskBadge({ level }: { level: string }) {
  const colors: Record<string, string> = {
    LOW: "bg-green-500/20 text-green-400 border-green-500/30",
    MEDIUM: "bg-amber-500/20 text-amber-400 border-amber-500/30",
    HIGH: "bg-red-500/20 text-red-400 border-red-500/30",
  };
  return (
    <Badge className={`text-xs ${colors[level] || "bg-gray-500/20 text-gray-400"}`}>
      {level} Risk
    </Badge>
  );
}

export default function MarketplacePage() {
  const { t } = useTranslation();
  const {
    listings,
    summary,
    opportunities,
    selectedProperty,
    loading,
    filters,
    pagination,
    setListings,
    setSummary,
    setOpportunities,
    setSelectedProperty,
    setLoading,
    setFilters,
    setPagination,
    setError,
  } = useAssetMarketplaceStore();

  const [searchCity, setSearchCity] = useState("");
  const [minPrice, setMinPrice] = useState("");
  const [maxPrice, setMaxPrice] = useState("");
  const [minBedrooms, setMinBedrooms] = useState("");
  const [maxBedrooms, setMaxBedrooms] = useState("");
  const [minYield, setMinYield] = useState("");
  const [certTier, setCertTier] = useState("all");
  const [sortBy, setSortBy] = useState("price_desc");
  const [detailOpen, setDetailOpen] = useState(false);
  const [detailData, setDetailData] = useState<PropertyMarketData | null>(null);
  const [detailLoading, setDetailLoading] = useState(false);

  useEffect(() => {
    fetchData();
  }, []);

  useEffect(() => {
    fetchData();
  }, [filters]);

  const fetchData = async () => {
    setLoading(true);
    setError(null);
    try {
      const [listingsRes, summaryRes, oppsRes] = await Promise.all([
        assetMarketplaceApi.listAssets(filters),
        assetMarketplaceApi.getSummary(),
        assetMarketplaceApi.getOpportunities(5),
      ]);
      if (listingsRes.data) {
        const d = listingsRes.data as any;
        setListings(d.data || []);
        setPagination({ page: d.page, limit: d.limit, total: d.total, totalPages: d.totalPages });
      }
      if (summaryRes.data) setSummary(summaryRes.data as MarketplaceSummary);
      if (oppsRes.data) setOpportunities(oppsRes.data as InvestmentOpportunity[]);
    } catch (e: any) {
      setError(e.message || "Failed to load marketplace data");
    } finally {
      setLoading(false);
    }
  };

  const handleApplyFilters = () => {
    setFilters({
      city: searchCity || undefined,
      minPrice: minPrice ? Number(minPrice) : undefined,
      maxPrice: maxPrice ? Number(maxPrice) : undefined,
      minBedrooms: minBedrooms ? Number(minBedrooms) : undefined,
      maxBedrooms: maxBedrooms ? Number(maxBedrooms) : undefined,
      minYield: minYield ? Number(minYield) : undefined,
      certificateTier: certTier !== "all" ? certTier : undefined,
      sortBy,
      page: 1,
    });
  };

  const handleClearFilters = () => {
    setSearchCity("");
    setMinPrice("");
    setMaxPrice("");
    setMinBedrooms("");
    setMaxBedrooms("");
    setMinYield("");
    setCertTier("all");
    setSortBy("price_desc");
    setFilters({
      city: undefined,
      minPrice: undefined,
      maxPrice: undefined,
      minBedrooms: undefined,
      maxBedrooms: undefined,
      minYield: undefined,
      certificateTier: undefined,
      sortBy: "price_desc",
      page: 1,
    });
  };

  const handleViewDetails = async (propertyId: string) => {
    setDetailLoading(true);
    setDetailOpen(true);
    setDetailData(null);
    try {
      const res = await assetMarketplaceApi.getPropertyMarketData(propertyId);
      if (res.data) setDetailData(res.data as PropertyMarketData);
    } catch (e) {
      console.error("Failed to load property details", e);
    } finally {
      setDetailLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">
                {t("admin_marketplace_title", "Asset Marketplace")}
              </h1>
              <p className="text-muted-foreground">
                {t(
                  "admin_marketplace_description",
                  "Income-verified residential property asset trading marketplace"
                )}
              </p>
            </div>
          </div>
        </motion.div>

        {/* Summary Cards */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6"
        >
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10">
                  <Building2 className="w-5 h-5 text-blue-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_marketplace_total_listings", "Total Listings")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {summary?.totalListings ?? 0}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-green-500/10">
                  <DollarSign className="w-5 h-5 text-green-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_marketplace_total_value", "Total Value")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {summary ? formatCurrency(summary.totalValue) : "$0"}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10">
                  <TrendingUp className="w-5 h-5 text-amber-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_marketplace_avg_yield", "Avg Yield")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {summary?.averageYield?.toFixed(1) ?? "0"}%
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-purple-500/10">
                  <Shield className="w-5 h-5 text-purple-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_marketplace_avg_trust", "Avg Trust Score")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {(summary?.averageTrustScore ?? 0) / 10}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Filters */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.15 }}
          className="mb-6"
        >
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-3 mb-3">
                <div className="relative">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                  <Input
                    placeholder={t("admin_marketplace_filter_city", "City")}
                    value={searchCity}
                    onChange={(e) => setSearchCity(e.target.value)}
                    className="pl-10 bg-white/5 border-white/10 text-foreground placeholder:text-muted-foreground"
                  />
                </div>
                <Input
                  type="number"
                  placeholder="Min Price"
                  value={minPrice}
                  onChange={(e) => setMinPrice(e.target.value)}
                  className="bg-white/5 border-white/10 text-foreground placeholder:text-muted-foreground"
                />
                <Input
                  type="number"
                  placeholder="Max Price"
                  value={maxPrice}
                  onChange={(e) => setMaxPrice(e.target.value)}
                  className="bg-white/5 border-white/10 text-foreground placeholder:text-muted-foreground"
                />
                <Input
                  type="number"
                  placeholder="Min Yield %"
                  value={minYield}
                  onChange={(e) => setMinYield(e.target.value)}
                  className="bg-white/5 border-white/10 text-foreground placeholder:text-muted-foreground"
                />
                <Select value={certTier} onValueChange={setCertTier}>
                  <SelectTrigger className="bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder="Certificate Tier" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Tiers</SelectItem>
                    {CERTIFICATE_TIERS.map((tier) => (
                      <SelectItem key={tier} value={tier}>
                        {tier.replace(/_/g, " ")}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Select value={sortBy} onValueChange={setSortBy}>
                  <SelectTrigger className="bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder="Sort By" />
                  </SelectTrigger>
                  <SelectContent>
                    {SORT_OPTIONS.map((opt) => (
                      <SelectItem key={opt.value} value={opt.value}>
                        {opt.label}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="flex gap-2">
                <Button onClick={handleApplyFilters} className="bg-primary hover:bg-primary/90">
                  <Filter className="w-4 h-4 mr-2" />
                  Apply Filters
                </Button>
                <Button onClick={handleClearFilters} variant="outline">
                  <X className="w-4 h-4 mr-2" />
                  Clear
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Property Grid */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="mb-8"
        >
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Store className="w-5 h-5" />
                {t("admin_marketplace_title", "Asset Marketplace")} ({listings.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              {loading ? (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {[1, 2, 3, 4, 5, 6].map((i) => (
                    <div key={i} className="h-64 bg-muted/30 rounded-xl animate-pulse" />
                  ))}
                </div>
              ) : listings.length === 0 ? (
                <div className="text-center py-12">
                  <Building2 className="w-16 h-16 text-muted-foreground mx-auto mb-4 opacity-30" />
                  <p className="text-muted-foreground">
                    {t("admin_marketplace_no_results", "No properties found matching your criteria")}
                  </p>
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {listings.map((listing, idx) => (
                    <motion.div
                      key={listing.propertyId}
                      initial={{ opacity: 0, y: 20 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: idx * 0.05 }}
                    >
                      <Card className="bg-card/50 border-border hover:border-primary/30 transition-all duration-200 h-full flex flex-col">
                        <CardContent className="p-4 flex flex-col flex-1">
                          <div className="flex items-start justify-between mb-3">
                            <div className="flex-1 min-w-0">
                              <h3 className="font-semibold text-foreground truncate">
                                {listing.propertyName}
                              </h3>
                              <p className="text-sm text-muted-foreground flex items-center gap-1">
                                <Building2 className="w-3 h-3 shrink-0" />
                                {listing.city}, {listing.country}
                              </p>
                            </div>
                            <CertificateTierBadge tier={listing.certificateTier} />
                          </div>

                          <div className="grid grid-cols-2 gap-3 mb-3">
                            <div>
                              <p className="text-xs text-muted-foreground mb-0.5">Price</p>
                              <p className="text-lg font-bold text-foreground">
                                {formatCurrency(listing.price, listing.currency)}
                              </p>
                            </div>
                            <div>
                              <p className="text-xs text-muted-foreground mb-0.5">
                                {t("admin_marketplace_yield", "Yield")}
                              </p>
                              <YieldBadge yieldRate={listing.yieldRate} />
                            </div>
                          </div>

                          <div className="grid grid-cols-2 gap-3 mb-3">
                            <div>
                              <p className="text-xs text-muted-foreground mb-0.5">
                                {t("admin_marketplace_trust_score", "Trust Score")}
                              </p>
                              <TrustScoreDisplay score={listing.trustScore} />
                            </div>
                            <div>
                              <p className="text-xs text-muted-foreground mb-0.5">
                                {t("admin_marketplace_annual_income", "Annual Income")}
                              </p>
                              <p className="text-sm font-semibold text-foreground">
                                {formatCurrency(listing.annualIncome)}
                              </p>
                            </div>
                          </div>

                          <div className="flex items-center gap-2 mb-3 text-xs text-muted-foreground">
                            <span>{listing.bedrooms} bed</span>
                            <span>·</span>
                            <span>{listing.squareMeters} m²</span>
                            <span>·</span>
                            <span>Grade: {listing.investmentGrade}</span>
                          </div>

                          <div className="mt-auto pt-2 border-t border-border">
                            <Button
                              onClick={() => handleViewDetails(listing.propertyId)}
                              variant="outline"
                              size="sm"
                              className="w-full"
                            >
                              <Eye className="w-3.5 h-3.5 mr-2" />
                              {t("admin_marketplace_view_details", "View Details")}
                            </Button>
                          </div>
                        </CardContent>
                      </Card>
                    </motion.div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </motion.div>

        {/* Investment Opportunities */}
        {opportunities.length > 0 && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 }}
          >
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <Award className="w-5 h-5" />
                  {t("admin_marketplace_opportunities", "Investment Opportunities")}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {opportunities.map((opp, idx) => (
                    <div
                      key={opp.propertyId}
                      className="flex items-start gap-4 p-4 rounded-xl bg-muted/30 border border-border hover:border-primary/30 transition-colors"
                    >
                      <div className="flex items-center justify-center w-10 h-10 rounded-full bg-primary/10 text-primary font-bold text-sm shrink-0">
                        {idx + 1}
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-start justify-between gap-2 mb-2">
                          <div>
                            <h4 className="font-semibold text-foreground">{opp.propertyName}</h4>
                            <p className="text-sm text-muted-foreground flex items-center gap-1">
                              <Building2 className="w-3 h-3" />
                              {opp.city}
                            </p>
                          </div>
                          <RiskBadge level={opp.riskLevel} />
                        </div>

                        <div className="grid grid-cols-3 gap-4 mb-3">
                          <div>
                            <p className="text-xs text-muted-foreground">Price</p>
                            <p className="text-sm font-semibold text-foreground">
                              {formatCurrency(opp.price)}
                            </p>
                          </div>
                          <div>
                            <p className="text-xs text-muted-foreground">Yield</p>
                            <p className="text-sm font-semibold text-foreground">{opp.yieldRate.toFixed(1)}%</p>
                          </div>
                          <div>
                            <p className="text-xs text-muted-foreground">Annual Income</p>
                            <p className="text-sm font-semibold text-foreground">
                              {formatCurrency(opp.estimatedAnnualIncome)}
                            </p>
                          </div>
                        </div>

                        {opp.recommendedFor.length > 0 && (
                          <div className="mb-2">
                            <p className="text-xs text-muted-foreground mb-1">
                              {t("admin_marketplace_recommended_for", "Recommended For")}
                            </p>
                            <div className="flex flex-wrap gap-1">
                              {opp.recommendedFor.map((r) => (
                                <Badge key={r} variant="outline" className="text-xs">
                                  {r}
                                </Badge>
                              ))}
                            </div>
                          </div>
                        )}

                        {opp.highlights.length > 0 && (
                          <div>
                            <p className="text-xs text-muted-foreground mb-1">
                              {t("admin_marketplace_highlights", "Highlights")}
                            </p>
                            <div className="flex flex-wrap gap-1">
                              {opp.highlights.map((h, i) => (
                                <span
                                  key={i}
                                  className="text-xs bg-green-500/10 text-green-400 px-2 py-0.5 rounded-full"
                                >
                                  {h}
                                </span>
                              ))}
                            </div>
                          </div>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </motion.div>
        )}

        {/* Property Detail Dialog */}
        <Dialog open={detailOpen} onOpenChange={setDetailOpen}>
          <DialogContent className="max-w-3xl max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle className="text-foreground flex items-center gap-2">
                <Home className="w-5 h-5" />
                {t("admin_marketplace_property_details", "Property Details")}
              </DialogTitle>
            </DialogHeader>

            {detailLoading ? (
              <div className="space-y-4 py-8">
                {[1, 2, 3].map((i) => (
                  <div key={i} className="h-16 bg-muted/30 rounded-lg animate-pulse" />
                ))}
              </div>
            ) : detailData ? (
              <div className="space-y-6">
                {/* Main listing info */}
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <h3 className="text-xl font-bold text-foreground">{detailData.listing.propertyName}</h3>
                    <p className="text-muted-foreground flex items-center gap-1 mt-1">
                      <Building2 className="w-4 h-4" />
                      {detailData.listing.city}, {detailData.listing.country}
                    </p>
                    <p className="text-sm text-muted-foreground mt-1">{detailData.listing.address}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-2xl font-bold text-foreground">
                      {formatCurrency(detailData.listing.price)}
                    </p>
                    <div className="flex justify-end gap-2 mt-2">
                      <YieldBadge yieldRate={detailData.listing.yieldRate} />
                      <CertificateTierBadge tier={detailData.listing.certificateTier} />
                    </div>
                  </div>
                </div>

                {/* Property metrics */}
                <div className="grid grid-cols-4 gap-3">
                  <div className="p-3 rounded-lg bg-muted/30 text-center">
                    <p className="text-xs text-muted-foreground mb-1">Trust Score</p>
                    <p className="text-lg font-bold text-foreground">
                      {(detailData.listing.trustScore / 10).toFixed(1)}
                    </p>
                  </div>
                  <div className="p-3 rounded-lg bg-muted/30 text-center">
                    <p className="text-xs text-muted-foreground mb-1">
                      {t("admin_marketplace_annual_income", "Annual Income")}
                    </p>
                    <p className="text-lg font-bold text-foreground">
                      {formatCurrency(detailData.listing.annualIncome)}
                    </p>
                  </div>
                  <div className="p-3 rounded-lg bg-muted/30 text-center">
                    <p className="text-xs text-muted-foreground mb-1">
                      {t("admin_marketplace_estimated_rent", "Est. Monthly Rent")}
                    </p>
                    <p className="text-lg font-bold text-foreground">
                      {formatCurrency(detailData.listing.estimatedMonthlyRent)}
                    </p>
                  </div>
                  <div className="p-3 rounded-lg bg-muted/30 text-center">
                    <p className="text-xs text-muted-foreground mb-1">
                      {t("admin_marketplace_investment_grade", "Investment Grade")}
                    </p>
                    <p className="text-lg font-bold text-foreground">
                      {detailData.listing.investmentGrade}
                    </p>
                  </div>
                </div>

                {/* Market Trends */}
                <div>
                  <h4 className="font-semibold text-foreground mb-3 flex items-center gap-2">
                    <TrendingUp className="w-4 h-4" />
                    {t("admin_marketplace_market_trends", "Market Trends")}
                  </h4>
                  <div className="grid grid-cols-3 gap-3">
                    <div className="p-3 rounded-lg bg-muted/30 text-center">
                      <p className="text-xs text-muted-foreground mb-1">
                        {t("admin_marketplace_avg_price_city", "Avg Price in City")}
                      </p>
                      <p className="text-lg font-bold text-foreground">
                        {formatCurrency(detailData.marketTrends.averagePriceInCity)}
                      </p>
                    </div>
                    <div className="p-3 rounded-lg bg-muted/30 text-center">
                      <p className="text-xs text-muted-foreground mb-1">Avg Yield in City</p>
                      <p className="text-lg font-bold text-foreground">
                        {detailData.marketTrends.averageYieldInCity.toFixed(1)}%
                      </p>
                    </div>
                    <div className="p-3 rounded-lg bg-muted/30 text-center">
                      <p className="text-xs text-muted-foreground mb-1">
                        {t("admin_marketplace_price_per_sqm", "Price per m²")}
                      </p>
                      <p className="text-lg font-bold text-foreground">
                        {formatCurrency(detailData.marketTrends.pricePerSqm)}
                      </p>
                    </div>
                  </div>
                </div>

                {/* Comparable Properties */}
                {detailData.comparables.length > 0 && (
                  <div>
                    <h4 className="font-semibold text-foreground mb-3 flex items-center gap-2">
                      <Store className="w-4 h-4" />
                      {t("admin_marketplace_comparables", "Comparable Properties")} ({detailData.comparables.length})
                    </h4>
                    <div className="space-y-2">
                      {detailData.comparables.map((comp) => (
                        <div
                          key={comp.propertyId}
                          className="flex items-center justify-between p-3 rounded-lg bg-muted/30 border border-border"
                        >
                          <div>
                            <p className="text-sm font-medium text-foreground">{comp.propertyName}</p>
                            <p className="text-xs text-muted-foreground">{comp.city}</p>
                          </div>
                          <div className="text-right">
                            <p className="text-sm font-semibold text-foreground">
                              {formatCurrency(comp.price)}
                            </p>
                            <YieldBadge yieldRate={comp.yieldRate} />
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            ) : (
              <div className="text-center py-8 text-muted-foreground">
                Failed to load property details
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </div>
  );
}
