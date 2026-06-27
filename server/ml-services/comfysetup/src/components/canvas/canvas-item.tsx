'use client';

import { useRef, useState, useCallback, useEffect } from 'react';
import { CanvasItem } from '@/lib/store/canvas-store';
import { RotateCw, Lock } from 'lucide-react';

interface CanvasItemComponentProps {
    item: CanvasItem;
    zoom: number;
    isSelected: boolean;
    onSelect: (addToSelection: boolean) => void;
    onUpdate: (updates: Partial<CanvasItem>) => void;
}

export function CanvasItemComponent({
    item,
    zoom,
    isSelected,
    onSelect,
    onUpdate,
}: CanvasItemComponentProps) {
    const itemRef = useRef<HTMLDivElement>(null);
    const [isDragging, setIsDragging] = useState(false);
    const [isResizing, setIsResizing] = useState(false);
    const [dragStart, setDragStart] = useState({ x: 0, y: 0 });
    const [initialPos, setInitialPos] = useState({ x: 0, y: 0 });
    const [resizeStart, setResizeStart] = useState({ width: 0, height: 0, x: 0, y: 0 });

    const handleMouseMove = useCallback((e: MouseEvent) => {
        if (isDragging && !item.locked) {
            onUpdate({
                x: initialPos.x + (e.clientX - dragStart.x) / zoom,
                y: initialPos.y + (e.clientY - dragStart.y) / zoom,
            });
        }

        if (isResizing && !item.locked) {
            const deltaX = (e.clientX - resizeStart.x) / zoom;
            const deltaY = (e.clientY - resizeStart.y) / zoom;
            const newWidth = Math.max(50, resizeStart.width + deltaX);
            const newHeight = Math.max(50, resizeStart.height + deltaY);
            onUpdate({
                width: newWidth,
                height: newHeight,
            });
        }
    }, [isDragging, isResizing, item.locked, dragStart, initialPos, resizeStart, onUpdate, zoom]);

    const handleMouseUp = useCallback(() => {
        setIsDragging(false);
        setIsResizing(false);
    }, []);

    useEffect(() => {
        if (isDragging || isResizing) {
            window.addEventListener('mousemove', handleMouseMove);
            window.addEventListener('mouseup', handleMouseUp);
            return () => {
                window.removeEventListener('mousemove', handleMouseMove);
                window.removeEventListener('mouseup', handleMouseUp);
            };
        }
    }, [isDragging, isResizing, handleMouseMove, handleMouseUp]);

    // Early return after all hooks
    if (!item.visible) return null;

    const handleMouseDown = (e: React.MouseEvent) => {
        if (item.locked) return;
        e.stopPropagation();

        onSelect(e.shiftKey);

        setIsDragging(true);
        setDragStart({ x: e.clientX, y: e.clientY });
        setInitialPos({ x: item.x, y: item.y });
    };

    const handleResizeMouseDown = (e: React.MouseEvent) => {
        if (item.locked) return;
        e.stopPropagation();
        setIsResizing(true);
        setResizeStart({
            width: item.width,
            height: item.height,
            x: e.clientX,
            y: e.clientY,
        });
    };

    const handleRotate = (e: React.MouseEvent) => {
        e.stopPropagation();
        onUpdate({ rotation: (item.rotation + 45) % 360 });
    };

    return (
        <div
            ref={itemRef}
            className={`absolute cursor-move select-none ${isSelected ? 'ring-2 ring-purple-500 ring-offset-2 ring-offset-slate-900' : ''
                } ${item.locked ? 'cursor-not-allowed opacity-70' : ''}`}
            style={{
                left: item.x,
                top: item.y,
                width: item.width,
                height: item.height,
                transform: `rotate(${item.rotation}deg) scaleX(${item.scaleX}) scaleY(${item.scaleY})`,
                opacity: item.opacity,
                zIndex: item.zIndex + 10,
            }}
            onMouseDown={handleMouseDown}
        >
            {/* Item image - using img for dynamic external URLs */}
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
                src={item.src}
                alt={item.name}
                className="h-full w-full object-contain pointer-events-none"
                draggable={false}
            />

            {/* Selection controls */}
            {isSelected && !item.locked && (
                <>
                    {/* Resize handle */}
                    <div
                        className="absolute -bottom-2 -right-2 h-4 w-4 cursor-se-resize rounded-full bg-purple-500 border-2 border-white shadow-lg"
                        onMouseDown={handleResizeMouseDown}
                    />

                    {/* Rotate handle */}
                    <button
                        className="absolute -top-8 left-1/2 -translate-x-1/2 rounded-full bg-slate-800 p-1.5 text-white shadow-lg hover:bg-purple-500"
                        onClick={handleRotate}
                    >
                        <RotateCw className="h-3 w-3" />
                    </button>

                    {/* Corner indicators */}
                    <div className="absolute -left-1 -top-1 h-2 w-2 rounded-full bg-purple-500 border border-white" />
                    <div className="absolute -right-1 -top-1 h-2 w-2 rounded-full bg-purple-500 border border-white" />
                    <div className="absolute -left-1 -bottom-1 h-2 w-2 rounded-full bg-purple-500 border border-white" />
                </>
            )}

            {/* Lock indicator */}
            {item.locked && (
                <div className="absolute -top-6 left-1/2 -translate-x-1/2 rounded bg-slate-800 px-2 py-0.5">
                    <Lock className="h-3 w-3 text-slate-400" />
                </div>
            )}
        </div>
    );
}
