import { prisma } from './prisma';
import { generateReport } from './report-generator';

export interface ScheduleConfig {
  frequency: 'daily' | 'weekly' | 'monthly' | 'quarterly' | 'yearly' | 'manual';
  dayOfWeek?: number; // 0-6 (Sunday-Saturday)
  dayOfMonth?: number; // 1-31
  time?: string; // HH:MM format
  timezone?: string;
  enabled?: boolean;
}

interface ScheduledJob {
  id: string;
  config: ScheduleConfig;
  timeoutId?: NodeJS.Timeout;
  intervalId?: NodeJS.Timeout;
}

const scheduledJobs = new Map<string, ScheduledJob>();

export async function scheduleReport(reportId: string, scheduleConfig: ScheduleConfig): Promise<void> {
  try {
    // Remove existing job if it exists
    unscheduleReport(reportId);

    const report = await prisma.report.findUnique({
      where: { id: reportId },
      include: { org: true, user: true }
    });

    if (!report || !report.isActive) {
      return;
    }

    const job: ScheduledJob = {
      id: reportId,
      config: scheduleConfig
    };

    // Calculate next execution time
    const nextExecution = getNextExecutionTime(scheduleConfig);
    const delay = nextExecution.getTime() - Date.now();

    if (delay > 0) {
      // Schedule single execution
      job.timeoutId = setTimeout(async () => {
        await executeScheduledReport(reportId);
        
        // If it's a recurring job, schedule the next one
        if (scheduleConfig.frequency !== 'manual') {
          scheduleRecurringExecution(reportId, scheduleConfig);
        }
      }, delay);
    }

    scheduledJobs.set(reportId, job);
    
    console.log(`Report ${reportId} scheduled for next execution at ${nextExecution.toISOString()}`);
  } catch (error) {
    console.error('Error scheduling report:', error);
    throw error;
  }
}

function getNextExecutionTime(config: ScheduleConfig): Date {
  const now = new Date();
  const [hours, minutes] = (config.time || '09:00').split(':').map(Number);
  
  switch (config.frequency) {
    case 'daily':
      const nextDaily = new Date(now);
      nextDaily.setHours(hours, minutes, 0, 0);
      if (nextDaily.getTime() <= now.getTime()) {
        nextDaily.setDate(nextDaily.getDate() + 1);
      }
      return nextDaily;
    
    case 'weekly':
      const nextWeekly = new Date(now);
      const dayOfWeek = config.dayOfWeek || 1; // Monday by default
      nextWeekly.setHours(hours, minutes, 0, 0);
      
      // Calculate days until next specified day
      let daysUntil = (dayOfWeek - nextWeekly.getDay() + 7) % 7;
      if (daysUntil === 0 && nextWeekly.getTime() <= now.getTime()) {
        daysUntil = 7;
      }
      
      nextWeekly.setDate(nextWeekly.getDate() + daysUntil);
      return nextWeekly;
    
    case 'monthly':
      const nextMonthly = new Date(now);
      const dayOfMonth = config.dayOfMonth || 1;
      nextMonthly.setDate(dayOfMonth);
      nextMonthly.setHours(hours, minutes, 0, 0);
      
      if (nextMonthly.getTime() <= now.getTime()) {
        nextMonthly.setMonth(nextMonthly.getMonth() + 1);
      }
      return nextMonthly;
    
    case 'quarterly':
      const nextQuarterly = new Date(now);
      const quarterDay = config.dayOfMonth || 1;
      nextQuarterly.setDate(quarterDay);
      nextQuarterly.setHours(hours, minutes, 0, 0);
      
      // Find next quarter (1, 4, 7, 10)
      const currentMonth = nextQuarterly.getMonth();
      const quarterMonths = [0, 3, 6, 9]; // Jan, Apr, Jul, Oct
      const nextQuarter = quarterMonths.find(m => m > currentMonth) || quarterMonths[0] + 12;
      
      nextQuarterly.setMonth(nextQuarter);
      if (nextQuarterly.getTime() <= now.getTime()) {
        nextQuarterly.setFullYear(nextQuarterly.getFullYear() + 1);
      }
      return nextQuarterly;
    
    case 'yearly':
      const nextYearly = new Date(now);
      const yearDay = config.dayOfMonth || 1;
      nextYearly.setDate(yearDay);
      nextYearly.setMonth(0); // January
      nextYearly.setHours(hours, minutes, 0, 0);
      
      if (nextYearly.getTime() <= now.getTime()) {
        nextYearly.setFullYear(nextYearly.getFullYear() + 1);
      }
      return nextYearly;
    
    case 'manual':
      throw new Error('Manual reports cannot be scheduled automatically');
    
    default:
      throw new Error(`Unsupported frequency: ${config.frequency}`);
  }
}

function scheduleRecurringExecution(reportId: string, config: ScheduleConfig): void {
  const intervalMs = getIntervalInMilliseconds(config.frequency);
  
  if (intervalMs > 0) {
    const intervalId = setInterval(async () => {
      await executeScheduledReport(reportId);
    }, intervalMs);
    
    const job = scheduledJobs.get(reportId);
    if (job) {
      job.intervalId = intervalId;
    }
  }
}

function getIntervalInMilliseconds(frequency: string): number {
  switch (frequency) {
    case 'daily':
      return 24 * 60 * 60 * 1000; // 1 day
    case 'weekly':
      return 7 * 24 * 60 * 60 * 1000; // 1 week
    case 'monthly':
      return 30 * 24 * 60 * 60 * 1000; // ~1 month
    case 'quarterly':
      return 90 * 24 * 60 * 60 * 1000; // ~3 months
    case 'yearly':
      return 365 * 24 * 60 * 60 * 1000; // ~1 year
    case 'manual':
      return 0; // No recurrence for manual
    default:
      return 0; // No recurrence
  }
}

function buildCronExpression(config: ScheduleConfig): string {
  const time = config.time || '09:00';
  const [hours, minutes] = time.split(':').map(Number);
  
  switch (config.frequency) {
    case 'daily':
      return `${minutes} ${hours} * * *`;
    
    case 'weekly':
      return `${minutes} ${hours} * * ${config.dayOfWeek || 1}`; // Monday by default
    
    case 'monthly':
      return `${minutes} ${hours} ${config.dayOfMonth || 1} * *`;
    
    case 'quarterly':
      // Every 3 months on the specified day
      return `${minutes} ${hours} ${config.dayOfMonth || 1} 1,4,7,10 *`;
    
    case 'yearly':
      // Every year on January 1st or specified day
      return `${minutes} ${hours} ${config.dayOfMonth || 1} 1 *`;
    
    default:
      throw new Error(`Unsupported frequency: ${config.frequency}`);
  }
}

async function executeScheduledReport(reportId: string): Promise<void> {
  try {
    const report = await prisma.report.findUnique({
      where: { id: reportId },
      include: { org: true, user: true }
    });

    if (!report || !report.isActive) {
      console.log(`Report ${reportId} is not active, skipping execution`);
      return;
    }

    console.log(`Executing scheduled report: ${report.name}`);

    // Create execution record
    const execution = await prisma.reportExecution.create({
      data: {
        orgId: report.orgId,
        reportId: reportId,
        executedBy: 'system',
        status: 'RUNNING',
        executedAt: new Date(),
        parameters: report.config as any || {}
      }
    });

    try {
      // Generate the report
      const result = await generateReport(report, report.config as any || {});
      
      // Update execution with success
      await prisma.reportExecution.update({
        where: { id: execution.id },
        data: {
          status: 'COMPLETED',
          resultUrl: result.fileUrl,
          executedAt: new Date()
        }
      });

      // Update report last run time
      await prisma.report.update({
        where: { id: reportId },
        data: { lastRunAt: new Date() }
      });

      // Send notifications to recipients
      if (report.recipients && Array.isArray(report.recipients)) {
        await sendReportNotifications(report, result, execution);
      }

      console.log(`Successfully executed report ${report.name}`);
    } catch (error) {
      // Update execution with error
      await prisma.reportExecution.update({
        where: { id: execution.id },
        data: {
          status: 'FAILED',
          errorMessage: error instanceof Error ? error.message : 'Unknown error',
          executedAt: new Date()
        }
      });

      console.error(`Failed to execute report ${report.name}:`, error);
      
      // Send error notification
      await sendErrorNotification(report, error, execution);
    }
  } catch (error) {
    console.error(`Error executing scheduled report ${reportId}:`, error);
  }
}

async function sendReportNotifications(report: any, result: any, execution: any): Promise<void> {
  try {
    const recipients = report.recipients as string[];
    
    for (const recipient of recipients) {
      // Here you would implement email sending logic
      // For now, we'll just log it
      console.log(`Sending report notification to: ${recipient}`);
      console.log(`Report: ${report.name}`);
      console.log(`Download URL: ${result.fileUrl}`);
      
      // TODO: Implement actual email sending
      // await emailService.send({
      //   to: recipient,
      //   subject: `Scheduled Report: ${report.name}`,
      //   template: 'report-notification',
      //   data: {
      //     reportName: report.name,
      //     downloadUrl: result.fileUrl,
      //     generatedAt: result.generatedAt,
      //     executedAt: execution.executedAt
      //   }
      // });
    }
  } catch (error) {
    console.error('Error sending report notifications:', error);
  }
}

async function sendErrorNotification(report: any, error: any, execution: any): Promise<void> {
  try {
    // Send error notification to report creator
    console.log(`Sending error notification to: ${report.user.email}`);
    console.log(`Report: ${report.name}`);
    console.log(`Error: ${error instanceof Error ? error.message : 'Unknown error'}`);
    
    // TODO: Implement actual email sending
    // await emailService.send({
    //   to: report.user.email,
    //   subject: `Report Generation Failed: ${report.name}`,
    //   template: 'report-error',
    //   data: {
    //     reportName: report.name,
    //     errorMessage: error instanceof Error ? error.message : 'Unknown error',
    //     executedAt: execution.executedAt
    //   }
    // });
  } catch (notificationError) {
    console.error('Error sending error notification:', notificationError);
  }
}

export async function initializeScheduledReports(): Promise<void> {
  try {
    console.log('Initializing scheduled reports...');
    
    // Get all active reports with schedules
    const reports = await prisma.report.findMany({
      where: {
        isActive: true,
        schedule: { not: null } as any, // Type assertion to handle Prisma JsonValue type
        deletedAt: null
      },
      include: {
        org: true,
        user: true
      }
    });

    for (const report of reports) {
      if (report.schedule) {
        try {
          // Safe type casting with validation
          const scheduleConfig = report.schedule as any;
          if (scheduleConfig && typeof scheduleConfig === 'object' && scheduleConfig.frequency) {
            await scheduleReport(report.id, scheduleConfig as ScheduleConfig);
          } else {
            console.warn(`Invalid schedule config for report ${report.id}`);
          }
        } catch (error) {
          console.error(`Failed to schedule report ${report.id}:`, error);
        }
      }
    }

    console.log(`Initialized ${reports.length} scheduled reports`);
  } catch (error) {
    console.error('Error initializing scheduled reports:', error);
  }
}

export async function unscheduleReport(reportId: string): Promise<void> {
  try {
    const job = scheduledJobs.get(reportId);
    if (job) {
      if (job.timeoutId) {
        clearTimeout(job.timeoutId);
      }
      if (job.intervalId) {
        clearInterval(job.intervalId);
      }
      scheduledJobs.delete(reportId);
      console.log(`Unscheduled report: ${reportId}`);
    }
  } catch (error) {
    console.error('Error unscheduling report:', error);
  }
}

export function getScheduledReportsCount(): number {
  return scheduledJobs.size;
}

export function getScheduledReportIds(): string[] {
  return Array.from(scheduledJobs.keys());
}

// Clean up on process exit
process.on('SIGTERM', () => {
  console.log('Shutting down scheduled reports...');
  scheduledJobs.forEach(job => {
    if (job.timeoutId) clearTimeout(job.timeoutId);
    if (job.intervalId) clearInterval(job.intervalId);
  });
});

process.on('SIGINT', () => {
  console.log('Shutting down scheduled reports...');
  scheduledJobs.forEach(job => {
    if (job.timeoutId) clearTimeout(job.timeoutId);
    if (job.intervalId) clearInterval(job.intervalId);
  });
});
