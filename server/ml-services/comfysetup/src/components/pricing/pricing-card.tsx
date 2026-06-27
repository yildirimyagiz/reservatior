'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { Check, Sparkles, Loader2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import { motion } from 'framer-motion';

interface PricingFeature {
    text: string;
    included: boolean;
}

interface PricingTier {
    name: string;
    price: number;
    credits: number;
    description: string;
    features: PricingFeature[];
    isPopular?: boolean;
    buttonText?: string;
}

interface PricingCardProps {
    tier: PricingTier;
    annual?: boolean;
}

export function PricingCard({ tier }: PricingCardProps) {
    const router = useRouter();
    const [isLoading, setIsLoading] = useState(false);

    const handleAction = async () => {
        setIsLoading(true);
        try {
            if (tier.name === 'Free Trial') {
                const res = await fetch('/api/billing/trial', { method: 'POST' });
                if (res.ok) {
                    router.push('/en/editor'); // Redirect to editor to start using
                } else {
                    const data = await res.json();
                    if (res.status === 401) {
                         router.push('/en/auth/signin');
                    } else {
                         alert(data.error || 'Failed to start trial');
                    }
                }
            } else {
                // Logic for paid plans (e.g. Stripe Checkout)
                // For now just redirect to billing or show coming soon
                console.log('Select plan:', tier.name);
                router.push(`/en/billing?plan=${tier.name.toLowerCase()}`);
            }
        } catch (error) {
            console.error('Action failed:', error);
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <motion.div
            whileHover={{ y: -5 }}
            className={cn(
                "relative flex flex-col p-6 rounded-2xl border transition-all duration-300",
                tier.isPopular
                    ? "glass-card border-purple-500/50 shadow-purple-500/20"
                    : "glass border-white/10 hover:border-white/20"
            )}
        >
            {tier.isPopular && (
                <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-gradient-to-r from-purple-600 to-pink-600 rounded-full text-xs font-semibold text-white flex items-center gap-1 shadow-lg">
                    <Sparkles className="w-3 h-3" />
                    Most Popular
                </div>
            )}

            <div className="mb-6">
                <h3 className="text-xl font-bold text-white mb-2">{tier.name}</h3>
                <div className="flex items-baseline gap-1">
                    <span className="text-4xl font-bold text-white">${tier.price}</span>
                    <span className="text-slate-400 text-sm">/month</span>
                </div>
                <p className="text-sm text-slate-400 mt-2">{tier.description}</p>
            </div>

            <div className="mb-6 rounded-lg bg-white/5 p-4 border border-white/5">
                <div className="text-center">
                    <span className="text-2xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">
                        {tier.credits}
                    </span>
                    <span className="text-sm text-slate-300 ml-1">Credits / mo</span>
                </div>
            </div>

            <ul className="space-y-3 mb-8 flex-1">
                {tier.features.map((feature, i) => (
                    <li key={i} className="flex items-start gap-3 text-sm">
                        <div className={cn(
                            "mt-0.5 rounded-full p-0.5",
                            feature.included ? "text-purple-400 bg-purple-400/10" : "text-slate-600 bg-slate-800"
                        )}>
                            <Check className="w-3 h-3" />
                        </div>
                        <span className={feature.included ? "text-slate-300" : "text-slate-500 line-through"}>
                            {feature.text}
                        </span>
                    </li>
                ))}
            </ul>

            <Button
                variant={tier.isPopular ? "primary" : "secondary"}
                onClick={handleAction}
                disabled={isLoading}
                className={cn(
                    "w-full",
                    tier.isPopular && "bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-500 hover:to-pink-500 border-0"
                )}
            >
                {isLoading ? (
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                ) : (
                    tier.buttonText || "Get Started"
                )}
            </Button>
        </motion.div>
    );
}
