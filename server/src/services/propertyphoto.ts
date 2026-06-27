import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { PrismaClient } from "@prisma/client";

export class PropertyPhotoService extends BaseService<any, any, any> {
  constructor(client?: PrismaClient) {
    super((client || prisma).propertyPhoto);
  }
}

export const propertyPhotoService = new PropertyPhotoService();
