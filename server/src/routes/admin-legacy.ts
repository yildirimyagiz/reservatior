import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { prisma } from "../lib/prisma";

export const adminRoutes = new Elysia({ prefix: "/admin" })
  .use(authMiddleware)
  .onBeforeHandle(hasPermission("admin.access"))

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
  })

  // GET /admin/plans/:id - Enhanced plan details
  .get("/plans/:id", async ({ params, set }: { params: any; set: any }) => {
    const plan = await prisma.plan.findUnique({ 
      where: { id: params.id },
      include: { 
        orgSubscriptions: { 
          where: { deletedAt: null },
          include: {
            org: {
              select: { id: true, name: true, email: true }
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
          select: { id: true, name: true, email: true }
        }
      }
    });
    return { data };
  })

  // GET /admin/subscriptions/:id - Enhanced subscription details
  .get("/subscriptions/:id", async ({ params, set }: { params: any; set: any }) => {
    const subscription = await prisma.orgSubscription.findUnique({ 
      where: { id: params.id },
      include: { 
        plan: true, 
        org: {
          include: {
            users: {
              select: { id: true, name: true, email: true, role: true },
              take: 5
            }
          }
        }
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
        cancelAtPeriodEnd: !immediate,
        cancellationReason: reason,
        updatedAt: new Date()
      },
      include: {
        plan: true,
        org: {
          select: { id: true, name: true, email: true }
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
          select: { users: true }
        }
      } 
    });
    return { data };
  })

  // GET /admin/roles/:id - Enhanced role details
  .get("/roles/:id", async ({ params, set }: { params: any; set: any }) => {
    const role = await prisma.role.findUnique({ 
      where: { id: params.id },
      include: { 
        permissions: { 
          include: { permission: true } 
        },
        users: {
          select: { id: true, name: true, email: true },
          take: 10
        },
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
      take: 100,
      include: {
        org: {
          select: { id: true, name: true }
        }
      }
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
        status: "PENDING",
        lastError: null,
        retryCount: { increment: 1 },
        runAt: new Date(),
        updatedAt: new Date()
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
        orderBy: { [sortBy]: sortOrder },
        include: {
          organization: {
            select: { id: true, name: true }
          }
        }
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
  })

  // GET /admin/users/:userId - Enhanced user details
  .get("/users/:userId", async ({ params, set }: { params: any; set: any }) => {
    const user = await prisma.user.findUnique({ 
      where: { id: params.userId },
      include: {
        organization: {
          select: { id: true, name: true, plan: true }
        },
        roles: {
          include: {
            role: {
              select: { id: true, name: true, key: true }
            }
          }
        },
        sessions: {
          orderBy: { createdAt: "desc" },
          take: 5
        },
        _count: {
          select: {
            properties: true,
            reports: true,
            achievements: true
          }
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
          lastActiveAt: { gte: dateFilter }
        }
      }),
      prisma.organization.count({ where: { deletedAt: null } }),
      prisma.orgSubscription.count({ 
        where: { 
          deletedAt: null,
          status: "ACTIVE"
        }
      }),
      prisma.orgSubscription.aggregate({
        where: {
          deletedAt: null,
          status: "ACTIVE"
        },
        _sum: { priceMonthlyCents: true }
      }),
      prisma.job.count({
        where: {
          deletedAt: null,
          createdAt: { gte: dateFilter }
        }
      }),
      prisma.$queryRaw`
        SELECT 
          DATE_FORMAT(createdAt, ${dateFormat}) as period,
          COUNT(*) as users,
          SUM(CASE WHEN lastActiveAt >= ${dateFilter} THEN 1 ELSE 0 END) as activeUsers
        FROM User 
        WHERE createdAt >= ${dateFilter}
          AND deletedAt IS NULL
        GROUP BY period
        ORDER BY period DESC
        LIMIT 100
      ` as any[]
    ]);
    
    return {
      data: {
        summary: {
          totalUsers,
          activeUsers,
          totalOrgs,
          activeSubscriptions,
          totalRevenue: totalRevenue._sum.priceMonthlyCents || 0,
          recentJobs
        },
        trends: systemMetrics
      }
    };
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
          status: "FAILED",
          updatedAt: { gte: dateFilter }
        }
      }),
      prisma.report.count({
        where: {
          status: "PENDING"
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
            lastActiveAt: { gte: new Date(Date.now() - 24 * 60 * 60 * 1000) } // Last 24 hours
          }
        }),
        totalJobs: await prisma.job.count({ where: { deletedAt: null } }),
        pendingJobs: await prisma.job.count({ 
          where: { 
            deletedAt: null,
            status: "PENDING"
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
        include: {
          organization: {
            select: { name: true }
          }
        },
        orderBy: { createdAt: "desc" }
      });
      
      if (format === "csv") {
        const csv = [
          "ID,Name,Email,Role,Status,Organization,Created,Last Active",
          ...users.map(user => 
            `${user.id},${user.name},${user.email},${user.role},${user.status},${user.organization?.name || 'N/A'},${user.createdAt},${user.lastActiveAt || 'Never'}`
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
