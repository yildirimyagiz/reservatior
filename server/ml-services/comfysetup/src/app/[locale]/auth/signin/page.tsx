'use client';

import { useState } from 'react';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { signIn } from 'next-auth/react';
import { motion } from 'framer-motion';
import { Mail, ArrowRight, Loader2, Sparkles, Check, Shield } from 'lucide-react';
import { Button } from '@/components/ui/button';

export default function SignInPage() {
    const params = useParams();
    const locale = params.locale as string;
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);

    const handleGoogleSignIn = async () => {
        setIsLoading(true);
        await signIn('google', { callbackUrl: `/${locale}/editor` });
    };

    const handleEmailSignIn = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!email || !password) return;

        setIsLoading(true);

        try {
            const res = await signIn('credentials', {
                email,
                password,
                redirect: false,
                callbackUrl: `/${locale}/editor`,
            });

            if (res?.error) {
                console.error("Sign in error:", res.error);
                setIsLoading(false);
                // In a real app, you would set an error state here to show in UI
            } else {
                // Success - redirect handled by client or router
                window.location.href = `/${locale}/editor`;
            }
        } catch (error) {
            console.error("Sign in failed", error);
            setIsLoading(false);
        }
    };

    const benefits = [
        'Unlimited AI staging generations',
        'Access to all design styles',
        'Save and export your designs',
        'Priority support',
    ];

    return (
        <div className="min-h-screen bg-slate-950 flex">
            {/* Left side - Form */}
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
                        Welcome back
                    </h1>
                    <p className="text-slate-400 mb-8">
                        Sign in to continue to your account
                    </p>

                    {/* Google Sign In */}
                    <Button
                        onClick={handleGoogleSignIn}
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
                                Continue with Google
                            </>
                        )}
                    </Button>

                    <div className="relative my-6">
                        <div className="absolute inset-0 flex items-center">
                            <div className="w-full border-t border-slate-800" />
                        </div>
                        <div className="relative flex justify-center text-xs uppercase">
                            <span className="bg-slate-950 px-3 text-slate-500">Or continue with</span>
                        </div>
                    </div>

                    {/* Email Sign In */}
                    <form onSubmit={handleEmailSignIn} className="space-y-4">
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
                                    className="w-full h-12 pl-11 pr-4 rounded-xl bg-slate-900 border border-slate-800 text-white placeholder:text-slate-600 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all"
                                />
                            </div>
                        </div>

                        <Button
                            type="submit"
                            disabled={isLoading || !email || !password}
                            className="w-full h-12 bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-500 hover:to-indigo-500 shadow-lg shadow-purple-500/25"
                        >
                            {isLoading ? (
                                <Loader2 className="h-5 w-5 animate-spin" />
                            ) : (
                                <>
                                    Sign In
                                    <ArrowRight className="ml-2 h-5 w-5" />
                                </>
                            )}
                        </Button>
                    </form>

                    <p className="mt-6 text-center text-sm text-slate-500">
                        Don&apos;t have an account?{' '}
                        <Link
                            href={`/${locale}/auth/signup`}
                            className="text-purple-400 hover:text-purple-300 font-medium"
                        >
                            Sign up for free
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

            {/* Right side - Hero */}
            <div className="hidden lg:flex flex-1 items-center justify-center bg-gradient-to-br from-purple-900/20 to-indigo-900/20 p-12 relative overflow-hidden">
                {/* Background orbs */}
                <div className="absolute top-1/4 right-1/4 h-[400px] w-[400px] rounded-full bg-purple-600/20 blur-[100px]" />
                <div className="absolute bottom-1/4 left-1/4 h-[300px] w-[300px] rounded-full bg-indigo-600/20 blur-[80px]" />

                <div className="relative z-10 max-w-lg">
                    <motion.div
                        initial={{ opacity: 0, scale: 0.9 }}
                        animate={{ opacity: 1, scale: 1 }}
                        transition={{ delay: 0.2 }}
                    >
                        <h2 className="text-4xl font-bold text-white mb-6">
                            Transform Empty Spaces into Dream Homes
                        </h2>
                        <p className="text-lg text-slate-400 mb-8">
                            Join thousands of real estate professionals using AI to stage properties in seconds.
                        </p>

                        <div className="space-y-4">
                            {benefits.map((benefit, index) => (
                                <motion.div
                                    key={benefit}
                                    initial={{ opacity: 0, x: -20 }}
                                    animate={{ opacity: 1, x: 0 }}
                                    transition={{ delay: 0.3 + index * 0.1 }}
                                    className="flex items-center gap-3"
                                >
                                    <div className="flex h-6 w-6 items-center justify-center rounded-full bg-green-500/20">
                                        <Check className="h-4 w-4 text-green-400" />
                                    </div>
                                    <span className="text-slate-300">{benefit}</span>
                                </motion.div>
                            ))}
                        </div>

                        {/* Floating preview images */}
                        <div className="mt-12 relative">
                            <motion.div
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.6 }}
                                className="w-72 h-48 rounded-2xl overflow-hidden shadow-2xl shadow-purple-500/20 rotate-[-3deg]"
                            >
                                {/* eslint-disable-next-line @next/next/no-img-element */}
                                <img
                                    src="https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=400&q=80"
                                    alt="Staged room"
                                    className="w-full h-full object-cover"
                                />
                            </motion.div>
                            <motion.div
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.8 }}
                                className="absolute -bottom-8 left-32 w-56 h-40 rounded-2xl overflow-hidden shadow-2xl shadow-indigo-500/20 rotate-[4deg]"
                            >
                                {/* eslint-disable-next-line @next/next/no-img-element */}
                                <img
                                    src="https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=400&q=80"
                                    alt="Before staging"
                                    className="w-full h-full object-cover"
                                />
                            </motion.div>
                        </div>
                    </motion.div>
                </div>
            </div>
        </div>
    );
}
