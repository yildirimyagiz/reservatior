import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CommunicationTemplateService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.communicationTemplate, "communicationTemplate");
  }
}

export const communicationTemplateService = new CommunicationTemplateService();
