export const openApiSpec = {
  openapi: "3.0.3",
  info: {
    title: "Reservatior Platform API",
    version: "2.0.0",
    description:
      "AI-native Residential Infrastructure Platform — 21 OS Modules + 7 Core Intelligence Layers",
  },
  servers: [{ url: "/api/v1", description: "Production" }],

  tags: [
    { name: "Finance OS", description: "Escrow engine, financial dashboards, and treasury management" },
    { name: "Governance OS", description: "Compliance rules, audit trails, and legal governance" },
    { name: "Partner OS", description: "Partner ecosystem, agreements, suppliers, and vendor reviews" },
    { name: "Developer API OS", description: "API keys, integrations, webhooks, and developer tooling" },
    { name: "Analytics OS", description: "Analytics engine, reports, dashboards, metrics, and alerts" },
    { name: "Document OS", description: "Document lifecycle, contracts, signatures, and templates" },
    { name: "Notification OS", description: "Notifications, messaging, communication logs, and channels" },
    { name: "Identity OS", description: "Identity and access management, roles, permissions, and sessions" },
    { name: "Localization OS", description: "Countries, currencies, exchange rates, languages, and tax regulations" },
    { name: "Investment OS", description: "Investment deals, projections, comparables, and market insights" },
    { name: "Operations OS", description: "Maintenance, inspections, cleaning, vendor ratings, and service providers" },
    { name: "Security OS", description: "KYC verification, fraud detection, access audit, and security policies" },
    { name: "User OS", description: "User profiles, identity, consent, journey, interests, recommendations, and notifications" },
    { name: "Ads OS", description: "Ad campaigns, creatives, audience segments, channels, budgets, attribution, and conversions" },
    { name: "Booking OS", description: "Booking management, live feed, pricing engine, and check-in/out" },
    { name: "Listing OS", description: "Property listings, creation, and updates" },
    { name: "Agent OS", description: "Agent registration, performance dashboards, network signals, and status management" },
  ],

  paths: {
    // ──────────────────────────────────────────────
    // Finance OS
    // ──────────────────────────────────────────────
    "/finance-os/dashboard": {
      get: {
        tags: ["Finance OS"],
        summary: "Finance OS Dashboard",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
        ],
        responses: {
          "200": { description: "Dashboard stats", content: { "application/json": { schema: { $ref: "#/components/schemas/SuccessResponse" } } } },
          "400": { $ref: "#/components/responses/BadRequest" },
          "500": { $ref: "#/components/responses/InternalError" },
        },
      },
    },

    // ──────────────────────────────────────────────
    // Governance OS
    // ──────────────────────────────────────────────
    "/governance-os/dashboard": {
      get: {
        tags: ["Governance OS"],
        summary: "Governance OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/governance-os/rules": {
      get: {
        tags: ["Governance OS"],
        summary: "List Governance Rules",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "status", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated rules" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/governance-os/compliance": {
      get: {
        tags: ["Governance OS"],
        summary: "List Compliance Records",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "status", in: "query", schema: { type: "string" } },
          { name: "type", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated compliance records" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Governance OS"],
        summary: "Create Compliance Record",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateComplianceRecordRequest" } } },
        },
        responses: { "201": { description: "Compliance record created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/governance-os/compliance/stats": {
      get: {
        tags: ["Governance OS"],
        summary: "Compliance Statistics",
        responses: { "200": { description: "Compliance stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/governance-os/compliance/{id}": {
      patch: {
        tags: ["Governance OS"],
        summary: "Update Compliance Status",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["status"], properties: { status: { type: "string" }, notes: { type: "string" } } } } },
        },
        responses: { "200": { description: "Compliance record updated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/governance-os/legal/{orgId}": {
      get: {
        tags: ["Governance OS"],
        summary: "Get Legal Compliance by Organization",
        parameters: [{ name: "orgId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Legal compliance data" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/governance-os/audit-trail": {
      get: {
        tags: ["Governance OS"],
        summary: "Get Audit Trail",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "entityType", in: "query", schema: { type: "string" } },
          { name: "action", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Audit trail entries" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Partner OS
    // ──────────────────────────────────────────────
    "/partner-os/dashboard": {
      get: {
        tags: ["Partner OS"],
        summary: "Partner OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/partner-os/partners": {
      get: {
        tags: ["Partner OS"],
        summary: "List Partners",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated partners" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Partner OS"],
        summary: "Create Partner",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreatePartnerRequest" } } },
        },
        responses: { "201": { description: "Partner created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/partner-os/agreements": {
      get: {
        tags: ["Partner OS"],
        summary: "List Agreements",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "status", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated agreements" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Partner OS"],
        summary: "Create Agreement",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateAgreementRequest" } } },
        },
        responses: { "201": { description: "Agreement created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/partner-os/agreements/stats": {
      get: {
        tags: ["Partner OS"],
        summary: "Agreement Statistics",
        responses: { "200": { description: "Agreement stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/partner-os/suppliers": {
      get: {
        tags: ["Partner OS"],
        summary: "List Suppliers",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated suppliers" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/partner-os/reviews/{orgId}": {
      get: {
        tags: ["Partner OS"],
        summary: "Get Vendor Reviews",
        parameters: [{ name: "orgId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Vendor reviews" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Developer API OS
    // ──────────────────────────────────────────────
    "/developer-os/dashboard": {
      get: {
        tags: ["Developer API OS"],
        summary: "Developer API OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/developer-os/api-keys": {
      get: {
        tags: ["Developer API OS"],
        summary: "List API Keys",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated API keys" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Developer API OS"],
        summary: "Create API Key",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateApiKeyRequest" } } },
        },
        responses: { "201": { description: "API key created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/developer-os/integrations": {
      get: {
        tags: ["Developer API OS"],
        summary: "List Integrations",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Integrations list" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/developer-os/integrations/stats": {
      get: {
        tags: ["Developer API OS"],
        summary: "Integration Statistics",
        responses: { "200": { description: "Integration stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/developer-os/webhooks": {
      get: {
        tags: ["Developer API OS"],
        summary: "List Webhooks",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Webhooks list" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Developer API OS"],
        summary: "Create Webhook",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateWebhookRequest" } } },
        },
        responses: { "201": { description: "Webhook created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/developer-os/logs": {
      get: {
        tags: ["Developer API OS"],
        summary: "Get Integration Logs",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "integrationId", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Integration logs" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/developer-os/webhooks/{id}/deliveries": {
      get: {
        tags: ["Developer API OS"],
        summary: "Get Webhook Deliveries",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Webhook deliveries" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Analytics OS
    // ──────────────────────────────────────────────
    "/analytics-os/dashboard": {
      get: {
        tags: ["Analytics OS"],
        summary: "Analytics OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/analytics-os/analytics": {
      get: {
        tags: ["Analytics OS"],
        summary: "List Analytics Records",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "type", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated analytics" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Analytics OS"],
        summary: "Create Analytics Record",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateAnalyticsRequest" } } },
        },
        responses: { "201": { description: "Analytics record created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/analytics-os/analytics/stats": {
      get: {
        tags: ["Analytics OS"],
        summary: "Analytics Statistics",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Analytics stats" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/analytics-os/reports": {
      get: {
        tags: ["Analytics OS"],
        summary: "List Reports",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated reports" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Analytics OS"],
        summary: "Create Report",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateReportRequest" } } },
        },
        responses: { "201": { description: "Report created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/analytics-os/reports/{id}/executions": {
      get: {
        tags: ["Analytics OS"],
        summary: "Get Report Executions",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Report executions" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/analytics-os/dashboards": {
      get: {
        tags: ["Analytics OS"],
        summary: "List Dashboards",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboards list" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/analytics-os/metrics": {
      get: {
        tags: ["Analytics OS"],
        summary: "Get System Metrics",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "metricType", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "System metrics" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/analytics-os/alerts": {
      get: {
        tags: ["Analytics OS"],
        summary: "Get Performance Alerts",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "severity", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Performance alerts" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/analytics-os/health": {
      get: {
        tags: ["Analytics OS"],
        summary: "Get Health Checks",
        responses: { "200": { description: "Health checks" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Document OS
    // ──────────────────────────────────────────────
    "/document-os/dashboard": {
      get: {
        tags: ["Document OS"],
        summary: "Document OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/document-os/documents": {
      get: {
        tags: ["Document OS"],
        summary: "List Documents",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "documentType", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated documents" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Document OS"],
        summary: "Create Document",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateDocumentRequest" } } },
        },
        responses: { "201": { description: "Document created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/document-os/documents/stats": {
      get: {
        tags: ["Document OS"],
        summary: "Document Statistics",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Document stats" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/document-os/contracts": {
      get: {
        tags: ["Document OS"],
        summary: "List Contracts",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "status", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated contracts" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Document OS"],
        summary: "Create Contract",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateContractRequest" } } },
        },
        responses: { "201": { description: "Contract created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/document-os/contracts/stats": {
      get: {
        tags: ["Document OS"],
        summary: "Contract Statistics",
        responses: { "200": { description: "Contract stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/document-os/contracts/{id}/versions": {
      get: {
        tags: ["Document OS"],
        summary: "Get Contract Versions",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Contract versions" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/document-os/signatures": {
      get: {
        tags: ["Document OS"],
        summary: "List Signature Requests",
        parameters: [{ name: "orgId", in: "query", schema: { type: "string" } }],
        responses: { "200": { description: "Signature requests" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/document-os/signatures/stats": {
      get: {
        tags: ["Document OS"],
        summary: "Signature Statistics",
        responses: { "200": { description: "Signature stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/document-os/templates": {
      get: {
        tags: ["Document OS"],
        summary: "List Document Templates",
        responses: { "200": { description: "Document templates" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Notification OS
    // ──────────────────────────────────────────────
    "/notification-os/dashboard": {
      get: {
        tags: ["Notification OS"],
        summary: "Notification OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/notification-os/notifications": {
      get: {
        tags: ["Notification OS"],
        summary: "List Notifications",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "status", in: "query", schema: { type: "string" } },
          { name: "userId", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated notifications" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Notification OS"],
        summary: "Create Notification",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateNotificationRequest" } } },
        },
        responses: { "201": { description: "Notification created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/notification-os/notifications/stats": {
      get: {
        tags: ["Notification OS"],
        summary: "Notification Statistics",
        responses: { "200": { description: "Notification stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/notification-os/notifications/{id}/read": {
      patch: {
        tags: ["Notification OS"],
        summary: "Mark Notification as Read",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Notification marked as read" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/notification-os/messages": {
      get: {
        tags: ["Notification OS"],
        summary: "List Messages",
        parameters: [
          { name: "threadId", in: "query", schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated messages" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Notification OS"],
        summary: "Send Message",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/SendMessageRequest" } } },
        },
        responses: { "201": { description: "Message sent" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/notification-os/messages/stats": {
      get: {
        tags: ["Notification OS"],
        summary: "Message Statistics",
        responses: { "200": { description: "Message stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/notification-os/logs": {
      get: {
        tags: ["Notification OS"],
        summary: "Communication Logs",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "type", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Communication logs" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/notification-os/templates": {
      get: {
        tags: ["Notification OS"],
        summary: "List Communication Templates",
        responses: { "200": { description: "Templates list" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/notification-os/channels": {
      get: {
        tags: ["Notification OS"],
        summary: "List Communication Channels",
        responses: { "200": { description: "Channels list" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Identity OS
    // ──────────────────────────────────────────────
    "/identity-os/dashboard": {
      get: {
        tags: ["Identity OS"],
        summary: "Identity OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/users": {
      get: {
        tags: ["Identity OS"],
        summary: "List Users",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "search", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated users" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/users/stats": {
      get: {
        tags: ["Identity OS"],
        summary: "User Statistics",
        responses: { "200": { description: "User stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/sessions": {
      get: {
        tags: ["Identity OS"],
        summary: "List Active Sessions",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "userId", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Active sessions" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/sessions/{id}": {
      delete: {
        tags: ["Identity OS"],
        summary: "Revoke Session",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Session revoked" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/roles": {
      get: {
        tags: ["Identity OS"],
        summary: "List Roles",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Roles list" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/permissions": {
      get: {
        tags: ["Identity OS"],
        summary: "List Permissions",
        responses: { "200": { description: "Permissions list" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/accounts/{userId}": {
      get: {
        tags: ["Identity OS"],
        summary: "List User Accounts (SSO Providers)",
        parameters: [{ name: "userId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "User accounts" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/members/{orgId}": {
      get: {
        tags: ["Identity OS"],
        summary: "List Organization Members",
        parameters: [{ name: "orgId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Org members" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/identity-os/api-keys": {
      get: {
        tags: ["Identity OS"],
        summary: "List API Keys",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "API keys list" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Localization OS
    // ──────────────────────────────────────────────
    "/localization-os/dashboard": {
      get: {
        tags: ["Localization OS"],
        summary: "Localization OS Dashboard",
        responses: { "200": { description: "Dashboard data" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/countries": {
      get: {
        tags: ["Localization OS"],
        summary: "List Countries",
        responses: { "200": { description: "Countries list" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/countries/{isoCode}": {
      get: {
        tags: ["Localization OS"],
        summary: "Get Country Config",
        parameters: [{ name: "isoCode", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Country config" }, "404": { description: "Country not found" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/countries/{isoCode}/states": {
      get: {
        tags: ["Localization OS"],
        summary: "Get State Configs",
        parameters: [{ name: "isoCode", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "State configs" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/currencies": {
      get: {
        tags: ["Localization OS"],
        summary: "List Currencies",
        responses: { "200": { description: "Currencies list" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/exchange-rates": {
      get: {
        tags: ["Localization OS"],
        summary: "List Exchange Rates",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "baseCurrency", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Exchange rates" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Localization OS"],
        summary: "Create Exchange Rate",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateExchangeRateRequest" } } },
        },
        responses: { "201": { description: "Exchange rate created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/languages": {
      get: {
        tags: ["Localization OS"],
        summary: "List Languages",
        responses: { "200": { description: "Languages list" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/compliance": {
      get: {
        tags: ["Localization OS"],
        summary: "List Legal Compliance Records",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "region", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Compliance records" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/compliance/stats": {
      get: {
        tags: ["Localization OS"],
        summary: "Compliance Statistics",
        responses: { "200": { description: "Compliance stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/tax-regulations": {
      get: {
        tags: ["Localization OS"],
        summary: "List Tax Regulations",
        parameters: [
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "taxAuthority", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Tax regulations" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/localization-os/tax-regulations/stats": {
      get: {
        tags: ["Localization OS"],
        summary: "Tax Regulation Statistics",
        responses: { "200": { description: "Tax stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Investment OS
    // ──────────────────────────────────────────────
    "/investment-os/dashboard": {
      get: {
        tags: ["Investment OS"],
        summary: "Investment OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/deals": {
      get: {
        tags: ["Investment OS"],
        summary: "List Investment Deals",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
          { name: "status", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated deals" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Investment OS"],
        summary: "Create Investment Deal",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateDealRequest" } } },
        },
        responses: { "201": { description: "Deal created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/deals/{id}": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Investment Deal",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Deal details" }, "404": { description: "Deal not found" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      patch: {
        tags: ["Investment OS"],
        summary: "Update Investment Deal",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/UpdateDealRequest" } } },
        },
        responses: { "200": { description: "Deal updated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/deals/{id}/analyze": {
      post: {
        tags: ["Investment OS"],
        summary: "Analyze Investment Deal",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Deal analysis" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/deals/{id}/duplicate": {
      post: {
        tags: ["Investment OS"],
        summary: "Duplicate Investment Deal",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["userId"], properties: { userId: { type: "string" } } } } },
        },
        responses: { "201": { description: "Deal duplicated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/deals/{id}/stats": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Deal Stats",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Deal stats" }, "404": { description: "Deal not found" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/projections/{dealId}": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Projections for Deal",
        parameters: [{ name: "dealId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Projections" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/projections/{dealId}/generate": {
      post: {
        tags: ["Investment OS"],
        summary: "Generate Projections",
        parameters: [{ name: "dealId", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/GenerateProjectionsRequest" } } },
        },
        responses: { "201": { description: "Projections generated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/projections/{dealId}/summary": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Projections Summary",
        parameters: [{ name: "dealId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Projections summary" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/comparables/{propertyId}": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Comparables for Property",
        parameters: [{ name: "propertyId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Comparables" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/comparables": {
      post: {
        tags: ["Investment OS"],
        summary: "Add Comparable",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/AddComparableRequest" } } },
        },
        responses: { "201": { description: "Comparable added" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/comparables/{id}": {
      delete: {
        tags: ["Investment OS"],
        summary: "Remove Comparable",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Comparable removed" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/comparables/{propertyId}/adjusted-price": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Adjusted Price",
        parameters: [{ name: "propertyId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Adjusted price" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/insights": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Market Insights",
        parameters: [
          { name: "region", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Market insights" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Investment OS"],
        summary: "Generate Market Insight",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/GenerateInsightRequest" } } },
        },
        responses: { "201": { description: "Insight generated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/insights/{region}": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Insights by Region",
        parameters: [{ name: "region", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Region insights" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/investment-os/insights/{region}/trends": {
      get: {
        tags: ["Investment OS"],
        summary: "Get Market Trends",
        parameters: [
          { name: "region", in: "path", required: true, schema: { type: "string" } },
          { name: "months", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Market trends" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Operations OS
    // ──────────────────────────────────────────────
    "/operations-os/dashboard": {
      get: {
        tags: ["Operations OS"],
        summary: "Operations OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/maintenance": {
      get: {
        tags: ["Operations OS"],
        summary: "List Maintenance Schedules",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Maintenance schedules" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Operations OS"],
        summary: "Create Maintenance Schedule",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateMaintenanceRequest" } } },
        },
        responses: { "201": { description: "Maintenance created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/maintenance/{id}": {
      get: {
        tags: ["Operations OS"],
        summary: "Get Maintenance Schedule",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Maintenance details" }, "404": { description: "Not found" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/maintenance/{id}/complete": {
      post: {
        tags: ["Operations OS"],
        summary: "Complete Maintenance",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", properties: { cost: { type: "number" }, notes: { type: "string" } } } } },
        },
        responses: { "200": { description: "Maintenance completed" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/maintenance/overdue": {
      get: {
        tags: ["Operations OS"],
        summary: "Get Overdue Maintenance",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Overdue maintenance" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/maintenance/property/{propertyId}": {
      get: {
        tags: ["Operations OS"],
        summary: "Get Maintenance by Property",
        parameters: [{ name: "propertyId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Property maintenance" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/vendor-ratings/{vendorId}": {
      get: {
        tags: ["Operations OS"],
        summary: "Get Vendor Rating Summary",
        parameters: [{ name: "vendorId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Vendor rating summary" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/vendor-ratings/{vendorId}/list": {
      get: {
        tags: ["Operations OS"],
        summary: "List Vendor Ratings",
        parameters: [{ name: "vendorId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Vendor ratings list" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/vendor-ratings": {
      post: {
        tags: ["Operations OS"],
        summary: "Rate a Vendor",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateVendorRatingRequest" } } },
        },
        responses: { "201": { description: "Rating created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/inspections": {
      get: {
        tags: ["Operations OS"],
        summary: "List Inspections",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Inspections list" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Operations OS"],
        summary: "Schedule Inspection",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateInspectionRequest" } } },
        },
        responses: { "201": { description: "Inspection scheduled" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/inspections/upcoming": {
      get: {
        tags: ["Operations OS"],
        summary: "Get Upcoming Inspections",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Upcoming inspections" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/inspections/{id}/complete": {
      post: {
        tags: ["Operations OS"],
        summary: "Complete Inspection",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", properties: { result: { type: "string" }, notes: { type: "string" } } } } },
        },
        responses: { "200": { description: "Inspection completed" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/cleaning": {
      get: {
        tags: ["Operations OS"],
        summary: "List Cleaning Schedules",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Cleaning schedules" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Operations OS"],
        summary: "Schedule Cleaning",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateCleaningRequest" } } },
        },
        responses: { "201": { description: "Cleaning scheduled" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/cleaning/upcoming": {
      get: {
        tags: ["Operations OS"],
        summary: "Get Upcoming Cleanings",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Upcoming cleanings" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/operations-os/service-providers": {
      get: {
        tags: ["Operations OS"],
        summary: "List Service Providers",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "category", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Service providers" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Operations OS"],
        summary: "Register Service Provider",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateServiceProviderRequest" } } },
        },
        responses: { "201": { description: "Service provider registered" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Security OS
    // ──────────────────────────────────────────────
    "/security-os/dashboard": {
      get: {
        tags: ["Security OS"],
        summary: "Security OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/kyc": {
      get: {
        tags: ["Security OS"],
        summary: "List KYC Verifications",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "status", in: "query", schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "KYC verifications" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Security OS"],
        summary: "Submit KYC Verification",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/SubmitKycRequest" } } },
        },
        responses: { "201": { description: "KYC submitted" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/kyc/{id}/approve": {
      post: {
        tags: ["Security OS"],
        summary: "Approve KYC",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "KYC approved" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/kyc/{id}/reject": {
      post: {
        tags: ["Security OS"],
        summary: "Reject KYC",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", properties: { reason: { type: "string" } } } } },
        },
        responses: { "200": { description: "KYC rejected" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/fraud": {
      get: {
        tags: ["Security OS"],
        summary: "Get Fraud Alerts",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Fraud alerts" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/fraud/flag": {
      post: {
        tags: ["Security OS"],
        summary: "Flag Suspicious Activity",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/FlagFraudRequest" } } },
        },
        responses: { "201": { description: "Activity flagged" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/fraud/{id}/resolve": {
      post: {
        tags: ["Security OS"],
        summary: "Resolve Fraud Alert",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["resolution"], properties: { resolution: { type: "string" } } } } },
        },
        responses: { "200": { description: "Alert resolved" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/audit": {
      get: {
        tags: ["Security OS"],
        summary: "Get Access Audit Logs",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Audit logs" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/audit/log": {
      post: {
        tags: ["Security OS"],
        summary: "Log Access Event",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/LogAccessEventRequest" } } },
        },
        responses: { "201": { description: "Event logged" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/policies": {
      get: {
        tags: ["Security OS"],
        summary: "List Security Policies",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Security policies" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Security OS"],
        summary: "Create Security Policy",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreatePolicyRequest" } } },
        },
        responses: { "201": { description: "Policy created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/security-os/policies/{id}/toggle": {
      patch: {
        tags: ["Security OS"],
        summary: "Toggle Security Policy",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["isActive"], properties: { isActive: { type: "boolean" } } } } },
        },
        responses: { "200": { description: "Policy toggled" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // User OS
    // ──────────────────────────────────────────────
    "/user-os/dashboard": {
      get: {
        tags: ["User OS"],
        summary: "User OS Dashboard",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/profile": {
      get: {
        tags: ["User OS"],
        summary: "Get User Profile",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "User profile" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      put: {
        tags: ["User OS"],
        summary: "Upsert User Profile",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/UpsertProfileRequest" } } },
        },
        responses: { "200": { description: "Profile upserted" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/identity": {
      get: {
        tags: ["User OS"],
        summary: "Get Identity Providers",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Identity providers" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/identity/link": {
      post: {
        tags: ["User OS"],
        summary: "Link Identity Provider",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/LinkIdentityRequest" } } },
        },
        responses: { "201": { description: "Provider linked" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/identity/{id}": {
      delete: {
        tags: ["User OS"],
        summary: "Unlink Identity Provider",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Provider unlinked" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/sessions": {
      get: {
        tags: ["User OS"],
        summary: "Get User Sessions",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "User sessions" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/sessions/revoke-all": {
      post: {
        tags: ["User OS"],
        summary: "Revoke All Sessions",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["userId"], properties: { userId: { type: "string" } } } } },
        },
        responses: { "200": { description: "All sessions revoked" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/consent": {
      get: {
        tags: ["User OS"],
        summary: "Get User Consents",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "User consents" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/consent/grant": {
      post: {
        tags: ["User OS"],
        summary: "Grant Consent",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/GrantConsentRequest" } } },
        },
        responses: { "200": { description: "Consent granted" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/consent/withdraw": {
      post: {
        tags: ["User OS"],
        summary: "Withdraw Consent",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/WithdrawConsentRequest" } } },
        },
        responses: { "200": { description: "Consent withdrawn" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/consent/bulk": {
      post: {
        tags: ["User OS"],
        summary: "Bulk Grant Consents",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/BulkConsentRequest" } } },
        },
        responses: { "200": { description: "Consents granted" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/journey": {
      get: {
        tags: ["User OS"],
        summary: "Get User Journey",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "User journey" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/journey/advance": {
      post: {
        tags: ["User OS"],
        summary: "Advance Journey Stage",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/AdvanceJourneyRequest" } } },
        },
        responses: { "200": { description: "Journey advanced" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/journey/stats": {
      get: {
        tags: ["User OS"],
        summary: "Get Journey Stats",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Journey stats" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/activity": {
      get: {
        tags: ["User OS"],
        summary: "Get User Activity",
        parameters: [
          { name: "userId", in: "query", required: true, schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "User activity" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/activity/log": {
      post: {
        tags: ["User OS"],
        summary: "Log Activity",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/LogActivityRequest" } } },
        },
        responses: { "200": { description: "Activity logged" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/interests": {
      get: {
        tags: ["User OS"],
        summary: "Get User Interests",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "User interests" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["User OS"],
        summary: "Add Interest",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/AddInterestRequest" } } },
        },
        responses: { "201": { description: "Interest added" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/interests/{id}": {
      delete: {
        tags: ["User OS"],
        summary: "Remove Interest",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Interest removed" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/preferences": {
      get: {
        tags: ["User OS"],
        summary: "Get Category Preferences",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Category preferences" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["User OS"],
        summary: "Set Category Preference",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/SetPreferenceRequest" } } },
        },
        responses: { "200": { description: "Preference set" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/saved-searches": {
      get: {
        tags: ["User OS"],
        summary: "Get Saved Searches",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Saved searches" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["User OS"],
        summary: "Create Saved Search",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateSavedSearchRequest" } } },
        },
        responses: { "201": { description: "Saved search created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/saved-searches/{id}": {
      delete: {
        tags: ["User OS"],
        summary: "Delete Saved Search",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Search deleted" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/recommendations": {
      get: {
        tags: ["User OS"],
        summary: "Get Recommendations",
        parameters: [
          { name: "userId", in: "query", required: true, schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Recommendations" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/recommendations/track": {
      post: {
        tags: ["User OS"],
        summary: "Track Recommendation Interaction",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["id"], properties: { id: { type: "string" } } } } },
        },
        responses: { "200": { description: "Interaction tracked" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/relationships": {
      get: {
        tags: ["User OS"],
        summary: "Get User Relationships",
        parameters: [{ name: "userId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "User relationships" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/notifications": {
      get: {
        tags: ["User OS"],
        summary: "Get Notifications",
        parameters: [
          { name: "userId", in: "query", required: true, schema: { type: "string" } },
          { name: "unreadOnly", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Notifications" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/notifications/read": {
      post: {
        tags: ["User OS"],
        summary: "Mark All Notifications Read",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["userId"], properties: { userId: { type: "string" } } } } },
        },
        responses: { "200": { description: "All notifications read" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/notifications/{id}/read": {
      post: {
        tags: ["User OS"],
        summary: "Mark Notification Read",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Notification read" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/user-os/notifications/{id}/dismiss": {
      post: {
        tags: ["User OS"],
        summary: "Dismiss Notification",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Notification dismissed" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Ads OS
    // ──────────────────────────────────────────────
    "/ads-os/dashboard": {
      get: {
        tags: ["Ads OS"],
        summary: "Ads OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/campaigns": {
      get: {
        tags: ["Ads OS"],
        summary: "List Campaigns",
        parameters: [
          { name: "orgId", in: "query", required: true, schema: { type: "string" } },
          { name: "status", in: "query", schema: { type: "string" } },
          { name: "page", in: "query", schema: { type: "string" } },
          { name: "limit", in: "query", schema: { type: "string" } },
        ],
        responses: { "200": { description: "Paginated campaigns" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Ads OS"],
        summary: "Create Campaign",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateCampaignRequest" } } },
        },
        responses: { "201": { description: "Campaign created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/campaigns/{id}": {
      get: {
        tags: ["Ads OS"],
        summary: "Get Campaign",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Campaign details" }, "404": { description: "Campaign not found" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/campaigns/{id}/activate": {
      post: {
        tags: ["Ads OS"],
        summary: "Activate Campaign",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Campaign activated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/campaigns/{id}/pause": {
      post: {
        tags: ["Ads OS"],
        summary: "Pause Campaign",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Campaign paused" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/campaigns/{id}/complete": {
      post: {
        tags: ["Ads OS"],
        summary: "Complete Campaign",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Campaign completed" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/campaigns/{id}/duplicate": {
      post: {
        tags: ["Ads OS"],
        summary: "Duplicate Campaign",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["name"], properties: { name: { type: "string" } } } } },
        },
        responses: { "201": { description: "Campaign duplicated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/creatives/{campaignId}": {
      get: {
        tags: ["Ads OS"],
        summary: "Get Campaign Creatives",
        parameters: [{ name: "campaignId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Campaign creatives" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/creatives": {
      post: {
        tags: ["Ads OS"],
        summary: "Create Creative",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateCreativeRequest" } } },
        },
        responses: { "201": { description: "Creative created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/segments": {
      get: {
        tags: ["Ads OS"],
        summary: "List Audience Segments",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Audience segments" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Ads OS"],
        summary: "Create Audience Segment",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateSegmentRequest" } } },
        },
        responses: { "201": { description: "Segment created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/segments/ai-generate": {
      post: {
        tags: ["Ads OS"],
        summary: "AI Generate Segment",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/AiGenerateSegmentRequest" } } },
        },
        responses: { "201": { description: "AI segment generated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/channels": {
      get: {
        tags: ["Ads OS"],
        summary: "List Channel Connections",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Channel connections" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/channels/connect": {
      post: {
        tags: ["Ads OS"],
        summary: "Connect Channel",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/ConnectChannelRequest" } } },
        },
        responses: { "201": { description: "Channel connected" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/channels/{id}/disconnect": {
      post: {
        tags: ["Ads OS"],
        summary: "Disconnect Channel",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Channel disconnected" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/budgets/{campaignId}": {
      get: {
        tags: ["Ads OS"],
        summary: "Get Campaign Budget",
        parameters: [{ name: "campaignId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Campaign budget" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/budgets": {
      post: {
        tags: ["Ads OS"],
        summary: "Set Campaign Budget",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/SetBudgetRequest" } } },
        },
        responses: { "200": { description: "Budget set" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/events": {
      post: {
        tags: ["Ads OS"],
        summary: "Track Campaign Event",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/TrackEventRequest" } } },
        },
        responses: { "201": { description: "Event tracked" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/events/stats/{campaignId}": {
      get: {
        tags: ["Ads OS"],
        summary: "Get Event Stats",
        parameters: [{ name: "campaignId", in: "path", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Event stats" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/attribution": {
      get: {
        tags: ["Ads OS"],
        summary: "Get Channel Attribution",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Channel attribution" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Ads OS"],
        summary: "Track Attribution",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/TrackAttributionRequest" } } },
        },
        responses: { "201": { description: "Attribution tracked" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/conversions": {
      get: {
        tags: ["Ads OS"],
        summary: "Get Conversion Funnel",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Conversion funnel" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
      post: {
        tags: ["Ads OS"],
        summary: "Track Conversion",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/TrackConversionRequest" } } },
        },
        responses: { "201": { description: "Conversion tracked" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/ads-os/conversions/roas": {
      get: {
        tags: ["Ads OS"],
        summary: "Get ROAS",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "ROAS data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Booking OS
    // ──────────────────────────────────────────────
    "/booking-os/dashboard": {
      get: {
        tags: ["Booking OS"],
        summary: "Booking OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/booking-os/live-feed": {
      get: {
        tags: ["Booking OS"],
        summary: "Live Feed (IoT Access Logs)",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Live feed data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/booking-os/pricing-engine": {
      get: {
        tags: ["Booking OS"],
        summary: "Pricing Engine Data",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Pricing data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/booking-os/create": {
      post: {
        tags: ["Booking OS"],
        summary: "Create Booking",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateBookingRequest" } } },
        },
        responses: { "201": { description: "Booking created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/booking-os/status/{id}": {
      put: {
        tags: ["Booking OS"],
        summary: "Update Booking Status",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["status"], properties: { status: { type: "string" } } } } },
        },
        responses: { "200": { description: "Booking status updated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Listing OS
    // ──────────────────────────────────────────────
    "/listing-os/dashboard": {
      get: {
        tags: ["Listing OS"],
        summary: "Listing OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/listing-os/create": {
      post: {
        tags: ["Listing OS"],
        summary: "Create Listing",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/CreateListingRequest" } } },
        },
        responses: { "201": { description: "Listing created" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/listing-os/update/{id}": {
      put: {
        tags: ["Listing OS"],
        summary: "Update Listing",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/UpdateListingRequest" } } },
        },
        responses: { "200": { description: "Listing updated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },

    // ──────────────────────────────────────────────
    // Agent OS
    // ──────────────────────────────────────────────
    "/agent-os/dashboard": {
      get: {
        tags: ["Agent OS"],
        summary: "Agent OS Dashboard",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Dashboard data" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/agent-os/network-signals": {
      get: {
        tags: ["Agent OS"],
        summary: "Network Signals (Lead Conversions)",
        parameters: [{ name: "orgId", in: "query", required: true, schema: { type: "string" } }],
        responses: { "200": { description: "Network signals" }, "400": { $ref: "#/components/responses/BadRequest" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/agent-os/register": {
      post: {
        tags: ["Agent OS"],
        summary: "Register Agent",
        requestBody: {
          required: true,
          content: { "application/json": { schema: { $ref: "#/components/schemas/RegisterAgentRequest" } } },
        },
        responses: { "201": { description: "Agent registered" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
    "/agent-os/status/{id}": {
      put: {
        tags: ["Agent OS"],
        summary: "Update Agent Status",
        parameters: [{ name: "id", in: "path", required: true, schema: { type: "string" } }],
        requestBody: {
          required: true,
          content: { "application/json": { schema: { type: "object", required: ["status"], properties: { status: { type: "string" } } } } },
        },
        responses: { "200": { description: "Agent status updated" }, "500": { $ref: "#/components/responses/InternalError" } },
      },
    },
  },

  components: {
    responses: {
      BadRequest: {
        description: "Bad request — missing required parameters",
        content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorResponse" } } },
      },
      InternalError: {
        description: "Internal server error",
        content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorResponse" } } },
      },
    },

    schemas: {
      // ── Common wrappers ─────────────────────────
      SuccessResponse: {
        type: "object",
        properties: {
          success: { type: "boolean", example: true },
          data: { description: "Response payload (varies by endpoint)" },
        },
        required: ["success"],
      },
      ErrorResponse: {
        type: "object",
        properties: {
          success: { type: "boolean", example: false },
          error: { type: "string" },
        },
        required: ["success", "error"],
      },
      PaginatedResponse: {
        type: "object",
        properties: {
          success: { type: "boolean", example: true },
          data: { type: "array", items: {} },
          total: { type: "integer" },
          page: { type: "integer" },
          limit: { type: "integer" },
        },
      },

      // ── User ────────────────────────────────────
      User: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          email: { type: "string", format: "email" },
          name: { type: "string" },
          role: { type: "string" },
          orgId: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },

      // ── Property / Listing ──────────────────────
      Property: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          title: { type: "string" },
          address: { type: "string" },
          orgId: { type: "string" },
          status: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      Listing: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          title: { type: "string" },
          price: { type: "number" },
          propertyId: { type: "string" },
          orgId: { type: "string" },
          status: { type: "string", enum: ["AVAILABLE", "BOOKED", "INACTIVE"] },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateListingRequest: {
        type: "object",
        required: ["title", "price", "orgId", "propertyId"],
        properties: {
          title: { type: "string" },
          price: { type: "number" },
          orgId: { type: "string" },
          propertyId: { type: "string" },
        },
      },
      UpdateListingRequest: {
        type: "object",
        properties: {
          title: { type: "string" },
          price: { type: "number" },
          status: { type: "string" },
        },
      },

      // ── Booking ─────────────────────────────────
      Booking: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          propertyId: { type: "string" },
          guestId: { type: "string" },
          orgId: { type: "string" },
          startDate: { type: "string", format: "date-time" },
          endDate: { type: "string", format: "date-time" },
          status: { type: "string", enum: ["CONFIRMED", "CHECKED_IN", "CHECKED_OUT", "CANCELLED"] },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateBookingRequest: {
        type: "object",
        required: ["propertyId", "guestId", "startDate", "endDate", "orgId"],
        properties: {
          propertyId: { type: "string" },
          guestId: { type: "string" },
          startDate: { type: "string", format: "date" },
          endDate: { type: "string", format: "date" },
          orgId: { type: "string" },
        },
      },

      // ── Deal (Investment) ───────────────────────
      Deal: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          userId: { type: "string" },
          name: { type: "string" },
          propertyId: { type: "string" },
          dealType: { type: "string" },
          investmentAmount: { type: "number" },
          expectedReturn: { type: "number" },
          riskLevel: { type: "string" },
          status: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateDealRequest: {
        type: "object",
        required: ["orgId", "userId", "name"],
        properties: {
          orgId: { type: "string" },
          userId: { type: "string" },
          name: { type: "string" },
          propertyId: { type: "string" },
          dealType: { type: "string" },
          investmentAmount: { type: "number" },
          expectedReturn: { type: "number" },
          riskLevel: { type: "string" },
        },
      },
      UpdateDealRequest: {
        type: "object",
        properties: {
          name: { type: "string" },
          dealType: { type: "string" },
          status: { type: "string" },
          investmentAmount: { type: "number" },
          expectedReturn: { type: "number" },
          riskLevel: { type: "string" },
        },
      },

      // ── Campaign (Ads) ──────────────────────────
      Campaign: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          name: { type: "string" },
          objective: { type: "string" },
          channel: { type: "string" },
          status: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateCampaignRequest: {
        type: "object",
        required: ["orgId", "name"],
        properties: {
          orgId: { type: "string" },
          name: { type: "string" },
          objective: { type: "string" },
          channel: { type: "string" },
        },
      },

      // ── Document ────────────────────────────────
      Document: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          documentType: { type: "string" },
          fileUrl: { type: "string" },
          name: { type: "string" },
          metadata: { type: "object" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateDocumentRequest: {
        type: "object",
        required: ["orgId", "documentType"],
        properties: {
          orgId: { type: "string" },
          documentType: { type: "string" },
          fileUrl: { type: "string" },
          name: { type: "string" },
          metadata: { type: "object" },
        },
      },
      Contract: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          type: { type: "string" },
          title: { type: "string" },
          status: { type: "string" },
          documentUrl: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateContractRequest: {
        type: "object",
        required: ["orgId", "type"],
        properties: {
          orgId: { type: "string" },
          type: { type: "string" },
          title: { type: "string" },
          documentUrl: { type: "string" },
        },
      },

      // ── Notification ────────────────────────────
      Notification: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          title: { type: "string" },
          body: { type: "string" },
          userId: { type: "string" },
          status: { type: "string", enum: ["UNREAD", "READ", "DISMISSED"] },
          ruleKey: { type: "string" },
          data: { type: "object" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateNotificationRequest: {
        type: "object",
        required: ["title", "body"],
        properties: {
          title: { type: "string" },
          body: { type: "string" },
          userId: { type: "string" },
          status: { type: "string" },
          ruleKey: { type: "string" },
          data: { type: "object" },
        },
      },
      SendMessageRequest: {
        type: "object",
        required: ["senderId", "body"],
        properties: {
          senderId: { type: "string" },
          body: { type: "string" },
          threadId: { type: "string" },
          subject: { type: "string" },
        },
      },

      // ── Agent ───────────────────────────────────
      Agent: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          name: { type: "string" },
          email: { type: "string", format: "email" },
          orgId: { type: "string" },
          status: { type: "string", enum: ["ACTIVE", "INACTIVE", "SUSPENDED"] },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      RegisterAgentRequest: {
        type: "object",
        required: ["name", "email", "orgId"],
        properties: {
          name: { type: "string" },
          email: { type: "string", format: "email" },
          orgId: { type: "string" },
        },
      },

      // ── Partner ─────────────────────────────────
      Partner: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          legalName: { type: "string" },
          serviceAreas: { type: "string" },
          defaultCommissionBps: { type: "integer" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreatePartnerRequest: {
        type: "object",
        required: ["orgId", "legalName"],
        properties: {
          orgId: { type: "string" },
          legalName: { type: "string" },
          serviceAreas: { type: "string" },
          defaultCommissionBps: { type: "integer" },
        },
      },
      Agreement: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          partnerId: { type: "string" },
          type: { type: "string" },
          terms: { type: "object" },
          status: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateAgreementRequest: {
        type: "object",
        required: ["partnerId", "type"],
        properties: {
          partnerId: { type: "string" },
          type: { type: "string" },
          terms: { type: "object" },
        },
      },

      // ── Maintenance (Operations) ────────────────
      MaintenanceSchedule: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          propertyId: { type: "string" },
          title: { type: "string" },
          description: { type: "string" },
          scheduledDate: { type: "string", format: "date-time" },
          priority: { type: "string" },
          vendorId: { type: "string" },
          status: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateMaintenanceRequest: {
        type: "object",
        required: ["orgId", "propertyId", "title"],
        properties: {
          orgId: { type: "string" },
          propertyId: { type: "string" },
          title: { type: "string" },
          description: { type: "string" },
          scheduledDate: { type: "string", format: "date" },
          priority: { type: "string" },
          vendorId: { type: "string" },
        },
      },

      // ── Inspection (Operations) ─────────────────
      CreateInspectionRequest: {
        type: "object",
        required: ["orgId", "propertyId", "inspectionType"],
        properties: {
          orgId: { type: "string" },
          propertyId: { type: "string" },
          inspectionType: { type: "string" },
          scheduledDate: { type: "string", format: "date" },
          inspectorId: { type: "string" },
        },
      },

      // ── Cleaning (Operations) ───────────────────
      CreateCleaningRequest: {
        type: "object",
        required: ["orgId", "propertyId"],
        properties: {
          orgId: { type: "string" },
          propertyId: { type: "string" },
          scheduledDate: { type: "string", format: "date" },
          cleanerId: { type: "string" },
          notes: { type: "string" },
        },
      },

      // ── Vendor Rating (Operations) ──────────────
      VendorRating: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          vendorId: { type: "string" },
          rating: { type: "number" },
          review: { type: "string" },
          userId: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateVendorRatingRequest: {
        type: "object",
        required: ["orgId", "vendorId", "rating"],
        properties: {
          orgId: { type: "string" },
          vendorId: { type: "string" },
          rating: { type: "number", minimum: 1, maximum: 5 },
          review: { type: "string" },
          userId: { type: "string" },
        },
      },

      // ── Service Provider (Operations) ───────────
      ServiceProvider: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          name: { type: "string" },
          category: { type: "string" },
          phone: { type: "string" },
          email: { type: "string" },
          rating: { type: "number" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateServiceProviderRequest: {
        type: "object",
        required: ["orgId", "name", "category"],
        properties: {
          orgId: { type: "string" },
          name: { type: "string" },
          category: { type: "string" },
          phone: { type: "string" },
          email: { type: "string" },
          rating: { type: "number" },
        },
      },

      // ── KYC (Security) ──────────────────────────
      KycVerification: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          userId: { type: "string" },
          orgId: { type: "string" },
          documentType: { type: "string" },
          documentNumber: { type: "string" },
          status: { type: "string", enum: ["PENDING", "APPROVED", "REJECTED"] },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      SubmitKycRequest: {
        type: "object",
        required: ["userId", "orgId", "documentType"],
        properties: {
          userId: { type: "string" },
          orgId: { type: "string" },
          documentType: { type: "string" },
          documentNumber: { type: "string" },
          documentUrl: { type: "string" },
        },
      },

      // ── Fraud (Security) ────────────────────────
      FraudAlert: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          entityType: { type: "string" },
          entityId: { type: "string" },
          riskLevel: { type: "string" },
          description: { type: "string" },
          status: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      FlagFraudRequest: {
        type: "object",
        required: ["orgId", "entityType", "entityId", "riskLevel", "description"],
        properties: {
          orgId: { type: "string" },
          entityType: { type: "string" },
          entityId: { type: "string" },
          riskLevel: { type: "string" },
          description: { type: "string" },
        },
      },

      // ── Audit (Security) ────────────────────────
      AuditLog: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          userId: { type: "string" },
          action: { type: "string" },
          resource: { type: "string" },
          resourceId: { type: "string" },
          ipAddress: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      LogAccessEventRequest: {
        type: "object",
        required: ["orgId", "userId", "action", "resource"],
        properties: {
          orgId: { type: "string" },
          userId: { type: "string" },
          action: { type: "string" },
          resource: { type: "string" },
          resourceId: { type: "string" },
          ipAddress: { type: "string" },
        },
      },

      // ── Policy (Security) ───────────────────────
      SecurityPolicy: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          name: { type: "string" },
          description: { type: "string" },
          policyType: { type: "string" },
          isActive: { type: "boolean" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreatePolicyRequest: {
        type: "object",
        required: ["orgId", "name", "policyType"],
        properties: {
          orgId: { type: "string" },
          name: { type: "string" },
          description: { type: "string" },
          policyType: { type: "string" },
        },
      },

      // ── Analytics ───────────────────────────────
      AnalyticsRecord: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          entityId: { type: "string" },
          entityType: { type: "string" },
          type: { type: "string" },
          data: { type: "object" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateAnalyticsRequest: {
        type: "object",
        required: ["orgId", "entityId", "entityType", "type"],
        properties: {
          orgId: { type: "string" },
          entityId: { type: "string" },
          entityType: { type: "string" },
          type: { type: "string" },
          data: { type: "object" },
        },
      },
      Report: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          userId: { type: "string" },
          name: { type: "string" },
          reportType: { type: "string" },
          config: { type: "object" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateReportRequest: {
        type: "object",
        required: ["orgId", "userId", "name", "reportType"],
        properties: {
          orgId: { type: "string" },
          userId: { type: "string" },
          name: { type: "string" },
          reportType: { type: "string" },
          config: { type: "object" },
        },
      },

      // ── Compliance (Governance) ─────────────────
      ComplianceRecord: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          type: { type: "string" },
          entityId: { type: "string" },
          entityType: { type: "string" },
          status: { type: "string" },
          notes: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateComplianceRecordRequest: {
        type: "object",
        required: ["type", "entityId", "entityType"],
        properties: {
          type: { type: "string" },
          entityId: { type: "string" },
          entityType: { type: "string" },
          status: { type: "string" },
          notes: { type: "string" },
        },
      },

      // ── API Key (Developer) ─────────────────────
      ApiKey: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          name: { type: "string" },
          scopes: { type: "array", items: { type: "string" } },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateApiKeyRequest: {
        type: "object",
        required: ["orgId", "name"],
        properties: {
          orgId: { type: "string" },
          name: { type: "string" },
          scopes: { type: "array", items: { type: "string" } },
        },
      },

      // ── Webhook (Developer) ─────────────────────
      Webhook: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          url: { type: "string", format: "uri" },
          events: { type: "array", items: { type: "string" } },
          secret: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateWebhookRequest: {
        type: "object",
        required: ["orgId", "url", "events"],
        properties: {
          orgId: { type: "string" },
          url: { type: "string", format: "uri" },
          events: { type: "array", items: { type: "string" } },
          secret: { type: "string" },
        },
      },

      // ── Exchange Rate (Localization) ────────────
      ExchangeRate: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          baseCurrency: { type: "string" },
          quoteCurrency: { type: "string" },
          rate: { type: "number" },
          source: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateExchangeRateRequest: {
        type: "object",
        required: ["orgId", "baseCurrency", "quoteCurrency", "rate"],
        properties: {
          orgId: { type: "string" },
          baseCurrency: { type: "string" },
          quoteCurrency: { type: "string" },
          rate: { type: "number" },
          source: { type: "string" },
        },
      },

      // ── Investment Projections ───────────────────
      GenerateProjectionsRequest: {
        type: "object",
        properties: {
          years: { type: "integer" },
          annualGrowthRate: { type: "number" },
          rentalYield: { type: "number" },
        },
      },

      // ── Comparables (Investment) ─────────────────
      Comparable: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          propertyId: { type: "string" },
          comparablePropertyId: { type: "string" },
          address: { type: "string" },
          price: { type: "number" },
          squareFootage: { type: "number" },
          bedrooms: { type: "integer" },
          bathrooms: { type: "number" },
          distance: { type: "number" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      AddComparableRequest: {
        type: "object",
        required: ["propertyId"],
        properties: {
          propertyId: { type: "string" },
          comparablePropertyId: { type: "string" },
          address: { type: "string" },
          price: { type: "number" },
          squareFootage: { type: "number" },
          bedrooms: { type: "integer" },
          bathrooms: { type: "number" },
          distance: { type: "number" },
        },
      },

      // ── Market Insight (Investment) ─────────────
      MarketInsight: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          region: { type: "string" },
          type: { type: "string" },
          data: { type: "object" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      GenerateInsightRequest: {
        type: "object",
        required: ["region"],
        properties: {
          region: { type: "string" },
          type: { type: "string" },
          period: { type: "string" },
        },
      },

      // ── User OS specific ────────────────────────
      UpsertProfileRequest: {
        type: "object",
        required: ["userId"],
        properties: {
          userId: { type: "string" },
          name: { type: "string" },
          email: { type: "string", format: "email" },
          phone: { type: "string" },
          avatarUrl: { type: "string" },
        },
      },
      LinkIdentityRequest: {
        type: "object",
        required: ["userId", "provider", "providerId"],
        properties: {
          userId: { type: "string" },
          provider: { type: "string" },
          providerId: { type: "string" },
        },
      },
      GrantConsentRequest: {
        type: "object",
        required: ["userId", "consentType", "granted"],
        properties: {
          userId: { type: "string" },
          consentType: { type: "string" },
          granted: { type: "boolean" },
        },
      },
      WithdrawConsentRequest: {
        type: "object",
        required: ["userId", "consentType"],
        properties: {
          userId: { type: "string" },
          consentType: { type: "string" },
        },
      },
      BulkConsentRequest: {
        type: "object",
        required: ["userId", "consents"],
        properties: {
          userId: { type: "string" },
          consents: {
            type: "array",
            items: {
              type: "object",
              required: ["consentType", "granted"],
              properties: {
                consentType: { type: "string" },
                granted: { type: "boolean" },
              },
            },
          },
        },
      },
      AdvanceJourneyRequest: {
        type: "object",
        required: ["userId", "stage"],
        properties: {
          userId: { type: "string" },
          stage: { type: "string" },
        },
      },
      LogActivityRequest: {
        type: "object",
        required: ["userId", "action"],
        properties: {
          userId: { type: "string" },
          action: { type: "string" },
          metadata: { type: "object" },
        },
      },
      AddInterestRequest: {
        type: "object",
        required: ["userId", "category"],
        properties: {
          userId: { type: "string" },
          category: { type: "string" },
          subcategory: { type: "string" },
          priority: { type: "integer" },
        },
      },
      SetPreferenceRequest: {
        type: "object",
        required: ["userId", "category", "weight"],
        properties: {
          userId: { type: "string" },
          category: { type: "string" },
          weight: { type: "number" },
        },
      },
      CreateSavedSearchRequest: {
        type: "object",
        required: ["userId", "name", "filters"],
        properties: {
          userId: { type: "string" },
          name: { type: "string" },
          filters: { type: "object" },
          alertEnabled: { type: "boolean" },
        },
      },

      // ── Ads OS specific ─────────────────────────
      Creative: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          campaignId: { type: "string" },
          title: { type: "string" },
          bodyText: { type: "string" },
          imageUrl: { type: "string" },
          ctaType: { type: "string" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateCreativeRequest: {
        type: "object",
        required: ["campaignId", "title"],
        properties: {
          campaignId: { type: "string" },
          title: { type: "string" },
          bodyText: { type: "string" },
          imageUrl: { type: "string" },
          ctaType: { type: "string" },
        },
      },
      AudienceSegment: {
        type: "object",
        properties: {
          id: { type: "string", format: "uuid" },
          orgId: { type: "string" },
          name: { type: "string" },
          criteria: { type: "object" },
          createdAt: { type: "string", format: "date-time" },
        },
      },
      CreateSegmentRequest: {
        type: "object",
        required: ["orgId", "name", "criteria"],
        properties: {
          orgId: { type: "string" },
          name: { type: "string" },
          criteria: { type: "object" },
        },
      },
      AiGenerateSegmentRequest: {
        type: "object",
        required: ["orgId", "criteria"],
        properties: {
          orgId: { type: "string" },
          criteria: { type: "object" },
        },
      },
      ConnectChannelRequest: {
        type: "object",
        required: ["orgId", "channel", "config"],
        properties: {
          orgId: { type: "string" },
          channel: { type: "string" },
          config: { type: "object" },
        },
      },
      SetBudgetRequest: {
        type: "object",
        required: ["campaignId", "dailyBudget", "totalBudget"],
        properties: {
          campaignId: { type: "string" },
          dailyBudget: { type: "number" },
          totalBudget: { type: "number" },
          currency: { type: "string" },
        },
      },
      TrackEventRequest: {
        type: "object",
        required: ["campaignId", "eventType"],
        properties: {
          campaignId: { type: "string" },
          eventType: { type: "string" },
          metadata: { type: "object" },
        },
      },
      TrackAttributionRequest: {
        type: "object",
        required: ["orgId", "channel", "eventType"],
        properties: {
          orgId: { type: "string" },
          channel: { type: "string" },
          eventType: { type: "string" },
          campaignId: { type: "string" },
        },
      },
      TrackConversionRequest: {
        type: "object",
        required: ["orgId", "metricType", "value"],
        properties: {
          orgId: { type: "string" },
          metricType: { type: "string" },
          value: { type: "number" },
          campaignId: { type: "string" },
        },
      },
    },
  },
} as const;
