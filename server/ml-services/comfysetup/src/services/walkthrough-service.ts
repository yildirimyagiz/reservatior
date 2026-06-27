import type { WalkthroughInput, WalkthroughOutput } from "@/types/walkthrough";

export const walkthroughService = {
  selectPipeline: async (input: WalkthroughInput): Promise<unknown> => { // Keep any for now if return type undefined
    const res = await fetch("/api/v1/walkthroughs/select-pipeline", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(input),
    });
    if (!res.ok) throw new Error("Failed to select pipeline");
    return res.json();
  },

  generate: async (input: WalkthroughInput): Promise<WalkthroughOutput> => {
    const res = await fetch("/api/v1/walkthroughs/generate", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(input),
    });
    if (!res.ok) throw new Error("Failed to start generation");
    return res.json();
  },

  getStatus: async (jobId: string): Promise<WalkthroughOutput> => {
    const res = await fetch(`/api/v1/walkthroughs/status/${jobId}`);
    if (!res.ok) throw new Error("Failed to get status");
    return res.json();
  }
};
