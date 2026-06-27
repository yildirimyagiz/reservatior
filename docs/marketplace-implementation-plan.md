# Implementation Plan - Autonomous Operational Tracking via Gemini AI

This plan outlines the design and integration of `GeminiOpsNotificationCoordinator`, a service powered by Google Gemini AI (`gemini-2.5-flash`) that tracks operational state changes (task compliance, physical inspections, police reporting, bank escrows, and host penalties) to autonomously generate and deliver context-rich, multilingual notifications and chat messages.

---

## User Review Required

> [!IMPORTANT]
> - **Autonomous Execution Triggers:** We propose registering asynchronous hooks inside key routes (`task.ts`, `escrow-account.ts`, `police-report.ts`) so that any state change immediately runs the Gemini audit tracker without slowing down the initial write.
> - **Multilingual Support:** The AI will generate both Turkish and English variations of all notifications and chat logs so that stakeholders (B2B Travel Agencies, local Hosts/Emlakçı, and B2C Guests) receive updates in their preferred language.
> - **Urgency Levels:** Gemini will tag notifications as `INFO`, `WARNING`, or `CRITICAL`. We will style these warnings differently on the client dashboard and mobile screens to represent AI Audit alerts.

---

## Open Questions

> [!WARNING]
> 1. **Trigger Mechanism:** Should we run the Gemini audit synchronously in the route handlers (returning the generated alert immediately in the response) or asynchronously in the background so it doesn't block API response times? (Recommended: Asynchronously in the background).
> 2. **Mock Fallback:** When the Gemini API key is missing or rate-limited, should the service fall back to a localized template generator, or log a warning and skip creation? (Recommended: Fall back to localized templates).

---

## Proposed Changes

### Backend Component (`server`)

#### [NEW] [gemini-ops-coordinator.ts](file:///Users/os2026/Downloads/Reservatior/server/src/services/ai/gemini-ops-coordinator.ts)
Create a central service to coordinate operations and compile AI audits:
- **`trackTaskGPS(taskId: string)`**: Triggered when a physical inspection task finishes. If coordinates do not match the property location (`gpsVerified = false` or `photoLocationMatch = false`), Gemini writes a warning message to the host and agency.
- **`trackKbsStatus(logId: string)`**: Triggered on KBS log updates. If status is `FAILED`, Gemini drafts a checklist detailing why the jandarma/polis submission failed (e.g. document number mismatch, passport expired) and actions needed.
- **`trackEscrowChange(escrowId: string)`**: Triggered on bank escrow blockages (`HOLDING`), pending releases, or disputes. Alerts the host when funds are locked/unlocked or if a dispute is registered.
- **`trackHostPenalty(penaltyId: string)`**: Triggered when a `HostPenalty` is logged. Translates the penalty explanation, details relocation costs, and drafts B2B communication warning the host.
- Each method triggers a prompt to `gemini-2.5-flash` to return:
  ```json
  {
    "b2b": {
      "tr": { "title": "...", "body": "..." },
      "en": { "title": "...", "body": "..." },
      "urgency": "INFO | WARNING | CRITICAL"
    },
    "b2c": {
      "tr": { "title": "...", "body": "..." },
      "en": { "title": "...", "body": "..." },
      "urgency": "INFO | WARNING | CRITICAL"
    },
    "chatMessage": {
      "tr": "...",
      "en": "..."
    },
    "recommendedAction": "verify_gps | update_document | check_escrow | dispute_penalty"
  }
  ```
- Automatically creates records in `Notification` and `Message` tables matching the outputs.

#### [MODIFY] [routes/ai.ts](file:///Users/os2026/Downloads/Reservatior/server/src/routes/ai.ts)
- Add a new route `POST /ai/ops-track/trigger` to manually test/trigger autonomous tracking audits for a given resource ID (task, escrow, KBS log, or host penalty).

#### [MODIFY] [routes/task.ts](file:///Users/os2026/Downloads/Reservatior/server/src/routes/task.ts)
- Hook the patch/update endpoints to trigger `GeminiOpsNotificationCoordinator.trackTaskGPS(taskId)` when a task is completed.

#### [MODIFY] [routes/escrow-account.ts](file:///Users/os2026/Downloads/Reservatior/server/src/routes/escrow-account.ts)
- Hook the create/update endpoints to trigger `GeminiOpsNotificationCoordinator.trackEscrowChange(escrowId)`.

#### [MODIFY] [routes/police-report.ts](file:///Users/os2026/Downloads/Reservatior/server/src/routes/police-report.ts)
- Hook the create/update endpoints to trigger `GeminiOpsNotificationCoordinator.trackKbsStatus(logId)`.

---

### Client Component (`client`)

#### [MODIFY] [Notifications.tsx](file:///Users/os2026/Downloads/Reservatior/client/src/pages/client/notifications/Notifications.tsx)
- Render custom styles for AI Audit notifications:
  - Add visual tags/badges for `AI Audit` (using sleek glassmorphic icons).
  - Use custom color treatments (amber for `WARNING`, red for `CRITICAL`) with micro-animations.

---

### Mobile Component (`mobile`)

We will ensure notifications and chat threads support displaying the new structured properties from the database seamlessly.

---

## Verification Plan

### Automated Tests
- Build and run code check:
  ```bash
  bun run build
  ```
- Create a test script `/Users/os2026/Downloads/Reservatior/server/src/services/ai/test-ops-coordinator.ts` to mock operations events and run them against Gemini, ensuring it returns correctly structured responses and inserts records into the database.

### Manual Verification
- Trigger test audits using the route `POST /ai/ops-track/trigger` and verify notifications appear on the client interface with correct styling and translations.
