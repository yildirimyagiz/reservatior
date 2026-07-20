/**
 * Saga: Identity Management
 * 
 * Flow:
 *   organization.created
 *       |
 *   [Setup identity structure]
 *       |
 *   team.created
 *       |
 *   role.created
 *       |
 *   role.assigned
 *       |
 *   [User onboarding complete]
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class IdentityManagementSaga extends BaseSaga {
  public organizationId: string;
  public userId: string;
  public organizationType: string;

  constructor(
    organizationId: string,
    userId: string,
    organizationType: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'ORGANIZATION_CREATED', organizationId, userId, organizationType }, localization);
    this.organizationId = organizationId;
    this.userId = userId;
    this.organizationType = organizationType;
  }

  protected async compensate(): Promise<void> {
    console.log(`[IdentityManagementSaga] Compensating organization ${this.organizationId}. Rolling back identity setup...`);
  }

  public async onOrganizationCreated() {
    console.log(`[IdentityManagementSaga] Organization ${this.organizationId} created. Setting up identity structure...`);
    await this.transition({ step: 'SETTING_UP_STRUCTURE' });

    // Create default team for the organization
    setTimeout(() => {
      eventBus.publish(DomainEvents.TEAM_CREATED, {
        organizationId: this.organizationId,
        name: 'Default Team',
        description: 'Primary team for organization',
        createdBy: this.userId,
        localization: this.localization
      }, 'IdentityOS', this.sagaId);
    }, 1000);
  }

  public async onTeamCreated(msg: EventMessage) {
    console.log(`[IdentityManagementSaga] Team created for organization ${this.organizationId}. Creating roles...`);
    await this.transition({ step: 'CREATING_ROLES' });

    // Create default roles (Admin, Agent, Viewer)
    setTimeout(() => {
      eventBus.publish(DomainEvents.ROLE_CREATED, {
        organizationId: this.organizationId,
        name: 'Organization Admin',
        description: 'Full administrative access',
        permissions: ['*'],
        isSystem: true,
        localization: this.localization
      }, 'IdentityOS', this.sagaId);
    }, 800);
  }

  public async onRoleCreated(msg: EventMessage) {
    console.log(`[IdentityManagementSaga] Role created for organization ${this.organizationId}. Assigning to user...`);
    await this.transition({ step: 'ASSIGNING_ROLE' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.ROLE_ASSIGNED, {
        userId: this.userId,
        roleId: msg.payload.roleId || 'default_admin_role',
        organizationId: this.organizationId,
        assignedBy: this.userId,
        localization: this.localization
      }, 'IdentityOS', this.sagaId);
    }, 500);
  }

  public async onRoleAssigned(msg: EventMessage) {
    console.log(`[IdentityManagementSaga] Role assigned to user ${this.userId}. Creating session...`);
    await this.transition({ step: 'CREATING_SESSION' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.SESSION_CREATED, {
        userId: this.userId,
        organizationId: this.organizationId,
        deviceInfo: {
          userAgent: 'System',
          ip: '127.0.0.1',
          deviceType: 'desktop'
        },
        localization: this.localization
      }, 'IdentityOS', this.sagaId);
    }, 500);
  }

  public async onSessionCreated(msg: EventMessage) {
    console.log(`[IdentityManagementSaga] Session created for user ${this.userId}. IDENTITY SAGA COMPLETE.`);
    await this.complete();
  }

  public async onOrganizationDeleted(msg: EventMessage) {
    console.log(`[IdentityManagementSaga] Organization ${this.organizationId} deleted. SAGA FAILED.`);
    await this.fail('Organization was deleted');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, IdentityManagementSaga>();

export function registerIdentityManagementListeners() {
  eventBus.subscribe(DomainEvents.ORGANIZATION_CREATED, (msg) => {
    const { organizationId, userId, type } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new IdentityManagementSaga(organizationId, userId, type, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onOrganizationCreated();
    console.log(`[IdentityManagementSaga] ✅ Started for Organization ${organizationId}`);
  });

  eventBus.subscribe(DomainEvents.TEAM_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onTeamCreated(msg);
  });

  eventBus.subscribe(DomainEvents.ROLE_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onRoleCreated(msg);
  });

  eventBus.subscribe(DomainEvents.ROLE_ASSIGNED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onRoleAssigned(msg);
  });

  eventBus.subscribe(DomainEvents.SESSION_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onSessionCreated(msg);
  });
}
