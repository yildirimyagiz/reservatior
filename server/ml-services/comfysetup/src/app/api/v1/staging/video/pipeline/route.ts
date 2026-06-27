
import { NextRequest, NextResponse } from 'next/server';
import { selectWalkthroughPipeline, PipelineInputSchema } from '@/lib/video/pipeline-selector';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    
    // Validate input using Zod schema
    const validation = PipelineInputSchema.safeParse(body);
    
    if (!validation.success) {
      return NextResponse.json(
        { error: 'Invalid input', details: validation.error.format() },
        { status: 400 }
      );
    }

    // Execute Logic
    const result = selectWalkthroughPipeline(validation.data);

    return NextResponse.json(result);
    
  } catch (error) {
    console.error('Pipeline selection error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
