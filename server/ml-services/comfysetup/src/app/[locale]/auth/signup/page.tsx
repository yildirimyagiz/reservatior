'use client';

import { useState } from 'react';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { signIn } from 'next-auth/react';
import { motion } from 'framer-motion';
import { Mail, ArrowRight, Loader2, Sparkles, Zap, Shield, Clock } from 'lucide-react';
import { Button } from '@/components/ui/button';

export default function SignUpPage() {
    const params = useParams();
    const locale = params.locale as string;
    const [email, setEmail] = useState('');
    const [name, setName] = useState('');
    const [password, setPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);

    const handleGoogleSignUp = async () => {
        setIsLoading(true);
        await signIn('google', { callbackUrl: `/${locale}/editor` });
    };

    const handleEmailSignUp = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!email || !password || !name) return;

        setIsLoading(true);

        try {
            // 1. Register User
            const res = await fetch('/api/auth/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name, email, password }),
            });

            const data = await res.json();

            if (!res.ok) {
                throw new Error(data.error || 'Registration failed');
            }

            // 2. Sign In
            await signIn('credentials', {
                email,
                password,
                callbackUrl: `/${locale}/editor`,
            });

        } catch (error) {
            console.error(error);
            setIsLoading(false);
            // In a real app, show a toast error here
        }
    };

    const trialBenefits = [
        {
            icon: Zap,
            title: '5 Free Images',
            description: 'Generate up to 5 AI-staged images',
        },
        {
            icon: Clock,
            title: '5-Day Trial',
            description: 'Full access to all premium features',
        },
        {
            icon: Shield,
            title: 'Verified Access',
            description: 'Card verification required',
        },
    ];

    return (
        <div className="min-h-screen bg-slate-950 flex">
            {/* Left side - Hero */}
            <div className="hidden lg:flex flex-1 items-center justify-center bg-gradient-to-br from-indigo-900/20 to-purple-900/20 p-12 relative overflow-hidden">
                {/* Background orbs */}
                <div className="absolute top-1/3 left-1/3 h-[500px] w-[500px] rounded-full bg-indigo-600/20 blur-[120px]" />
                <div className="absolute bottom-1/3 right-1/3 h-[300px] w-[300px] rounded-full bg-purple-600/20 blur-[80px]" />

                <div className="relative z-10 max-w-lg">
                    <motion.div
                        initial={{ opacity: 0, scale: 0.9 }}
                        animate={{ opacity: 1, scale: 1 }}
                        transition={{ delay: 0.2 }}
                    >
                        <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-purple-500/10 border border-purple-500/20 mb-6">
                            <Sparkles className="h-4 w-4 text-purple-400" />
                            <span className="text-sm text-purple-300 font-medium">Start Free Trial</span>
                        </div>

                        <h2 className="text-4xl font-bold text-white mb-6">
                            Join 10,000+ Real Estate Professionals
                        </h2>
                        <p className="text-lg text-slate-400 mb-10">
                            Start staging properties with AI in seconds. No design experience required.
                        </p>

                        {/* Trial benefits */}
                        <div className="space-y-6">
                            {trialBenefits.map((benefit, index) => (
                                <motion.div
                                    key={benefit.title}
                                    initial={{ opacity: 0, x: -20 }}
                                    animate={{ opacity: 1, x: 0 }}
                                    transition={{ delay: 0.3 + index * 0.1 }}
                                    className="flex items-start gap-4"
                                >
                                    <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-gradient-to-br from-purple-600/20 to-indigo-600/20 text-purple-400">
                                        <benefit.icon className="h-6 w-6" />
                                    </div>
                                    <div>
                                        <h3 className="text-lg font-semibold text-white">{benefit.title}</h3>
                                        <p className="text-sm text-slate-400">{benefit.description}</p>
                                    </div>
                                </motion.div>
                            ))}
                        </div>

                        {/* Testimonial */}
                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.7 }}
                            className="mt-12 p-6 rounded-2xl bg-slate-900/50 border border-slate-800"
                        >
                            <p className="text-slate-300 italic mb-4">
                                &quot;FurnitureStaging.AI helped me sell a property 3 weeks faster. The AI staging is incredibly realistic!&quot;
                            </p>
                            <div className="flex items-center gap-3">
                                <div className="h-10 w-10 rounded-full bg-gradient-to-br from-purple-500 to-indigo-500" />
                                <div>
                                    <p className="text-sm font-medium text-white">Sarah Johnson</p>
                                    <p className="text-xs text-slate-500">Realtor, RE/MAX</p>
                                </div>
                            </div>
                        </motion.div>
                    </motion.div>
                </div>
            </div>

            {/* Right side - Form */}
            <div className="flex-1 flex items-center justify-center p-8">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="w-full max-w-md"
                >
                    {/* Logo */}
                    <Link href={`/${locale}`} className="inline-flex items-center gap-2 mb-8">
                        <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-gradient-to-br from-purple-600 to-indigo-600 shadow-lg shadow-purple-500/25">
                            <Sparkles className="h-5 w-5 text-white" />
                        </div>
                        <span className="text-xl font-bold text-white">FurnitureStaging.AI</span>
                    </Link>

                    <h1 className="text-3xl font-bold text-white mb-2">
                        Create your account
                    </h1>
                    <p className="text-slate-400 mb-8">
                        Start your free trial with 5 images
                    </p>

                    {/* Google Sign Up */}
                    <Button
                        onClick={handleGoogleSignUp}
                        disabled={isLoading}
                        variant="outline"
                        className="w-full h-12 bg-white hover:bg-slate-100 text-slate-900 border-0 mb-4"
                    >
                        {isLoading ? (
                            <Loader2 className="h-5 w-5 animate-spin" />
                        ) : (
                            <>
                                <svg className="h-5 w-5 mr-3" viewBox="0 0 24 24">
                                    <path
                                        fill="currentColor"
                                        d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                                    />
                                    <path
                                        fill="#34A853"
                                        d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                                    />
                                    <path
                                        fill="#FBBC05"
                                        d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                                    />
                                    <path
                                        fill="#EA4335"
                                        d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                                    />
                                </svg>
                                Sign up with Google
                            </>
                        )}
                    </Button>

                    <div className="relative my-6">
                        <div className="absolute inset-0 flex items-center">
                            <div className="w-full border-t border-slate-800" />
                        </div>
                        <div className="relative flex justify-center text-xs uppercase">
                            <span className="bg-slate-950 px-3 text-slate-500">Or continue with email</span>
                        </div>
                    </div>

                    {/* Email Sign Up Form */}
                    <form onSubmit={handleEmailSignUp} className="space-y-4">
                        <div>
                            <label htmlFor="name" className="block text-sm font-medium text-slate-300 mb-2">
                                Full name
                            </label>
                            <input
                                id="name"
                                type="text"
                                value={name}
                                onChange={(e) => setName(e.target.value)}
                                placeholder="John Doe"
                                required
                                className="w-full h-12 px-4 rounded-xl bg-slate-900 border border-slate-800 text-white placeholder:text-slate-600 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all"
                            />
                        </div>

                        <div>
                            <label htmlFor="email" className="block text-sm font-medium text-slate-300 mb-2">
                                Email address
                            </label>
                            <div className="relative">
                                <Mail className="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 text-slate-500" />
                                <input
                                    id="email"
                                    type="email"
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                    placeholder="you@example.com"
                                    required
                                    className="w-full h-12 pl-11 pr-4 rounded-xl bg-slate-900 border border-slate-800 text-white placeholder:text-slate-600 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all"
                                />
                            </div>
                        </div>

                        <div>
                            <label htmlFor="password" className="block text-sm font-medium text-slate-300 mb-2">
                                Password
                            </label>
                            <div className="relative">
                                <Shield className="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 text-slate-500" />
                                <input
                                    id="password"
                                    type="password"
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    placeholder="••••••••"
                                    required
                                    minLength={6}
                                    className="w-full h-12 pl-11 pr-4 rounded-xl bg-slate-900 border border-slate-800 text-white placeholder:text-slate-600 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all"
                                />
                            </div>
                        </div>

                        <Button
                            type="submit"
                            disabled={isLoading}
                            className="w-full h-12 bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-500 hover:to-indigo-500 shadow-lg shadow-purple-500/25"
                        >
                            {isLoading ? (
                                <Loader2 className="h-5 w-5 animate-spin" />
                            ) : (
                                <>
                                    Create Account
                                    <ArrowRight className="ml-2 h-5 w-5" />
                                </>
                            )}
                        </Button>
                    </form>

                    <p className="mt-6 text-center text-sm text-slate-500">
                        Already have an account?{' '}
                        <Link
                            href={`/${locale}/auth/signin`}
                            className="text-purple-400 hover:text-purple-300 font-medium"
                        >
                            Sign in
                        </Link>
                    </p>

                    <p className="mt-8 text-center text-xs text-slate-600">
                        By continuing, you agree to our{' '}
                        <Link href={`/${locale}/terms`} className="text-slate-500 hover:text-slate-400">
                            Terms of Service
                        </Link>{' '}
                        and{' '}
                        <Link href={`/${locale}/privacy`} className="text-slate-500 hover:text-slate-400">
                            Privacy Policy
                        </Link>
                    </p>
                </motion.div>
            </div>
        </div>
    );
}
