import { decayScheduler } from "../services/reputation/decay-scheduler";

export const REPUTATION_DECAY_REGIONS = ["US", "TR", "UK", "DE", "FR", "ES", "IT", "AE", "SA", "CA", "AU"];

export async function runReputationDecayCron(): Promise<void> {
  for (const region of REPUTATION_DECAY_REGIONS) {
    try {
      const result = await decayScheduler.applyDecay(region);
      if (result.agentsDecayed > 0 || result.scoreResets > 0) {
        console.log(`[ReputationDecayCron] Region ${region}: ${result.agentsDecayed} decayed, ${result.scoreResets} reset`);
      }
    } catch (err) {
      console.error(`[ReputationDecayCron] Region ${region} error:`, err);
    }
  }
}
