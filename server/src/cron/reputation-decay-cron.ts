import { decayScheduler } from "../services/reputation/decay-scheduler";

// 23 Regions with their respective primary timezones
export const REPUTATION_DECAY_REGIONS: Record<string, string> = {
  US: "America/New_York",
  TR: "Europe/Istanbul",
  UK: "Europe/London",
  DE: "Europe/Berlin",
  FR: "Europe/Paris",
  ES: "Europe/Madrid",
  IT: "Europe/Rome",
  AE: "Asia/Dubai",
  SA: "Asia/Riyadh",
  CA: "America/Toronto",
  AU: "Australia/Sydney",
  BR: "America/Sao_Paulo",
  MX: "America/Mexico_City",
  JP: "Asia/Tokyo",
  IN: "Asia/Kolkata",
  CN: "Asia/Shanghai",
  ZA: "Africa/Johannesburg",
  NG: "Africa/Lagos",
  EG: "Africa/Cairo",
  KR: "Asia/Seoul",
  RU: "Europe/Moscow",
  AR: "America/Argentina/Buenos_Aires",
  SG: "Asia/Singapore"
};

export async function runReputationDecayCron(): Promise<void> {
  const now = new Date();

  for (const [region, timezone] of Object.entries(REPUTATION_DECAY_REGIONS)) {
    try {
      // Get current hour in the target timezone
      const formatter = new Intl.DateTimeFormat('en-US', {
        timeZone: timezone,
        hour: 'numeric',
        hour12: false,
      });
      
      const localHour = parseInt(formatter.format(now), 10);
      
      // Sinyal erimesi sadece yerel saatle gece 04:00'da çalışır
      if (localHour === 4) {
        console.log(`[ReputationDecayCron] It is 04:00 in ${region} (${timezone}). Running decay...`);
        const result = await decayScheduler.applyDecay(region);
        if (result.agentsDecayed > 0 || result.scoreResets > 0) {
          console.log(`[ReputationDecayCron] Region ${region}: ${result.agentsDecayed} decayed, ${result.scoreResets} reset`);
        }
      }
    } catch (err) {
      console.error(`[ReputationDecayCron] Region ${region} error:`, err);
    }
  }
}
