"use client";

import { useState, useEffect } from "react";
import { walkthroughService } from "@/services/walkthrough-service";
import { WalkthroughInput } from "@/types/walkthrough";
import WalkthroughPreview from "./components/WalkthroughPreview";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { toast } from "sonner";
import { Loader2 } from "lucide-react";

// Mock types for now if not globally available
// import { WalkthroughInput } from "@/types/walkthrough"; 

export default function WalkthroughGenerationPage() {
  const [isProcessing, setIsProcessing] = useState(false);
  const [jobId, setJobId] = useState<string | null>(null);
  const [videoUrl, setVideoUrl] = useState<string | null>(null);

  // Poll for status if we have a job ID
  useEffect(() => {
    let interval: NodeJS.Timeout;

    if (jobId && !videoUrl) {
      interval = setInterval(async () => {
        try {
          const status = await walkthroughService.getStatus(jobId);
          console.log("Job Status:", status);
          
          if (status.status === "COMPLETED" && status.output_url) {
             setVideoUrl(status.output_url);
             setIsProcessing(false);
             setJobId(null);
             toast.success("Walkthrough generated!");
          } else if (status.status === "FAILED") {
             setIsProcessing(false);
             setJobId(null);
             toast.error("Generation failed: " + status.error);
          }
        } catch (e) {
          console.error("Polling error", e);
        }
      }, 5000);
    }

    return () => clearInterval(interval);
  }, [jobId, videoUrl]);

  const handleStartGeneration = async () => {
    setIsProcessing(true);
    try {
      // 1. Select Pipeline (Optional, can be skipped if hardcoded)
      // const pipeline = await walkthroughService.selectPipeline({ ... });

      // 2. Start Job
      // Mock data for input
      const input: WalkthroughInput = {
        listing_id: "demo-123",
        image_urls: ["https://example.com/image1.jpg"],
        room_type: "living_room",
        design_style: "modern"
      };

      const job = await walkthroughService.generate(input);
      setJobId(job.job_id); // Assuming backend returns job_id
      toast.info("Generation started...");
    } catch (error) {
      console.error(error);
      setIsProcessing(false);
      toast.error("Failed to start generation");
    }
  };

  return (
    <div className="container mx-auto py-8">
      <h1 className="text-3xl font-bold mb-8">AI Walkthrough Generation</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
        <Card className="p-6">
           <h2 className="text-xl font-semibold mb-4">Configuration</h2>
           <p className="mb-4 text-slate-500">Configure your walkthrough settings here.</p>
           
           <Button onClick={handleStartGeneration} disabled={isProcessing}>
             {isProcessing && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
             {isProcessing ? "Processing..." : "Generate Walkthrough"}
           </Button>
        </Card>

        <div>
            <WalkthroughPreview 
               videoUrl={videoUrl}
               isProcessing={isProcessing}
            />
        </div>
      </div>
    </div>
  );
}
