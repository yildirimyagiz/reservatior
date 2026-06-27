/** @type {import('next').NextConfig} */
const nextConfig = {
    // === PRODUCTION OPTIMIZATIONS ===

    // Output mode
    output: 'standalone',

    // External packages for server-side rendering
    serverExternalPackages: ['nodemailer', 'sharp'],

    // Optimize for production
    poweredByHeader: false,

    // Ignore TypeScript and ESLint errors during build
    typescript: {
        ignoreBuildErrors: true,
    },
    eslint: {
        ignoreDuringBuilds: true,
    },

    // Compress responses
    compress: true,

    // === IMAGES ===
    images: {
        // Use CDN for image optimization in production
        unoptimized: process.env.NODE_ENV === 'production',

        // Remote patterns for allowed image sources
        remotePatterns: [
            // Shopify
            {
                protocol: 'https',
                hostname: '**.myshopify.com',
            },
            {
                protocol: 'https',
                hostname: 'cdn.shopify.com',
            },
            {
                protocol: 'https',
                hostname: '**.shopifycdn.com',
            },
            // Stock images
            {
                protocol: 'https',
                hostname: 'images.unsplash.com',
            },
            {
                protocol: 'https',
                hostname: 'plus.unsplash.com',
            },
            {
                protocol: 'https',
                hostname: 'm.media-amazon.com',
            },
            // Cloudflare R2 CDN (add your domain)
            {
                protocol: 'https',
                hostname: '**.r2.cloudflarestorage.com',
            },
            {
                protocol: 'https',
                hostname: 'images.collov.ai',
            },
            // Custom CDN domain
            {
                protocol: 'https',
                hostname: 'images.atlasvs.com',
            },
            // Avatars
            {
                protocol: 'https',
                hostname: 'i.pravatar.cc',
            },
        ],

        // Reduce quality slightly for bandwidth savings
        deviceSizes: [640, 750, 828, 1080, 1200],
        imageSizes: [16, 32, 48, 64, 96, 128, 256],
    },

    // === API REWRITES ===
    async rewrites() {
        const backendUrl = process.env.BACKEND_URL || 'http://127.0.0.1:8000';

        return [
            {
                source: '/api/v1/walkthroughs/:path*',
                destination: `${backendUrl}/api/v1/walkthroughs/:path*`,
            },
            {
                source: '/api/v1/brochures/:path*',
                destination: `${backendUrl}/api/v1/brochures/:path*`,
            },
        ];
    },

    // === HEADERS ===
    async headers() {
        return [
            {
                source: '/(.*)',
                headers: [
                    {
                        key: 'X-Frame-Options',
                        value: 'SAMEORIGIN',
                    },
                    {
                        key: 'X-Content-Type-Options',
                        value: 'nosniff',
                    },
                    {
                        key: 'X-XSS-Protection',
                        value: '1; mode=block',
                    },
                    {
                        key: 'Referrer-Policy',
                        value: 'strict-origin-when-cross-origin',
                    },
                ],
            },
            // Cache static assets aggressively
            {
                source: '/static/:path*',
                headers: [
                    {
                        key: 'Cache-Control',
                        value: 'public, max-age=31536000, immutable',
                    },
                ],
            },
            // Cache fonts
            {
                source: '/fonts/:path*',
                headers: [
                    {
                        key: 'Cache-Control',
                        value: 'public, max-age=31536000, immutable',
                    },
                ],
            },
        ];
    },

    // === EXPERIMENTAL ===
    experimental: {
        // Server actions for form handling
        serverActions: {
            bodySizeLimit: '2mb',
        },
    },

    // === WEBPACK ===
    webpack: (config, { isServer }) => {
        // Handle sharp for image processing
        if (isServer) {
            config.externals.push('sharp');
        }
        return config;
    },
};

export default nextConfig;
