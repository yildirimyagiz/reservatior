"use client";

import { useState } from "react";
import { voiceoverService } from "@/services/voiceover-service";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Select } from "@/components/ui/select";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { toast } from "sonner";
import { Loader2, Mic, PlayCircle } from "lucide-react";

const LANGUAGES = [
  { value: "EN", label: "English" },
  { value: "ES", label: "Spanish" },
  { value: "FR", label: "French" },
  { value: "DE", label: "German" },
  { value: "IT", label: "Italian" },
  { value: "PT", label: "Portuguese" },
  { value: "AR", label: "Arabic" },
  { value: "ZH_CN", label: "Chinese" },
  { value: "JA", label: "Japanese" },
  { value: "KO", label: "Korean" },
];

export function VoiceoverGenerator() {
  const [text, setText] = useState("");
  const [language, setLanguage] = useState("EN");
  const [loading, setLoading] = useState(false);
  const [audioUrl, setAudioUrl] = useState<string | null>(null);

  const handleGenerate = async () => {
    if (!text) return;
    setLoading(true);
    setAudioUrl(null);
    
    try {
      const data = await voiceoverService.generate({
        text,
        language,
      });
      
      setAudioUrl(data.audioUrl);
      toast.success("Voiceover generated successfully!");
    } catch (error) {
      console.error(error);
      toast.error("Failed to generate voiceover. Check backend connection.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card className="w-full h-full bg-white dark:bg-slate-900 border-slate-200 dark:border-slate-800">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
            <Mic className="w-5 h-5 text-primary" />
            AI Voiceover
        </CardTitle>
        <CardDescription>
            Generate professional voiceovers for your property videos in multiple languages.
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="space-y-2">
            <Label htmlFor="language">Language</Label>
            <Select
                value={language}
                onChange={setLanguage}
                options={LANGUAGES}
                placeholder="Select Language"
            />
        </div>

        <div className="space-y-2">
            <Label htmlFor="script">Script</Label>
            <Textarea 
                id="script"
                placeholder="Enter your property description here..." 
                value={text} 
                onChange={(e) => setText(e.target.value)} 
                className="min-h-[120px] resize-none"
            />
            <p className="text-xs text-muted-foreground">
                {text.length} characters
            </p>
        </div>

        <Button 
            onClick={handleGenerate} 
            disabled={loading || !text} 
            className="w-full"
        >
            {loading ? (
                <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Generating Audio...
                </>
            ) : (
                "Generate Voiceover"
            )}
        </Button>

        {audioUrl && (
            <div className="mt-4 p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50 border border-slate-100 dark:border-slate-800 animate-in fade-in slide-in-from-top-2">
                <div className="flex items-center gap-2 mb-2">
                    <PlayCircle className="w-4 h-4 text-primary" />
                    <span className="text-sm font-medium">Preview</span>
                </div>
                <audio controls className="w-full h-8">
                    <source src={audioUrl} type="audio/mpeg" />
                    Your browser does not support the audio element.
                </audio>
            </div>
        )}
      </CardContent>
    </Card>
  );
}
