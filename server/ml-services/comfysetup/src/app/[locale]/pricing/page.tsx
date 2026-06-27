import { isValidLocale } from '@/lib/i18n/config';
import { notFound } from 'next/navigation';
import { PricingCard } from '@/components/pricing/pricing-card';

export default async function PricingPage({ params }: { params: Promise<{ locale: string }> }) {
    const { locale } = await params;

    if (!isValidLocale(locale)) {
        notFound();
    }

    // const dictionary = await getDictionary(locale);

    const tiers = [
        {
            name: "Free Trial",
            price: 0,
            credits: 5,
            description: "No commitment. 5-Day Access.",
            buttonText: "Start Free Trial",
            features: [
                { text: "5 Images (One-time)", included: true },
                { text: "Standard Quality Generation", included: true },
                { text: "Personal Usage Only", included: true },
                { text: "Credit Card Verification", included: true },
                { text: "Priority Rendering", included: false },
                { text: "Dedicated Expert", included: false },
            ]
        },
        {
            name: "Standard",
            price: 10,
            credits: 60,
            description: "Perfect for independent realtors getting started.",
            features: [
                { text: "60 Credits per month", included: true },
                { text: "Standard Quality Generation", included: true },
                { text: "Commercial Usage Rights", included: true },
                { text: "Email Support", included: true },
                { text: "Priority Rendering", included: false },
                { text: "Dedicated Expert", included: false },
            ]
        },
        {
            name: "Advanced",
            price: 29,
            credits: 150,
            description: "Ideal for growing agencies and regular stagers.",
            isPopular: true,
            features: [
                { text: "150 Credits per month", included: true },
                { text: "High Quality Generation", included: true },
                { text: "Commercial Usage Rights", included: true },
                { text: "Priority Email Support", included: true },
                { text: "Priority Rendering", included: true },
                { text: "Dedicated Expert", included: false },
            ]
        },
        {
            name: "Premium",
            price: 49,
            credits: 263,
            description: "For high-volume rendering needs.",
            features: [
                { text: "263 Credits per month", included: true },
                { text: "Ultra Quality Generation", included: true },
                { text: "Commercial Usage Rights", included: true },
                { text: "24/7 Priority Support", included: true },
                { text: "Instant Rendering Queue", included: true },
                { text: "Dedicated Expert", included: true },
            ]
        },
        {
            name: "Enterprise",
            price: 99,
            credits: 526,
            description: "Maximum power for large teams.",
            features: [
                { text: "526 Credits per month", included: true },
                { text: "Ultra Quality Generation", included: true },
                { text: "Commercial Usage Rights", included: true },
                { text: "24/7 Priority Support", included: true },
                { text: "Instant Rendering Queue", included: true },
                { text: "Dedicated Account Manager", included: true },
            ]
        }
    ];

    return (
        <div className="relative min-h-screen pt-24 pb-16 px-4 isolate overflow-hidden">
            {/* Background Gradients */}
            <div className="absolute inset-x-0 top-0 -z-10 transform-gpu overflow-hidden blur-3xl" aria-hidden="true">
                <div className="relative left-[calc(50%-11rem)] aspect-[1155/678] w-[36.125rem] -translate-x-1/2 rotate-[30deg] bg-gradient-to-tr from-[#ff80b5] to-[#9089fc] opacity-20 sm:left-[calc(50%-30rem)] sm:w-[72.1875rem]" style={{ clipPath: 'polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)' }} />
            </div>

            <div className="mx-auto max-w-7xl">
                <div className="mx-auto max-w-2xl text-center mb-16">
                    <h1 className="text-4xl font-bold tracking-tight text-white sm:text-6xl gradient-text">
                        Simple, Credit-Based Pricing
                    </h1>
                    <p className="mt-6 text-lg leading-8 text-slate-300">
                        Choose the plan that fits your volume. Upgrade or downgrade anytime.
                        <br />
                        <span className="text-sm text-slate-400 mt-2 block">1 Credit = 1 Staged Photo Generaton</span>
                    </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-5 gap-4">
                    {tiers.map((tier) => (
                        <PricingCard key={tier.name} tier={tier} />
                    ))}
                </div>

                {/* FAQ or Trust Section could go here */}
            </div>
        </div>
    );
}
