import { getDictionary, isValidLocale } from '@/lib/i18n/config';
import { notFound } from 'next/navigation';
import { LibraryClient } from './library-client';

interface PageProps {
    params: Promise<{ locale: string }>;
}

export default async function LibraryPage({ params }: PageProps) {
    const { locale } = await params;

    if (!isValidLocale(locale)) {
        notFound();
    }

    const dictionary = await getDictionary(locale);

    return (
        <div className="min-h-screen bg-slate-950 pt-24 pb-12">
            <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
                <LibraryClient
                    title={dictionary.library.title}
                    description={dictionary.library.noFurniture}
                />
            </div>
        </div>
    );
}
