import { t } from "i18next";
export type AIModelCategory = "Reasoning" | "Speech to Text" | "Text to Text" | "Vision" | "Function Calling" | "Multilingual" | "Safety";
export type AIModel = {
  id: string;
  name: string;
  provider: string;
  category: AIModelCategory;
  description: string;
  icon?: string;
};
export const AI_MODELS: AIModel[] = [
// Reasoning
{
  id: "gpt-oss-120b",
  name: "GPT OSS 120B",
  provider: "Open Source",
  category: "Reasoning",
  description: t("client.src.highcomplexity_spatial_reasoning_for")
}, {
  id: "gpt-oss-20b",
  name: "GPT OSS 20B",
  provider: "Open Source",
  category: "Reasoning",
  description: t("client.src.fast_logic_for_transition")
}, {
  id: "qwen-3-32b",
  name: "Qwen 3 32B",
  provider: "Alibaba",
  category: "Reasoning",
  description: t("client.src.optimized_for_multilingual_context")
},
// Vision
{
  id: "llama-4-scout",
  name: "Llama 4 Scout",
  provider: "Meta",
  category: "Vision",
  description: t("client.src.advanced_scene_understanding_and")
}, {
  id: "llama-4-maverick",
  name: "Llama 4 Maverick",
  provider: "Meta",
  category: "Vision",
  description: t("client.src.creative_framing_and_aesthetic")
},
// Speech to Text
{
  id: "whisper-large-v3",
  name: "Whisper Large v3",
  provider: "OpenAI",
  category: "Speech to Text",
  description: t("client.src.stateoftheart_transcription")
}, {
  id: "whisper-turbo",
  name: "Whisper Large v3 Turbo",
  provider: "OpenAI",
  category: "Speech to Text",
  description: t("client.src.realtime_voice_command_processing")
},
// Text to Text / Multilingual
{
  id: "kimi-k2",
  name: "Kimi K2",
  provider: "Moonshot",
  category: "Text to Text",
  description: t("client.src.longcontext_understanding_for_property")
}, {
  id: "llama-3-3-70b",
  name: "Llama 3.3 70B",
  provider: "Meta",
  category: "Multilingual",
  description: t("client.src.excellent_translation_capabilities")
},
// TTS
{
  id: "playai-tts",
  name: "PlayAI TTS",
  provider: "Play.ai",
  category: "Text to Text",
  description: t("client.src.ultrarealistic_voiceovers")
},
// Safety
{
  id: "safety-gpt-20b",
  name: "Safety GPT OSS 20B",
  provider: "Open Source",
  category: "Safety",
  description: t("client.src.content_moderation_and_compliance")
}, {
  id: "llama-guard",
  name: "Llama Guard",
  provider: "Meta",
  category: "Safety",
  description: t("client.src.inputoutput_safety_classification")
}];