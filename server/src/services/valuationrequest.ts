import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ValuationRequestService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.valuationRequest, "valuationRequest");
  }
}

export const valuationRequestService = new ValuationRequestService();
