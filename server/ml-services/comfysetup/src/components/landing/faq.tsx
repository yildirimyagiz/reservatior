"use client";

import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import type { Dictionary } from '@/lib/i18n/config';

interface FAQProps {
  dictionary: Dictionary;
}

export function FAQ({ dictionary }: FAQProps) {
  const d = dictionary.landing.faq;

  return (
    <section className="py-24 bg-slate-950">
      <div className="container mx-auto px-4 max-w-3xl">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-5xl font-bold text-white mb-4">
            {d.title}
          </h2>
          <p className="text-slate-400 text-lg">
            {d.subtitle}
          </p>
        </div>

        <Accordion type="single" collapsible className="w-full space-y-4">
          {d.items.map((faq, index) => (
            <AccordionItem key={index} value={`item-${index}`} className="border border-white/10 rounded-lg px-6 bg-white/5 data-[state=open]:bg-white/10 transition-colors">
              <AccordionTrigger className="text-lg font-medium text-white hover:text-purple-400 hover:no-underline py-6">
                {faq.question}
              </AccordionTrigger>
              <AccordionContent className="text-slate-300 pb-6 text-base leading-relaxed">
                {faq.answer}
              </AccordionContent>
            </AccordionItem>
          ))}
        </Accordion>
      </div>
    </section>
  );
}
