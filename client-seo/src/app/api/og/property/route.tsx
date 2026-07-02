import { ImageResponse } from 'next/og';
import { NextRequest } from 'next/server';

export const runtime = 'edge';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);

    // Dynamic params
    const title = searchParams.get('title')?.slice(0, 60) || 'Premium Real Estate';
    const price = searchParams.get('price') || 'Contact for Price';
    const location = searchParams.get('location') || 'Reservatior';
    const image = searchParams.get('image') || 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1200&q=80';

    return new ImageResponse(
      (
        <div
          style={{
            height: '100%',
            width: '100%',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'flex-start',
            justifyContent: 'flex-end',
            backgroundImage: `url(${image})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            position: 'relative',
          }}
        >
          {/* Overlay Gradient */}
          <div
            style={{
              position: 'absolute',
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              backgroundImage: 'linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.3) 50%, rgba(0,0,0,0) 100%)',
            }}
          />
          
          {/* Content */}
          <div
            style={{
              display: 'flex',
              flexDirection: 'column',
              padding: '60px',
              zIndex: 10,
              width: '100%',
            }}
          >
            <div
              style={{
                fontSize: 32,
                color: '#38bdf8', // Tailwind light blue
                fontWeight: 'bold',
                textTransform: 'uppercase',
                letterSpacing: '0.1em',
                marginBottom: '10px',
              }}
            >
              {location}
            </div>
            
            <div
              style={{
                fontSize: 72,
                color: 'white',
                fontWeight: 900,
                lineHeight: 1.1,
                marginBottom: '20px',
                textShadow: '0 2px 10px rgba(0,0,0,0.5)',
              }}
            >
              {title}
            </div>

            <div
              style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                width: '100%',
              }}
            >
              <div
                style={{
                  fontSize: 50,
                  color: '#4ade80', // Tailwind green
                  fontWeight: 'bold',
                }}
              >
                {price}
              </div>

              <div
                style={{
                  display: 'flex',
                  alignItems: 'center',
                }}
              >
                {/* Brand Logo/Text */}
                <div
                  style={{
                    fontSize: 40,
                    fontWeight: 900,
                    color: 'white',
                    background: 'linear-gradient(to right, #2563eb, #4f46e5)',
                    padding: '10px 30px',
                    borderRadius: '12px',
                  }}
                >
                  RESERVATIOR
                </div>
              </div>
            </div>
          </div>
        </div>
      ),
      {
        width: 1200,
        height: 630,
      }
    );
  } catch (e: any) {
    console.error(e);
    return new Response(`Failed to generate OG image`, {
      status: 500,
    });
  }
}
