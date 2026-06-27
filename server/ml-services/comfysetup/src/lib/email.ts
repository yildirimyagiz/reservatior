import nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST || 'localhost',
  port: parseInt(process.env.SMTP_PORT || '465'),
  secure: true,
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASSWORD,
  },
});

export async function sendEmail({
  to,
  subject,
  html,
  text,
}: {
  to: string;
  subject: string;
  html?: string;
  text?: string;
}) {
  const from = process.env.SMTP_FROM || process.env.SMTP_USER || 'noreply@atlasvs.cloud';
  const fromName = process.env.SMTP_FROM_NAME || 'AtlasVS';

  try {
    const info = await transporter.sendMail({
      from: `"${fromName}" <${from}>`,
      to,
      subject,
      html,
      text,
    });
    console.log('Email sent:', info.messageId);
    return { success: true, messageId: info.messageId };
  } catch (error) {
    console.error('Email error:', error);
    return { success: false, error };
  }
}

export default transporter;
