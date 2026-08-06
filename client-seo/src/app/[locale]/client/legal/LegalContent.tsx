"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { FileText, Shield, PenTool, Workflow, UserCheck, Pen, Scale } from "lucide-react";
import Link from "next/link";
import { useTranslation } from "react-i18next";

export function LegalContent() {
    const { t } = useTranslation();
  const legalModules = [
    {
      title: "Documents",
      description: "Manage legal documents for properties and rentals",
      icon: FileText,
      href: "/client/legal/documents",
      color: "text-brand"
    },
    {
      title: "Compliance",
      description: "Manage legal compliance for properties and rentals",
      icon: Shield,
      href: "/client/legal/compliance",
      color: "text-success"
    },
    {
      title: "Document Templates",
      description: "Create and manage legal document templates",
      icon: PenTool,
      href: "/client/legal/document-templates",
      color: "text-brand"
    },
    {
      title: "Document Workflow",
      description: "Manage document workflows and approval processes",
      icon: Workflow,
      href: "/client/legal/document-workflow",
      color: "text-orange-500"
    },
    {
      title: "Right to Rent",
      description: "Manage Right to Rent checks and tenant verification",
      icon: UserCheck,
      href: "/client/legal/right-to-rent",
      color: "text-cyan-500"
    },
    {
      title: "Signatures",
      description: "Manage digital signatures for legal documents",
      icon: Pen,
      href: "/client/legal/signatures",
      color: "text-pink-500"
    },
    {
      title: "Deposit Protection",
      description: "Manage security deposits and deposit protection schemes",
      icon: Scale,
      href: "/client/legal/deposit-protection",
      color: "text-brand"
    },
    {
      title: "Solicitor Management",
      description: "Manage solicitors and legal professionals",
      icon: Scale,
      href: "/client/legal/solicitor-management",
      color: "text-rose-500"
    }
  ];

  return (
    <div className="container mx-auto p-6">
      <div className="mb-8">
        <h1 className="text-3xl font-bold">{t("legal.legalcontent.auto_ext_1")}</h1>
        <p className="text-muted-foreground">{t("legal.legalcontent.auto_ext_2")}</p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {legalModules.map((module) => (
          <Link key={module.href} href={module.href}>
            <Card className="hover:shadow-lg transition-shadow cursor-pointer h-full">
              <CardHeader>
                <div className={`w-12 h-12 rounded-lg bg-muted flex items-center justify-center mb-4 ${module.color}`}>
                  <module.icon className="w-6 h-6" />
                </div>
                <CardTitle className="text-lg">{module.title}</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">{module.description}</p>
              </CardContent>
            </Card>
          </Link>
        ))}
      </div>
    </div>
  );
}
