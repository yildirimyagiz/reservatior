import { t } from "i18next";
import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Progress } from "@/components/ui/progress";
import { Users, CreditCard, Crown, Star, Calendar, TrendingUp, Gift, Settings, CheckCircle, AlertTriangle, Clock, DollarSign, Award, Shield, Zap, Plus, Edit, Trash2, Download, Eye, Mail, Phone } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";
import { edenClient } from "@/lib/eden-client";
import { useNavigate } from "react-router-dom";
interface MembershipTier {
  id: string;
  name: string;
  price: number;
  currency: string;
  billingCycle: 'MONTHLY' | 'YEARLY';
  features: string[];
  isActive: boolean;
  maxProperties: number;
  maxUsers: number;
  supportLevel: 'BASIC' | 'STANDARD' | 'PREMIUM' | 'ENTERPRISE';
  color: string;
  icon: string;
}
interface Member {
  id: string;
  name: string;
  email: string;
  phone: string;
  membershipTier: string;
  membershipTierName: string;
  startDate: string;
  endDate: string;
  status: 'ACTIVE' | 'EXPIRED' | 'CANCELLED' | 'SUSPENDED';
  autoRenew: boolean;
  propertiesCount: number;
  totalSpent: number;
  lastPaymentDate: string;
  nextBillingDate: string;
  avatar: string;
}
interface MembershipFeature {
  id: string;
  name: string;
  description: string;
  tier: string;
  isActive: boolean;
  usageLimit?: number;
  currentUsage?: number;
}
export default function MembershipManagement() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState<'members' | 'tiers' | 'features' | 'analytics'>('members');
  const [members, setMembers] = useState<Member[]>([]);
  const [tiers, setTiers] = useState<MembershipTier[]>([]);
  const [features, setFeatures] = useState<MembershipFeature[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [tierFilter, setTierFilter] = useState("ALL");
  const {
    toast
  } = useToast();
  const navigate = useNavigate();

  // Mock data
  const [mockTiers] = useState<MembershipTier[]>([{
    id: "tier_basic",
    name: "Basic",
    price: 29.99,
    currency: "USD",
    billingCycle: "MONTHLY",
    features: ["Up to 10 properties", "Basic analytics", "Email support", "Mobile app access"],
    isActive: true,
    maxProperties: 10,
    maxUsers: 3,
    supportLevel: "BASIC",
    color: "bg-gray-500/10 text-gray-400 border-gray-500/20",
    icon: "Users"
  }, {
    id: "tier_standard",
    name: "Standard",
    price: 79.99,
    currency: "USD",
    billingCycle: "MONTHLY",
    features: ["Up to 50 properties", "Advanced analytics", "Priority support", "API access", "Custom branding"],
    isActive: true,
    maxProperties: 50,
    maxUsers: 10,
    supportLevel: "STANDARD",
    color: "bg-blue-500/10 text-blue-400 border-blue-500/20",
    icon: "Star"
  }, {
    id: "tier_premium",
    name: "Premium",
    price: 199.99,
    currency: "USD",
    billingCycle: "MONTHLY",
    features: ["Unlimited properties", "AI-powered analytics", "Dedicated support", "White-label options", "Advanced integrations"],
    isActive: true,
    maxProperties: -1,
    maxUsers: -1,
    supportLevel: "PREMIUM",
    color: "bg-purple-500/10 text-purple-400 border-purple-500/20",
    icon: "Crown"
  }, {
    id: "tier_enterprise",
    name: "Enterprise",
    price: 499.99,
    currency: "USD",
    billingCycle: "MONTHLY",
    features: ["Everything in Premium", "Custom development", "On-premise deployment", "SLA guarantee", "Dedicated account manager"],
    isActive: true,
    maxProperties: -1,
    maxUsers: -1,
    supportLevel: "ENTERPRISE",
    color: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
    icon: "Shield"
  }]);
  const [mockMembers] = useState<Member[]>([{
    id: "member_001",
    name: "John Doe Properties",
    email: "john@doeproperties.com",
    phone: "+1 (555) 123-4567",
    membershipTier: "tier_standard",
    membershipTierName: "Standard",
    startDate: "2026-01-15T00:00:00Z",
    endDate: "2026-04-15T23:59:59Z",
    status: "ACTIVE",
    autoRenew: true,
    propertiesCount: 25,
    totalSpent: 2399.97,
    lastPaymentDate: "2026-03-15T10:30:00Z",
    nextBillingDate: "2026-04-15T00:00:00Z",
    avatar: "https://api.dicebear.com/7.x/avatars/john"
  }, {
    id: "member_002",
    name: "Jane Smith Realty",
    email: "jane@smithrealty.com",
    phone: "+1 (555) 987-6543",
    membershipTier: "tier_premium",
    membershipTierName: "Premium",
    startDate: "2026-02-01T00:00:00Z",
    endDate: "2027-02-01T23:59:59Z",
    status: "ACTIVE",
    autoRenew: true,
    propertiesCount: 150,
    totalSpent: 3999.98,
    lastPaymentDate: "2026-03-01T14:20:00Z",
    nextBillingDate: "2026-04-01T00:00:00Z",
    avatar: "https://api.dicebear.com/7.x/avatars/jane"
  }, {
    id: "member_003",
    name: "Mike Johnson Commercial",
    email: "mike@johnsoncommercial.com",
    phone: "+1 (555) 246-8090",
    membershipTier: "tier_enterprise",
    membershipTierName: "Enterprise",
    startDate: "2025-06-01T00:00:00Z",
    endDate: "2026-06-01T23:59:59Z",
    status: "EXPIRED",
    autoRenew: false,
    propertiesCount: 500,
    totalSpent: 5999.94,
    lastPaymentDate: "2026-05-01T09:15:00Z",
    nextBillingDate: "",
    avatar: "https://api.dicebear.com/7.x/avatars/mike"
  }]);
  const [mockFeatures] = useState<MembershipFeature[]>([{
    id: "feature_properties",
    name: "Property Listings",
    description: t("admin.membership.number_of_properties_you"),
    tier: "ALL",
    isActive: true,
    usageLimit: 10,
    currentUsage: 175
  }, {
    id: "feature_analytics",
    name: "Advanced Analytics",
    description: t("admin.membership.detailed_analytics_and_reporting"),
    tier: "STANDARD",
    isActive: true,
    usageLimit: undefined,
    currentUsage: undefined
  }, {
    id: "feature_ai",
    name: "AI-Powered Tools",
    description: t("admin.membership.ai_valuation_and_insights"),
    tier: "PREMIUM",
    isActive: true,
    usageLimit: undefined,
    currentUsage: undefined
  }, {
    id: "feature_api",
    name: "API Access",
    description: t("admin.membership.full_api_access_for"),
    tier: "STANDARD",
    isActive: true,
    usageLimit: 1000,
    currentUsage: 750
  }, {
    id: "feature_white_label",
    name: "White-Label Options",
    description: t("admin.membership.custom_branding_and_domain"),
    tier: "ENTERPRISE",
    isActive: true,
    usageLimit: undefined,
    currentUsage: undefined
  }]);
  useEffect(() => {
    // Simulate API calls
    setTimeout(() => {
      setMembers(mockMembers);
      setTiers(mockTiers);
      setFeatures(mockFeatures);
      setLoading(false);
    }, 1000);
  }, []);
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'ACTIVE':
        return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
      case 'EXPIRED':
        return 'bg-red-500/10 text-red-400 border-red-500/20';
      case 'CANCELLED':
        return 'bg-slate-500/10 text-muted-foreground border-slate-500/20';
      case 'SUSPENDED':
        return 'bg-orange-500/10 text-orange-400 border-orange-500/20';
      default:
        return 'bg-slate-500/10 text-muted-foreground border-slate-500/20';
    }
  };
  const getTierIcon = (iconName: string) => {
    switch (iconName) {
      case 'Users':
        return <Users className="w-5 h-5" />;
      case 'Star':
        return <Star className="w-5 h-5" />;
      case 'Crown':
        return <Crown className="w-5 h-5" />;
      case 'Shield':
        return <Shield className="w-5 h-5" />;
      default:
        return <Award className="w-5 h-5" />;
    }
  };
  const filteredMembers = members.filter(member => {
    const matchesSearch = member.name.toLowerCase().includes(searchTerm.toLowerCase()) || member.email.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesTier = tierFilter === "ALL" || member.membershipTier === tierFilter;
    return matchesSearch && matchesTier;
  });
  const totalRevenue = members.reduce((sum, member) => sum + (member.totalSpent || 0), 0);
  const activeMembers = members.filter(member => member.status === 'ACTIVE').length;
  const expiredMembers = members.filter(member => member.status === 'EXPIRED').length;
  const handleUpgradeMembership = async (memberId: string, newTierId: string) => {
    try {
      // Mock API call
      await new Promise(resolve => setTimeout(resolve, 2000));
      setMembers(prev => prev.map(member => member.id === memberId ? {
        ...member,
        membershipTier: newTierId,
        status: 'ACTIVE' as const
      } : member));
      toast({
        title: t("admin.membership.membership_upgraded"),
        description: t("admin.membership.member_has_been_upgraded")
      });
    } catch (error) {
      toast({
        title: t("admin.membership.upgrade_failed"),
        description: t("admin.membership.failed_to_upgrade_membership"),
        variant: "destructive"
      });
    }
  };
  const handleRenewMembership = async (memberId: string) => {
    try {
      // Mock API call
      await new Promise(resolve => setTimeout(resolve, 1500));
      setMembers(prev => prev.map(member => member.id === memberId ? {
        ...member,
        status: 'ACTIVE',
        endDate: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000).toISOString()
      } : member));
      toast({
        title: t("admin.membership.membership_renewed"),
        description: t("admin.membership.membership_has_been_renewed")
      });
    } catch (error) {
      toast({
        title: t("admin.membership.renewal_failed"),
        description: t("admin.membership.failed_to_renew_membership"),
        variant: "destructive"
      });
    }
  };
  const handleCancelMembership = async (memberId: string) => {
    try {
      // Mock API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      setMembers(prev => prev.map(member => member.id === memberId ? {
        ...member,
        status: 'CANCELLED',
        autoRenew: false
      } : member));
      toast({
        title: t("admin.membership.membership_cancelled"),
        description: t("admin.membership.membership_has_been_cancelled")
      });
    } catch (error) {
      toast({
        title: t("admin.membership.cancellation_failed"),
        description: t("admin.membership.failed_to_cancel_membership"),
        variant: "destructive"
      });
    }
  };
  if (loading) {
    return <PageShell title={t('membershipTitle')} description={t('membershipDescription')}>
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
        </div>
      </PageShell>;
  }
  return <PageShell title={t('membershipTitle')} description={t('membershipDescription')}>
      <div className="max-w-7xl mx-auto px-4 lg:px-8 py-10 space-y-8">
        
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-3xl font-bold text-foreground">{t('membershipTitle')}</h1>
            <p className="text-sm text-muted-foreground mt-1">
              {t('membershipDescription')}
            </p>
          </div>
          
          <div className="flex items-center gap-4">
            <Button className="bg-blue-600 hover:bg-blue-500 text-foreground font-bold text-xs">
              <Plus className="w-4 h-4 mr-2" />
              {t('addMember')}
            </Button>
          </div>
        </div>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-emerald-500/20 flex items-center justify-center">
                <Users className="w-5 h-5 text-emerald-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t('activeMembers')}</p>
                <p className="text-2xl font-bold text-foreground">{activeMembers}</p>
              </div>
            </div>
          </Card>

          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-blue-500/20 flex items-center justify-center">
                <DollarSign className="w-5 h-5 text-blue-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t('monthlyRevenue')}</p>
                <p className="text-2xl font-bold text-foreground">${totalRevenue.toLocaleString()}</p>
              </div>
            </div>
          </Card>

          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-purple-500/20 flex items-center justify-center">
                <TrendingUp className="w-5 h-5 text-purple-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t('expiredMembers')}</p>
                <p className="text-2xl font-bold text-foreground">{expiredMembers}</p>
              </div>
            </div>
          </Card>

          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-orange-500/20 flex items-center justify-center">
                <Gift className="w-5 h-5 text-orange-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t('avgMemberValue')}</p>
                <p className="text-2xl font-bold text-foreground">${activeMembers > 0 ? (totalRevenue / activeMembers).toFixed(0) : '0'}</p>
              </div>
            </div>
          </Card>
        </div>

        {/* Navigation Tabs */}
        <div className="flex space-x-1 border-b border-border">
          {[{
          id: 'members',
          label: t('members'),
          icon: <Users className="w-4 h-4" />
        }, {
          id: 'tiers',
          label: t('tiers'),
          icon: <Crown className="w-4 h-4" />
        }, {
          id: 'features',
          label: t('membership'),
          icon: <Star className="w-4 h-4" />
        }, {
          id: 'analytics',
          label: t('membershipAnalytics'),
          icon: <TrendingUp className="w-4 h-4" />
        }].map(tab => <button key={tab.id} onClick={() => setActiveTab(tab.id as any)} className={cn("px-4 py-3 text-sm font-medium transition-colors border-b-2", activeTab === tab.id ? "text-foreground border-blue-500" : "text-muted-foreground border-transparent hover:text-foreground")}>
              <div className="flex items-center gap-2">
                {tab.icon}
                {tab.label}
              </div>
            </button>)}
        </div>

        {/* Tab Content */}
        <div className="mt-8">
          
          {/* Members Tab */}
          {activeTab === 'members' && <div className="space-y-6">
              {/* Filters */}
              <Card className="bg-card border-border rounded-3xl p-6">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-foreground">{t("admin.membership.filters")}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="search" className="text-[10px] font-bold text-muted-foreground">{t("admin.membership.search")}</Label>
                      <Input id="search" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} placeholder={t("admin.membership.search_by_name_or")} className="bg-muted/50 border-border text-foreground" />
                    </div>
                    
                    <div className="space-y-2">
                      <Label htmlFor="tier" className="text-[10px] font-bold text-muted-foreground">{t("admin.membership.membership_tier")}</Label>
                      <Select value={tierFilter} onValueChange={value => setTierFilter(value)}>
                        <SelectTrigger className="bg-muted/50 border-border text-foreground">
                          <SelectValue placeholder={t("admin.membership.all_tiers")} />
                        </SelectTrigger>
                        <SelectContent className="bg-[#14151a] border-border">
                          <SelectItem value="ALL">{t("admin.membership.all_tiers")}</SelectItem>
                          <SelectItem value="tier_basic">{t("admin.membership.basic")}</SelectItem>
                          <SelectItem value="tier_standard">{t("admin.membership.standard")}</SelectItem>
                          <SelectItem value="tier_premium">{t("admin.membership.premium")}</SelectItem>
                          <SelectItem value="tier_enterprise">{t("admin.membership.enterprise")}</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </div>
                </CardContent>
              </Card>

              {/* Members List */}
              <Card className="bg-card border-border rounded-3xl p-8">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                    <Users className="w-5 h-5 text-emerald-500" />{t("admin.membership.members")}{filteredMembers.length})
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {filteredMembers.map(member => <motion.div key={member.id} initial={{
                  opacity: 0,
                  y: 10
                }} animate={{
                  opacity: 1,
                  y: 0
                }} className="bg-muted/50 rounded-2xl p-4 border border-border">
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-3">
                            <img src={member.avatar} alt={member.name} className="w-12 h-12 rounded-full" />
                            <div>
                              <h4 className="text-sm font-bold text-foreground">{member.name}</h4>
                              <p className="text-xs text-muted-foreground">{member.email}</p>
                              <p className="text-xs text-muted-foreground">{member.phone}</p>
                              <p className="text-xs text-muted-foreground">
                                {member.propertiesCount}{t("admin.membership.properties")}</p>
                            </div>
                          </div>
                          
                          <div className="text-right">
                            <Badge className={cn("text-[9px] font-bold   px-2", getStatusColor(member.status))}>
                              {member.status}
                            </Badge>
                          </div>
                        </div>
                        
                        <div className="grid grid-cols-2 gap-4 mt-3 text-xs">
                          <div>
                            <p className="text-muted-foreground">{t("admin.membership.tier")}{member.membershipTierName}</p>
                            <p className="text-muted-foreground">{t("admin.membership.start")}{new Date(member.startDate).toLocaleDateString()}</p>
                            <p className="text-muted-foreground">{t("admin.membership.end")}{new Date(member.endDate).toLocaleDateString()}</p>
                          </div>
                          
                          <div className="text-right">
                            <p className="text-muted-foreground">{t("admin.membership.total_spent")}{(member.totalSpent || 0).toFixed(2)}</p>
                            <p className="text-muted-foreground">{t("admin.membership.next_billing")}{member.nextBillingDate ? new Date(member.nextBillingDate).toLocaleDateString() : 'N/A'}</p>
                          </div>
                        </div>
                        
                        <div className="flex items-center gap-2 mt-3">
                          {member.status === 'EXPIRED' && <Button size="sm" onClick={() => handleRenewMembership(member.id)}>
                              <CreditCard className="w-3 h-3 mr-1" />{t("admin.membership.renew")}</Button>}
                          
                          {member.status === 'ACTIVE' && <Button size="sm" variant="outline" onClick={() => handleUpgradeMembership(member.id, 'tier_premium')}>
                              <Zap className="w-3 h-3 mr-1" />{t("admin.membership.upgrade")}</Button>}
                          
                          <Button size="sm" variant="outline">
                            <Eye className="w-3 h-3 mr-1" />{t("admin.membership.view_details")}</Button>
                          
                          <Button size="sm" variant="outline">
                            <Mail className="w-3 h-3 mr-1" />{t("admin.membership.contact")}</Button>
                          
                          <Button size="sm" variant="outline" onClick={() => handleCancelMembership(member.id)}>
                            <Trash2 className="w-3 h-3 mr-1" />{t("admin.membership.cancel")}</Button>
                        </div>
                      </motion.div>)}
                  </div>                  </CardContent>
                </Card>
              </div>}

          {/* Tiers Tab */}
          {activeTab === 'tiers' && <div className="space-y-6">
              <Card className="bg-card border-border rounded-3xl p-8">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                    <Crown className="w-5 h-5 text-purple-500" />{t("admin.membership.membership_tiers")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {tiers.map(tier => <motion.div key={tier.id} whileHover={{
                  scale: 1.02
                }} className={cn("bg-muted/50 rounded-2xl p-6 border border-border", tier.color)}>
                        <div className="flex items-center justify-between mb-4">
                          <div className="flex items-center gap-3">
                            {getTierIcon(tier.icon)}
                            <div>
                              <h3 className="text-lg font-bold text-foreground">{tier.name}</h3>
                              <p className="text-xs text-muted-foreground capitalize">{tier.billingCycle.toLowerCase()}</p>
                            </div>
                          </div>
                          
                          <div className="text-right">
                            <Badge className={cn("text-[9px] font-bold   px-2", tier.isActive ? "bg-emerald-500/20 text-emerald-400 border-emerald-500/20" : "bg-slate-500/20 text-muted-foreground border-slate-500/20")}>
                              {tier.isActive ? "ACTIVE" : "INACTIVE"}
                            </Badge>
                          </div>
                        </div>
                        
                        <div className="text-2xl font-bold text-foreground mb-4">
                          ${tier.price.toFixed(2)}/{tier.billingCycle === 'MONTHLY' ? 'mo' : 'yr'}
                        </div>
                        
                        <div className="space-y-2">
                          <ul className="text-sm text-muted-foreground">
                            {tier.features.map((feature, index) => <li key={index} className="flex items-center gap-2">
                                <CheckCircle className="w-3 h-3 text-emerald-400" />
                                <span>{feature}</span>
                              </li>)}
                          </ul>
                        </div>
                        
                        <div className="grid grid-cols-2 gap-4 text-xs text-muted-foreground">
                          <div>
                            <p>{t("admin.membership.max_properties")}{tier.maxProperties === -1 ? 'Unlimited' : tier.maxProperties}</p>
                            <p>{t("admin.membership.max_users")}{tier.maxUsers === -1 ? 'Unlimited' : tier.maxUsers}</p>
                          </div>
                          <div className="text-right">
                            <p>{t("admin.membership.support")}{tier.supportLevel}</p>
                            <p>{t("admin.membership.color")}{tier.color}</p>
                          </div>
                        </div>
                      </motion.div>)}
                  </div>
                </CardContent>
              </Card>
            </div>}

          {/* Features Tab */}
          {activeTab === 'features' && <div className="space-y-6">
              <Card className="bg-card border-border rounded-3xl p-8">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                    <Star className="w-5 h-5 text-yellow-500" />{t("admin.membership.membership_features")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {features.map(feature => <motion.div key={feature.id} initial={{
                  opacity: 0,
                  y: 10
                }} animate={{
                  opacity: 1,
                  y: 0
                }} className="bg-muted/50 rounded-2xl p-4 border border-border">
                        <div className="flex items-center justify-between">
                          <div className="flex-1">
                            <h4 className="text-sm font-bold text-foreground">{feature.name}</h4>
                            <p className="text-xs text-muted-foreground">{feature.description}</p>
                            <p className="text-xs text-muted-foreground">{t("admin.membership.available_for")}{feature.tier}</p>
                          </div>
                          
                          <div className="text-right">
                            <Badge className={cn("text-[9px] font-bold   px-2", feature.isActive ? "bg-emerald-500/20 text-emerald-400 border-emerald-500/20" : "bg-slate-500/20 text-muted-foreground border-slate-500/20")}>
                              {feature.isActive ? "ACTIVE" : "INACTIVE"}
                            </Badge>
                          </div>
                        </div>
                        
                        {feature.usageLimit && <div className="mt-3">
                            <div className="flex items-center justify-between text-sm">
                              <span className="text-muted-foreground">{t("admin.membership.usage")}</span>
                              <span className="text-foreground">
                                {feature.currentUsage || 0} / {feature.usageLimit}
                              </span>
                            </div>
                            <Progress value={feature.currentUsage ? feature.currentUsage / feature.usageLimit * 100 : 0} className="h-2" />
                          </div>}
                      </motion.div>)}
                  </div>                  </CardContent>
                </Card>
            </div>}

          {/* Analytics Tab */}
          {activeTab === 'analytics' && <div className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <Card className="bg-card border-border rounded-3xl p-6">
                  <CardHeader>
                    <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                      <TrendingUp className="w-5 h-5 text-emerald-500" />{t("admin.membership.revenue_analytics")}</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="text-center">
                      <div className="text-xl font-bold text-foreground">${totalRevenue.toLocaleString()}</div>
                      <p className="text-sm text-muted-foreground">{t("admin.membership.total_revenue")}</p>
                    </div>
                    
                    <div className="grid grid-cols-2 gap-4 text-sm">
                      <div>
                        <p className="text-muted-foreground">{t("admin.membership.monthly_revenue")}</p>
                        <p className="text-lg font-bold text-foreground">${(totalRevenue / 12).toFixed(2)}</p>
                      </div>
                      <div>
                        <p className="text-muted-foreground">{t("admin.membership.average_revenuemember")}</p>
                        <p className="text-lg font-bold text-foreground">${activeMembers > 0 ? (totalRevenue / activeMembers).toFixed(2) : '0'}</p>
                      </div>
                    </div>
                    
                    <div className="mt-4">
                      <p className="text-sm text-muted-foreground">{t("admin.membership.growth_rate")}</p>
                      <div className="text-2xl font-bold text-emerald-400">+15.3%</div>
                    </div>
                  </CardContent>
                </Card>

                <Card className="bg-card border-border rounded-3xl p-6">
                  <CardHeader>
                    <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                      <Users className="w-5 h-5 text-blue-500" />{t("admin.membership.member_analytics")}</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="grid grid-cols-2 gap-4 text-sm">
                      <div>
                        <p className="text-muted-foreground">{t("admin.membership.active_members")}</p>
                        <p className="text-lg font-bold text-foreground">{activeMembers}</p>
                      </div>
                      <div>
                        <p className="text-muted-foreground">{t("admin.membership.expired_members")}</p>
                        <p className="text-lg font-bold text-foreground">{expiredMembers}</p>
                      </div>
                      <div>
                        <p className="text-muted-foreground">{t("admin.membership.churn_rate")}</p>
                        <p className="text-lg font-bold text-orange-400">{activeMembers > 0 ? (expiredMembers / activeMembers * 100).toFixed(1) : '0'}%</p>
                      </div>
                      <div>
                        <p className="text-muted-foreground">{t("admin.membership.retention_rate")}</p>
                        <p className="text-lg font-bold text-emerald-400">{activeMembers > 0 ? ((activeMembers - expiredMembers) / activeMembers * 100).toFixed(1) : '0'}%</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </div>
            </div>}
        </div>
      </div>
    </PageShell>;
}