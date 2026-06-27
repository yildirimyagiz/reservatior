
export interface VoiceoverInput {
  text: string;
  language: string;
  voice?: string;
}

export interface VoiceoverOutput {
  audioUrl: string;
  duration?: number;
}

export const voiceoverService = {
  generate: async (input: VoiceoverInput): Promise<VoiceoverOutput> => {
    const res = await fetch("/api/v1/voiceover/generate", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(input),
    });
    
    if (!res.ok) {
        const errorText = await res.text();
        throw new Error(errorText || "Failed to generate voiceover");
    }
    
    return res.json();
  }
};
