import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class HostPenaltyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.hostPenalty, "hostPenalty");
  }
}

export const hostPenaltyService = new HostPenaltyService();
export default hostPenaltyService;
