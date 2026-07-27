/**
 * Portfolio Import Routes
 *
 * API endpoints for importing portfolio data from XLSX/CSV files.
 * Handles file upload, preview, and execution.
 */
import { Elysia, t } from 'elysia';
import { authMiddleware } from '../middleware/auth';
import { importPortfolio, importAllFromDirectory } from '../services/portfolio-import';
import { scrapeAnthillOfficial, downloadProjectAssets, exportScrapedData } from '../services/project-scraper';
import * as fs from 'fs';
import * as path from 'path';

const UPLOAD_DIR = path.join(__dirname, '../../uploads/imports');

export const portfolioImportRoutes = new Elysia({ prefix: '/portfolio/import' })
  .use(authMiddleware)

  // ─── Upload & Parse XLSX/CSV ──────────────────────────────────
  .post('/upload', async ({ body, auth }: any) => {
    // In real implementation, handle multipart file upload
    // For now, expect file path
    const { filePath, projectName, projectAddress, city, district, region } = body as any;

    if (!filePath || !projectName) {
      return { success: false, msg: 'filePath and projectName are required' };
    }

    const result = await importPortfolio({
      filePath,
      projectName,
      projectAddress: projectAddress || 'İstanbul',
      city: city || 'Istanbul',
      district: district || '',
      region: region || 'TR',
      dryRun: false,
    });

    return { success: result.success, data: result };
  }, {
    body: t.Object({
      filePath: t.String(),
      projectName: t.String(),
      projectAddress: t.Optional(t.String()),
      city: t.Optional(t.String()),
      district: t.Optional(t.String()),
      region: t.Optional(t.String()),
    }),
  })

  // ─── Preview (Dry Run) ────────────────────────────────────────
  .post('/preview', async ({ body }: any) => {
    const { filePath, projectName } = body as any;

    if (!filePath || !projectName) {
      return { success: false, msg: 'filePath and projectName are required' };
    }

    const result = await importPortfolio({
      filePath,
      projectName,
      dryRun: true,
    });

    return { success: true, data: result };
  }, {
    body: t.Object({
      filePath: t.String(),
      projectName: t.String(),
    }),
  })

  // ─── Bulk Import from Directory ───────────────────────────────
  .post('/bulk', async ({ body }: any) => {
    const { directory, region } = body as any;

    if (!directory) {
      return { success: false, msg: 'directory is required' };
    }

    const results = await importAllFromDirectory(directory, { region: region || 'TR' });

    return {
      success: true,
      data: {
        totalFiles: results.length,
        totalImported: results.reduce((sum, r) => sum + r.imported, 0),
        results,
      },
    };
  }, {
    body: t.Object({
      directory: t.String(),
      region: t.Optional(t.String()),
    }),
  })

  // ─── Scrape from Web ──────────────────────────────────────────
  .post('/scrape', async ({ body }: any) => {
    const { projectName, downloadImages } = body as any;

    if (projectName !== 'anthill') {
      return { success: false, msg: 'Only "anthill" is currently supported for web scraping' };
    }

    const project = await scrapeAnthillOfficial();

    if (downloadImages) {
      await downloadProjectAssets(project, UPLOAD_DIR);
    }

    exportScrapedData(project, UPLOAD_DIR);

    return {
      success: true,
      data: {
        name: project.name,
        developer: project.developer,
        amenities: project.amenities.length,
        images: project.images.length,
        floorPlans: project.floorPlans.length,
        pricing: project.pricing,
        scrapedDataPath: `/uploads/projects/${project.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}-scraped.json`,
      },
    };
  }, {
    body: t.Object({
      projectName: t.String(),
      downloadImages: t.Optional(t.Boolean()),
    }),
  })

  // ─── Import History ───────────────────────────────────────────
  .get('/history', async () => {
    // In real implementation, read from ImportHistory table
    return {
      success: true,
      data: {
        imports: [],
        message: 'Import history tracking coming soon',
      },
    };
  });
