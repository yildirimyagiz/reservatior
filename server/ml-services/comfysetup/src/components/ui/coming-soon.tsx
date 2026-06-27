import { Construction } from 'lucide-react';
import Link from 'next/link';

interface ComingSoonProps {
    title: string;
    description: string;
    backHref?: string;
    backLabel?: string;
}

export function ComingSoon({ 
    title, 
    description, 
    backHref = "/", 
    backLabel = "Back to Home" 
}: ComingSoonProps) {
    return (
        <div className="flex flex-col items-center justify-center min-h-[60vh] px-4 text-center">
            <div className="w-16 h-16 bg-gradient-to-br from-purple-500/20 to-blue-500/20 rounded-2xl flex items-center justify-center mb-6 border border-white/10">
                <Construction className="w-8 h-8 text-purple-400" />
            </div>
            <h1 className="text-3xl md:text-4xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-slate-400 mb-4">
                {title}
            </h1>
            <p className="text-lg text-slate-400 max-w-lg mb-8">
                {description}
            </p>
            <Link 
                href={backHref}
                className="px-6 py-2.5 bg-white text-slate-950 font-medium rounded-lg hover:bg-slate-200 transition-colors"
            >
                {backLabel}
            </Link>
        </div>
    );
}
