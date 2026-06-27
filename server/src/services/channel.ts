import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ChannelService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.channel, "channel");
  }
}

export const channelService = new ChannelService();
