import type { Metadata } from "next";
import TemplateCatalog from "@/pages-spa/document_os/TemplateCatalog";

export const metadata: Metadata = {
  title: "Contract Template Library | Reservatior",
  description: "Localized contract templates for 23 countries across leasing, sales and platform agreements.",
};

export default function TemplatesPage() {
  return <TemplateCatalog />;
}
