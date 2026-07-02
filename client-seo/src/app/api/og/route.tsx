import { ImageResponse } from "next/og";

export const runtime = "edge";

export async function GET() {
  return new ImageResponse(
    (
      <div
        style={{
          width: 1200,
          height: 630,
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          background: "linear-gradient(135deg, #0F172A 0%, #1E1B4B 50%, #0F172A 100%)",
          fontFamily: "system-ui, sans-serif",
        }}
      >
        <div
          style={{
            display: "flex",
            alignItems: "center",
            gap: 16,
            marginBottom: 24,
          }}
        >
          <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#4F46E5" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" />
            <polyline points="9 22 9 12 15 12 15 22" />
          </svg>
          <span style={{ fontSize: 72, fontWeight: 800, color: "white", letterSpacing: "-0.02em" }}>
            Reservatior
          </span>
        </div>
        <span style={{ fontSize: 28, color: "#94A3B8", marginBottom: 40, textAlign: "center" }}>
          AI-Powered Real Estate Platform
        </span>
        <div
          style={{
            display: "flex",
            gap: 24,
            padding: "16px 32px",
            background: "rgba(79, 70, 229, 0.15)",
            borderRadius: 16,
            border: "1px solid rgba(79, 70, 229, 0.3)",
          }}
        >
          {["AI Valuation", "Video Tours", "Smart Search", "Direct Booking"].map((tag) => (
            <span key={tag} style={{ fontSize: 18, fontWeight: 600, color: "#A5B4FC" }}>
              {tag}
            </span>
          ))}
        </div>
      </div>
    ),
    {
      width: 1200,
      height: 630,
    },
  );
}
