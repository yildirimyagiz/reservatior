// Instagram mention management for local influencer & business tagging
// Data stored in DB via SocialAutomationRule model (keyword = city name)

import { prisma } from "../lib/prisma";

interface MentionSuggestion {
  username: string;
  type: "BUSINESS" | "INFLUENCER" | "LOCAL_SPOT";
}

const DEFAULT_MENTIONS: Record<string, MentionSuggestion[]> = {
  TR: [
    { username: "reservatior", type: "BUSINESS" },
  ],
  US: [
    { username: "reservatior", type: "BUSINESS" },
  ],
  AE: [
    { username: "reservatior", type: "BUSINESS" },
  ],
};

export async function getMentionsForCity(
  country?: string | null,
  city?: string | null,
): Promise<MentionSuggestion[]> {
  const rules = await prisma.socialAutomationRule.findMany({
    where: {
      isActive: true,
      triggerType: "KEYWORD_MATCH",
      socialAccount: { platform: "INSTAGRAM", isActive: true },
    },
    select: { keywords: true },
  });

  const matched: MentionSuggestion[] = [];

  for (const rule of rules) {
    for (const keyword of rule.keywords) {
      if (city && keyword.toLowerCase().includes(city.toLowerCase())) {
        matched.push({ username: keyword, type: "LOCAL_SPOT" });
      }
    }
  }

  const fallback = country ? DEFAULT_MENTIONS[country] : null;
  if (fallback) matched.push(...fallback);

  return matched.slice(0, 3);
}

export async function addMentionRule(
  orgId: string,
  socialAccountId: string,
  keyword: string,
  username: string,
): Promise<void> {
  await prisma.socialAutomationRule.create({
    data: {
      orgId,
      socialAccountId,
      name: `Instagram mention: @${username}`,
      triggerType: "KEYWORD_MATCH",
      keywords: [keyword, username],
      action: "AI_REPLY",
      isActive: true,
    },
  });
}
