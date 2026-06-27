import { Elysia, t } from 'elysia';
import { getWhatsAppService } from '../../services/whatsapp-service';

export const whatsappRouter = new Elysia({ prefix: '/whatsapp' })
  .get('/status', async () => {
    try {
      const service = getWhatsAppService();
      const status = await service.getStatus();
      return {
        success: true,
        data: status
      };
    } catch (error) {
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Failed to get WhatsApp status'
      };
    }
  })

  .post('/initialize', async () => {
    try {
      const service = getWhatsAppService();
      await service.initialize();
      return {
        success: true,
        message: 'WhatsApp service initialized successfully'
      };
    } catch (error) {
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Failed to initialize WhatsApp service'
      };
    }
  })

  .get('/qr', async () => {
    try {
      const service = getWhatsAppService();
      const qrCode = await service.getQRCode();
      return {
        success: true,
        data: { qrCode }
      };
    } catch (error) {
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Failed to generate QR code'
      };
    }
  })

  .post('/send', async ({ body }) => {
    try {
      const service = getWhatsAppService();
      await service.sendMessage(body);
      return {
        success: true,
        message: 'Message sent successfully'
      };
    } catch (error) {
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Failed to send message'
      };
    }
  }, {
    body: t.Object({
      to: t.String(),
      body: t.String(),
      mediaUrl: t.Optional(t.String())
    })
  })

  .post('/send-bulk', async ({ body }) => {
    try {
      const service = getWhatsAppService();
      await service.sendBulkMessages(body.messages);
      return {
        success: true,
        message: `Sent ${body.messages.length} messages successfully`
      };
    } catch (error) {
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Failed to send bulk messages'
      };
    }
  }, {
    body: t.Object({
      messages: t.Array(t.Object({
        to: t.String(),
        body: t.String(),
        mediaUrl: t.Optional(t.String())
      }))
    })
  })

  .post('/disconnect', async () => {
    try {
      const service = getWhatsAppService();
      await service.disconnect();
      return {
        success: true,
        message: 'WhatsApp service disconnected successfully'
      };
    } catch (error) {
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Failed to disconnect WhatsApp service'
      };
    }
  });
