/**
 * SMS Queue Worker using BullMQ
 * Handles bulk SMS sending with rate limiting and exponential backoff
 * Provider: Netgsm / Turkcell (configurable)
 * Rate Limit: 100 messages/minute (provider-specific)
 */

import { Queue, Worker, Job } from 'bullmq';
import Redis from 'ioredis';

const redisUrl = process.env.REDIS_URL || 'redis://localhost:6379';
const connection = new Redis(redisUrl);

// SMS Queue
export const smsQueue = new Queue('sms-sending', { connection });

interface SMSJobData {
  phone: string;
  message: string;
  type: 'OTP' | 'NOTIFICATION' | 'MARKETING' | 'INVITATION';
  userId?: string;
  propertyId?: string;
  metadata?: Record<string, any>;
}

/**
 * SMS Provider Configuration
 */
const SMS_PROVIDER = process.env.SMS_PROVIDER || 'netgsm';
const SMS_API_KEY = process.env.SMS_API_KEY;
const SMS_API_SECRET = process.env.SMS_API_SECRET;
const SMS_SENDER_ID = process.env.SMS_SENDER_ID || 'Reservatior';

/**
 * Rate limiting: 100 messages/minute per provider
 */
const RATE_LIMIT_PER_MINUTE = 100;
const BATCH_SIZE = 500; // Process in batches of 500

/**
 * Send SMS via Netgsm
 */
async function sendViaNetgsm(phone: string, message: string): Promise<boolean> {
  try {
    // Netgsm API integration
    const response = await fetch('https://api.netgsm.com.tr/sms/send/get', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        usercode: SMS_API_KEY,
        password: SMS_API_SECRET,
        gsmno: phone,
        message: message,
        msgheader: SMS_SENDER_ID,
      }),
    });

    const data = await response.json();
    return data.status === '00'; // Netgsm success code
  } catch (error) {
    console.error('[SMS Queue] Netgsm error:', error);
    return false;
  }
}

/**
 * Send SMS via Turkcell
 */
async function sendViaTurkcell(phone: string, message: string): Promise<boolean> {
  try {
    // Turkcell API integration
    const response = await fetch('https://api.turkcell.com.tr/sms/send', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SMS_API_KEY}`,
      },
      body: JSON.stringify({
        recipient: phone,
        message: message,
        sender: SMS_SENDER_ID,
      }),
    });

    const data = await response.json();
    return data.success === true;
  } catch (error) {
    console.error('[SMS Queue] Turkcell error:', error);
    return false;
  }
}

/**
 * Send SMS based on provider configuration
 */
async function sendSMS(phone: string, message: string): Promise<boolean> {
  switch (SMS_PROVIDER.toLowerCase()) {
    case 'netgsm':
      return await sendViaNetgsm(phone, message);
    case 'turkcell':
      return await sendViaTurkcell(phone, message);
    default:
      console.error('[SMS Queue] Unknown SMS provider:', SMS_PROVIDER);
      return false;
  }
}

/**
 * SMS Queue Worker
 */
const smsWorker = new Worker<SMSJobData>(
  'sms-sending',
  async (job: Job<SMSJobData>) => {
    const { phone, message, type, userId, propertyId, metadata } = job.data;

    console.log(`[SMS Queue] Processing SMS for ${phone}, type: ${type}`);

    // Rate limiting check
    const currentMinute = Math.floor(Date.now() / 60000);
    const rateKey = `sms:rate:${currentMinute}`;
    const currentCount = await connection.incr(rateKey);
    
    if (currentCount === 1) {
      await connection.expire(rateKey, 60); // Expire after 1 minute
    }

    if (currentCount > RATE_LIMIT_PER_MINUTE) {
      console.warn('[SMS Queue] Rate limit exceeded, delaying...');
      await new Promise(resolve => setTimeout(resolve, 60000)); // Wait 1 minute
    }

    // Send SMS
    const success = await sendSMS(phone, message);

    if (success) {
      console.log(`[SMS Queue] SMS sent successfully to ${phone}`);
      
      // Log success to database (optional)
      // await prisma.smsLog.create({ ... });
      
      return { success: true, phone, type };
    } else {
      throw new Error(`Failed to send SMS to ${phone}`);
    }
  },
  {
    connection,
    concurrency: 10, // Process 10 SMS concurrently
    limiter: {
      max: RATE_LIMIT_PER_MINUTE,
      duration: 60000, // 1 minute
    },
  }
);

smsWorker.on('completed', (job) => {
  console.log(`[SMS Queue] Job ${job.id} completed`);
});

smsWorker.on('failed', (job, err) => {
  console.error(`[SMS Queue] Job ${job?.id} failed:`, err.message);
});

/**
 * Add SMS to queue
 */
export async function addSMSJob(data: SMSJobData): Promise<void> {
  await smsQueue.add('send-sms', data, {
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
 * Add bulk SMS to queue (batch processing)
 */
export async function addBulkSMSJobs(dataArray: SMSJobData[]): Promise<void> {
  const jobs = dataArray.map((data, index) => ({
    name: 'send-sms',
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
    await smsQueue.addBulk(batch);
    console.log(`[SMS Queue] Added batch ${i / BATCH_SIZE + 1} with ${batch.length} SMS`);
    
    // Small delay between batches to avoid overwhelming the provider
    if (i + BATCH_SIZE < jobs.length) {
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
  }
}

/**
 * Get queue statistics
 */
export async function getSMSQueueStats(): Promise<{
  waiting: number;
  active: number;
  completed: number;
  failed: number;
}> {
  const [waiting, active, completed, failed] = await Promise.all([
    smsQueue.getWaitingCount(),
    smsQueue.getActiveCount(),
    smsQueue.getCompletedCount(),
    smsQueue.getFailedCount(),
  ]);

  return { waiting, active, completed, failed };
}

/**
 * Graceful shutdown
 */
export async function closeSMSQueue(): Promise<void> {
  await smsWorker.close();
  await smsQueue.close();
  await connection.quit();
  console.log('[SMS Queue] Closed');
}

// Handle process termination
process.on('SIGTERM', async () => {
  await closeSMSQueue();
});

process.on('SIGINT', async () => {
  await closeSMSQueue();
});
