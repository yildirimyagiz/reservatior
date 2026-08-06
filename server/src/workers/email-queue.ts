/**
 * Email Queue Worker using BullMQ
 * Handles bulk email sending with rate limiting and exponential backoff
 * Provider: SendGrid / Mailgun (configurable)
 * Rate Limit: 100 emails/minute (provider-specific)
 */

import { Queue, Worker, Job } from 'bullmq';
import Redis from 'ioredis';
import nodemailer from 'nodemailer';

const redisUrl = process.env.REDIS_URL || 'redis://localhost:6379';
const connection = new Redis(redisUrl);

// Email Queue
export const emailQueue = new Queue('email-sending', { connection });

interface EmailJobData {
  to: string;
  subject: string;
  html: string;
  text?: string;
  type: 'NOTIFICATION' | 'MARKETING' | 'INVITATION' | 'VERIFICATION' | 'RECOVERY';
  userId?: string;
  propertyId?: string;
  metadata?: Record<string, any>;
}

/**
 * Email Provider Configuration
 */
const EMAIL_PROVIDER = process.env.EMAIL_PROVIDER || 'smtp';
const EMAIL_HOST = process.env.EMAIL_HOST || 'mail.reservatior.com';
const EMAIL_PORT = parseInt(process.env.EMAIL_PORT || '465');
const EMAIL_SECURE = process.env.EMAIL_SECURE === 'true';
const EMAIL_USER = process.env.EMAIL_USER;
const EMAIL_PASS = process.env.EMAIL_PASS;
const EMAIL_FROM = process.env.EMAIL_FROM || 'info@reservatior.com';

// SendGrid Configuration
const SENDGRID_API_KEY = process.env.SENDGRID_API_KEY;

// Mailgun Configuration
const MAILGUN_API_KEY = process.env.MAILGUN_API_KEY;
const MAILGUN_DOMAIN = process.env.MAILGUN_DOMAIN;

/**
 * Rate limiting: 100 emails/minute per provider
 */
const RATE_LIMIT_PER_MINUTE = 100;
const BATCH_SIZE = 500; // Process in batches of 500

/**
 * Create SMTP transporter
 */
const smtpTransporter = nodemailer.createTransport({
  host: EMAIL_HOST,
  port: EMAIL_PORT,
  secure: EMAIL_SECURE,
  auth: {
    user: EMAIL_USER,
    pass: EMAIL_PASS,
  },
});

/**
 * Send email via SMTP
 */
async function sendViaSMTP(
  to: string,
  subject: string,
  html: string,
  text?: string
): Promise<boolean> {
  try {
    const info = await smtpTransporter.sendMail({
      from: EMAIL_FROM,
      to,
      subject,
      html,
      text,
    });
    console.log('[Email Queue] SMTP email sent:', info.messageId);
    return true;
  } catch (error) {
    console.error('[Email Queue] SMTP error:', error);
    return false;
  }
}

/**
 * Send email via SendGrid
 */
async function sendViaSendGrid(
  to: string,
  subject: string,
  html: string,
  text?: string
): Promise<boolean> {
  try {
    const response = await fetch('https://api.sendgrid.com/v3/mail/send', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SENDGRID_API_KEY}`,
      },
      body: JSON.stringify({
        personalizations: [
          {
            to: [{ email: to }],
            subject,
          },
        ],
        from: { email: EMAIL_FROM },
        content: [
          { type: 'text/html', value: html },
          ...(text ? [{ type: 'text/plain', value: text }] : []),
        ],
      }),
    });

    return response.status === 202;
  } catch (error) {
    console.error('[Email Queue] SendGrid error:', error);
    return false;
  }
}

/**
 * Send email via Mailgun
 */
async function sendViaMailgun(
  to: string,
  subject: string,
  html: string,
  text?: string
): Promise<boolean> {
  try {
    const formData = new URLSearchParams();
    formData.append('from', EMAIL_FROM);
    formData.append('to', to);
    formData.append('subject', subject);
    formData.append('html', html);
    if (text) formData.append('text', text);

    const response = await fetch(
      `https://api.mailgun.net/v3/${MAILGUN_DOMAIN}/messages`,
      {
        method: 'POST',
        headers: {
          'Authorization': `Basic ${Buffer.from(`api:${MAILGUN_API_KEY}`).toString('base64')}`,
        },
        body: formData,
      }
    );

    return response.status === 200;
  } catch (error) {
    console.error('[Email Queue] Mailgun error:', error);
    return false;
  }
}

/**
 * Send email based on provider configuration
 */
async function sendEmail(
  to: string,
  subject: string,
  html: string,
  text?: string
): Promise<boolean> {
  switch (EMAIL_PROVIDER.toLowerCase()) {
    case 'sendgrid':
      return await sendViaSendGrid(to, subject, html, text);
    case 'mailgun':
      return await sendViaMailgun(to, subject, html, text);
    case 'smtp':
    default:
      return await sendViaSMTP(to, subject, html, text);
  }
}

/**
 * Email Queue Worker
 */
const emailWorker = new Worker<EmailJobData>(
  'email-sending',
  async (job: Job<EmailJobData>) => {
    const { to, subject, html, text, type, userId, propertyId, metadata } = job.data;

    console.log(`[Email Queue] Processing email to ${to}, type: ${type}`);

    // Rate limiting check
    const currentMinute = Math.floor(Date.now() / 60000);
    const rateKey = `email:rate:${currentMinute}`;
    const currentCount = await connection.incr(rateKey);
    
    if (currentCount === 1) {
      await connection.expire(rateKey, 60); // Expire after 1 minute
    }

    if (currentCount > RATE_LIMIT_PER_MINUTE) {
      console.warn('[Email Queue] Rate limit exceeded, delaying...');
      await new Promise(resolve => setTimeout(resolve, 60000)); // Wait 1 minute
    }

    // Send email
    const success = await sendEmail(to, subject, html, text);

    if (success) {
      console.log(`[Email Queue] Email sent successfully to ${to}`);
      
      // Log success to database (optional)
      // await prisma.emailLog.create({ ... });
      
      return { success: true, to, type };
    } else {
      throw new Error(`Failed to send email to ${to}`);
    }
  },
  {
    connection,
    concurrency: 20, // Process 20 emails concurrently
    limiter: {
      max: RATE_LIMIT_PER_MINUTE,
      duration: 60000, // 1 minute
    },
  }
);

emailWorker.on('completed', (job) => {
  console.log(`[Email Queue] Job ${job.id} completed`);
});

emailWorker.on('failed', (job, err) => {
  console.error(`[Email Queue] Job ${job?.id} failed:`, err.message);
});

/**
 * Add email to queue
 */
export async function addEmailJob(data: EmailJobData): Promise<void> {
  await emailQueue.add('send-email', data, {
    attempts: 5,
    backoff: {
      type: 'exponential',
      delay: 2000, // Start with 2s, then 4s, 8s, 16s, 32s
    },
    removeOnComplete: {
      count: 1000, // Keep last 1000 completed jobs
      age: 3600, // 1 hour
    },
    removeOnFail: {
      count: 5000, // Keep last 5000 failed jobs
    },
  });
}

/**
 * Add bulk emails to queue (batch processing)
 */
export async function addBulkEmailJobs(dataArray: EmailJobData[]): Promise<void> {
  const jobs = dataArray.map((data, index) => ({
    name: 'send-email',
    data,
    opts: {
      attempts: 5,
      backoff: {
        type: 'exponential',
        delay: 2000,
      },
    },
  }));

  // Process in batches of 500
  for (let i = 0; i < jobs.length; i += BATCH_SIZE) {
    const batch = jobs.slice(i, i + BATCH_SIZE);
    await emailQueue.addBulk(batch);
    console.log(`[Email Queue] Added batch ${i / BATCH_SIZE + 1} with ${batch.length} emails`);
    
    // Small delay between batches to avoid overwhelming the provider
    if (i + BATCH_SIZE < jobs.length) {
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
  }
}

/**
 * Get queue statistics
 */
export async function getEmailQueueStats(): Promise<{
  waiting: number;
  active: number;
  completed: number;
  failed: number;
}> {
  const [waiting, active, completed, failed] = await Promise.all([
    emailQueue.getWaitingCount(),
    emailQueue.getActiveCount(),
    emailQueue.getCompletedCount(),
    emailQueue.getFailedCount(),
  ]);

  return { waiting, active, completed, failed };
}

/**
 * Graceful shutdown
 */
export async function closeEmailQueue(): Promise<void> {
  await emailWorker.close();
  await emailQueue.close();
  await connection.quit();
  smtpTransporter.close();
  console.log('[Email Queue] Closed');
}

// Handle process termination
process.on('SIGTERM', async () => {
  await closeEmailQueue();
});

process.on('SIGINT', async () => {
  await closeEmailQueue();
});
