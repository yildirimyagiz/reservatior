import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class FavoriteService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.favorite, "favorite");
  }
}

export const favoriteService = new FavoriteService();
