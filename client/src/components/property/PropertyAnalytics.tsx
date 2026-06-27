import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { TrendingUp, TrendingDown, DollarSign, MapPin, Calculator, BarChart3, Activity, Target, AlertTriangle, CheckCircle } from "lucide-react";
interface PropertyAnalytics {
  price_prediction: {
    predicted_price: number;
    confidence_interval: [number, number];
    price_per_sqft: number;
    market_comparison: string;
  };
  location_analysis: {
    overall_score: number;
    livability_score: number;
    investment_potential: number;
    family_friendly: number;
    commute_score: number;
    neighborhood: string;
  };
  investment_analysis: {
    cash_on_cash_return: number;
    cap_rate: number;
    monthly_cash_flow: number;
    break_even_years: number;
    investment_grade: string;
    risk_score: number;
  };
  market_trends: {
    median_price: number;
    price_trend: string;
    days_on_market: number;
    inventory_level: string;
  };
}
interface PropertyAnalyticsProps {
  propertyId: string;
  propertyData: any;
}
export default function PropertyAnalytics({
  propertyId,
  propertyData
}: PropertyAnalyticsProps) {
  const {
    t
  } = useTranslation();
  const [analytics, setAnalytics] = useState<PropertyAnalytics | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  useEffect(() => {
    fetchAnalytics();
  }, [propertyId]);
  const fetchAnalytics = async () => {
    try {
      setLoading(true);

      // Fetch all analytics data
      const [priceRes, locationRes, investmentRes, marketRes] = await Promise.all([fetch(`/api/v1/real-estate/price-prediction`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          bedrooms: propertyData.bedrooms,
          bathrooms: propertyData.bathrooms,
          area_sqft: propertyData.area_sqft,
          latitude: propertyData.location?.latitude,
          longitude: propertyData.location?.longitude,
          year_built: propertyData.year_built,
          property_type: propertyData.property_type,
          school_rating: propertyData.school_rating || 7.5,
          walk_score: propertyData.walk_score || 75,
          crime_rate: propertyData.crime_rate || 25
        })
      }), fetch(`/api/v1/real-estate/location-analysis`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          lat: propertyData.location?.latitude,
          lng: propertyData.location?.longitude,
          property_type: propertyData.property_type
        })
      }), fetch(`/api/v1/real-estate/investment-analysis`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          purchase_price: propertyData.price,
          monthly_rent: propertyData.estimated_rent || propertyData.price * 0.008,
          down_payment_percent: 0.20,
          mortgage_rate: 0.068,
          mortgage_term: 30,
          vacancy_rate: 0.05,
          property_tax_rate: 0.012,
          insurance_rate: 0.003,
          maintenance_rate: 0.01
        })
      }), fetch(`/api/v1/real-estate/market-trends/${encodeURIComponent(propertyData.location?.city || 'new_york')}`)]);
      const [priceData, locationData, investmentData, marketData] = await Promise.all([priceRes.json(), locationRes.json(), investmentRes.json(), marketRes.json()]);
      setAnalytics({
        price_prediction: priceData,
        location_analysis: locationData.scores,
        investment_analysis: investmentData,
        market_trends: marketData
      });
    } catch (e) {
      console.error('Analytics fetch error:', e);
      setError('Failed to load analytics data');
    } finally {
      setLoading(false);
    }
  };
  const getGradeColor = (grade: string) => {
    if (grade.startsWith('A')) return 'bg-green-100 text-green-700';
    if (grade.startsWith('B')) return 'bg-blue-100 text-blue-700';
    if (grade.startsWith('C')) return 'bg-yellow-100 text-yellow-700';
    return 'bg-red-100 text-red-700';
  };
  const getScoreColor = (score: number) => {
    if (score >= 85) return 'text-green-600';
    if (score >= 70) return 'text-blue-600';
    if (score >= 55) return 'text-yellow-600';
    return 'text-red-600';
  };
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0
    }).format(amount);
  };
  if (loading) {
    return <div className="space-y-6">
        {[1, 2, 3, 4].map(i => <Card key={i} className="animate-pulse">
            <CardHeader>
              <div className="h-6 bg-gray-200 rounded w-1/3"></div>
            </CardHeader>
            <CardContent>
              <div className="h-32 bg-gray-200 rounded"></div>
            </CardContent>
          </Card>)}
      </div>;
  }
  if (error || !analytics) {
    return <Card>
        <CardContent className="p-6">
          <div className="flex items-center gap-2 text-red-600">
            <AlertTriangle className="w-5 h-5" />
            <span>{error || 'Analytics data unavailable'}</span>
          </div>
        </CardContent>
      </Card>;
  }
  return <div className="space-y-6">
      {/* Price Prediction */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <DollarSign className="w-5 h-5" />{t("client.src.price_prediction")}</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.predicted_price")}</div>
              <div className="text-2xl font-bold">
                {formatCurrency(analytics.price_prediction.predicted_price)}
              </div>
              <div className="text-xs text-muted-foreground">
                {formatCurrency(analytics.price_prediction.confidence_interval[0])} - 
                {formatCurrency(analytics.price_prediction.confidence_interval[1])}
              </div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.price_per_sqft")}</div>
              <div className="text-2xl font-bold">
                {formatCurrency(analytics.price_prediction.price_per_sqft)}
              </div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.market_position")}</div>
              <Badge className={analytics.price_prediction.market_comparison.includes('Above') ? 'bg-green-100 text-green-700' : 'bg-blue-100 text-blue-700'}>
                {analytics.price_prediction.market_comparison}
              </Badge>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Location Analysis */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <MapPin className="w-5 h-5" />{t("client.src.location_intelligence")}</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <div className="text-sm text-muted-foreground mb-2">{t("client.src.neighborhood")}</div>
              <div className="font-semibold">{analytics.location_analysis.neighborhood}</div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground mb-2">{t("client.src.overall_score")}</div>
              <div className={`text-2xl font-bold ${getScoreColor(analytics.location_analysis.overall_score)}`}>
                {analytics.location_analysis.overall_score}/100
              </div>
            </div>
          </div>
          
          <div className="space-y-3">
            <div>
              <div className="flex justify-between text-sm mb-1">
                <span>{t("client.src.livability")}</span>
                <span className={getScoreColor(analytics.location_analysis.livability_score)}>
                  {analytics.location_analysis.livability_score}/100
                </span>
              </div>
              <Progress value={analytics.location_analysis.livability_score} />
            </div>
            <div>
              <div className="flex justify-between text-sm mb-1">
                <span>{t("client.src.investment_potential")}</span>
                <span className={getScoreColor(analytics.location_analysis.investment_potential)}>
                  {analytics.location_analysis.investment_potential}/100
                </span>
              </div>
              <Progress value={analytics.location_analysis.investment_potential} />
            </div>
            <div>
              <div className="flex justify-between text-sm mb-1">
                <span>{t("client.src.family_friendly")}</span>
                <span className={getScoreColor(analytics.location_analysis.family_friendly)}>
                  {analytics.location_analysis.family_friendly}/100
                </span>
              </div>
              <Progress value={analytics.location_analysis.family_friendly} />
            </div>
            <div>
              <div className="flex justify-between text-sm mb-1">
                <span>{t("client.src.commute_score")}</span>
                <span className={getScoreColor(analytics.location_analysis.commute_score)}>
                  {analytics.location_analysis.commute_score}/100
                </span>
              </div>
              <Progress value={analytics.location_analysis.commute_score} />
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Investment Analysis */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Calculator className="w-5 h-5" />{t("client.src.investment_analysis")}</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.cash_on_cash_return")}</div>
              <div className={`text-xl font-bold ${getScoreColor(analytics.investment_analysis.cash_on_cash_return * 5)}`}>
                {analytics.investment_analysis.cash_on_cash_return.toFixed(1)}%
              </div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.cap_rate")}</div>
              <div className={`text-xl font-bold ${getScoreColor(analytics.investment_analysis.cap_rate * 10)}`}>
                {analytics.investment_analysis.cap_rate.toFixed(1)}%
              </div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.monthly_cash_flow")}</div>
              <div className={`text-xl font-bold ${analytics.investment_analysis.monthly_cash_flow >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                {formatCurrency(analytics.investment_analysis.monthly_cash_flow)}
              </div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.investment_grade")}</div>
              <Badge className={getGradeColor(analytics.investment_analysis.investment_grade)}>
                {analytics.investment_analysis.investment_grade}
              </Badge>
            </div>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 pt-4">
            <div>
              <div className="flex justify-between text-sm mb-1">
                <span>{t("client.src.breakeven_period")}</span>
                <span>{analytics.investment_analysis.break_even_years}{t("client.src.years")}</span>
              </div>
              <Progress value={Math.min(100, 10 / analytics.investment_analysis.break_even_years * 100)} />
            </div>
            <div>
              <div className="flex justify-between text-sm mb-1">
                <span>{t("client.src.risk_score")}</span>
                <span className={analytics.investment_analysis.risk_score < 50 ? 'text-green-600' : 'text-yellow-600'}>
                  {analytics.investment_analysis.risk_score}/100
                </span>
              </div>
              <Progress value={analytics.investment_analysis.risk_score} className="bg-red-100" />
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Market Trends */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />{t("client.src.market_trends")}</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.median_price")}</div>
              <div className="text-xl font-bold">
                {formatCurrency(analytics.market_trends.median_price)}
              </div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.price_trend")}</div>
              <div className="flex items-center gap-1">
                {analytics.market_trends.price_trend.startsWith('+') ? <TrendingUp className="w-4 h-4 text-green-600" /> : <TrendingDown className="w-4 h-4 text-red-600" />}
                <span className={`text-xl font-bold ${analytics.market_trends.price_trend.startsWith('+') ? 'text-green-600' : 'text-red-600'}`}>
                  {analytics.market_trends.price_trend}
                </span>
              </div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.days_on_market")}</div>
              <div className="text-xl font-bold">
                {analytics.market_trends.days_on_market}
              </div>
            </div>
            <div>
              <div className="text-sm text-muted-foreground">{t("client.src.inventory_level")}</div>
              <Badge className={analytics.market_trends.inventory_level === 'Low' ? 'bg-green-100 text-green-700' : analytics.market_trends.inventory_level === 'High' ? 'bg-red-100 text-red-700' : 'bg-blue-100 text-blue-700'}>
                {analytics.market_trends.inventory_level}
              </Badge>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Summary */}
      <Card className="bg-linear-to-r from-blue-50 to-purple-50">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Target className="w-5 h-5" />{t("client.src.investment_summary")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="text-center">
              <CheckCircle className="w-8 h-8 text-green-600 mx-auto mb-2" />
              <div className="font-semibold text-green-800">{t("client.src.strong_investment")}</div>
              <div className="text-sm text-green-600">
                {analytics.investment_analysis.cash_on_cash_return > 8 ? 'Excellent returns expected' : 'Decent investment opportunity'}
              </div>
            </div>
            <div className="text-center">
              <Activity className="w-8 h-8 text-blue-600 mx-auto mb-2" />
              <div className="font-semibold text-blue-800">{t("client.src.market_position")}</div>
              <div className="text-sm text-blue-600">
                {analytics.price_prediction.market_comparison.includes('Above') ? 'Above market average pricing' : 'Competitive market pricing'}
              </div>
            </div>
            <div className="text-center">
              <MapPin className="w-8 h-8 text-purple-600 mx-auto mb-2" />
              <div className="font-semibold text-purple-800">{t("client.src.location_quality")}</div>
              <div className="text-sm text-purple-600">
                {analytics.location_analysis.overall_score > 80 ? 'Premium location' : analytics.location_analysis.overall_score > 70 ? 'Good location' : 'Average location'}
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>;
}