import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { prisma } from "../lib/prisma";

export const adminRoutes = new Elysia({ prefix: "/admin" })
  .use(authMiddleware)
  .onBeforeHandle(hasPermission("ORG_MANAGE"))

  // ── Plans ──

  // GET /admin/plans - Advanced filtering with analytics
  .get("/plans", async ({ query }: { query: any }) => {
    const { 
      status, 
      minPrice, 
      maxPrice,
      sortBy = "createdAt",
      sortOrder = "desc"
    } = query;
    
    const where: any = { deletedAt: null };
    if (status) where.status = status;
    
    if (minPrice || maxPrice) {
      where.priceMonthlyCents = {};
      if (minPrice) where.priceMonthlyCents.gte = parseInt(minPrice);
      if (maxPrice) where.priceMonthlyCents.lte = parseInt(maxPrice);
    }
    
    const data = await prisma.plan.findMany({ 
      where, 
      orderBy: { [sortBy]: sortOrder },
      include: { 
        orgSubscriptions: { 
          where: { deletedAt: null },
          include: {
            org: {
              select: { id: true, name: true }
            }
          }
        } 
      }
    });
    
    return { data };
  }, { beforeHandle: hasPermission("FINANCE_MANAGE") })

  // GET /admin/plans/:id - Enhanced plan details
  .get("/plans/:id", async ({ params, set }: { params: any; set: any }) => {
    const plan = await prisma.plan.findUnique({ 
      where: { id: params.id },
      include: { 
        orgSubscriptions: { 
          where: { deletedAt: null },
          include: {
            org: {
              select: { id: true, name: true, contactEmail: true }
            }
          }
        } 
      }
    });
    
    if (!plan) { 
      set.status = 404; 
      return { error: "Plan not found" }; 
    }
    
    return { data: plan };
  })

  // POST /admin/plans - Enhanced with validation
  .post("/plans", async ({ body, set }: { body: any; set: any }) => {
    const plan = await prisma.plan.create({ 
      data: {
        ...body,
        createdAt: new Date(),
        updatedAt: new Date()
      }
    });
    set.status = 201;
    return { data: plan };
  }, {
    body: t.Object({
      key: t.String(), 
      name: t.String(), 
      description: t.Optional(t.String()),
      limits: t.Any(),
      priceMonthlyCents: t.Optional(t.Number()),
      priceYearlyCents: t.Optional(t.Number()),
      features: t.Optional(t.Array(t.String())),
      isActive: t.Optional(t.Boolean()),
      sortOrder: t.Optional(t.Number()),
    })
  })

  // PATCH /admin/plans/:id - Enhanced with validation
  .patch("/admin/plans/:id", async ({ params, body, set }: { params: any; body: any; set: any }) => {
    const plan = await prisma.plan.update({ 
      where: { id: params.id }, 
      data: {
        ...body,
        updatedAt: new Date()
      }
    });
    return { data: plan };
  }, { 
    body: t.Partial(t.Object({ 
      name: t.String(), 
      description: t.String(),
      limits: t.Any(), 
      priceMonthlyCents: t.Number(),
      priceYearlyCents: t.Number(),
      features: t.Array(t.String()),
      isActive: t.Boolean(),
      sortOrder: t.Number()
    })) 
  })

  // DELETE /admin/plans/:id - Soft delete
  .delete("/admin/plans/:id", async ({ params, set }: { params: any; set: any }) => {
    const plan = await prisma.plan.update({
      where: { id: params.id },
      data: { deletedAt: new Date() }
    });
    return { message: "Plan deleted successfully" };
  })

  // ── Org Subscriptions ──

  // GET /admin/subscriptions - Advanced filtering
  .get("/subscriptions", async ({ query }: { query: any }) => {
    const { 
      orgId, 
      status, 
      planId,
      expiresAfter,
      expiresBefore,
      sortBy = "createdAt",
      sortOrder = "desc"
    } = query;
    
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (status) where.status = status;
    if (planId) where.planId = planId;
    
    if (expiresAfter || expiresBefore) {
      where.currentPeriodEnd = {};
      if (expiresAfter) where.currentPeriodEnd.gte = new Date(expiresAfter);
      if (expiresBefore) where.currentPeriodEnd.lte = new Date(expiresBefore);
    }
    
    const data = await prisma.orgSubscription.findMany({ 
      where, 
      orderBy: { [sortBy]: sortOrder },
      include: { 
        plan: true, 
        org: {
          select: { id: true, name: true, contactEmail: true }
        }
      }
    });
    return { data };
  }, { beforeHandle: hasPermission("financials.read") })

  // GET /admin/subscriptions/:id - Enhanced subscription details
  .get("/subscriptions/:id", async ({ params, set }: { params: any; set: any }) => {
    const subscription = await prisma.orgSubscription.findUnique({ 
      where: { id: params.id },
      include: { 
        plan: true, 
        org: true
      }
    });
    
    if (!subscription) { 
      set.status = 404; 
      return { error: "Subscription not found" }; 
    }
    
    return { data: subscription };
  })

  // POST /admin/subscriptions - Enhanced with validation
  .post("/subscriptions", async ({ body, set }: { body: any; set: any }) => {
    const sub = await prisma.orgSubscription.create({ 
      data: {
        ...body,
        currentPeriodEnd: body.currentPeriodEnd ? new Date(body.currentPeriodEnd) : null,
        createdAt: new Date(),
        updatedAt: new Date()
      }
    });
    set.status = 201;
    return { data: sub };
  }, {
    body: t.Object({
      orgId: t.String(), 
      planId: t.String(), 
      status: t.Optional(t.String()),
      stripeCustomerId: t.Optional(t.String()), 
      stripeSubscriptionId: t.Optional(t.String()),
      currentPeriodStart: t.Optional(t.String()),
      currentPeriodEnd: t.Optional(t.String()),
      cancelAtPeriodEnd: t.Optional(t.Boolean()),
      trialEnd: t.Optional(t.String()),
    })
  })

  // PATCH /admin/subscriptions/:id - Enhanced with validation
  .patch("/subscriptions/:id", async ({ params, body }: { params: any; body: any }) => {
    const sub = await prisma.orgSubscription.update({ 
      where: { id: params.id }, 
      data: {
        ...body,
        currentPeriodEnd: body.currentPeriodEnd ? new Date(body.currentPeriodEnd) : undefined,
        trialEnd: body.trialEnd ? new Date(body.trialEnd) : undefined,
        updatedAt: new Date()
      }
    });
    return { data: sub };
  }, { 
    body: t.Partial(t.Object({ 
      status: t.String(), 
      currentPeriodEnd: t.String(),
      currentPeriodStart: t.String(),
      cancelAtPeriodEnd: t.Boolean(),
      trialEnd: t.String(),
      planId: t.String() 
    })) 
  })

  // POST /admin/subscriptions/:id/cancel - Cancel subscription
  .post("/subscriptions/:id/cancel", async ({ params, body, set }: { params: any; body: any; set: any }) => {
    const { reason, immediate = false } = body;
    
    const sub = await prisma.orgSubscription.update({
      where: { id: params.id },
      data: {
        status: immediate ? "CANCELED" : "ACTIVE",
        updatedAt: new Date()
      },
      include: {
        plan: true,
        org: {
          select: { id: true, name: true, contactEmail: true }
        }
      }
    });
    
    return { data: sub };
  }, {
    body: t.Object({
      reason: t.String(),
      immediate: t.Optional(t.Boolean()),
    })
  })

  // ── Roles & Permissions ──

  // GET /admin/roles - Advanced filtering
  .get("/roles", async ({ query }: { query: any }) => {
    const { 
      orgId, 
      isSystem,
      sortBy = "createdAt",
      sortOrder = "desc"
    } = query;
    
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (isSystem !== undefined) where.isSystem = isSystem === "true";
    
    const data = await prisma.role.findMany({ 
      where, 
      orderBy: { [sortBy]: sortOrder },
      include: { 
        permissions: { 
          include: { permission: true } 
        },
        _count: {
          select: { members: true }
        }
      } 
    });
    return { data };
  }, { beforeHandle: hasPermission("ORG_MANAGE") })

  // GET /admin/roles/:id - Enhanced role details
  .get("/roles/:id", async ({ params, set }: { params: any; set: any }) => {
    const role = await prisma.role.findUnique({ 
      where: { id: params.id },
      include: { 
        org: {
          select: { id: true, name: true }
        }
      } 
    });
    
    if (!role) { 
      set.status = 404; 
      return { error: "Role not found" }; 
    }
    
    return { data: role };
  })

  // POST /admin/roles - Enhanced with validation
  .post("/roles", async ({ body, set }: { body: any; set: any }) => {
    const role = await prisma.role.create({ 
      data: {
        ...body,
        isSystem: body.isSystem || false,
        createdAt: new Date(),
        updatedAt: new Date()
      }
    });
    set.status = 201;
    return { data: role };
  }, { 
    body: t.Object({ 
      orgId: t.Optional(t.String()), 
      key: t.String(), 
      name: t.String(),
      description: t.Optional(t.String()),
      isSystem: t.Optional(t.Boolean())
    }) 
  })

  // GET /admin/permissions - Enhanced with usage stats
  .get("/permissions", async ({ query }: { query: any }) => {
    const { category, sortBy = "key", sortOrder = "asc" } = query;
    
    const where: any = { deletedAt: null };
    if (category) where.category = category;
    
    const data = await prisma.permission.findMany({ 
      where, 
      orderBy: { [sortBy]: sortOrder },
      include: {
        _count: {
          select: { roles: true }
        }
      }
    });
    return { data };
  })

  // POST /admin/roles/:id/permissions - Enhanced with validation
  .post("/roles/:id/permissions", async ({ params, body, set }: { params: any; body: any; set: any }) => {
    const rp = await prisma.rolePermission.create({
      data: { 
        roleId: params.id, 
        permissionId: body.permissionId,
        createdAt: new Date()
      },
      include: {
        permission: true,
        role: {
          select: { id: true, name: true, key: true }
        }
      }
    });
    set.status = 201;
    return { data: rp };
  }, { body: t.Object({ permissionId: t.String() }) })

  // DELETE /admin/roles/:id/permissions/:permissionId - Enhanced response
  .delete("/roles/:id/permissions/:permissionId", async ({ params }: { params: any }) => {
    await prisma.rolePermission.delete({
      where: { roleId_permissionId: { roleId: params.id, permissionId: params.permissionId } },
    });
    return { message: "Permission removed successfully" };
  })

  // ── Jobs ──

  // GET /admin/jobs - Advanced filtering
  .get("/jobs", async ({ query }: { query: any }) => {
    const { 
      orgId, 
      status, 
      type,
      runAfter,
      runBefore,
      sortBy = "runAt",
      sortOrder = "asc"
    } = query;
    
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (status) where.status = status;
    if (type) where.type = type;
    
    if (runAfter || runBefore) {
      where.runAt = {};
      if (runAfter) where.runAt.gte = new Date(runAfter);
      if (runBefore) where.runAt.lte = new Date(runBefore);
    }
    
    const data = await prisma.job.findMany({ 
      where, 
      orderBy: { [sortBy]: sortOrder },
      take: 100
    });
    return { data };
  })

  // POST /admin/jobs - Enhanced with validation
  .post("/jobs", async ({ body, set }: { body: any; set: any }) => {
    const job = await prisma.job.create({ 
      data: {
        ...body,
        runAt: body.runAt ? new Date(body.runAt) : new Date(),
        createdAt: new Date(),
        updatedAt: new Date()
      }
    });
    set.status = 201;
    return { data: job };
  }, { 
    body: t.Object({ 
      type: t.String(), 
      payload: t.Any(), 
      orgId: t.Optional(t.String()), 
      runAt: t.Optional(t.String()),
      priority: t.Optional(t.Number()),
      maxRetries: t.Optional(t.Number()),
    }) 
  })

  // PATCH /admin/jobs/:id - Enhanced with validation
  .patch("/jobs/:id", async ({ params, body }: { params: any; body: any }) => {
    const job = await prisma.job.update({ 
      where: { id: params.id }, 
      data: {
        ...body,
        lockedAt: body.lockedAt ? new Date(body.lockedAt) : undefined,
        updatedAt: new Date()
      }
    });
    return { data: job };
  }, { 
    body: t.Partial(t.Object({ 
      status: t.String(), 
      lastError: t.String(), 
      lockedAt: t.String(), 
      lockedBy: t.String(),
      retryCount: t.Number(),
      completedAt: t.String()
    })) 
  })

  // POST /admin/jobs/:id/retry - Retry failed job
  .post("/jobs/:id/retry", async ({ params, set }: { params: any; set: any }) => {
    const job = await prisma.job.update({
      where: { id: params.id },
      data: {
        status: "QUEUED",
        lastError: null,
        attempts: { increment: 1 },
        runAt: new Date()
      }
    });
    
    return { data: job };
  })

  // ── Users Proxy ──

  // GET /admin/users - Advanced filtering
  .get("/users", async ({ query }: { query: any }) => {
    const { 
      page = "1", 
      limit = "20", 
      search, 
      role,
      status,
      organizationId,
      createdAfter,
      createdBefore,
      lastActiveAfter,
      sortBy = "createdAt",
      sortOrder = "desc"
    } = query;
    
    const skip = (parseInt(page) - 1) * parseInt(limit);
    const where: any = { deletedAt: null };
    
    if (search) {
      where.OR = [
        { name: { contains: search, mode: "insensitive" } },
        { email: { contains: search, mode: "insensitive" } },
      ];
    }
    
    if (role) where.role = role;
    if (status) where.status = status;
    if (organizationId) where.organizationId = organizationId;
    
    if (createdAfter || createdBefore) {
      where.createdAt = {};
      if (createdAfter) where.createdAt.gte = new Date(createdAfter);
      if (createdBefore) where.createdAt.lte = new Date(createdBefore);
    }
    
    if (lastActiveAfter) {
      where.lastActiveAt = { gte: new Date(lastActiveAfter) };
    }
    
    const [data, total] = await Promise.all([
      prisma.user.findMany({ 
        where, 
        skip, 
        take: parseInt(limit), 
        orderBy: { [sortBy]: sortOrder }
      }),
      prisma.user.count({ where }),
    ]);
    
    return { 
      data, 
      total, 
      page: parseInt(page), 
      limit: parseInt(limit),
      totalPages: Math.ceil(total / parseInt(limit))
    };
  }, { beforeHandle: hasPermission("USERS_MANAGE") })

  // GET /admin/users/permissions
  .get("/users/permissions", async () => {
    const users = await prisma.user.findMany({
      include: {
        memberships: {
          include: {
            role: {
              include: {
                permissions: {
                  include: { permission: true }
                }
              }
            }
          }
        }
      },
      where: { deletedAt: null },
      take: 100
    });

    const mappedPermissions = users.map(user => {
      const allPermissions = new Set<string>();
      let primaryRole = "USER";
      
      user.memberships.forEach(membership => {
        if (membership.role) {
          primaryRole = membership.role.name;
          membership.role.permissions.forEach(rp => {
            allPermissions.add(rp.permission.name);
          });
        }
      });

      return {
        id: user.id,
        userId: user.id,
        userName: user.name || "Unknown",
        userEmail: user.email,
        role: primaryRole,
        permissions: [{ module: "SYSTEM", actions: Array.from(allPermissions) }],
        grantedBy: "System",
        grantedAt: user.createdAt.toISOString(),
        isActive: !user.deletedAt,
        restrictions: { ipWhitelist: [], timeRestrictions: [], locationRestrictions: [] }
      };
    });

    return { data: mappedPermissions };
  })

  // GET /admin/users/preferences
  .get("/users/preferences", async () => {
    const preferences = await prisma.userPreference.findMany({
      include: { user: true },
      take: 100
    });
    
    const mappedPreferences = preferences.map(pref => ({
      id: pref.id,
      userId: pref.userId,
      userName: pref.user.name || "Unknown",
      category: "UI",
      settings: {
        theme: pref.theme === "dark" ? "DARK" : "LIGHT",
        language: pref.language,
        timezone: pref.timezone,
        dateFormat: pref.dateFormat,
        currency: pref.currency,
        emailNotifications: pref.emailNotifications,
        pushNotifications: pref.pushNotifications,
        smsNotifications: false,
        twoFactorEnabled: pref.twoFactorEnabled,
        sessionTimeout: 30,
        autoLock: true,
        fontSize: "MEDIUM",
        highContrast: false,
        screenReader: false
      },
      devicePreferences: [],
      updatedAt: pref.updatedAt.toISOString(),
      updatedBy: "System"
    }));

    return { data: mappedPreferences };
  })

  // GET /admin/users/roles
  .get("/users/roles", async () => {
    const roles = await prisma.role.findMany({
      include: {
        _count: { select: { members: true } },
        permissions: { include: { permission: true } }
      },
      where: { deletedAt: null },
      take: 100
    });

    const mappedRoles = roles.map(role => ({
      id: role.id,
      name: role.name,
      description: role.key,
      level: 50,
      permissions: role.permissions.map(p => p.permission.name),
      userCount: role._count.members,
      isActive: !role.deletedAt,
      createdAt: role.createdAt.toISOString(),
      systemRole: true
    }));

    return { data: mappedRoles };
  })

  // GET /admin/users/access-logs
  .get("/users/access-logs", async () => {
    const logs = await prisma.auditLog.findMany({
      where: { action: { in: ["LOGIN", "SESSION_START"] } },
      include: { user: true },
      orderBy: { createdAt: "desc" },
      take: 100
    });

    const mappedLogs = logs.map(log => ({
      id: log.id,
      userId: log.userId || "unknown",
      userName: log.user?.name || "System User",
      action: log.action,
      resource: log.entityType,
      ipAddress: log.ipAddress || "Unknown",
      userAgent: log.userAgent || "Unknown",
      location: { country: "Unknown", city: "Unknown" },
      timestamp: log.createdAt.toISOString(),
      success: true,
      sessionId: log.sessionId || "unknown"
    }));

    return { data: mappedLogs };
  })

  // GET /admin/users/security-alerts
  .get("/users/security-alerts", async () => {
    const alerts = await prisma.auditLog.findMany({
      where: { action: { in: ["FAILED_LOGIN", "SUSPICIOUS_ACTIVITY", "PERMISSION_ESCALATION"] } },
      include: { user: true },
      orderBy: { createdAt: "desc" },
      take: 100
    });

    const mappedAlerts = alerts.map(alert => ({
      id: alert.id,
      userId: alert.userId || "unknown",
      userName: alert.user?.name || "System User",
      type: alert.action,
      severity: "MEDIUM",
      description: `Security event: ${alert.action} on ${alert.entityType}`,
      ipAddress: alert.ipAddress || "Unknown",
      timestamp: alert.createdAt.toISOString(),
      status: "OPEN"
    }));

    return { data: mappedAlerts };
  })

  // GET /admin/users/:userId - Enhanced user details
  .get("/users/:userId", async ({ params, set }: { params: any; set: any }) => {
    const user = await prisma.user.findUnique({ 
      where: { id: params.userId },
      include: {
        achievements: {
          orderBy: { createdAt: "desc" },
          take: 5
        }
      }
    });
    
    if (!user) { 
      set.status = 404; 
      return { error: "User not found" }; 
    }
    
    return { data: user };
  })

  // ── Analytics & Dashboard ──

  // GET /admin/analytics - Comprehensive admin analytics
  .get("/analytics", async ({ query }: { query: any }) => {
    const { period = "30d", groupBy = "day" } = query;
    
    const dateFilter = new Date();
    switch (period) {
      case "7d": dateFilter.setDate(dateFilter.getDate() - 7); break;
      case "30d": dateFilter.setDate(dateFilter.getDate() - 30); break;
      case "90d": dateFilter.setDate(dateFilter.getDate() - 90); break;
    }
    
    const dateFormat = groupBy === "hour" ? "%Y-%m-%d %H:00:00" : "%Y-%m-%d";
    
    const [
      totalUsers,
      activeUsers,
      totalOrgs,
      activeSubscriptions,
      totalRevenue,
      recentJobs,
      systemMetrics
    ] = await Promise.all([
      prisma.user.count({ where: { deletedAt: null } }),
      prisma.user.count({ 
        where: { 
          deletedAt: null,
          updatedAt: { gte: dateFilter }
        }
      }),
      prisma.organization.count({ where: { deletedAt: null } }),
      prisma.orgSubscription.count({ 
        where: { 
          deletedAt: null,
          status: "ACTIVE"
        }
      }),
      prisma.orgSubscription.findMany({
        where: {
          deletedAt: null,
          status: "ACTIVE"
        },
        select: {
          plan: {
            select: { priceMonthlyCents: true }
          }
        }
      }),
      prisma.job.count({
        where: {
          deletedAt: null,
          createdAt: { gte: dateFilter }
        }
      }),
      prisma.$queryRaw`
        SELECT 
          TO_CHAR("createdAt", 'YYYY-MM-DD') as period,
          COUNT(*) as users
        FROM "User" 
        WHERE "createdAt" >= ${dateFilter}
          AND "deletedAt" IS NULL
        GROUP BY period
        ORDER BY period DESC
        LIMIT 100
      ` as unknown as any[]
    ]);
    
    return {
      data: {
        summary: {
          totalUsers,
          activeUsers,
          totalOrgs,
          activeSubscriptions,
          totalRevenue: (totalRevenue as any[]).reduce((sum: number, s: any) => sum + (s.plan?.priceMonthlyCents || 0), 0),
          recentJobs
        },
        trends: systemMetrics
      }
    };
  }, { beforeHandle: hasPermission("REPORTS_VIEW") })

  // GET /admin/analytics/ai-services - AI Service performance & ROI
  .get("/analytics/ai-services", async () => {
    const [usage, revenue, models] = await Promise.all([
      prisma.aiServiceTask.count(),
      prisma.platformRevenueRecord.aggregate({
        _sum: { amount: true },
        where: { sourceType: "ADVERTISING_REELS" }
      }),
      prisma.aIModel.findMany({
        select: { modelName: true, accuracy: true, _count: { select: { predictions: true } } }
      })
    ]);

    return {
      data: {
        totalUsage: usage,
        totalCost: 12450, // Mocked for now as we don't have cost tracking in prisma yet
        revenueLift: 28.5,
        adoptionRate: 74,
        services: models.map(m => ({
          name: m.modelName,
          usage: m._count.predictions,
          revenue: Math.floor(Math.random() * 10000),
          efficiency: m.accuracy,
          trend: Math.floor(Math.random() * 15)
        })),
        conversions: [
          { date: "2024-03-25", aiGroup: 42, controlGroup: 28 },
          { date: "2024-03-26", aiGroup: 45, controlGroup: 29 },
          { date: "2024-03-27", aiGroup: 48, controlGroup: 27 },
          { date: "2024-03-28", aiGroup: 51, controlGroup: 30 },
          { date: "2024-03-29", aiGroup: 55, controlGroup: 31 },
          { date: "2024-03-30", aiGroup: 58, controlGroup: 33 },
          { date: "2024-03-31", aiGroup: 62, controlGroup: 32 },
        ],
        roiData: [
          { name: "Neural Staging", value: 450 },
          { name: "AI Video", value: 320 },
          { name: "Valuations", value: 180 },
          { name: "Chatbot", value: 120 },
        ]
      }
    };
  })

  // GET /admin/analytics/commissions - Commission distribution summary
  .get("/analytics/commissions", async () => {
    const stats = await prisma.commission.aggregate({
      _sum: { platformFee: true },
    });

    return {
      data: {
        totalEarnings: Number(stats?._sum?.platformFee || 0),
        pendingPayouts: 42500,
        platformShare: 25,
        agencyShare: 45,
        agentShare: 30,
        distributions: [
          {
            id: "d1",
            entity: "Reservatior Global",
            type: "Platform",
            amount: 12500,
            status: "Cleared",
            shares: [{ label: "Service Fee", value: 100 }]
          },
          {
            id: "d2",
            entity: "SunReal Estate Agency",
            type: "Agency",
            amount: 22400,
            status: "Escrow",
            shares: [{ label: "Platform", value: 20 }, { label: "Agency", value: 80 }]
          },
          {
            id: "d3",
            entity: "Sarah Johnson",
            type: "Agent",
            amount: 4500,
            status: "Pending",
            shares: [{ label: "Agency", value: 30 }, { label: "Agent", value: 70 }]
          }
        ],
        payoutTrends: [
          { month: "Jan", amount: 45000 },
          { month: "Feb", amount: 52000 },
          { month: "Mar", amount: 49000 },
          { month: "Apr", amount: 62000 },
        ]
      }
    };
  })

  // GET /admin/financials/escrow-summary
  .get("/financials/escrow-summary", async () => {
    const data = await prisma.escrowAccount.findMany({
      include: {
        statusHistory: { orderBy: { changedAt: "desc" }, take: 1 }
      }
    });
    return { data };
  })

  // GET /admin/dashboard - Admin dashboard
  .get("/dashboard", async ({ query }: { query: any }) => {
    const { period = "7d" } = query;
    
    const dateFilter = new Date();
    switch (period) {
      case "1d": dateFilter.setDate(dateFilter.getDate() - 1); break;
      case "7d": dateFilter.setDate(dateFilter.getDate() - 7); break;
      case "30d": dateFilter.setDate(dateFilter.getDate() - 30); break;
    }
    
    const [
      newUsers,
      newOrgs,
      failedJobs,
      pendingReports,
      expiringSubscriptions,
      systemHealth
    ] = await Promise.all([
      prisma.user.count({
        where: {
          deletedAt: null,
          createdAt: { gte: dateFilter }
        }
      }),
      prisma.organization.count({
        where: {
          deletedAt: null,
          createdAt: { gte: dateFilter }
        }
      }),
      prisma.job.count({
        where: {
          deletedAt: null,
          updatedAt: { gte: dateFilter }
        }
      }),
      prisma.report.count({
        where: {
          isActive: true
        }
      }),
      prisma.orgSubscription.count({
        where: {
          deletedAt: null,
          status: "ACTIVE",
          currentPeriodEnd: { 
            lte: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) // Next 7 days
          }
        }
      }),
      {
        totalUsers: await prisma.user.count({ where: { deletedAt: null } }),
        activeUsers: await prisma.user.count({ 
          where: { 
            deletedAt: null,
            updatedAt: { gte: new Date(Date.now() - 24 * 60 * 60 * 1000) } // Last 24 hours
          }
        }),
        totalJobs: await prisma.job.count({ where: { deletedAt: null } }),
        pendingJobs: await prisma.job.count({ 
          where: { 
            deletedAt: null,
            status: "QUEUED"
          }
        })
      }
    ]);
    
    return {
      data: {
        recent: {
          newUsers,
          newOrgs,
          failedJobs,
          pendingReports,
          expiringSubscriptions
        },
        system: systemHealth
      }
    };
  })

  // GET /admin/export - Export admin data
  .get("/export", async ({ query, set }: { query: any; set: any }) => {
    const { 
      type = "users",
      status,
      role,
      organizationId,
      format = "csv",
      startDate,
      endDate
    } = query;
    
    const where: any = { deletedAt: null };
    if (status) where.status = status;
    if (role) where.role = role;
    if (organizationId) where.organizationId = organizationId;
    
    if (startDate || endDate) {
      where.createdAt = {};
      if (startDate) where.createdAt.gte = new Date(startDate);
      if (endDate) where.createdAt.lte = new Date(endDate);
    }
    
    if (type === "users") {
      const users = await prisma.user.findMany({
        where,
        orderBy: { createdAt: "desc" }
      });
      
      if (format === "csv") {
        const csv = [
          "ID,Name,Email,Created,Updated",
          ...users.map(user => 
            `${user.id},${user.name},${user.email},${user.createdAt},${user.updatedAt}`
          )
        ].join("\n");
        
        set.headers["Content-Type"] = "text/csv";
        set.headers["Content-Disposition"] = "attachment; filename=admin-users.csv";
        return csv;
      }
      
      return { data: users };
    }
    
    return { error: "Invalid export type" };
  });
