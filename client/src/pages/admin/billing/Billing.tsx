import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { CreditCard, Download, CheckCircle } from "lucide-react";
export default function Billing() {
  const {
    t
  } = useTranslation();
  const [billingCycle, setBillingCycle] = useState("monthly");
  const plans = [{
    name: "Starter",
    price: billingCycle === "monthly" ? "$29" : "$290",
    description: t("admin.billing.ideal_for_individual_users"),
    features: [t("admin.billing.5_users", "5 kullanıcı"), t("admin.billing.10_gb_storage", "10 GB depolama"), t("admin.billing.basic_support", "Temel destek"), t("admin.billing.api_access", "API erişimi")],
    current: false
  }, {
    name: "Professional",
    price: billingCycle === "monthly" ? "$99" : "$990",
    description: t("admin.billing.perfect_for_small_teams"),
    features: [t("admin.billing.25_users_plan", "25 kullanıcı"), t("admin.billing.100_gb_storage_plan", "100 GB depolama"), t("admin.billing.priority_support", "Öncelikli destek"), t("admin.billing.advanced_api", "Gelişmiş API"), t("admin.billing.analytical_reports", "Analitik raporlar")],
    current: true
  }, {
    name: "Enterprise",
    price: "Custom",
    description: t("admin.billing.custom_solution_for_large"),
    features: [t("admin.billing.unlimited_users", "Sınırsız kullanıcı"), t("admin.billing.unlimited_storage", "Sınırsız depolama"), t("admin.billing.24_7_support", "7/24 destek"), t("admin.billing.custom_api", "Özel API"), t("admin.billing.advanced_security", "Gelişmiş güvenlik"), t("admin.billing.sla_guarantee", "SLA garantisi")],
    current: false
  }];
  const invoices = [{
    id: "INV-2024-001",
    date: "2024-03-01",
    amount: "$99.00",
    status: "paid",
    plan: "Professional"
  }, {
    id: "INV-2024-002",
    date: "2024-02-01",
    amount: "$99.00",
    status: "paid",
    plan: "Professional"
  }, {
    id: "INV-2024-003",
    date: "2024-01-01",
    amount: "$99.00",
    status: "paid",
    plan: "Professional"
  }];
  const paymentMethods = [{
    id: 1,
    type: "card",
    last4: "4242",
    brand: "Visa",
    expiry: "12/25",
    isDefault: true
  }, {
    id: 2,
    type: "card",
    last4: "8888",
    brand: "Mastercard",
    expiry: "09/24",
    isDefault: false
  }];
  return <div className="min-h-screen bg-background">
      <div className="container mx-auto p-6">
        <div className="mb-6">
          <h1 className="text-3xl font-bold">{t("admin.billing.billing")}</h1>
          <p className="text-muted-foreground">{t("admin.billing.subscription_and_payment_management")}</p>
        </div>

        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="grid w-full grid-cols-4">
            <TabsTrigger value="overview">{t("admin.billing.overview")}</TabsTrigger>
            <TabsTrigger value="plans">{t("admin.billing.plans")}</TabsTrigger>
            <TabsTrigger value="billing">{t("admin.billing.invoices")}</TabsTrigger>
            <TabsTrigger value="payment">{t("admin.billing.payment_methods")}</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-6">
            <div className="grid gap-6 md:grid-cols-2">
              <Card>
                <CardHeader>
                  <CardTitle>{t("admin.billing.current_plan")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div>
                      <h3 className="text-2xl font-bold">{t("admin.billing.professional")}</h3>
                      <p className="text-3xl font-bold">$99<span className="text-lg font-normal">/mo</span></p>
                    </div>
                    <Badge variant="default">{t("admin.billing.active")}</Badge>
                    <div className="space-y-2">
                      <div className="flex justify-between">
                        <span>{t("admin.billing.25_users")}</span>
                        <span>{t("admin.billing.15_in_use")}</span>
                      </div>
                      <div className="flex justify-between">
                        <span>{t("admin.billing.100_gb_storage")}</span>
                        <span>{t("admin.billing.45_gb_in_use")}</span>
                      </div>
                    </div>
                    <Button className="w-full">{t("admin.billing.upgrade_plan")}</Button>
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>{t("admin.billing.billing_info")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div>
                      <p className="text-sm text-muted-foreground">{t("admin.billing.next_billing_date")}</p>
                      <p className="text-lg font-medium">{t("admin.billing.april_1_2024")}</p>
                    </div>
                    <div>
                      <p className="text-sm text-muted-foreground">{t("admin.billing.estimated_amount")}</p>
                      <p className="text-lg font-medium">$99.00</p>
                    </div>
                    <div className="space-y-2">
                      <div className="flex justify-between text-sm">
                        <span>{t("admin.billing.plan_fee")}</span>
                        <span>$99.00</span>
                      </div>
                      <div className="flex justify-between text-sm">
                        <span>{t("admin.billing.vat_18")}</span>
                        <span>$17.82</span>
                      </div>
                      <div className="flex justify-between font-medium pt-2 border-t">
                        <span>{t("admin.billing.total")}</span>
                        <span>$116.82</span>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="plans" className="space-y-6">
            <div className="flex justify-center mb-6">
              <div className="flex items-center gap-2 bg-muted p-1 rounded-lg">
                <Button variant={billingCycle === "monthly" ? "default" : "ghost"} size="sm" onClick={() => setBillingCycle("monthly")}>{t("admin.billing.monthly")}</Button>
                <Button variant={billingCycle === "yearly" ? "default" : "ghost"} size="sm" onClick={() => setBillingCycle("yearly")}>{t("admin.billing.yearly_20_discount")}</Button>
              </div>
            </div>

            <div className="grid gap-6 md:grid-cols-3">
              {plans.map(plan => <Card key={plan.name} className={plan.current ? "border-primary" : ""}>
                  <CardHeader>
                    <CardTitle className="flex items-center justify-between">
                      {plan.name}
                      {plan.current && <Badge variant="default">{t("admin.billing.current")}</Badge>}
                    </CardTitle>
                    <div>
                      <p className="text-3xl font-bold">{plan.price}</p>
                      <p className="text-sm text-muted-foreground">{plan.description}</p>
                    </div>
                  </CardHeader>
                  <CardContent>
                    <ul className="space-y-2 mb-4">
                      {plan.features.map(feature => <li key={feature} className="flex items-center gap-2 text-sm">
                          <CheckCircle className="w-4 h-4 text-green-500" />
                          {feature}
                        </li>)}
                    </ul>
                    <Button className="w-full" variant={plan.current ? "outline" : "default"} disabled={plan.current}>
                      {plan.current ? t("admin.billing.current_plan", "Mevcut Plan") : t("admin.billing.select", "Seç")}
                    </Button>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>

          <TabsContent value="billing" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.billing.invoice_history")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {invoices.map(invoice => <div key={invoice.id} className="flex items-center justify-between p-4 border rounded-lg">
                      <div>
                        <p className="font-medium">{invoice.id}</p>
                        <p className="text-sm text-muted-foreground">{invoice.date}</p>
                        <p className="text-sm">{invoice.plan}</p>
                      </div>
                      <div className="text-right">
                        <p className="font-medium">{invoice.amount}</p>
                        <Badge variant={invoice.status === "paid" ? "default" : "secondary"}>
                          {invoice.status === "paid" ? t("admin.billing.paid", "Ödendi") : t("admin.billing.pending", "Bekliyor")}
                        </Badge>
                      </div>
                      <Button variant="outline" size="sm">
                        <Download className="w-4 h-4 mr-2" />{t("admin.billing.download")}</Button>
                    </div>)}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="payment" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.billing.payment_methods")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {paymentMethods.map(method => <div key={method.id} className="flex items-center justify-between p-4 border rounded-lg">
                      <div className="flex items-center gap-3">
                        <CreditCard className="w-5 h-5" />
                        <div>
                          <p className="font-medium">
                            {method.brand} •••• {method.last4}
                          </p>
                          <p className="text-sm text-muted-foreground">{t("admin.billing.expiry")}{method.expiry}
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center gap-2">
                        {method.isDefault && <Badge variant="default">{t("admin.billing.default")}</Badge>}
                        <Button variant="outline" size="sm">{t("admin.billing.edit")}</Button>
                      </div>
                    </div>)}
                </div>
                <Button className="w-full mt-4">{t("admin.billing.add_payment_method")}</Button>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>;
}