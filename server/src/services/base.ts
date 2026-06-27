import { PrismaClient } from "@prisma/client";
import { prisma } from "../lib/prisma";

export class BaseService<T, CreateInput, UpdateInput> {
  constructor(protected model: any, protected modelName?: string) {}

  /**
   * Returns a new instance of this service bound to a specific PrismaClient.
   * Required for Multi-Region/Multi-Tenant routing.
   */
  withDB(db: PrismaClient): this {
    if (!this.modelName) {
      console.warn("⚠️ modelName not provided in constructor, falling back to default db");
      return this;
    }
    const clone = Object.create(this);
    clone.model = (db as any)[this.modelName];
    return clone;
  }

  async getAll(params: {
    where?: any;
    orderBy?: any;
    skip?: number;
    take?: number;
    include?: any;
    select?: any;
  }) {
    const [data, total] = await Promise.all([
      this.model.findMany(params),
      this.model.count({ where: params.where }),
    ]);
    return { 
      data, 
      total, 
      page: Math.floor((params.skip || 0) / (params.take || 20)) + 1,
      limit: params.take || 20 
    };
  }

  async getById(id: string, include?: any) {
    return this.model.findUnique({
      where: { id },
      include,
    });
  }

  async create(data: CreateInput, include?: any) {
    return this.model.create({
      data,
      include,
    });
  }

  async update(id: string, data: UpdateInput, include?: any) {
    return this.model.update({
      where: { id },
      data,
      include,
    });
  }

  async delete(id: string) {
    return this.model.delete({
      where: { id },
    });
  }

  async upsert(id: string, create: CreateInput, update: UpdateInput) {
    return this.model.upsert({
      where: { id },
      create,
      update,
    });
  }
}
