"use client";

import { useState } from "react";
import {
  Target,
  Globe,
  DollarSign,
  TrendingUp,
  Shield,
  Home,
  Save,
  CheckCircle,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useInvestmentIntelligenceStore } from "@/lib/investment-intelligence-store";

export default function InvestorProfilePage() {
  const { investorProfile, setInvestorProfile } = useInvestmentIntelligenceStore();
  const [saved, setSaved] = useState(false);
  const [profile, setProfile] = useState({
    name: investorProfile?.name || "",
    email: investorProfile?.email || "",
    preferredCountries: investorProfile?.preferredCountries || ["UAE"],
    budgetMin: investorProfile?.budgetRange?.min || 500000,
    budgetMax: investorProfile?.budgetRange?.max || 5000000,
    investmentStrategy: investorProfile?.investmentStrategy || "balanced",
    riskProfile: investorProfile?.riskProfile || "moderate",
    preferredPropertyTypes: investorProfile?.preferredPropertyTypes || ["apartment"],
    rentalPreference: investorProfile?.rentalPreference || "long-term",
  });

  const handleSave = () => {
    setInvestorProfile({
      id: `inv-${Date.now()}`,
      ...profile,
      budgetRange: { min: profile.budgetMin, max: profile.budgetMax },
      calculatorUsageCount: 0,
      reportsGenerated: 0,
      propertiesSaved: [],
      leadScore: "MEDIUM",
      createdAt: new Date().toISOString(),
      lastActivity: new Date().toISOString(),
    });
    setSaved(true);
    setTimeout(() => setSaved(false), 2000);
  };

  return (
    <div className="max-w-3xl mx-auto space-y-6">
      <div>
        <h1 className="text-2xl font-bold flex items-center gap-2">
          <Target className="w-6 h-6" />
          Investor Profile
        </h1>
        <p className="text-muted-foreground">
          Set your investment preferences to receive personalized property recommendations.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Personal Information</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label>Name</Label>
              <Input
                value={profile.name}
                onChange={(e) => setProfile({ ...profile, name: e.target.value })}
                placeholder="Your name"
              />
            </div>
            <div>
              <Label>Email</Label>
              <Input
                type="email"
                value={profile.email}
                onChange={(e) => setProfile({ ...profile, email: e.target.value })}
                placeholder="your@email.com"
              />
            </div>
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Globe className="w-4 h-4" />
            Investment Preferences
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div>
            <Label>Preferred Markets</Label>
            <div className="flex flex-wrap gap-2 mt-2">
              {["UAE", "Turkey", "UK", "USA", "France", "Portugal", "Spain", "Thailand"].map((country) => (
                <button
                  key={country}
                  onClick={() => {
                    const countries = profile.preferredCountries.includes(country)
                      ? profile.preferredCountries.filter((c) => c !== country)
                      : [...profile.preferredCountries, country];
                    setProfile({ ...profile, preferredCountries: countries });
                  }}
                  className={`px-3 py-1.5 text-sm rounded-full border transition-colors ${
                    profile.preferredCountries.includes(country)
                      ? "bg-primary text-primary-foreground border-primary"
                      : "bg-card text-muted-foreground border-border hover:border-primary/50"
                  }`}
                >
                  {country}
                </button>
              ))}
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label>Min Budget</Label>
              <div className="relative">
                <DollarSign className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                <Input
                  type="number"
                  value={profile.budgetMin}
                  onChange={(e) => setProfile({ ...profile, budgetMin: parseInt(e.target.value) || 0 })}
                  className="pl-10"
                />
              </div>
            </div>
            <div>
              <Label>Max Budget</Label>
              <div className="relative">
                <DollarSign className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                <Input
                  type="number"
                  value={profile.budgetMax}
                  onChange={(e) => setProfile({ ...profile, budgetMax: parseInt(e.target.value) || 0 })}
                  className="pl-10"
                />
              </div>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label>Investment Strategy</Label>
              <Select
                value={profile.investmentStrategy}
                onValueChange={(val) => setProfile({ ...profile, investmentStrategy: val as any })}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="cashflow">Cash Flow focused</SelectItem>
                  <SelectItem value="appreciation">Capital Appreciation focused</SelectItem>
                  <SelectItem value="balanced">Balanced Approach</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label>Risk Profile</Label>
              <Select
                value={profile.riskProfile}
                onValueChange={(val) => setProfile({ ...profile, riskProfile: val as any })}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="conservative">Conservative</SelectItem>
                  <SelectItem value="moderate">Moderate</SelectItem>
                  <SelectItem value="aggressive">Aggressive</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>

          <div>
            <Label>Preferred Property Types</Label>
            <div className="flex flex-wrap gap-2 mt-2">
              {["apartment", "villa", "townhouse", "studio", "penthouse", "commercial"].map((type) => (
                <button
                  key={type}
                  onClick={() => {
                    const types = profile.preferredPropertyTypes.includes(type)
                      ? profile.preferredPropertyTypes.filter((t) => t !== type)
                      : [...profile.preferredPropertyTypes, type];
                    setProfile({ ...profile, preferredPropertyTypes: types });
                  }}
                  className={`px-3 py-1.5 text-sm rounded-full border transition-colors capitalize ${
                    profile.preferredPropertyTypes.includes(type)
                      ? "bg-primary text-primary-foreground border-primary"
                      : "bg-card text-muted-foreground border-border hover:border-primary/50"
                  }`}
                >
                  {type}
                </button>
              ))}
            </div>
          </div>

          <div>
            <Label>Rental Preference</Label>
            <Select
              value={profile.rentalPreference}
              onValueChange={(val) => setProfile({ ...profile, rentalPreference: val as any })}
            >
              <SelectTrigger>
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="short-term">Short-Term (Airbnb-style)</SelectItem>
                <SelectItem value="long-term">Long-Term (Annual lease)</SelectItem>
                <SelectItem value="mixed">Mixed Strategy</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </CardContent>
      </Card>

      <Button onClick={handleSave} size="lg" className="w-full">
        {saved ? (
          <>
            <CheckCircle className="w-4 h-4 mr-2" />
            Profile Saved!
          </>
        ) : (
          <>
            <Save className="w-4 h-4 mr-2" />
            Save Investment Profile
          </>
        )}
      </Button>

      {investorProfile && (
        <Card className="border-primary/30 bg-primary/5">
          <CardContent className="p-4 text-center">
            <p className="text-sm text-muted-foreground">
              Your profile is active. AI will recommend properties matching your preferences.
            </p>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
