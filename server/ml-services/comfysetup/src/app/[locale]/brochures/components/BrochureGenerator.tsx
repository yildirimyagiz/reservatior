"use client";

import { useState, useEffect } from "react";
import { brochureService, BrochureTemplate } from "@/services/brochure-service";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { toast } from "sonner";
import { Loader2, FileText, CheckCircle2, Building2 } from "lucide-react";
import { Select } from "@/components/ui/select";
import { cn } from "@/lib/utils";

interface Property {
  id: string;
  title: string;
  address: string;
}

export function BrochureGenerator() {
  const [properties, setProperties] = useState<Property[]>([]);
  const [templates, setTemplates] = useState<BrochureTemplate[]>([]);
  const [selectedPropertyId, setSelectedPropertyId] = useState<string>("");
  const [selectedTemplateId, setSelectedTemplateId] = useState<string>("");
  const [loading, setLoading] = useState(false);
  const [fetching, setFetching] = useState(true);

  useEffect(() => {
    const loadData = async () => {
      try {
        const [tpls, propsRes] = await Promise.all([
          brochureService.getTemplates(),
          fetch("/api/v1/properties").then(res => res.json())
        ]);
        setTemplates(tpls);
        setProperties(propsRes);
      } catch (error) {
        console.error(error);
        toast.error("Failed to load data");
      } finally {
        setFetching(false);
      }
    };
    loadData();
  }, []);

  const handleGenerate = async () => {
    if (!selectedPropertyId || !selectedTemplateId) return;
    setLoading(true);
    try {
      const pdfBlob = await brochureService.generate({
        propertyId: selectedPropertyId,
        templateId: selectedTemplateId
      });
      
      // Create download link
      const url = window.URL.createObjectURL(pdfBlob);
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', `brochure_${selectedPropertyId}_${selectedTemplateId}.pdf`);
      document.body.appendChild(link);
      link.click();
      link.parentNode?.removeChild(link);
      
      toast.success("Brochure generated & downloaded!");
    } catch (error) {
      console.error(error);
      toast.error("Failed to generate brochure");
    } finally {
      setLoading(false);
    }
  };

  if (fetching) {
    return <div className="flex justify-center p-12"><Loader2 className="animate-spin w-8 h-8 text-primary" /></div>;
  }

  return (
    <div className="flex flex-col gap-8 max-w-5xl mx-auto">
      
      {/* 1. Property Selection */}
      <section>
         <h2 className="text-xl font-semibold mb-4 flex items-center gap-2">
            <Building2 className="w-5 h-5 text-primary" /> 
            Select Property
         </h2>
         <Card className="p-6">
            <Select 
                value={selectedPropertyId} 
                onChange={setSelectedPropertyId}
                options={properties.map(p => ({
                    value: p.id,
                    label: `${p.title} (${p.address})`
                }))}
                placeholder="Choose a property..."
                className="w-full md:max-w-md"
            />
            {properties.length === 0 && (
                <div className="p-2 text-sm text-muted-foreground mt-2">No properties found. Please create one first.</div>
            )}
         </Card>
      </section>

      {/* 2. Template Selection */}
      <section>
        <h2 className="text-xl font-semibold mb-4 flex items-center gap-2">
            <FileText className="w-5 h-5 text-primary" />
            Choose Template
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {templates.map((tpl) => (
                <div 
                    key={tpl.id}
                    onClick={() => setSelectedTemplateId(tpl.id)}
                    className={cn(
                        "cursor-pointer group relative rounded-xl border-2 transition-all duration-200 overflow-hidden hover:shadow-lg",
                        selectedTemplateId === tpl.id 
                            ? "border-primary bg-primary/5 ring-2 ring-primary/20" 
                            : "border-transparent bg-card hover:border-border"
                    )}
                >
                    <div className="aspect-[3/4] bg-slate-100 dark:bg-slate-800 relative">
                        {/* Placeholder for template preview if no URL */}
                        {tpl.thumbnailUrl ? (
                            // eslint-disable-next-line @next/next/no-img-element
                            <img src={tpl.thumbnailUrl} alt={tpl.name} className="w-full h-full object-cover" />
                        ) : (
                            <div className="flex items-center justify-center h-full text-slate-300">
                                <FileText className="w-16 h-16" />
                            </div>
                        )}
                        
                        {selectedTemplateId === tpl.id && (
                            <div className="absolute top-2 right-2 bg-primary text-white p-1 rounded-full shadow-lg">
                                <CheckCircle2 className="w-5 h-5" />
                            </div>
                        )}
                        
                        {tpl.isPremium && (
                            <div className="absolute top-2 left-2 bg-amber-500 text-white text-[10px] uppercase font-bold px-2 py-1 rounded-sm shadow-sm">
                                Premium
                            </div>
                        )}
                    </div>
                    
                    <div className="p-4">
                        <h3 className="font-medium text-foreground group-hover:text-primary transition-colors">{tpl.name}</h3>
                        <p className="text-sm text-muted-foreground line-clamp-2 mt-1">{tpl.description}</p>
                    </div>
                </div>
            ))}
        </div>
      </section>

      {/* 3. Action */}
      <div className="sticky bottom-6 z-10 flex justify-end">
          <Card className="p-4 shadow-xl border-primary/20 bg-background/80 backdrop-blur-md">
            <Button 
                size="lg" 
                onClick={handleGenerate} 
                disabled={loading || !selectedPropertyId || !selectedTemplateId} 
                className="w-full md:w-auto min-w-[200px]"
            >
                {loading ? <Loader2 className="mr-2 h-5 w-5 animate-spin" /> : <FileText className="mr-2 h-5 w-5" />}
                Generate Brochure
            </Button>
          </Card>
      </div>

    </div>
  );
}

