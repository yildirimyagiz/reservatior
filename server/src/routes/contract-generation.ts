import { Elysia, t } from 'elysia';
import { ContractEngine, ContractType, ContractData } from '../../config/contract-engine';
import { RegionCode } from '../../config/ai-yield-optimization';
import { regionMiddleware } from "../middleware/region";

export const contractGenerationRoutes = new Elysia({ prefix: '/contract-generation' })
  .use(regionMiddleware)
  .post('/', ({ orgId, db, body }) => {
    try {
      const { type, region, data } = body as { type: ContractType, region: RegionCode, data: ContractData };
      
      const compiledContractHtml = ContractEngine.generateContract(type, region, data);
      
      return {
        success: true,
        html: compiledContractHtml,
        metadata: {
          type,
          region,
          generatedAt: new Date().toISOString()
        }
      };
    } catch (error: any) {
      return {
        success: false,
        error: error.message || 'Failed to generate contract'
      };
    }
  }, {
    body: t.Object({
      type: t.Enum(ContractType),
      region: t.Enum(RegionCode),
      data: t.Any() // In production, this should be strictly typed using Elysia t.Object mirroring ContractData
    })
  });
