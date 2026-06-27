import { prisma } from "../../lib/prisma";
import nodemailer from "nodemailer";
import { AIEmailTemplates } from "./ai-email-templates";

// In production, this would use real SMTP credentials
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST || "smtp.mailtrap.io",
  port: parseInt(process.env.SMTP_PORT || "2525"),
  auth: {
    user: process.env.SMTP_USER || "test_user",
    pass: process.env.SMTP_PASS || "test_pass",
  },
});

export class AIEmailDrip {
  /**
   * Main cron job function that iterates over all leads and sends a personalized email.
   */
  static async runWeeklyDrip() {
    console.log("[AIEmailDrip] Starting Weekly Email Drip Campaign...");
    
    const leads = await prisma.lead.findMany({
      where: { email: { not: null } }
    });

    if (leads.length === 0) {
      console.log("[AIEmailDrip] No leads found with email addresses.");
      return;
    }

    // Get the latest blog post to feature
    const latestPost = await prisma.post.findFirst({
      orderBy: { createdAt: 'desc' }
    });

    for (const lead of leads) {
      if (!lead.email) continue;
      
      const recipientName = lead.firstName ? `${lead.firstName} ${lead.lastName || ''}`.trim() : "Valued Client";
      
      // Determine what template to use based on Mock Logic
      // In a real app, you might check lead.dateOfBirth or lead.tags/country
      const emailContent = await this.buildEmailContent(lead, latestPost);
      
      try {
        await transporter.sendMail({
          from: '"Reservatior Luxury" <exclusive@reservatior.com>',
          to: lead.email,
          subject: emailContent.subject,
          html: emailContent.html,
        });
        console.log(`[AIEmailDrip] Sent -> ${lead.email} (${emailContent.type})`);
      } catch (error) {
        console.error(`[AIEmailDrip] Failed to send to ${lead.email}`, error);
      }
    }
    
    console.log("[AIEmailDrip] Weekly Drip Campaign Finished.");
  }

  private static async buildEmailContent(lead: any, latestPost: any) {
    // 1. Check Birthday
    const isBirthday = false; // Mock: check lead.dateOfBirth == today
    if (isBirthday) {
      const htmlContent = `<p>Wishing you a wonderful year ahead. As a gift, enjoy exclusive priority access to our off-market properties this month.</p>`;
      return {
        type: "BIRTHDAY",
        subject: `Happy Birthday, ${lead.firstName}!`,
        html: AIEmailTemplates.generateBirthdayTemplate(htmlContent, lead.firstName || "Client")
      };
    }

    // 2. Check Cultural Holidays (Mocking country from Lead config/IP)
    const currentMonth = new Date().getMonth();
    const isDecember = currentMonth === 11;
    const isApril = currentMonth === 3;
    const isRamadanMonth = currentMonth === 2; // Approx for testing

    // Randomize for demonstration if lead has no country data
    const mockCountry = lead.sourceId === "TR_CAMPAIGN" ? "TURKEY" : (isDecember ? "UK" : "ISRAEL");

    if (isDecember && mockCountry === "UK") {
      const htmlContent = `<p>May your holidays be filled with joy. Have you seen our latest winter retreats?</p>`;
      return {
        type: "HOLIDAY_CHRISTMAS",
        subject: "Merry Christmas from Reservatior",
        html: AIEmailTemplates.generateHolidayTemplate("Merry Christmas", htmlContent, recipientName(lead))
      };
    }

    if (isRamadanMonth && mockCountry === "TURKEY") {
      const htmlContent = `<p>Wishing you a peaceful month. Discover family homes perfect for festive gatherings.</p>`;
      return {
        type: "HOLIDAY_EID",
        subject: "Eid Mubarak from Reservatior",
        html: AIEmailTemplates.generateHolidayTemplate("Eid Mubarak", htmlContent, recipientName(lead))
      };
    }

    if (isApril && mockCountry === "ISRAEL") {
      const htmlContent = `<p>Wishing you a joyous holiday season filled with peace.</p>`;
      return {
        type: "HOLIDAY_PASSOVER",
        subject: "Happy Passover",
        html: AIEmailTemplates.generateHolidayTemplate("Happy Passover", htmlContent, recipientName(lead))
      };
    }

    // 3. Fallback: Standard Weekly Newsletter
    const postSnippet = latestPost 
      ? `<div style="margin-top:20px; border-left: 3px solid #C5A059; padding-left: 15px;">
           <h3 style="color: #E8D09E; margin:0 0 10px 0;">Featured Insight: ${latestPost.title}</h3>
           <p style="color: #CCC; font-size: 14px;">Read our latest AI-curated guide tailored just for you.</p>
         </div>`
      : `<p>We have exciting new premium listings available this week.</p>`;

    return {
      type: "NEWSLETTER",
      subject: "Your Weekly Premium Real Estate Insights",
      html: AIEmailTemplates.generateNewsletter("Weekly Insights", postSnippet, recipientName(lead))
    };
  }
}

function recipientName(lead: any) {
  return lead.firstName ? `${lead.firstName}` : "Valued Client";
}
