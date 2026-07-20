import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class ChannelConnectionService extends BaseService<any, any, any> {
  constructor() { super(prisma.channelConnection, "channelConnection"); }

  async getByOrg(orgId: string) {
    return this.model.findMany({ where: { orgId }, orderBy: { createdAt: "desc" } });
  }

  async connect(orgId: string, channel: string, config: any) {
    const result = await this.model.create({ data: { orgId, channel, config, status: "CONNECTED", connectedAt: new Date(), createdAt: new Date() } });
    await eventBus.publish({ event: "ADS_CHANNEL_CONNECTED", payload: { id: result.id, channelType: result.channel, platform: result.channel }, source: "AdsOS" });
    return result;
  }

  async disconnect(id: string) {
    return this.model.update({ where: { id }, data: { status: "DISCONNECTED", disconnectedAt: new Date() } });
  }

  async testConnection(id: string) {
    return this.model.update({ where: { id }, data: { lastTestedAt: new Date(), lastTestResult: "OK" } });
  }
}

export const channelConnectionService = new ChannelConnectionService();
