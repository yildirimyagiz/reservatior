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

export class AITransactionMailer {
  /**
   * Send Onboarding / Welcome Email
   */
  static async sendWelcomeEmail(email: string, recipientName: string) {
    console.log(`[AITransactionMailer] Sending Welcome Email to ${email}`);
    const html = AIEmailTemplates.generateWelcomeEmail(recipientName, "https://reservatior.com/dashboard");
    
    await transporter.sendMail({
      from: '"Reservatior Team" <hello@reservatior.com>',
      to: email,
      subject: "Welcome to Reservatior Premium Real Estate",
      html,
    });
  }

  /**
   * Send Email Verification
   */
  static async sendEmailVerification(email: string, recipientName: string, token: string) {
    console.log(`[AITransactionMailer] Sending Email Verification to ${email}`);
    const html = AIEmailTemplates.generateEmailVerification(recipientName, `${process.env.CLIENT_URL || 'http://localhost:3001'}/verify-email?token=${token}&email=${encodeURIComponent(email)}`);

    await transporter.sendMail({
      from: '"Reservatior" <noreply@reservatior.com>',
      to: email,
      subject: "Verify Your Email",
      html,
    });
  }

  /**
   * Send Password Reset Email
   */
  static async sendPasswordReset(email: string, recipientName: string, token: string) {
    console.log(`[AITransactionMailer] Sending Password Reset to ${email}`);
    const html = AIEmailTemplates.generatePasswordReset(recipientName, `https://reservatior.com/reset-password?token=${token}`);
    
    await transporter.sendMail({
      from: '"Reservatior Security" <security@reservatior.com>',
      to: email,
      subject: "Reset Your Password",
      html,
    });
  }

  /**
   * Send Legal / Contract Email
   */
  static async sendContractEmail(email: string, recipientName: string, contractType: string, propertyName: string, documentId: string) {
    console.log(`[AITransactionMailer] Sending Contract (${contractType}) to ${email}`);
    const html = AIEmailTemplates.generateContractEmail(recipientName, contractType, `https://reservatior.com/sign/${documentId}`, propertyName);
    
    await transporter.sendMail({
      from: '"Reservatior Legal" <legal@reservatior.com>',
      to: email,
      subject: `Action Required: Sign ${contractType}`,
      html,
    });
  }

  /**
   * Send Transaction Status Alert
   */
  static async sendTransactionAlert(email: string, recipientName: string, requestType: string, propertyName: string, status: string) {
    console.log(`[AITransactionMailer] Sending Transaction Alert (${status}) to ${email}`);
    const html = AIEmailTemplates.generateTransactionAlert(recipientName, requestType, propertyName, status);
    
    await transporter.sendMail({
      from: '"Reservatior Transactions" <transactions@reservatior.com>',
      to: email,
      subject: `${requestType} Status Update: ${status}`,
      html,
    });
  }
}
