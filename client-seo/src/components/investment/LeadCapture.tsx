"use client";

import { useState, useCallback } from "react";
import { Mail, User, Phone, CheckCircle, ArrowRight, Loader2 } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { useInvestmentIntelligenceStore } from "@/lib/investment-intelligence-store";

interface LeadCaptureProps {
  source?: string;
  calculatorType?: string;
  onSuccess?: () => void;
}

export function LeadCapture({
  source = "calculator",
  calculatorType = "roi",
  onSuccess,
}: LeadCaptureProps) {
  const { captureLead } = useInvestmentIntelligenceStore();
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    phone: "",
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = useCallback(async () => {
    if (!formData.email) return;
    setIsSubmitting(true);
    try {
      await captureLead({
        name: formData.name,
        email: formData.email,
        phone: formData.phone || undefined,
        source,
        intent: "medium",
        calculatorType,
      });
      setSubmitted(true);
      onSuccess?.();
    } catch {
      // silent
    } finally {
      setIsSubmitting(false);
    }
  }, [formData, captureLead, source, calculatorType, onSuccess]);

  if (submitted) {
    return (
      <Card className="border-blue-500/30 bg-success/5">
        <CardContent className="p-6 text-center">
          <CheckCircle className="w-12 h-12 mx-auto mb-3 text-success" />
          <p className="text-lg font-bold">Thank you!</p>
          <p className="text-muted-foreground">
            Your investment report has been sent to {formData.email}
          </p>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="border-primary/30 bg-primary/5">
      <CardHeader>
        <CardTitle className="text-base flex items-center gap-2">
          <Mail className="w-5 h-5" />
          Get Your Free Investment Report
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <p className="text-sm text-muted-foreground">
          Receive a detailed AI-powered investment analysis with market comparisons,
          risk assessment, and personalized recommendations.
        </p>
        <div className="space-y-3">
          <div>
            <Label className="text-sm">Full Name</Label>
            <div className="relative">
              <User className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input
                placeholder="John Smith"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                className="pl-10"
              />
            </div>
          </div>
          <div>
            <Label className="text-sm">Email *</Label>
            <div className="relative">
              <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input
                type="email"
                placeholder="john@example.com"
                value={formData.email}
                onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                className="pl-10"
                required
              />
            </div>
          </div>
          <div>
            <Label className="text-sm">Phone (optional)</Label>
            <div className="relative">
              <Phone className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input
                type="tel"
                placeholder="+971 50 123 4567"
                value={formData.phone}
                onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                className="pl-10"
              />
            </div>
          </div>
        </div>
        <Button
          onClick={handleSubmit}
          disabled={isSubmitting || !formData.email}
          className="w-full"
          size="lg"
        >
          {isSubmitting ? (
            <Loader2 className="w-4 h-4 mr-2 animate-spin" />
          ) : (
            <ArrowRight className="w-4 h-4 mr-2" />
          )}
          {isSubmitting ? "Sending..." : "Send My Report"}
        </Button>
        <p className="text-xs text-muted-foreground/60 text-center">
          We respect your privacy. No spam, ever.
        </p>
      </CardContent>
    </Card>
  );
}
