'use client';

import { useEffect, useState } from 'react';
import { motion, stagger, useAnimate } from 'framer-motion';
import { cn } from '@/lib/utils';

export function TextGenerateEffect({
    words,
    className,
    filter = true,
    duration = 0.5,
}: {
    words: string;
    className?: string;
    filter?: boolean;
    duration?: number;
}) {
    const [scope, animate] = useAnimate();
    const wordsArray = words.split(' ');

    useEffect(() => {
        animate(
            'span',
            {
                opacity: 1,
                filter: filter ? 'blur(0px)' : 'none',
            },
            {
                duration: duration,
                delay: stagger(0.1),
            }
        );
    }, [animate, filter, duration]);

    return (
        <motion.div ref={scope} className={cn('font-bold', className)}>
            {wordsArray.map((word, idx) => (
                <motion.span
                    key={word + idx}
                    className="opacity-0"
                    style={{
                        filter: filter ? 'blur(10px)' : 'none',
                    }}
                >
                    {word}{' '}
                </motion.span>
            ))}
        </motion.div>
    );
}

export function TypewriterEffect({
    words,
    className,
    cursorClassName,
}: {
    words: { text: string; className?: string }[];
    className?: string;
    cursorClassName?: string;
}) {
    const [currentWordIndex, setCurrentWordIndex] = useState(0);
    const [currentText, setCurrentText] = useState('');
    const [isDeleting, setIsDeleting] = useState(false);

    useEffect(() => {
        const word = words[currentWordIndex].text;

        const timeout = setTimeout(() => {
            if (!isDeleting) {
                setCurrentText(word.substring(0, currentText.length + 1));
                if (currentText === word) {
                    setTimeout(() => setIsDeleting(true), 1500);
                }
            } else {
                setCurrentText(word.substring(0, currentText.length - 1));
                if (currentText === '') {
                    setIsDeleting(false);
                    setCurrentWordIndex((prev) => (prev + 1) % words.length);
                }
            }
        }, isDeleting ? 50 : 100);

        return () => clearTimeout(timeout);
    }, [currentText, isDeleting, currentWordIndex, words]);

    return (
        <div className={cn('inline-flex items-baseline', className)}>
            <span className={words[currentWordIndex].className}>
                {currentText}
            </span>
            <motion.span
                animate={{ opacity: [1, 0] }}
                transition={{ duration: 0.5, repeat: Infinity, repeatType: 'reverse' }}
                className={cn('ml-1 inline-block h-6 w-[2px] bg-purple-500', cursorClassName)}
            />
        </div>
    );
}
