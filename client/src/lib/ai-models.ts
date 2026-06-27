// AI Models configuration
export enum AIModelCategory {
  REASONING = "Reasoning",
  VISION = "Vision",
  SPEECH_TO_TEXT = "Speech to Text",
  TEXT_TO_TEXT = "Text to Text",
  MULTILINGUAL = "Multilingual",
  SAFETY = "Safety",
}

export const AI_MODELS = [
  {
    id: "gpt-4",
    name: "GPT-4",
    description: "Most capable model, great for complex tasks",
    provider: "OpenAI",
    maxTokens: 8192,
    costPerToken: 0.00003,
    category: AIModelCategory.REASONING,
  },
  {
    id: "gpt-3.5-turbo",
    name: "GPT-3.5 Turbo",
    description: "Fast and efficient for most tasks",
    provider: "OpenAI",
    maxTokens: 4096,
    costPerToken: 0.000002,
    category: AIModelCategory.TEXT_TO_TEXT,
  },
  {
    id: "claude-3",
    name: "Claude 3",
    description: "Advanced reasoning and analysis",
    provider: "Anthropic",
    maxTokens: 100000,
    costPerToken: 0.000015,
    category: AIModelCategory.SAFETY,
  },
  {
    id: "gemini-pro",
    name: "Gemini Pro",
    description: "Google's advanced multimodal model",
    provider: "Google",
    maxTokens: 32768,
    costPerToken: 0.000025,
    category: AIModelCategory.VISION,
  },
  {
    id: "gemini-pro-vision",
    name: "Gemini Pro Vision",
    description: "Multimodal model with advanced vision capabilities",
    provider: "Google",
    maxTokens: 32768,
    costPerToken: 0.000025,
    category: AIModelCategory.VISION,
  },
  {
    id: "gemini-ultra",
    name: "Gemini Ultra",
    description: "Google's most capable model for complex reasoning",
    provider: "Google",
    maxTokens: 100000,
    costPerToken: 0.00005,
    category: AIModelCategory.REASONING,
  },
];

export const AI_TOOLS = [
  {
    id: "text-generation",
    name: "Text Generation",
    description: "Generate human-like text content",
    icon: "FileText",
  },
  {
    id: "image-generation",
    name: "Image Generation",
    description: "Create images from text descriptions",
    icon: "Image",
  },
  {
    id: "code-generation",
    name: "Code Generation",
    description: "Generate and debug code",
    icon: "Code",
  },
  {
    id: "data-analysis",
    name: "Data Analysis",
    description: "Analyze and visualize data",
    icon: "BarChart",
  },
];
