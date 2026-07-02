import type { Metadata } from "next";
import { DocumentWorkflowContent } from "@/app/[locale]/client/legal/document-workflow/DocumentWorkflowContent";

export const metadata: Metadata = {
  title: "Document Workflow - Document Processes | Reservatior",
  description: "Manage document workflows and approval processes. Track document status and approvals.",
  keywords: ["document workflow", "approval processes", "document tracking", "workflow automation"],
  openGraph: {
    title: "Document Workflow - Document Processes | Reservatior",
    description: "Manage document workflows and approval processes.",
    type: "website",
  },
};

export default function DocumentWorkflowPage() {
  return <DocumentWorkflowContent />;
}
