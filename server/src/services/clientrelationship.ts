import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ClientRelationshipService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.clientRelationship, "clientRelationship");
  }
}

export const clientRelationshipService = new ClientRelationshipService();
