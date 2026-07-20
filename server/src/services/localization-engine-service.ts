import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class LocalizationEngineService {
  async getDashboard() {
    const [totalCountries, totalCurrencies, totalLanguages, totalExchangeRates, recentCompliance, recentTaxes] = await Promise.all([
      prisma.countryFintechConfig.count(),
      prisma.currency.count({ where: { isActive: true } }),
      prisma.language.count({ where: { isActive: true } }),
      prisma.exchangeRate.count(),
      prisma.legalCompliance.findMany({ orderBy: { createdAt: "desc" }, take: 5 }),
      prisma.globalTaxRegulation.findMany({ orderBy: { createdAt: "desc" }, take: 5 }),
    ]);
    return { totalCountries, totalCurrencies, totalLanguages, totalExchangeRates, recentCompliance, recentTaxes };
  }

  async getCountries() {
    return prisma.countryFintechConfig.findMany({
      orderBy: { name: "asc" },
    });
  }

  async getCountryByCode(isoCode: string) {
    return prisma.countryFintechConfig.findUnique({
      where: { isoCode },
      include: { states: true },
    });
  }

  async getStateConfigs(countryIsoCode: string) {
    return prisma.stateFintechConfig.findMany({
      where: { countryIsoCode },
      orderBy: { stateCode: "asc" },
    });
  }

  async getCurrencies() {
    return prisma.currency.findMany({
      orderBy: { code: "asc" },
    });
  }

  async getExchangeRates(params?: { skip?: number; take?: number; baseCurrency?: string }) {
    return prisma.exchangeRate.findMany({
      where: { ...(params?.baseCurrency && { baseCurrency: params.baseCurrency }) },
      orderBy: { asOfDate: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async getLanguages() {
    return prisma.language.findMany({
      orderBy: { name: "asc" },
    });
  }

  async getLegalCompliance(params?: { skip?: number; take?: number; region?: string }) {
    return prisma.legalCompliance.findMany({
      where: { ...(params?.region && { region: params.region as any }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async getComplianceStats() {
    const [total, byRegion, byStatus] = await Promise.all([
      prisma.legalCompliance.count(),
      prisma.legalCompliance.groupBy({ by: ["region"], _count: { id: true }, orderBy: { _count: { id: "desc" } } }),
      prisma.legalCompliance.findMany({ select: { verificationLevel: true } }).then(rows => {
        const counts: Record<string, number> = {};
        rows.forEach(r => { const k = r.verificationLevel || "UNKNOWN"; counts[k] = (counts[k] || 0) + 1; });
        return Object.entries(counts).map(([level, count]) => ({ level, count }));
      }),
    ]);
    return { total, byRegion: byRegion.map(r => ({ region: r.region, count: r._count.id })), byStatus };
  }

  async getTaxRegulations(params?: { skip?: number; take?: number; taxAuthority?: string }) {
    return prisma.globalTaxRegulation.findMany({
      where: { ...(params?.taxAuthority && { taxAuthority: params.taxAuthority }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async getTaxStats() {
    const [total, byAuthority] = await Promise.all([
      prisma.globalTaxRegulation.count(),
      prisma.globalTaxRegulation.groupBy({ by: ["taxAuthority"], _count: { id: true }, orderBy: { _count: { id: "desc" } }, take: 10 }),
    ]);
    return { total, byAuthority: byAuthority.map(a => ({ authority: a.taxAuthority, count: a._count.id })) };
  }

  async createExchangeRate(data: { orgId: string; baseCurrency: string; quoteCurrency: string; rate: number; source?: string }) {
    const result = await prisma.exchangeRate.create({
      data: {
        ...data,
        asOfDate: new Date(),
        createdAt: new Date(),
      },
    });
    await eventBus.publish(DomainEvents.EXCHANGE_RATE_IMPORTED, { id: result.id, baseCurrency: data.baseCurrency, quoteCurrency: data.quoteCurrency, rate: data.rate }, "LocalizationOS");
    return result;
  }
}

export const localizationEngineService = new LocalizationEngineService();
