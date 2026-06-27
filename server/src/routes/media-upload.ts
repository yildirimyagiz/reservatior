import { Elysia, t } from "elysia";
import { mkdir, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { v4 as uuidv4 } from "uuid";

const BASE_UPLOAD_PATH = join(process.cwd(), "ml-services", "comfysetup", "backend", "uploads");

export const mediaUploadRoutes = new Elysia({ prefix: "/media" })
  .post("/upload", async ({ body, set }) => {
    const { file, type, category, countryCode, stateCode, cityCode, propertyType, processingType, orgId, propertyId } = body;

    // Validate file
    if (!file) {
      set.status = 400;
      return { error: "No physical payload detected" };
    }

    // Determine target directory based on category and country
    // Structure: uploads/{countryCode}/{stateCode}/{cityCode}/{propertyType}/{fileCategory}/{processingType}/{orgId}/{propertyId}/
    const targetSubDir = ['videos', 'images', 'documents', 'floorplans', 'contracts', 'temp', 'processed'].includes(category) 
      ? category 
      : 'temp';
    
    // Build hierarchical path: country → state → city → propertyType → fileCategory → processingType → org → property
    const countryDir = countryCode || 'GLOBAL';
    const stateDir = stateCode || 'default-state';
    const cityDir = cityCode || 'default-city';
    const propertyTypeDir = propertyType || 'UNKNOWN';
    const processingTypeDir = processingType || 'raw';
    const orgDir = orgId || 'default-org';
    const propertyDir = propertyId || 'default-property';
    
    const targetDir = join(BASE_UPLOAD_PATH, countryDir, stateDir, cityDir, propertyTypeDir, targetSubDir, processingTypeDir, orgDir, propertyDir);
    
    // Ensure directory exists
    await mkdir(targetDir, { recursive: true });

    // Generate unique filename
    const extension = file.name.split('.').pop();
    const fileName = `${uuidv4()}.${extension}`;
    const filePath = join(targetDir, fileName);

    // Write file to disk
    const buffer = await file.arrayBuffer();
    await writeFile(filePath, Buffer.from(buffer));

    // Prepare response with hierarchical URL
    const relativeUrl = `/uploads/${countryDir}/${stateDir}/${cityDir}/${propertyTypeDir}/${targetSubDir}/${processingTypeDir}/${orgDir}/${propertyDir}/${fileName}`;

    // Trigger ML processing for documents
    let mlProcessingId = null;
    if (category === 'documents' && type === 'IDENTITY_DOCUMENT' || type === 'TITLE_DEED') {
      // In production, this would trigger ML processing
      mlProcessingId = uuidv4();
      // TODO: Call ML service for OCR and validation
    }

    return {
      success: true,
      data: {
        id: uuidv4(),
        fileName,
        originalName: file.name,
        category: targetSubDir,
        url: relativeUrl,
        path: filePath,
        mimeType: file.type,
        size: file.size,
        countryCode,
        stateCode,
        cityCode,
        propertyType,
        processingType,
        orgId,
        propertyId,
        mlProcessingId,
        timestamp: new Date().toISOString()
      },
      msg: "Media synchronized to Neural Hub"
    };
  }, {
    body: t.Object({
      file: t.File(),
      type: t.Optional(t.String()),     // e.g. "PROPERTY_VIDEO", "IDENTITY_DOCUMENT", "TITLE_DEED"
      category: t.String(),              // e.g. "videos" | "images" | "documents" | "floorplans" | "contracts"
      countryCode: t.Optional(t.String()), // e.g. "TR", "US", "UK"
      stateCode: t.Optional(t.String()),   // e.g. "34", "NY", "ENG"
      cityCode: t.Optional(t.String()),   // e.g. "IST", "NYC", "LON"
      propertyType: t.Optional(t.String()), // e.g. "APARTMENT", "VILLA", "DETACHED_HOUSE"
      processingType: t.Optional(t.String()), // e.g. "raw", "processed", "ocr", "validated"
      orgId: t.Optional(t.String()),     // Organization ID
      propertyId: t.Optional(t.String()) // Property ID
    })
  })
  // Endpoint to check processing status
  .get("/status/:id", async ({ params }) => {
    return {
      id: params.id,
      status: "QUEUED",
      engine: "ComfyUI/SDXL",
      progress: 0,
      eta: "Calculated after node assignment"
    };
  })
  // Endpoint to trigger ML processing for uploaded file
  .post("/process/:fileId", async ({ params, body, set }) => {
    const { processingType } = body;
    
    // In production, this would trigger actual ML processing
    // For now, return a processing job ID
    return {
      success: true,
      jobId: uuidv4(),
      fileId: params.fileId,
      processingType,
      status: "QUEUED",
      message: "ML processing job queued"
    };
  }, {
    params: t.Object({ fileId: t.String() }),
    body: t.Object({
      processingType: t.String() // e.g. "OCR", "FRAUD_DETECTION", "FACE_RECOGNITION"
    })
  });
