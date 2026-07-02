"use client";

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <html>
      <body>
        <div className="min-h-screen bg-[#0A0A0B] flex items-center justify-center p-6">
          <div className="text-center max-w-lg space-y-8">
            <div className="space-y-3">
              <h1 className="text-5xl font-black text-white">Critical Error</h1>
              <p className="text-slate-400 text-lg">A critical application error occurred. Please reload the page.</p>
            </div>
            <button
              onClick={reset}
              className="px-6 py-3 rounded-xl bg-blue-600 text-white font-bold hover:bg-blue-500 transition-all"
            >
              Reload Page
            </button>
          </div>
        </div>
      </body>
    </html>
  );
}
