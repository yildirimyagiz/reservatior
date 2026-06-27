import { getDictionary, isValidLocale } from '@/lib/i18n/config';
import { notFound } from 'next/navigation';

interface PageProps {
    params: Promise<{ locale: string }>;
}

export default async function SettingsPage({ params }: PageProps) {
    const { locale } = await params;

    if (!isValidLocale(locale)) {
        notFound();
    }

    const dictionary = await getDictionary(locale);

    return (
        <div className="min-h-screen bg-slate-950 pt-24 pb-12">
            <div className="mx-auto max-w-3xl px-4 sm:px-6 lg:px-8">
                {/* Page Header */}
                <div className="mb-8">
                    <h1 className="text-3xl font-bold text-white sm:text-4xl">
                        {dictionary.common.settings}
                    </h1>
                    <p className="mt-2 text-slate-400">
                        Configure your preferences and API connections.
                    </p>
                </div>

                {/* Coming soon placeholder */}
                <div className="rounded-xl border border-dashed border-slate-700 bg-slate-800/30 p-12 text-center">
                    <p className="text-slate-400">
                        Settings page coming soon. Configure seller APIs and preferences here.
                    </p>
                </div>
            </div>
        </div>
    );
}
