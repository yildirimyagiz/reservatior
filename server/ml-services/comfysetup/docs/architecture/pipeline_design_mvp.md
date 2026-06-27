# Production AI Pipeline Design: Real Estate Virtual Staging SaaS (MVP)

## 1. High-Level Architecture

```mermaid
graph TD
    User[Real Estate Agent] -->|Uploads Photos| Web[Next.js App (VPS)]
    Web -->|Auth & Validation| DB[(PostgreSQL)]
    Web -->|Push Job| Queue[(Redis Queue)]

    subgraph "Infrastructure (Cost-Optimized)"
        Queue -->|Pop Job| Orchestrator[Job Orchestrator]
        Orchestrator -->|Scale Up| GPU_Cloud[RunPod Serverless]
        GPU_Cloud -->|ComfyUI API| Workflow[Staging/Video Pipeline]
    end

    subgraph "AI Pipeline (SD 1.5)"
        Workflow -->|1. Segment| Detectron2[Room Segmentation]
        Workflow -->|2. Analysis| Depth[MiDaS Depth]
        Workflow -->|3. Geneation| SD15[Stable Diffusion 1.5]
        SD15 -->|Control| CN[ControlNet Depth]
        SD15 -->|Style| IP[IP-Adapter]

        Workflow -->|4. Video?| VideoDecision{Decision}
        VideoDecision -->|Simple| Parallax[2.5D Parallax]
        VideoDecision -->|Complex| InstantNGP[InstantNGP NeRF]
        VideoDecision -->|Premium| Gaussian[Gaussian Splatting]
    end

    Workflow -->|Result| S3[Object Storage]
    S3 -->|URL| Web
    Web -->|Notification| User
```

## 2. Step-by-Step Pipeline Flow

### Stage 1: Input & Validation

1.  **Upload**: User uploads 1-20 empty room photos (JPG/PNG).
    - _Constraint_: Min 512px, Max 4k.
2.  **Normalization**: Client-side resize to max 2048px (long edge) to save bandwidth.
3.  **Validation**:
    - Check aspect ratio (reject extreme panoramas).
    - Check brightness/blur (OpenCV check on server).

### Stage 2: Pre-Processing (CPU/Light GPU)

1.  **Segmentation**: Run **Detectron2** or **SAM** to identify:
    - Floor (critical for placing items)
    - Walls (for vertical alignment)
    - Windows (to avoid covering views)
2.  **Mask Generation**: Create "furnishable area" mask.
3.  **Depth Map**: Generate depth map using **MiDaS** (fast, optimized for SD 1.5).

### Stage 3: Image Staging Pipeline (CORE)

_Engine: ComfyUI on RunPod (Stateless)_

1.  **Model Loading**: Load `v1-5-pruned-emaonly.ckpt` (Cached on worker).
2.  **Conditioning**:
    - **Positive Prompt**: "Modern minimalist living room, interior design, photorealistic, 4k, architectural photography" + [Furniture keywords].
    - **ControlNet**: Apply `control_v11f1p_sd15_depth` at **0.8 strength**.
    - **IP-Adapter**: Load `ip-adapter-plus_sd15.bin` with "Amazon furniture" reference image (0.6 strength).
3.  **Inpainting**: Use `VAEEncodeForInpaint` with the generated Floor Mask.
4.  **Sampling**:
    - Sampler: `dpmpp_2m_karras` (Speed/Quality balance).
    - Steps: 20-25.
    - CFG: 7.0.
5.  **Refinement**: Optional `IMG2IMG` pass at 0.3 denoising for texture sharpening.

### Stage 4: Video Pipeline Strategy

_Logic based on `PipelineInputSchema`_

1.  **Assessment**: Check `photo_count`, `plan`, `luxury_flag`.
2.  **Execution**:
    - **2.5D Parallax**:
      - Take staged SD 1.5 output + Depth Map.
      - Apply simple camera translation (dolly-in).
      - _Cost: Near zero (CPU)._
    - **InstantNGP**:
      - Train lightweight NeRF from staged images.
      - Render smooth camera path.
      - _Cost: Low (Seconds of GPU)._
    - **Gaussian Splatting (Premium)**:
      - Only trigger if strictly required.
      - Train Splat from high-res staged images.
      - Render cinematic flythrough.
      - _Cost: High (Minutes of GPU)._

## 3. Decision Logic

| Scenario                  | Tier    | Action                         | Rationale                                            |
| :------------------------ | :------ | :----------------------------- | :--------------------------------------------------- |
| **Trial User**            | Free    | SD 1.5 Staging + Watermark     | Minimal cost, proves value.                          |
| **Single Photo**          | Any     | SD 1.5 Staging + 2.5D Parallax | Video impossible with 1 photo. Parallax adds "life". |
| **Apartment (6 photos)**  | Basic   | SD 1.5 + InstantNGP            | Good enough continuity, cheap.                       |
| **Penthouse (20 photos)** | Premium | SD 1.5 + Gaussian Splat        | Max quality for high-ticket user.                    |

## 4. Cost-Optimization

1.  **SD 1.5 over SDXL**:
    - 4x faster inference.
    - 4x lower VRAM usage (cheaper GPU instances).
    - Massive ControlNet compatibility.
    - _Result_: $0.002 per image vs $0.01+.
2.  **RunPod Serverless**:
    - Spin up GPU only when Queue > 0.
    - Scale to 0 when idle.
    - Spot instances enabled for 60% savings.
3.  **Strict Limits**:
    - Daily generation caps per tier.
    - Resolution cap at 1024x1024 for non-premium.

## 5. MVP vs Scale

| Feature     | MVP (Now)             | Scale (Future)         |
| :---------- | :-------------------- | :--------------------- |
| **Queue**   | Redis (BullMQ) on VPS | Managed SQS / Kafka    |
| **GPU**     | RunPod Serverless     | Dedicated H100 Cluster |
| **Staging** | ComfyUI SD 1.5        | ComfyUI SDXL / Flux    |
| **Video**   | Parallax / InstantNGP | 4D Gaussian Splatting  |
| **Storage** | Local / S3            | CDN + Edge Caching     |
| **Auth**    | NextAuth + Database   | Enterprise SSO         |

## 6. Implementation Notes for Developer

- **ComfyUI Workflow**: Ensure `ckpt_name` is set to SD 1.5. using SDXL nodes will crash the cost model.
- **Seed Locking**: If staging multiple photos of the same room, share the `seed` to maintain style consistency.
- **Safety**: Implement `NSFW` filter at the end of the pipeline.
