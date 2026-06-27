import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class HomeInformationPackService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.homeInformationPack, "homeInformationPack");
  }
}

export const homeInformationPackService = new HomeInformationPackService();
