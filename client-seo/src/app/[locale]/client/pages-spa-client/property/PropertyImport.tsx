"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { useToast } from "@/hooks/use-toast";
import { Download, Link, CheckCircle2, AlertTriangle, Loader2, Globe, Home, Plus, Zap } from "lucide-react";
import { apiClient } from "@/lib/api/client";
interface ImportResult {
  url: string;
  success: boolean;
  data?: any;
  platform?: string;
  confidence?: number;
  error?: string;
}
interface BulkImportSummary {
  total: number;
  successful: number;
  failed: number;
  successRate: number;
}
const SUPPORTED_PLATFORMS = [{
  name: "sahibinden.com",
  country: "TR",
  flag: "🇹🇷",
  requiresAuth: true
}, {
  name: "hurriyetemlak.com",
  country: "TR",
  flag: "🇹🇷",
  requiresAuth: false
}, {
  name: "zillow.com",
  country: "US",
  flag: "🇺🇸",
  requiresAuth: false
}, {
  name: "redfin.com",
  country: "US",
  flag: "🇺🇸",
  requiresAuth: false
}, {
  name: "rightmove.co.uk",
  country: "UK",
  flag: "🇬🇧",
  requiresAuth: false
}, {
  name: "immoweb.be",
  country: "BE",
  flag: "🇧🇪",
  requiresAuth: false
}];
export default function PropertyImport() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [url, setUrl] = useState("");
  const [bulkUrls, setBulkUrls] = useState("");
  const [loading, setLoading] = useState(false);
  const [results, setResults] = useState<ImportResult[]>([]);
  const [mode, setMode] = useState<"single" | "bulk">("single");
  const validateUrl = async (testUrl: string): Promise<{ valid: boolean; error?: string }> => {
    try {
      const response = await apiClient.post("/importer/validate-url", {
        url: testUrl
      });
      return response as any;
    } catch (e) {
      return {
        valid: false,
        error: "Validation failed"
      };
    }
  };
  const handleSingleImport = async () => {
    if (!url.trim()) {
      toast({
        title: t("common.error"),
        description: t("client.src.please_enter_a_property"),
        variant: "destructive"
      });
      return;
    }
    setLoading(true);
    try {
      // First validate URL
      const validation = await validateUrl(url);
      if (!validation.valid) {
        toast({
          title: t("client.src.unsupported_platform"),
          description: validation.error || "This platform is not supported",
          variant: "destructive"
        });
        return;
      }

      // Import the property
      const result = (await apiClient.post("/importer/scrape", {
        url,
        userId: "current-user" // In production, get from auth context
      })) as any;
      if (result.success) {
        setResults([{
          url,
          success: true,
          data: result.data,
          platform: result.platform,
          confidence: result.confidence
        }]);
        toast({
          title: t("client.src.import_successful"),
          description: `Property imported from ${result.platform} with ${result.confidence}% confidence`
        });
      } else {
        setResults([{
          url,
          success: false,
          error: result.error
        }]);
        toast({
          title: t("client.src.import_failed"),
          description: result.error,
          variant: "destructive"
        });
      }
    } catch (e) {
      toast({
        title: t("client.src.import_failed"),
        description: t("client.src.network_error_occurred"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const handleBulkImport = async () => {
    const urls = bulkUrls.split('\n').map(u => u.trim()).filter(u => u.length > 0);
    if (urls.length === 0) {
      toast({
        title: t("common.error"),
        description: t("client.src.please_enter_at_least"),
        variant: "destructive"
      });
      return;
    }
    if (urls.length > 10) {
      toast({
        title: t("common.error"),
        description: t("client.src.maximum_10_urls_allowed"),
        variant: "destructive"
      });
      return;
    }
    setLoading(true);
    try {
      const result = (await apiClient.post("/importer/bulk-import", {
        urls,
        userId: "current-user"
      })) as any;
      if (result.success) {
        setResults(result.results);
        toast({
          title: t("client.src.bulk_import_completed"),
          description: `${result.summary.successful}/${result.summary.total} properties imported successfully`
        });
      } else {
        toast({
          title: t("client.src.bulk_import_failed"),
          description: result.error,
          variant: "destructive"
        });
      }
    } catch (e) {
      toast({
        title: t("client.src.bulk_import_failed"),
        description: t("client.src.network_error_occurred"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const getConfidenceColor = (confidence: number) => {
    if (confidence >= 80) return "bg-blue-100 text-blue-700";
    if (confidence >= 60) return "bg-yellow-100 text-yellow-700";
    return "bg-red-100 text-red-700";
  };
  return <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">{t("client.src.property_import")}</h1>
          <p className="text-muted-foreground">{t("client.src.import_properties_from_external")}</p>
        </div>
        <div className="flex gap-2">
          <Button variant={mode === "single" ? "default" : "outline"} onClick={() => setMode("single")} size="sm">
            <Link className="w-4 h-4 mr-2" />{t("client.src.single_import")}</Button>
          <Button variant={mode === "bulk" ? "default" : "outline"} onClick={() => setMode("bulk")} size="sm">
            <Plus className="w-4 h-4 mr-2" />{t("client.src.bulk_import")}</Button>
        </div>
      </div>

      {/* Supported Platforms */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Globe className="w-5 h-5" />{t("client.src.supported_platforms")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {SUPPORTED_PLATFORMS.map(platform => <div key={platform.name} className="text-center p-3 border rounded-lg">
                <div className="text-2xl mb-1">{platform.flag}</div>
                <div className="text-sm font-medium">{platform.name}</div>
                {platform.requiresAuth && <Badge variant="outline" className="mt-1 text-xs">{t("client.src.login_required")}</Badge>}
              </div>)}
          </div>
        </CardContent>
      </Card>

      {/* Import Form */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Download className="w-5 h-5" />
            {mode === "single" ? "Single Property Import" : "Bulk Property Import"}
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {mode === "single" ? <div className="space-y-4">
              <div>
                <label className="text-sm font-medium">{t("client.src.property_url")}</label>
                <Input placeholder={t("client.src.httpssahibindencomilan")} value={url} onChange={e => setUrl(e.target.value)} className="mt-1" />
              </div>
              <Button onClick={handleSingleImport} disabled={loading || !url.trim()} className="w-full">
                {loading ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />{t("client.src.importing")}</> : <><Zap className="w-4 h-4 mr-2" />{t("client.src.import_property")}</>}
              </Button>
            </div> : <div className="space-y-4">
              <div>
                <label className="text-sm font-medium">{t("client.src.property_urls_one_per")}</label>
                <textarea aria-label="Property URLs" placeholder={t("client.src.httpssahibindencomilan1_httpshurriyetemlakcomilan2_httpszillowcomhomedetails3")} value={bulkUrls} onChange={e => setBulkUrls(e.target.value)} className="w-full mt-1 p-3 border rounded-md h-32 font-mono text-sm" />
              </div>
              <Button onClick={handleBulkImport} disabled={loading || !bulkUrls.trim()} className="w-full">
                {loading ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />{t("client.src.bulk_importing")}</> : <><Zap className="w-4 h-4 mr-2" />{t("client.src.import_all_properties")}</>}
              </Button>
            </div>}
        </CardContent>
      </Card>

      {/* Results */}
      {results.length > 0 && <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Home className="w-5 h-5" />{t("client.src.import_results")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {results.map((result, index) => <div key={index} className="flex items-center justify-between p-4 border rounded-lg">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      {result.success ? <CheckCircle2 className="w-5 h-5 text-blue-500" /> : <AlertTriangle className="w-5 h-5 text-red-500" />}
                      <span className="font-medium">{result.platform || "Unknown"}</span>
                      {result.confidence && <Badge className={getConfidenceColor(result.confidence)}>
                          {result.confidence}{t("client.src.confidence")}</Badge>}
                    </div>
                    <div className="text-sm text-muted-foreground truncate">{result.url}</div>
                  </div>
                  <div className="text-right">
                    {result.success ? <Button variant="outline" size="sm">{t("client.src.view_property")}</Button> : <div className="text-sm text-red-500">{result.error}</div>}
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>}

      {/* Tips */}
      <Alert>
        <AlertTriangle className="h-4 w-4" />
        <AlertDescription>
          <strong>{t("client.src.tips")}</strong>{t("client.src.make_sure_you_have")}</AlertDescription>
      </Alert>
    </div>;
}