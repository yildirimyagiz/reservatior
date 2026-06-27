import { isValidLocale } from '@/lib/i18n/config';
import { notFound } from 'next/navigation';
import { CanvasEditor } from '@/components/canvas';

export const dynamic = 'force-dynamic';

interface PageProps {
    params: Promise<{ locale: string }>;
}

export default async function EditorPage({ params }: PageProps) {
    const { locale } = await params;

    if (!isValidLocale(locale)) {
        notFound();
    }

    return <CanvasEditor />;
}
