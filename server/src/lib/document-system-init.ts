

// Additional Prisma models for document analysis and reporting
export const analysisJob = prisma.analysisJob;
export const documentAnalysis = prisma.documentAnalysis;

// Initialize the report scheduler when the server starts

import { prisma } from "./prisma";
import { initializeScheduledReports } from "./report-scheduler";

// Start scheduled reports
initializeScheduledReports().catch(console.error);

console.log("Enhanced document management system initialized");
console.log("Features:");
console.log("- Document upload with validation");
console.log("- AI-powered document analysis");
console.log("- Automated report generation");
console.log("- Scheduled report execution");
console.log("- Document duplicate detection");
console.log("- Full-text search in documents");
