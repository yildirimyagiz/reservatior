import { Elysia } from "elysia";
import { cron } from "@elysiajs/cron";
import { prismaManager } from "../lib/prisma";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";
import { MarketplaceEngine } from "../services/ai/marketplace-engine";
import { NotificationDispatcher } from "../services/notification-dispatcher";
import { rabbitMQService } from "../services/rabbitmq-service";
import { AISocialParser } from "../services/ai/ai-social-parser";
import { SmartMatcher } from "../services/matchmaking/smart-matcher";
import { SmartPricingUpdater } from "../workers/handlers/smart-pricing-updater";
import { AIArbitrageScanner } from "../workers/handlers/ai-arbitrage-scanner";
import { AutoPayoutDispatcher } from "../workers/handlers/auto-payout-dispatcher";
import { GuestCommunicationBot } from "../workers/handlers/guest-communication-bot";
import { ReviewSentimentTracker } from "../workers/handlers/review-sentiment-tracker";

export const systemCronRoutes = new Elysia({ prefix: "/system-cron" })
  .use(
    cron({
      name: 'frequent-notification-dispatcher',
      pattern: '*/15 * * * *', // Every 15 minutes
      async run() {
        console.log("[CRON] Running frequent notification dispatcher...");
        await NotificationDispatcher.processUndeliveredNotifications();
      }
    })
  )
  .use(
    cron({
      name: 'hourly-doping-checker',
      pattern: '0 * * * *', // Every hour
      async run() {
        console.log("[CRON] Checking for expired property promotions (Dopings)...");
        const db = prismaManager.getClient();
        
        try {
          const now = new Date();
          const expiredPromotions = await db.propertyPromotion.findMany({
            where: {
              status: "ACTIVE",
              endDate: { lte: now }
            },
            include: { Agency: true }
          });

          for (const promo of expiredPromotions) {
            if (promo.isAutoRenew) {
              // Automatically renew for another 7 days
              const nextWeek = new Date(now);
              nextWeek.setDate(nextWeek.getDate() + 7);
              
              await db.propertyPromotion.update({
                where: { id: promo.id },
                data: { endDate: nextWeek, updatedAt: now }
              });

              if (promo.userId || promo.Agency?.ownerId) {
                await db.notification.create({
                  data: {
                    title: "🚀 Promotion Auto-Renewed",
                    body: `Your property promotion for listing ${promo.propertyId} has been auto-renewed until ${nextWeek.toLocaleDateString()}.`,
                    status: "QUEUED",
                    userId: promo.userId || promo.Agency?.ownerId || "",
                    orgId: promo.Agency?.organizationId || "system"
                  }
                });
              }
            } else {
              // Mark as expired
              await db.propertyPromotion.update({
                where: { id: promo.id },
                data: { status: "EXPIRED", updatedAt: now }
              });

              if (promo.userId || promo.Agency?.ownerId) {
                await db.notification.create({
                  data: {
                    title: "⚠️ Promotion Expired",
                    body: `Your property promotion for listing ${promo.propertyId} has expired. Buy a new doping to stay at the top!`,
                    status: "QUEUED",
                    userId: promo.userId || promo.Agency?.ownerId || "",
                    orgId: promo.Agency?.organizationId || "system"
                  }
                });
              }
            }
          }
        } catch (err) {
          console.error("[CRON] Hourly doping check failed:", err);
        }
      }
    })
  )
  .use(
    cron({
      name: 'daily-mls-sync-publisher',
      pattern: '0 2 * * *', // Every night at 2:00 AM
      async run() {
        console.log("[CRON] Initiating Daily MLS Sync to RabbitMQ...");
        const db = prismaManager.getClient();

        try {
          const connections = await db.mLSConnection.findMany({
            where: { isEnabled: true }
          });

          for (const conn of connections) {
            console.log(`[CRON] Creating sync job for MLS Provider: ${conn.provider}`);
            const job = await db.mLSSyncJob.create({
              data: {
                orgId: conn.orgId,
                connectionId: conn.id,
                status: "RUNNING",
                startedAt: new Date()
              }
            });

            // Mock fetching thousands of listings from an external MLS API
            // In reality, you'd fetch from a RESO Web API
            const mockExtListings = Array.from({ length: 50 }).map((_, i) => ({
              connectionId: conn.id,
              orgId: conn.orgId,
              mlsNumber: `MLS-${conn.provider}-${i}-${Date.now()}`,
              status: "Active",
              price: 250000 + (Math.random() * 500000),
              photos: ["https://example.com/photo1.jpg"],
              syncJobId: job.id
            }));

            // Publish each listing to RabbitMQ for individual processing
            for (const listing of mockExtListings) {
              await rabbitMQService.publishToQueue('mls_sync_queue', listing);
            }

            console.log(`[CRON] Queued ${mockExtListings.length} items for processing in MLS Connection ${conn.id}.`);
          }
        } catch (err) {
          console.error("[CRON] Daily MLS Sync failed:", err);
        }
      }
    })
  )
  .use(
    cron({
      name: 'midnight-system-checks',
      // Run every midnight
      pattern: '0 0 * * *',
      async run() {
        console.log("[CRON] Running nightly system checks...");
        const db = prismaManager.getClient();

        try {
          // ============================================
          // 1. Escrow Auto-Release Check (72 hours post check-in)
          // ============================================
          const activeEscrows = await db.escrowAccount.findMany({
            where: { status: 'HOLDING' },
            include: { reservation: true }
          });

          for (const escrow of activeEscrows) {
            if (!(escrow as any).reservation?.checkInDate) continue;

            const checkIn = new Date((escrow as any).reservation.checkInDate).getTime();
            const now = Date.now();
            const hoursSinceCheckIn = (now - checkIn) / (1000 * 60 * 60);

            if (hoursSinceCheckIn >= 72) {
              console.log(`[CRON] Processing Escrow release for Reservation: ${escrow.reservationId}`);
              
              const payout = await MarketplaceEngine.evaluateEscrowPayout(
                escrow.reservationId,
                false
              );

              if (payout.status === 'FULLY_RELEASED') {
                await db.auditLog.create({
                  data: {
                    action: "ESCROW_AUTO_RELEASED",
                    entityType: "EscrowAccount",
                    entityId: escrow.id,
                    newValues: { details: payout.details },
                    orgId: escrow.orgId
                  }
                });
              }
            }
          }

          // ============================================
          // 2. Rent Arrears Nightly Check
          // ============================================
          const activeRentSchedules = await db.rentSchedule.findMany({
            where: { status: 'UNPAID' }
          });

          for (const schedule of activeRentSchedules) {
            const dueDate = new Date(schedule.dueDate).getTime();
            const now = Date.now();

            if (now > dueDate) {
              await db.rentSchedule.update({
                where: { id: schedule.id },
                data: { status: 'OVERDUE' }
              });

              const lease = await db.lease.findUnique({ where: { id: schedule.leaseId } });
              
              if (lease && lease.tenantId) {
                MLBridgeService.sendFeedback("tenant-screening", "RENT_ARREARS_DETECTED", -10.0, {
                  userId: lease.tenantId,
                  leaseId: lease.id,
                  scheduleId: schedule.id
                }).catch(console.error);

                await db.notification.create({
                  data: {
                    title: "Rent Overdue Notice",
                    body: `Your rent payment of ${schedule.amount} is now overdue. Please pay immediately to avoid late fees and AI score penalties.`,
                    status: "QUEUED",
                    userId: lease.tenantId,
                    orgId: schedule.orgId
                  }
                });
              }
            }
          }

          // ============================================
          // 3. Agent/Agency Subscription Expiry Reminders
          // ============================================
          const sevenDaysFromNow = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);
          const today = new Date();

          // Find subscriptions expiring within 7 days
          const expiringSubscriptions = await db.subscription.findMany({
            where: {
              isActive: true,
              updatedAt: {
                // Subscriptions whose billing cycle anniversary is within the next 7 days
                lte: sevenDaysFromNow
              }
            },
            include: {
              agents: { select: { id: true, ownerId: true, name: true } },
              agencies: { select: { id: true, ownerId: true, name: true } }
            }
          }).catch(() => []);

          for (const sub of expiringSubscriptions) {
            // Calculate next billing date based on billingCycle
            const lastUpdated = new Date(sub.updatedAt);
            let nextBillingDate: Date;
            if (sub.billingCycle === "MONTHLY") {
              nextBillingDate = new Date(lastUpdated);
              nextBillingDate.setMonth(nextBillingDate.getMonth() + 1);
            } else if (sub.billingCycle === "YEARLY") {
              nextBillingDate = new Date(lastUpdated);
              nextBillingDate.setFullYear(nextBillingDate.getFullYear() + 1);
            } else {
              continue; // Unknown billing cycle
            }

            const daysUntilRenewal = Math.ceil((nextBillingDate.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));

            if (daysUntilRenewal <= 7 && daysUntilRenewal > 0) {
              console.log(`[CRON] Subscription ${sub.id} renews in ${daysUntilRenewal} days`);

              // Notify linked agents
              for (const agent of (sub as any).agents || []) {
                if (agent.ownerId) {
                  await db.notification.create({
                    data: {
                      title: "🔔 Subscription Renewal Reminder",
                      body: `Your ${sub.type} subscription (${sub.price} ${sub.currency}/${sub.billingCycle}) will renew in ${daysUntilRenewal} days on ${nextBillingDate.toLocaleDateString()}.`,
                      status: "QUEUED",
                      userId: agent.ownerId,
                      orgId: sub.orgId
                    }
                  }).catch(console.warn);
                }
              }

              // Notify linked agency owners
              for (const agency of (sub as any).agencies || []) {
                if (agency.ownerId) {
                  await db.notification.create({
                    data: {
                      title: "🔔 Agency Subscription Renewal",
                      body: `Your agency "${agency.name}" subscription (${sub.type}) renews in ${daysUntilRenewal} days. Amount: ${sub.price} ${sub.currency}.`,
                      status: "QUEUED",
                      userId: agency.ownerId,
                      orgId: sub.orgId
                    }
                  }).catch(console.warn);
                }
              }

              await db.auditLog.create({
                data: {
                  action: "SUBSCRIPTION_RENEWAL_REMINDER",
                  entityType: "Subscription",
                  entityId: sub.id,
                  newValues: { details: `Renewal reminder sent. Renews in ${daysUntilRenewal} days. Amount: ${sub.price} ${sub.currency}/${sub.billingCycle}.` },
                  orgId: sub.orgId
                }
              }).catch(console.warn);
            }
          }

          // ============================================
          // 4. Commission Overdue Scanner (30+ days PENDING)
          // ============================================
          const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);

          const overdueCommissions = await db.commission.findMany({
            where: {
              status: "PENDING",
              createdAt: { lt: thirtyDaysAgo }
            },
            include: {
              agent: { select: { id: true, ownerId: true, name: true } },
              agency: { select: { id: true, ownerId: true, name: true } }
            }
          }).catch(() => []);

          for (const commission of overdueCommissions) {
            // Auto-mark as OVERDUE
            await db.commission.update({
              where: { id: commission.id },
              data: { status: "HOLDBACK" }
            }).catch(console.warn);

            MLBridgeService.sendFeedback("commission-tracking", "COMMISSION_AUTO_OVERDUE", -3.0, {
              commissionId: commission.id,
              agentId: commission.agentId,
              agencyId: commission.agencyId,
              amount: Number(commission.commissionAmount),
              daysPending: Math.ceil((Date.now() - new Date(commission.createdAt).getTime()) / (1000 * 60 * 60 * 24))
            }).catch(console.error);

            // Notify the agent
            if (commission.agent?.ownerId) {
              await db.notification.create({
                data: {
                  title: "⚠️ Commission Payment Overdue",
                  body: `Your commission of ${commission.commissionAmount} ${commission.currency} has been pending for over 30 days and is now marked OVERDUE. Agency: ${commission.agency?.name || "N/A"}.`,
                  status: "QUEUED",
                  userId: commission.agent.ownerId,
                  orgId: commission.orgId
                }
              }).catch(console.warn);
            }

            // Also notify the agency owner
            if (commission.agency?.ownerId) {
              await db.notification.create({
                data: {
                  title: "⚠️ Unpaid Agent Commission",
                  body: `Commission of ${commission.commissionAmount} ${commission.currency} for agent "${commission.agent?.name || "Unknown"}" has been PENDING for 30+ days. Please process payment.`,
                  status: "QUEUED",
                  userId: commission.agency.ownerId,
                  orgId: commission.orgId
                }
              }).catch(console.warn);
            }

            await db.auditLog.create({
              data: {
                action: "COMMISSION_AUTO_OVERDUE",
                entityType: "Commission",
                entityId: commission.id,
                newValues: { details: `Commission auto-flagged OVERDUE after 30+ days PENDING. Agent: ${commission.agentId}, Amount: ${commission.commissionAmount} ${commission.currency}.` },
                orgId: commission.orgId
              }
            }).catch(console.warn);
          }

          // ============================================
          // 5. Visibility Budget Nightly Decay (Continuous Regeneration)
          // ============================================
          console.log("[CRON] Applying nightly decay to Visibility Budgets for smooth regeneration...");
          const { agentMatchingService } = await import("../../src/services/agent-matching");
          await agentMatchingService.decayVisibilityBudgets(0.85).catch(console.warn);

          console.log("[CRON] Nightly system checks completed successfully.");
        } catch (error) {
          console.error("[CRON] Nightly system check failed:", error);
        }
      }
    })
  )
  .use(
    cron({
      name: 'social-inbound-matchmaker',
      pattern: '*/5 * * * *', // Run every 5 minutes
      async run() {
        console.log("[CRON] Running Social Inbound Message Matchmaker...");
        const regions = ["TR", "AE"];
        
        for (const region of regions) {
          try {
            const db = prismaManager.getClient(region);
            const pendingMessages = await db.socialInboundMessage.findMany({
              where: { status: "PENDING" },
              take: 20
            });

            if (pendingMessages.length === 0) continue;

            console.log(`[CRON] Found ${pendingMessages.length} pending inbound messages in region [${region}]`);

            for (const msg of pendingMessages) {
              try {
                console.log(`[CRON] Processing message: "${msg.messageText.substring(0, 50)}..."`);
                const parsedResult = await AISocialParser.parseMessage(msg.messageText);
                await SmartMatcher.processParsedMessage(msg.externalSenderId, parsedResult, msg.id);
              } catch (msgErr: any) {
                console.error(`[CRON] Error processing message ${msg.id}:`, msgErr.message);
              }
            }
          } catch (regionErr: any) {
            console.error(`[CRON] Failed to connect or query region [${region}]:`, regionErr.message);
          }
        }
      }
    })
  )
  .use(
    cron({
      name: 'daily-smart-pricing',
      pattern: '0 3 * * *', // Every night at 3:00 AM
      async run() {
        await SmartPricingUpdater.executeDailyUpdate();
      }
    })
  )
  .use(
    cron({
      name: 'hourly-arbitrage-scanner',
      pattern: '0 * * * *', // Every hour
      async run() {
        await AIArbitrageScanner.executeHourlyScan();
      }
    })
  )
  .use(
    cron({
      name: 'nightly-payout-dispatcher',
      pattern: '30 2 * * *', // Every night at 2:30 AM
      async run() {
        await AutoPayoutDispatcher.executeNightlyPayouts();
      }
    })
  )
  .use(
    cron({
      name: 'hourly-guest-communication',
      pattern: '15 * * * *', // Every hour at :15
      async run() {
        await GuestCommunicationBot.executeHourlyComms();
      }
    })
  )
  .use(
    cron({
      name: 'frequent-review-scanner',
      pattern: '*/10 * * * *', // Every 10 minutes
      async run() {
        await ReviewSentimentTracker.executeFrequentReviewScan();
      }
    })
  );
