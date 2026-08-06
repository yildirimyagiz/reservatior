"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Mail, Phone, MapPin, Send, RefreshCw, Shield, Cpu, ArrowUpRight } from "lucide-react";
import { m } from "framer-motion";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";

export function ContactContent() {
    const { t } = useTranslation();
  const { toast } = useToast();
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setTimeout(() => {
      setIsSubmitting(false);
      toast({
        title: "Message Sent",
        description: "Your message has been sent successfully",
      });
    }, 2000);
  };

  const contactNodes = [
    {
      icon: Mail,
      label: "Email",
      value: "support@reservatior.ai",
      sub: "24/7 Support",
      color: "text-brand"
    },
    {
      icon: Phone,
      label: "Phone",
      value: "+1 (888) 555-0123",
      sub: "Mon-Fri 9AM-6PM",
      color: "text-success"
    },
    {
      icon: MapPin,
      label: "Address",
      value: "New York, NY 10001",
      sub: "United States",
      color: "text-brand"
    }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("contact.contactcontent.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("contact.contactcontent.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/client/dashboard')}
              className="bg-brand hover:bg-brand"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("contact.contactcontent.auto_ext_3")}
                                      </Button>
          </div>
        </m.div>

        <div className="grid lg:grid-cols-2 gap-12">
          {/* Contact Form */}
          <m.div
            initial={{ opacity: 0, x: -30 }}
            animate={{ opacity: 1, x: 0 }}
            className="p-10 rounded-[40px] bg-white/5 backdrop-blur-xl border border-brand/20"
          >
            <div className="space-y-8">
              <div className="space-y-2">
                <h2 className="text-3xl font-bold text-white">{t("contact.contactcontent.auto_ext_4")}</h2>
                <p className="text-gray-400 text-sm">{t("contact.contactcontent.auto_ext_5")}</p>
              </div>

              <form onSubmit={handleSubmit} className="space-y-6">
                <div className="grid md:grid-cols-2 gap-6">
                  <div className="space-y-2">
                    <Label className="text-gray-400">{t("contact.contactcontent.auto_ext_6")}</Label>
                    <Input
                      required
                      className="h-14 bg-white/10 border-brand/30 rounded-2xl text-white placeholder:text-gray-500"
                      placeholder="Your name"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label className="text-gray-400">{t("contact.contactcontent.auto_ext_7")}</Label>
                    <Input
                      className="h-14 bg-white/10 border-brand/30 rounded-2xl text-white placeholder:text-gray-500"
                      placeholder="Your company"
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label className="text-gray-400">{t("contact.contactcontent.auto_ext_8")}</Label>
                  <Input
                    required
                    type="email"
                    className="h-14 bg-white/10 border-brand/30 rounded-2xl text-white placeholder:text-gray-500"
                    placeholder="your@email.com"
                  />
                </div>

                <div className="space-y-2">
                  <Label className="text-gray-400">{t("contact.contactcontent.auto_ext_9")}</Label>
                  <Textarea
                    required
                    className="min-h-[160px] bg-white/10 border-brand/30 rounded-3xl text-white placeholder:text-gray-500 p-6"
                    placeholder="Your message..."
                  />
                </div>

                <Button
                  disabled={isSubmitting}
                  className="w-full h-16 bg-brand hover:bg-brand text-white font-bold rounded-2xl transition-all"
                >
                  {isSubmitting ? (
                    <div className="flex items-center gap-3">
                      <RefreshCw className="w-5 h-5 animate-spin" />
                      <span>{t("contact.contactcontent.auto_ext_10")}</span>
                    </div>
                  ) : (
                    <div className="flex items-center gap-3">
                      <Send className="w-5 h-5" />
                      <span>{t("contact.contactcontent.auto_ext_11")}</span>
                    </div>
                  )}
                </Button>
              </form>
            </div>
          </m.div>

          {/* Contact Info */}
          <div className="space-y-8">
            <div className="grid sm:grid-cols-2 lg:grid-cols-1 gap-6">
              {contactNodes.map((node, idx) => (
                <m.div
                  key={node.label}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: idx * 0.1 }}
                  className="p-8 rounded-[32px] bg-white/5 backdrop-blur-xl border border-brand/20 hover:bg-white/10 transition-all"
                >
                  <div className="flex items-center gap-6">
                    <div className={cn(
                      "h-14 w-14 rounded-2xl bg-brand/20 border border-brand/30 flex items-center justify-center transition-transform hover:scale-110",
                      node.color
                    )}>
                      <node.icon className="w-6 h-6" />
                    </div>
                    <div className="space-y-1">
                      <p className="text-gray-400 text-sm font-medium">{node.label}</p>
                      <p className="text-lg font-bold text-white">{node.value}</p>
                      <p className="text-gray-500 text-xs">{node.sub}</p>
                    </div>
                  </div>
                </m.div>
              ))}
            </div>

            {/* Legal Info */}
            <m.div
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: 0.4 }}
              className="p-10 rounded-[40px] bg-gradient-to-br from-brand/10 to-brand/10 border border-brand/20 backdrop-blur-xl"
            >
              <div className="space-y-4">
                <h3 className="text-xl font-bold text-white flex items-center gap-2">
                  <Shield className="w-5 h-5 text-brand" />
                  {t("contact.contactcontent.auto_ext_12")}
                                                  </h3>
                <p className="text-gray-400 text-sm leading-relaxed">
                  {t("contact.contactcontent.auto_ext_13")}
                                                  </p>
                <div className="flex items-center gap-6 pt-4">
                  <div className="flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-success animate-pulse" />
                    <span className="text-white text-sm font-medium">{t("contact.contactcontent.auto_ext_14")}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Cpu className="w-4 h-4 text-brand" />
                    <span className="text-white text-sm font-medium">{t("contact.contactcontent.auto_ext_15")}</span>
                  </div>
                </div>
              </div>
            </m.div>
          </div>
        </div>
      </div>
    </div>
  );
}
