import imaps from 'imap-simple';
import { simpleParser } from 'mailparser';
import nodemailer from 'nodemailer';
import { GoogleGenerativeAI } from '@google/generative-ai';

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');

export class AIMailResponderService {
  private static isRunning = false;

  public static async startPolling() {
    if (this.isRunning) return;
    this.isRunning = true;
    
    console.log('[AI-MAIL] Starting IMAP polling for info@reservatior.com...');

    // Run immediately, then every 60 seconds
    this.checkEmails();
    setInterval(() => this.checkEmails(), 60 * 1000);
  }

  private static async checkEmails() {
    try {
      const config = {
        imap: {
          user: process.env.EMAIL_USER || '',
          password: process.env.EMAIL_PASS || '',
          host: process.env.EMAIL_HOST || 'mail.reservatior.com',
          port: parseInt(process.env.EMAIL_PORT || '993', 10),
          tls: true,
          tlsOptions: { rejectUnauthorized: false },
          authTimeout: 3000,
        }
      };

      if (!config.imap.user || !config.imap.password) {
        console.warn('[AI-MAIL] Missing email credentials in .env. Skipping.');
        return;
      }

      const connection = await imaps.connect(config);
      await connection.openBox('INBOX');

      // Search for unread messages
      const searchCriteria = ['UNSEEN'];
      const fetchOptions = {
        bodies: ['HEADER', 'TEXT', ''],
        markSeen: true
      };

      const messages = await connection.search(searchCriteria, fetchOptions);

      if (messages.length > 0) {
        console.log(`[AI-MAIL] Found ${messages.length} unread messages.`);
      }

      for (const item of messages) {
        const allPart = item.parts.find((part) => part.which === '');
        if (!allPart) continue;

        const mail = await simpleParser(allPart.body);
        const from = mail.from?.value[0]?.address;
        const subject = mail.subject || 'No Subject';
        const text = mail.text || '';

        console.log(`[AI-MAIL] Processing email from: ${from} | Subject: ${subject}`);

        if (!from || from.includes('mailer-daemon') || from.includes('noreply')) {
          continue; // Ignore automated bounces
        }

        // Process with Gemini AI
        const replyHtml = await this.generateAIResponse(subject, text);

        // Send Reply
        await this.sendReply(from, subject, replyHtml);
        
        console.log(`[AI-MAIL] Successfully replied to ${from}`);
      }

      connection.end();
    } catch (err) {
      console.error('[AI-MAIL] IMAP connection or processing error:', err);
    }
  }

  private static async generateAIResponse(subject: string, text: string): Promise<string> {
    const model = genAI.getGenerativeModel({ model: 'gemini-2.5-flash' });

    const prompt = `
    You are an elite, highly professional AI luxury travel and real estate concierge for "Reservatior".
    You are reading an incoming email from a client.
    
    Email Subject: ${subject}
    Email Body:
    "${text}"

    Task:
    Analyze the client's request. 
    1. If they are asking for hotel/accommodation recommendations or prices, provide a highly persuasive, luxurious response stating that our concierges are preparing a curated list of B2B luxury properties (mention we save them up to 30% compared to booking platforms) and we will send them exact options shortly.
    2. If it is a support request or general inquiry, give a polite, high-end customer service response saying their request has been prioritized and a dedicated agent will contact them soon.
    
    Output format: Return ONLY valid HTML that can be directly used as the body of an email. 
    Design the HTML to look elegant, using a clean sans-serif font (like Arial or Helvetica), dark gray text, and a professional signature from "Reservatior AI Concierge". Do not use markdown blocks like \`\`\`html.
    `;

    try {
      const result = await model.generateContent(prompt);
      const response = result.response.text();
      return response.replace(/```html/g, '').replace(/```/g, '').trim();
    } catch (err) {
      console.error('[AI-MAIL] Gemini generation failed:', err);
      return `<p>Değerli Müşterimiz,</p><p>E-postanız tarafımıza ulaşmıştır. Lüks konaklama ve gayrimenkul talebinizle ilgili uzman ekibimiz sizinle en kısa sürede iletişime geçecektir.</p><p>Saygılarımızla,<br><strong>Reservatior AI Concierge</strong></p>`;
    }
  }

  private static async sendReply(to: string, originalSubject: string, htmlBody: string) {
    const transporter = nodemailer.createTransport({
      host: process.env.EMAIL_HOST || 'mail.reservatior.com',
      port: parseInt(process.env.EMAIL_PORT || '465', 10),
      secure: process.env.EMAIL_SECURE === 'true',
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS,
      },
      tls: {
        rejectUnauthorized: false
      }
    });

    const replySubject = originalSubject.startsWith('Re:') ? originalSubject : `Re: ${originalSubject}`;

    await transporter.sendMail({
      from: `"${process.env.SMTP_FROM_NAME || 'Reservatior AI Concierge'}" <${process.env.EMAIL_FROM || process.env.EMAIL_USER}>`,
      to,
      bcc: 'yagizyildirim@icloud.com',
      subject: replySubject,
      html: htmlBody,
    });
  }
}
