/**
 * A1111 (Automatic1111 Stable Diffusion WebUI) Integration
 * 
 * Free, local alternative to ComfyUI for virtual staging.
 */

export { A1111Client, getA1111Client } from './client';
export type {
    A1111Config,
    Txt2ImgRequest,
    Img2ImgRequest,
    GenerationResponse,
    HealthStatus,
    StagingOptions,
} from './client';
