"use client";

import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Camera, Video } from "lucide-react";

export default function AdminAgentVideosPage() {
  return (
    <PageShell 
      title="Agent Videos" 
      description="Manage agent video content and recordings"
    >
      <div className="flex flex-col items-center justify-center py-20 text-center">
        <div className="w-16 h-16 rounded-full bg-primary/10 flex items-center justify-center mb-4">
          <Camera className="w-8 h-8 text-primary" />
        </div>
        <h2 className="text-xl font-semibold mb-2">Coming Soon</h2>
        <p className="text-muted-foreground max-w-md mb-6">
          Agent video management will be available in a future update.
        </p>
        <Button variant="outline">
          <Video className="w-4 h-4 mr-2" />
          Contact Support
        </Button>
      </div>
    </PageShell>
  );
}
