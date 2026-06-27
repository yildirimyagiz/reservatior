import nodemailer from "nodemailer";

const transporter = nodemailer.createTransport({
  host: process.env.EMAIL_HOST || "mail.reservatior.com",
  port: Number(process.env.EMAIL_PORT) || 465,
  secure: process.env.EMAIL_SECURE === "true",
  auth: {
    user: process.env.EMAIL_USER || "info@reservatior.com",
    pass: process.env.EMAIL_PASS || "Reservatior1928!",
  },
});

export async function sendEmail(options: {
  to: string;
  subject: string;
  text?: string;
  html?: string;
}) {
  try {
    await transporter.sendMail({
      from: process.env.EMAIL_FROM || "info@reservatior.com",
      to: options.to,
      subject: options.subject,
      text: options.text,
      html: options.html,
    });
    console.log(`📧 Email sent to ${options.to}: ${options.subject}`);
  } catch (err) {
    console.error(`❌ Failed to send email to ${options.to}:`, err);
  }
}
