/**
 * Document OS API Routes
 */

import { Elysia, t } from 'elysia';
import { documentOSService } from '../services/document-os';

export const documentOSRoutes = new Elysia({ prefix: '/documents' })
  /**
   * POST /api/documents/upload
   * Upload document
   */
  .post('/upload', async ({ body, set }) => {
    try {
      const document = await documentOSService.uploadDocument(body, body.file);
      return document;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to upload document' };
    }
  })

  /**
   * POST /api/documents/from-template
   * Create document from template
   */
  .post('/from-template', async ({ body, set }) => {
    try {
      const document = await documentOSService.createFromTemplate(
        body.templateId,
        body.variables,
        body.orgId
      );
      return document;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create document from template' };
    }
  }, {
    body: t.Object({
      templateId: t.String(),
      variables: t.Record(t.String, t.Any()),
      orgId: t.String()
    })
  })

  /**
   * POST /api/documents/:id/signature
   * Request digital signature
   */
  .post('/:id/signature', async ({ params, body, set }) => {
    try {
      const signatureRequests = await documentOSService.requestSignature(
        params.id,
        body.signers
      );
      return signatureRequests;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to request signature' };
    }
  }, {
    body: t.Object({
      signers: t.Array(t.Object({
        email: t.String(),
        name: t.String()
      }))
    })
  })

  /**
   * POST /api/documents/:id/approve
   * Approve document
   */
  .post('/:id/approve', async ({ params, body, set }) => {
    try {
      const document = await documentOSService.approveDocument(
        params.id,
        body.approverId,
        body.comments
      );
      return document;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to approve document' };
    }
  }, {
    body: t.Object({
      approverId: t.String(),
      comments: t.Optional(t.String())
    })
  })

  /**
   * POST /api/documents/:id/version
   * Create new version
   */
  .post('/:id/version', async ({ params, body, set }) => {
    try {
      const version = await documentOSService.createVersion(params.id, body.file);
      return version;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create version' };
    }
  })

  /**
   * GET /api/documents/search
   * Search documents
   */
  .get('/search', async ({ query, set }) => {
    try {
      const documents = await documentOSService.searchDocuments(
        query.query,
        {
          documentType: query.documentType,
          status: query.status,
          organizationId: query.orgId,
          tags: query.tags?.split(',')
        }
      );
      return documents;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to search documents' };
    }
  })

  /**
   * GET /api/documents/:id/timeline
   * Get document timeline
   */
  .get('/:id/timeline', async ({ params, set }) => {
    try {
      const timeline = await documentOSService.getDocumentTimeline(params.id);
      return timeline;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get document timeline' };
    }
  })

  /**
   * POST /api/documents/:id/archive
   * Archive document
   */
  .post('/:id/archive', async ({ params, set }) => {
    try {
      const document = await documentOSService.archiveDocument(params.id);
      return document;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to archive document' };
    }
  })

  /**
   * DELETE /api/documents/:id
   * Delete document
   */
  .delete('/:id', async ({ params, set }) => {
    try {
      await documentOSService.deleteDocument(params.id);
      return { success: true };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to delete document' };
    }
  });
