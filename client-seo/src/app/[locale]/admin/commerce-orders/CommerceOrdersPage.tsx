"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  ShoppingCart,
  Search,
  Plus,
  Eye,
  Package,
  CreditCard,
  Truck,
  CheckCircle,
  Clock,
  XCircle,
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
import { useCommerceOrdersStore } from "@/lib/store/commerce-orders-store";

const ORDER_STATUSES = [
  "PENDING",
  "CONFIRMED",
  "PROCESSING",
  "SHIPPED",
  "DELIVERED",
  "CANCELLED",
  "REFUNDED",
];

const PAYMENT_STATUSES = ["UNPAID", "PARTIAL", "PAID", "REFUNDED"];

const STATUS_COLORS: Record<string, string> = {
  PENDING: "bg-amber-500/20 text-amber-400",
  CONFIRMED: "bg-blue-500/20 text-blue-400",
  PROCESSING: "bg-purple-500/20 text-purple-400",
  SHIPPED: "bg-cyan-500/20 text-cyan-400",
  DELIVERED: "bg-green-500/20 text-green-400",
  CANCELLED: "bg-red-500/20 text-red-400",
  REFUNDED: "bg-orange-500/20 text-orange-400",
  UNPAID: "bg-red-500/20 text-red-400",
  PARTIAL: "bg-amber-500/20 text-amber-400",
  PAID: "bg-green-500/20 text-green-400",
};

const mockOrders = [
  { id: "1", orgId: "org1", orderNumber: "ORD-2026-001", status: "DELIVERED", buyerType: "USER", buyerId: "u1", buyerName: "John Doe", buyerEmail: "john@email.com", agentId: "a1", bundleId: "b1", propertyId: "p1", subtotal: 5999, discount: 200, tax: 464, total: 6263, currency: "USD", paymentMethod: "CREDIT_CARD", paymentStatus: "PAID", paidAt: "2026-01-20", paymentRef: "PAY-001", deliveryAddress: "123 Main St", deliveryDate: "2026-02-01", installationDate: null, financingOption: null, items: [], metadata: {}, createdAt: "2026-01-15", updatedAt: "2026-02-01" },
  { id: "2", orgId: "org1", orderNumber: "ORD-2026-002", status: "SHIPPED", buyerType: "USER", buyerId: "u2", buyerName: "Jane Smith", buyerEmail: "jane@email.com", agentId: "a2", bundleId: null, propertyId: "p2", subtotal: 3499, discount: 0, tax: 280, total: 3779, currency: "USD", paymentMethod: "BANK_TRANSFER", paymentStatus: "PAID", paidAt: "2026-02-10", paymentRef: "PAY-002", deliveryAddress: "456 Oak Ave", deliveryDate: "2026-02-20", installationDate: null, financingOption: null, items: [], metadata: {}, createdAt: "2026-02-05", updatedAt: "2026-02-15" },
  { id: "3", orgId: "org1", orderNumber: "ORD-2026-003", status: "PROCESSING", buyerType: "USER", buyerId: "u3", buyerName: "Bob Wilson", buyerEmail: "bob@email.com", agentId: "a3", bundleId: "b2", propertyId: "p3", subtotal: 12999, discount: 500, tax: 1000, total: 13499, currency: "USD", paymentMethod: "FINANCING", paymentStatus: "PARTIAL", paidAt: null, paymentRef: null, deliveryAddress: "789 Pine Rd", deliveryDate: "2026-03-01", installationDate: "2026-03-05", financingOption: "12_MONTHS", items: [], metadata: {}, createdAt: "2026-02-15", updatedAt: "2026-02-15" },
  { id: "4", orgId: "org1", orderNumber: "ORD-2026-004", status: "CONFIRMED", buyerType: "USER", buyerId: "u4", buyerName: "Alice Brown", buyerEmail: "alice@email.com", agentId: "a1", bundleId: null, propertyId: "p4", subtotal: 899, discount: 50, tax: 68, total: 917, currency: "USD", paymentMethod: "CREDIT_CARD", paymentStatus: "PAID", paidAt: "2026-02-18", paymentRef: "PAY-004", deliveryAddress: "321 Elm St", deliveryDate: "2026-03-01", installationDate: null, financingOption: null, items: [], metadata: {}, createdAt: "2026-02-18", updatedAt: "2026-02-18" },
  { id: "5", orgId: "org1", orderNumber: "ORD-2026-005", status: "PENDING", buyerType: "USER", buyerId: "u5", buyerName: "Charlie Davis", buyerEmail: "charlie@email.com", agentId: null, bundleId: null, propertyId: "p5", subtotal: 2499, discount: 0, tax: 200, total: 2699, currency: "USD", paymentMethod: "CREDIT_CARD", paymentStatus: "UNPAID", paidAt: null, paymentRef: null, deliveryAddress: "654 Maple Dr", deliveryDate: null, installationDate: null, financingOption: null, items: [], metadata: {}, createdAt: "2026-02-20", updatedAt: "2026-02-20" },
  { id: "6", orgId: "org1", orderNumber: "ORD-2026-006", status: "CANCELLED", buyerType: "USER", buyerId: "u6", buyerName: "Eva Martinez", buyerEmail: "eva@email.com", agentId: "a4", bundleId: null, propertyId: "p6", subtotal: 1499, discount: 100, tax: 112, total: 1511, currency: "USD", paymentMethod: "CREDIT_CARD", paymentStatus: "REFUNDED", paidAt: "2026-02-01", paymentRef: "PAY-006", deliveryAddress: "987 Cedar Ln", deliveryDate: null, installationDate: null, financingOption: null, items: [], metadata: {}, createdAt: "2026-02-01", updatedAt: "2026-02-10" },
];

function StatusIcon({ status }: { status: string }) {
  switch (status) {
    case "DELIVERED":
      return <CheckCircle className="w-3.5 h-3.5" />;
    case "SHIPPED":
      return <Truck className="w-3.5 h-3.5" />;
    case "PROCESSING":
      return <Package className="w-3.5 h-3.5" />;
    case "CANCELLED":
    case "REFUNDED":
      return <XCircle className="w-3.5 h-3.5" />;
    case "PENDING":
      return <Clock className="w-3.5 h-3.5" />;
    default:
      return <CreditCard className="w-3.5 h-3.5" />;
  }
}

export default function CommerceOrdersPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");
  const [paymentFilter, setPaymentFilter] = useState("all");
  const [detailItem, setDetailItem] = useState<any>(null);
  const [isDetailOpen, setIsDetailOpen] = useState(false);

  const filtered = mockOrders.filter((o) => {
    const matchesSearch =
      o.orderNumber.toLowerCase().includes(searchTerm.toLowerCase()) ||
      o.buyerName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      o.buyerEmail.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "all" || o.status === statusFilter;
    const matchesPayment =
      paymentFilter === "all" || o.paymentStatus === paymentFilter;
    return matchesSearch && matchesStatus && matchesPayment;
  });

  const totalOrders = mockOrders.length;
  const totalRevenue = mockOrders
    .filter((o) => o.paymentStatus === "PAID")
    .reduce((sum, o) => sum + o.total, 0);
  const pendingOrders = mockOrders.filter(
    (o) => o.status === "PENDING" || o.status === "CONFIRMED"
  ).length;
  const deliveredOrders = mockOrders.filter(
    (o) => o.status === "DELIVERED"
  ).length;

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
                {t("admin_commerce_orders_title", "Commerce Orders")}
              </h1>
              <p className="text-muted-foreground">
                {t(
                  "admin_commerce_orders_description",
                  "Track orders, payments, and delivery status"
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
                  <ShoppingCart className="w-5 h-5 text-blue-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_commerce_orders_total", "Total Orders")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {totalOrders}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-green-500/10">
                  <CreditCard className="w-5 h-5 text-green-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_commerce_orders_revenue", "Revenue")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    ${totalRevenue.toLocaleString()}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10">
                  <Clock className="w-5 h-5 text-amber-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_commerce_orders_pending", "Pending")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {pendingOrders}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-emerald-500/10">
                  <CheckCircle className="w-5 h-5 text-emerald-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_commerce_orders_delivered", "Delivered")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {deliveredOrders}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Search and Filters */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.15 }}
          className="mb-6"
        >
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t(
                        "admin_commerce_orders_search_placeholder",
                        "Search by order number, buyer..."
                      )}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select
                  value={statusFilter}
                  onValueChange={setStatusFilter}
                >
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue
                      placeholder={t(
                        "admin_commerce_orders_status",
                        "Status"
                      )}
                    />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">
                      {t(
                        "admin_commerce_orders_all_status",
                        "All Status"
                      )}
                    </SelectItem>
                    {ORDER_STATUSES.map((s) => (
                      <SelectItem key={s} value={s}>
                        {s}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Select
                  value={paymentFilter}
                  onValueChange={setPaymentFilter}
                >
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue
                      placeholder={t(
                        "admin_commerce_orders_payment",
                        "Payment"
                      )}
                    />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">
                      {t(
                        "admin_commerce_orders_all_payment",
                        "All Payment"
                      )}
                    </SelectItem>
                    {PAYMENT_STATUSES.map((s) => (
                      <SelectItem key={s} value={s}>
                        {s}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Orders Table */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <ShoppingCart className="w-5 h-5" />
                {t("admin_commerce_orders_list_title", "Orders")} (
                {filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border">
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_orders_number", "Order #")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_orders_buyer", "Buyer")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_orders_method", "Payment")}
                      </th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_orders_total", "Total")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_orders_status_col", "Status")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_orders_payment_col", "Payment")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_orders_date", "Date")}
                      </th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_orders_actions", "Actions")}
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    {filtered.map((order) => (
                      <tr
                        key={order.id}
                        className="border-b border-border/50 hover:bg-muted/30 transition-colors"
                      >
                        <td className="py-3 px-4">
                          <div className="text-foreground font-medium font-mono text-xs">
                            {order.orderNumber}
                          </div>
                        </td>
                        <td className="py-3 px-4">
                          <div className="text-foreground font-medium">
                            {order.buyerName}
                          </div>
                          <div className="text-xs text-muted-foreground">
                            {order.buyerEmail}
                          </div>
                        </td>
                        <td className="py-3 px-4 text-muted-foreground text-xs">
                          {order.paymentMethod?.replace(/_/g, " ")}
                        </td>
                        <td className="py-3 px-4 text-right font-medium text-foreground">
                          ${order.total.toLocaleString()}
                        </td>
                        <td className="py-3 px-4">
                          <Badge
                            className={`${STATUS_COLORS[order.status]} flex items-center gap-1 w-fit`}
                          >
                            <StatusIcon status={order.status} />
                            {order.status}
                          </Badge>
                        </td>
                        <td className="py-3 px-4">
                          <Badge
                            className={
                              STATUS_COLORS[order.paymentStatus] ||
                              "bg-gray-500/20 text-gray-400"
                            }
                          >
                            {order.paymentStatus}
                          </Badge>
                        </td>
                        <td className="py-3 px-4 text-xs text-muted-foreground">
                          {order.createdAt}
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex justify-end gap-2">
                            <Button
                              onClick={() => {
                                setDetailItem(order);
                                setIsDetailOpen(true);
                              }}
                              variant="ghost"
                              size="icon"
                              className="h-8 w-8"
                            >
                              <Eye className="w-4 h-4" />
                            </Button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Order Detail Dialog */}
        {detailItem && (
          <Dialog open={isDetailOpen} onOpenChange={setIsDetailOpen}>
            <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
              <DialogHeader>
                <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">
                  {detailItem.orderNumber}
                </DialogTitle>
                <DialogDescription className="text-muted-foreground">
                  {t(
                    "admin_commerce_orders_detail_desc",
                    "Order details and tracking"
                  )}
                </DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label className="text-xs text-muted-foreground">
                      {t("admin_commerce_orders_buyer", "Buyer")}
                    </Label>
                    <p className="text-foreground font-medium">
                      {detailItem.buyerName}
                    </p>
                    <p className="text-xs text-muted-foreground">
                      {detailItem.buyerEmail}
                    </p>
                  </div>
                  <div>
                    <Label className="text-xs text-muted-foreground">
                      {t("admin_commerce_orders_status_col", "Status")}
                    </Label>
                    <Badge
                      className={`${STATUS_COLORS[detailItem.status]} mt-1`}
                    >
                      {detailItem.status}
                    </Badge>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label className="text-xs text-muted-foreground">
                      {t("admin_commerce_orders_subtotal", "Subtotal")}
                    </Label>
                    <p className="text-foreground">
                      ${detailItem.subtotal.toLocaleString()}
                    </p>
                  </div>
                  <div>
                    <Label className="text-xs text-muted-foreground">
                      {t("admin_commerce_orders_discount", "Discount")}
                    </Label>
                    <p className="text-foreground">
                      -${detailItem.discount.toLocaleString()}
                    </p>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label className="text-xs text-muted-foreground">
                      {t("admin_commerce_orders_tax", "Tax")}
                    </Label>
                    <p className="text-foreground">
                      ${detailItem.tax.toLocaleString()}
                    </p>
                  </div>
                  <div>
                    <Label className="text-xs text-muted-foreground">
                      {t("admin_commerce_orders_total", "Total")}
                    </Label>
                    <p className="text-foreground text-xl font-bold">
                      ${detailItem.total.toLocaleString()}
                    </p>
                  </div>
                </div>
                <div className="border-t border-white/10 pt-4">
                  <Label className="text-xs text-muted-foreground">
                    {t("admin_commerce_orders_delivery_address", "Delivery")}
                  </Label>
                  <p className="text-foreground text-sm">
                    {detailItem.deliveryAddress}
                  </p>
                </div>
                {detailItem.deliveryDate && (
                  <div>
                    <Label className="text-xs text-muted-foreground">
                      {t("admin_commerce_orders_delivery_date", "Delivery Date")}
                    </Label>
                    <p className="text-foreground text-sm">
                      {detailItem.deliveryDate}
                    </p>
                  </div>
                )}
              </div>
              <DialogFooter className="pt-4 border-t border-white/10">
                <Button
                  variant="outline"
                  onClick={() => setIsDetailOpen(false)}
                  className="border-border text-foreground"
                >
                  {t("admin_action_close", "Close")}
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        )}
      </div>
    </div>
  );
}
