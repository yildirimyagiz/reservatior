import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { bankAccountService } from "../services/bank-account";

export const bankAccountRoutes = new Elysia({ prefix: "/bank-accounts" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    if (query.orgId) {
      return bankAccountService.getOrgAccounts(query.orgId);
    }
    const { page = "1", limit = "20", ...where } = query as any;
    return bankAccountService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Bank Accounts",
      description: "List all bank accounts for an organization with pagination",
      tags: ["Bank Accounts"]
    }
  })

  .post("/", async ({ body, set }) => {
    const data = await bankAccountService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.String(),
      accountType: t.Optional(t.String()),
      bankName: t.String(),
      bankCode: t.Optional(t.String()),
      accountName: t.String(),
      accountNumber: t.String(),
      iban: t.Optional(t.String()),
      routingNumber: t.Optional(t.String()),
      sortCode: t.Optional(t.String()),
      currency: t.Optional(t.String()),
      country: t.String(),
    }),
    beforeHandle: hasPermission("FINANCE_MANAGE"),
    detail: {
      summary: "Create Bank Account",
      description: "Create a new bank account for the organization",
      tags: ["Bank Accounts"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await bankAccountService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Bank account not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Bank Account",
      description: "Get a single bank account by ID",
      tags: ["Bank Accounts"]
    }
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await bankAccountService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Bank account not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      accountType: t.Optional(t.String()),
      bankName: t.Optional(t.String()),
      bankCode: t.Optional(t.String()),
      accountName: t.Optional(t.String()),
      accountNumber: t.Optional(t.String()),
      iban: t.Optional(t.String()),
      routingNumber: t.Optional(t.String()),
      sortCode: t.Optional(t.String()),
      currency: t.Optional(t.String()),
      country: t.Optional(t.String()),
      status: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("FINANCE_MANAGE"),
    detail: {
      summary: "Update Bank Account",
      description: "Update an existing bank account",
      tags: ["Bank Accounts"]
    }
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await bankAccountService.delete(params.id);
      return { success: true, message: "Bank account deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Bank account not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("FINANCE_MANAGE"),
    detail: {
      summary: "Delete Bank Account",
      description: "Delete a bank account",
      tags: ["Bank Accounts"]
    }
  })

  .post("/:id/default-payout", async ({ params, set }) => {
    const account = await bankAccountService.getById(params.id);
    if (!account) {
      set.status = 404;
      return { error: "Bank account not found" };
    }
    const data = await bankAccountService.setDefaultForPayouts(account.orgId, params.id);
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("FINANCE_MANAGE"),
    detail: {
      summary: "Set Default Payout Account",
      description: "Set a bank account as the default for outgoing payouts",
      tags: ["Bank Accounts"]
    }
  })

  .post("/:id/default-receipt", async ({ params, set }) => {
    const account = await bankAccountService.getById(params.id);
    if (!account) {
      set.status = 404;
      return { error: "Bank account not found" };
    }
    const data = await bankAccountService.setDefaultForReceipts(account.orgId, params.id);
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("FINANCE_MANAGE"),
    detail: {
      summary: "Set Default Receipt Account",
      description: "Set a bank account as the default for incoming receipts",
      tags: ["Bank Accounts"]
    }
  })

  .post("/:id/verify", async ({ params, body, set }) => {
    try {
      const data = await bankAccountService.verifyAccount(params.id, body.verifiedBy);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Bank account not found or verification failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      verifiedBy: t.String(),
    }),
    beforeHandle: hasPermission("FINANCE_MANAGE"),
    detail: {
      summary: "Verify Bank Account",
      description: "Mark a bank account as verified by a specified user",
      tags: ["Bank Accounts"]
    }
  });
