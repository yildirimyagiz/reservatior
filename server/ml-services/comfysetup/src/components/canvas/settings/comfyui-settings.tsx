'use client';

import { useState, useEffect, useCallback } from 'react';
import { useCanvasStore } from '@/lib/store/canvas-store';
import { Button } from '@/components/ui/button';
import { RefreshCw, CheckCircle2, XCircle, Loader2, Sparkles } from 'lucide-react';

type EngineType = 'a1111' | 'comfyui';

export function AISettings() {
    const { 
        comfyuiUrl, 
        selectedCheckpoint,
        setComfyUrl,
        setCheckpoint,
    } = useCanvasStore();

    const [engine, setEngine] = useState<EngineType>('a1111');
    const [isTesting, setIsTesting] = useState(false);
    const [status, setStatus] = useState<'idle' | 'connected' | 'error'>('idle');
    const [models, setModels] = useState<string[]>([]);
    const [samplers, setSamplers] = useState<string[]>([]);
    const [selectedSampler, setSelectedSampler] = useState('DPM++ 2M Karras');
    const [healthInfo, setHealthInfo] = useState<{ model?: string; modelsAvailable?: number }>({});

    // Default URLs
    const A1111_DEFAULT = 'http://127.0.0.1:7860';

    const currentUrl = engine === 'a1111' ? A1111_DEFAULT : comfyuiUrl;

    const testConnection = useCallback(async () => {
        setIsTesting(true);
        setStatus('idle');
        
        try {
            if (engine === 'a1111') {
                // Test A1111 connection
                const res = await fetch(`/api/v1/staging/a1111-status?url=${encodeURIComponent(currentUrl)}`);
                const data = await res.json();
                
                if (data.status === 'healthy') {
                    setStatus('connected');
                    setModels(data.models || []);
                    setSamplers(data.samplers || []);
                    setHealthInfo({
                        model: data.currentModel,
                        modelsAvailable: data.modelsAvailable,
                    });
                    
                    if (!selectedCheckpoint && data.models?.length > 0) {
                        setCheckpoint(data.models[0]);
                    }
                } else {
                    setStatus('error');
                }
            } else {
                // Test ComfyUI connection (legacy)
                const res = await fetch(`/api/v1/staging/comfyui?url=${encodeURIComponent(comfyuiUrl)}`);
                const data = await res.json();
                
                if (data.connected) {
                    setStatus('connected');
                    setModels(data.checkpoints || []);
                } else {
                    setStatus('error');
                }
            }
        } catch (error) {
            console.error(error);
            setStatus('error');
        } finally {
            setIsTesting(false);
        }
    }, [engine, currentUrl, comfyuiUrl, selectedCheckpoint, setCheckpoint]);

    // Auto-test on mount
    useEffect(() => {
        testConnection();
    }, [engine]); // eslint-disable-line react-hooks/exhaustive-deps

    return (
        <div className="space-y-4 rounded-lg border border-slate-800 bg-slate-800/50 p-3">
            <div className="flex items-center gap-2 text-sm font-semibold text-slate-200">
                <Sparkles className="h-4 w-4 text-purple-400" />
                <h3>AI Generation Settings</h3>
            </div>

            {/* Engine Toggle */}
            <div>
                <label className="mb-1 block text-xs text-slate-400">AI Engine</label>
                <div className="flex gap-2">
                    <button
                        onClick={() => setEngine('a1111')}
                        className={`flex-1 rounded px-3 py-1.5 text-xs font-medium transition ${
                            engine === 'a1111'
                                ? 'bg-purple-600 text-white'
                                : 'bg-slate-700 text-slate-300 hover:bg-slate-600'
                        }`}
                    >
                        A1111 (Free)
                    </button>
                    <button
                        onClick={() => setEngine('comfyui')}
                        className={`flex-1 rounded px-3 py-1.5 text-xs font-medium transition ${
                            engine === 'comfyui'
                                ? 'bg-purple-600 text-white'
                                : 'bg-slate-700 text-slate-300 hover:bg-slate-600'
                        }`}
                    >
                        ComfyUI
                    </button>
                </div>
            </div>

            {/* Server URL Display */}
            <div>
                <label className="mb-1 block text-xs text-slate-400">Server URL</label>
                <div className="flex gap-2">
                    <input
                        type="text"
                        value={currentUrl}
                        onChange={(e) => engine === 'comfyui' && setComfyUrl(e.target.value)}
                        readOnly={engine === 'a1111'}
                        className={`flex-1 rounded border border-slate-700 bg-slate-900 px-2 py-1 text-xs text-white focus:border-purple-500 focus:outline-none ${
                            engine === 'a1111' ? 'opacity-60' : ''
                        }`}
                    />
                    <Button
                        size="sm"
                        variant="secondary"
                        onClick={testConnection}
                        disabled={isTesting}
                        className="h-auto px-2 py-1"
                    >
                        {isTesting ? (
                            <Loader2 className="h-3 w-3 animate-spin" />
                        ) : (
                            <RefreshCw className="h-3 w-3" />
                        )}
                    </Button>
                </div>
            </div>

            {/* Status Indicator */}
            {status !== 'idle' && (
                <div className={`flex items-center gap-2 text-xs ${
                    status === 'connected' ? 'text-green-400' : 'text-red-400'
                }`}>
                    {status === 'connected' ? (
                        <>
                            <CheckCircle2 className="h-3 w-3" />
                            <span>Connected</span>
                            {healthInfo.model && (
                                <span className="text-slate-500">• {healthInfo.model}</span>
                            )}
                        </>
                    ) : (
                        <>
                            <XCircle className="h-3 w-3" />
                            <span>Not Connected</span>
                            <span className="text-slate-500 text-[10px]">
                                {engine === 'a1111' 
                                    ? '(Start: ./webui.sh --api)' 
                                    : '(Start ComfyUI)'}
                            </span>
                        </>
                    )}
                </div>
            )}

            {/* Model Selection */}
            {status === 'connected' && models.length > 0 && (
                <div className="space-y-3 pt-2">
                    <div>
                        <label className="mb-1 block text-xs text-slate-400">
                            Model ({models.length} available)
                        </label>
                        <select
                            value={selectedCheckpoint}
                            onChange={(e) => setCheckpoint(e.target.value)}
                            className="w-full rounded border border-slate-700 bg-slate-900 px-2 py-1 text-xs text-white focus:border-purple-500 focus:outline-none"
                        >
                            {models.map(model => (
                                <option key={model} value={model}>{model}</option>
                            ))}
                        </select>
                    </div>

                    {engine === 'a1111' && samplers.length > 0 && (
                        <div>
                            <label className="mb-1 block text-xs text-slate-400">Sampler</label>
                            <select
                                value={selectedSampler}
                                onChange={(e) => setSelectedSampler(e.target.value)}
                                className="w-full rounded border border-slate-700 bg-slate-900 px-2 py-1 text-xs text-white focus:border-purple-500 focus:outline-none"
                            >
                                {samplers.map(sampler => (
                                    <option key={sampler} value={sampler}>{sampler}</option>
                                ))}
                            </select>
                        </div>
                    )}
                </div>
            )}

            {/* Help Text */}
            <p className="text-[10px] text-slate-500">
                {engine === 'a1111' 
                    ? '💡 A1111 is free & runs locally. Start with: ./webui.sh --api'
                    : '💡 ComfyUI is an advanced workflow tool for complex pipelines.'
                }
            </p>
        </div>
    );
}

// Legacy export for backwards compatibility
export { AISettings as ComfyUISettings };
