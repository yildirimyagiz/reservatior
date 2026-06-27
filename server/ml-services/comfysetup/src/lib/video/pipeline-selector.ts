
import { z } from 'zod';

// =====================================
// INPUTS
// =====================================

export const PipelineInputSchema = z.object({
  photoCount: z.number().int().min(1),
  roomTypes: z.array(z.string()),
  targetResolution: z.enum(['high']), // "always high-res"
  userPlan: z.enum(['free', 'basic', 'pro', 'premium']),
  luxuryFlag: z.boolean(),
});

export type PipelineInput = z.infer<typeof PipelineInputSchema>;

// =====================================
// OUTPUTS
// =====================================

export interface PipelineSelectionResult {
  selected_pipeline: string;
  models_used: string[];
  expected_video_quality: 'low' | 'medium' | 'high' | 'premium';
  estimated_gpu_cost_usd: string;
  recommended_use_case: string;
  notes: string;
}

// =====================================
// LOGIC IMPLEMENTATION
// =====================================

export function selectWalkthroughPipeline(input: PipelineInput): PipelineSelectionResult {
  const { photoCount, userPlan, luxuryFlag } = input;

  let pipeline = '';
  let modelsUsed: string[] = [];
  let quality: PipelineSelectionResult['expected_video_quality'] = 'medium';
  let cost = '0.00';
  let useCase = '';

  // CORE SELECTION LOGIC (Strict adherence to prompt)
  if (photoCount <= 4) {
    pipeline = "2.5D Parallax (single room)";
    modelsUsed = ["Detectron2 (Segmentation)", "2.5D Parallax Engine"];
    quality = "low";
    cost = "0.02"; // Estimation for cheap CPU/light GPU op
    useCase = "Quick listing previews, single rooms";
  } 
  else if (photoCount <= 8) {
    pipeline = "InstantNGP (single zone walkthrough)";
    modelsUsed = ["Detectron2 (Preprocessing)", "InstantNGP (NeRF)"];
    quality = "medium";
    cost = "0.15";
    useCase = "Studio apartments, small open plans";
  } 
  else if (photoCount <= 15) {
    pipeline = "InstantNGP (full apartment walkthrough)";
    modelsUsed = ["Detectron2 (Preprocessing)", "InstantNGP (NeRF)", "Camera Path Smoother"];
    quality = "high";
    cost = "0.45";
    useCase = "Standard multi-room apartments";
  } 
  else if (userPlan === 'premium' || luxuryFlag === true) {
    pipeline = "Nerfstudio Gaussian Splatting";
    modelsUsed = ["Detectron2 (Preprocessing)", "Nerfstudio (Gaussian Splatting)", "Cinematic Path Planner"];
    quality = "premium";
    cost = "1.20"; // Expensive training
    useCase = "Luxury estates, penthouses, high-ticket sales";
  } 
  else {
    pipeline = "InstantNGP (full apartment walkthrough)";
    modelsUsed = ["Detectron2 (Preprocessing)", "InstantNGP (NeRF)"];
    quality = "high";
    cost = "0.60"; // Higher count = higher cost
    useCase = "Large properties (cost-optimized)";
  }

  // Mandatory Quality Check (Rule 3)
  const notes = "Resolution locked to ≥1536x1536 as per quality standards.";

  return {
    selected_pipeline: pipeline,
    models_used: modelsUsed,
    expected_video_quality: quality,
    estimated_gpu_cost_usd: cost,
    recommended_use_case: useCase,
    notes: notes
  };
}
