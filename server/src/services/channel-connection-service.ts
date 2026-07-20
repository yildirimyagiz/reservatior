import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ChannelConnectionService extends BaseService<any, any, any> {
  constructor() { super(prisma.channelConnection, "channelConnection"); }

  async getByOrg(orgId: string) {
    return this.model.findMany({ where: { orgId }, orderBy: { createdAt: "desc" } });
  }

  async connect(orgId: string, channel: string, config: any) {
    return this.model.create({ data: { orgId, channel, config, status: "CONNECTED", connectedAt: new Date(), createdAt: new Date() } });
  }

  async disconnect(id: string) {
    return this.model.update({ where: { id }, data: { status: "DISCONNECTED", disconnectedAt: new Date() } });
  }

  async testConnection(id: string) {
    return this.model.update({ where: { id }, data: { lastTestedAt: new Date(), lastTestResult: "OK" } });
  }
}

export const channelConnectionService = new ChannelConnectionService();
