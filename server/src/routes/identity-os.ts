/**
 * Identity OS API Routes
 */

import { Elysia, t } from 'elysia';
import { identityOSService } from '../services/identity-os';

export const identityOSRoutes = new Elysia({ prefix: '/identity' })
  /**
   * POST /api/identity/organizations
   * Create organization
   */
  .post('/organizations', async ({ body, set }) => {
    try {
      const organization = await identityOSService.createOrganization(body);
      return organization;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create organization' };
    }
  }, {
    body: t.Object({
      name: t.String(),
      type: t.Union([
        t.Literal('agency'),
        t.Literal('property_management'),
        t.Literal('investment_firm'),
        t.Literal('individual')
      ]),
      userId: t.String(),
      parentId: t.Optional(t.String())
    })
  })

  /**
   * POST /api/identity/teams
   * Create team
   */
  .post('/teams', async ({ body, set }) => {
    try {
      const team = await identityOSService.createTeam(body);
      return team;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create team' };
    }
  }, {
    body: t.Object({
      organizationId: t.String(),
      name: t.String(),
      description: t.Optional(t.String()),
      parentId: t.Optional(t.String()),
      permissions: t.Optional(t.Array(t.String()))
    })
  })

  /**
   * POST /api/identity/roles
   * Create role
   */
  .post('/roles', async ({ body, set }) => {
    try {
      const role = await identityOSService.createRole(body);
      return role;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create role' };
    }
  }, {
    body: t.Object({
      name: t.String(),
      description: t.Optional(t.String()),
      permissions: t.Array(t.String()),
      organizationId: t.Optional(t.String()),
      isSystem: t.Optional(t.Boolean())
    })
  })

  /**
   * POST /api/identity/roles/assign
   * Assign role to user
   */
  .post('/roles/assign', async ({ body, set }) => {
    try {
      const assignment = await identityOSService.assignRoleToUser(
        body.userId,
        body.roleId,
        body.organizationId
      );
      return assignment;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to assign role' };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      roleId: t.String(),
      organizationId: t.String()
    })
  })

  /**
   * GET /api/identity/permissions/check
   * Check permission
   */
  .get('/permissions/check', async ({ query, set }) => {
    try {
      const hasPermission = await identityOSService.hasPermission(
        query.userId,
        query.resource,
        query.action,
        query.organizationId
      );
      return { hasPermission };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to check permission' };
    }
  })

  /**
   * POST /api/identity/apikeys
   * Create API key
   */
  .post('/apikeys', async ({ body, set }) => {
    try {
      const result = await identityOSService.createAPIKey(body);
      return result;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create API key' };
    }
  }, {
    body: t.Object({
      name: t.String(),
      userId: t.String(),
      organizationId: t.String(),
      scopes: t.Array(t.String()),
      expiresAt: t.Optional(t.String())
    })
  })

  /**
   * POST /api/identity/sessions
   * Create session
   */
  .post('/sessions', async ({ body, set }) => {
    try {
      const session = await identityOSService.createSession(
        body.userId,
        body.deviceInfo
      );
      return session;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create session' };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      deviceInfo: t.Optional(t.Object({
        userAgent: t.String(),
        ip: t.String(),
        deviceType: t.String()
      }))
    })
  })

  /**
   * DELETE /api/identity/sessions/:id
   * Revoke session
   */
  .delete('/sessions/:id', async ({ params, set }) => {
    try {
      await identityOSService.revokeSession(params.id);
      return { success: true };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to revoke session' };
    }
  })

  /**
   * POST /api/identity/devices/trust
   * Trust device
   */
  .post('/devices/trust', async ({ body, set }) => {
    try {
      const device = await identityOSService.trustDevice(body.deviceId);
      return device;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to trust device' };
    }
  }, {
    body: t.Object({
      deviceId: t.String()
    })
  })

  /**
   * GET /api/identity/users/:userId/permissions
   * Get user permissions
   */
  .get('/users/:userId/permissions', async ({ params, query, set }) => {
    try {
      const permissions = await identityOSService.getUserPermissions(
        params.userId,
        query.organizationId
      );
      return { permissions };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get user permissions' };
    }
  })

  /**
   * POST /api/identity/login/risk
   * Assess login risk
   */
  .post('/login/risk', async ({ body, set }) => {
    try {
      const risk = await identityOSService.assessLoginRisk(
        body.userId,
        body.loginContext
      );
      return risk;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to assess login risk' };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      loginContext: t.Object({
        ip: t.String(),
        userAgent: t.String(),
        location: t.Optional(t.String())
      })
    })
  })

  /**
   * POST /api/identity/sso/enable
   * Enable SSO for organization
   */
  .post('/sso/enable', async ({ body, set }) => {
    try {
      const organization = await identityOSService.enableSSO(
        body.organizationId,
        body.provider,
        body.config
      );
      return organization;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to enable SSO' };
    }
  }, {
    body: t.Object({
      organizationId: t.String(),
      provider: t.String(),
      config: t.Record(t.String, t.Any())
    })
  })

  /**
   * GET /api/identity/users/:userId/graph
   * Get identity graph
   */
  .get('/users/:userId/graph', async ({ params, set }) => {
    try {
      const graph = await identityOSService.getIdentityGraph(params.userId);
      return graph;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get identity graph' };
    }
  });
