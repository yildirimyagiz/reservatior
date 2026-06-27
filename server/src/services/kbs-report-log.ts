import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class KbsReportLogService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.kbsReportLog, "kbsReportLog");
  }
}

export const kbsReportLogService = new KbsReportLogService();
export default kbsReportLogService;
