import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'FurnitureStaging.AI - AI-Powered Furniture Visualization',
  description:
    'AI-assisted staging for realtors, architects, and designers. Generate professional prompts to transform empty rooms into stunning visualizations.',
  keywords: [
    'AI staging',
    'furniture visualization',
    'virtual staging',
    'real estate',
    'interior design',

  ],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className="dark">
      <body className="min-h-screen bg-slate-950 antialiased">{children}</body>
    </html>
  );
}
