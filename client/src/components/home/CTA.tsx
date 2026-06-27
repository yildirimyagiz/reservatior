import { useTranslation } from "react-i18next";
import { ArrowRight, Sparkles } from "lucide-react";
import { motion } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
export function CTA() {
  const {
    t
  } = useTranslation();
  return <section className="py-24 px-4 md:px-6">
      <div className="container mx-auto text-center">
        <motion.div initial={{
        opacity: 0,
        y: 20
      }} whileInView={{
        opacity: 1,
        y: 0
      }} viewport={{
        once: true
      }} className="max-w-4xl mx-auto">
          <h2 className="text-2xl md:text-3xl font-medium tracking-wide mb-4">{t("client.src.ready_to_transform_your")}</h2>
          <p className="text-xl text-muted-foreground mb-8 max-w-2xl mx-auto">{t("client.src.join_thousands_of_professionals")}</p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/auth/signup" className="contents">
              <Button size="lg" className="bg-primary hover:bg-primary/90">
                <Sparkles className="w-5 h-5 mr-2" />{t("client.src.start_free_trial")}</Button>
            </Link>
            <Link to="/trust" className="contents">
              <Button size="lg" variant="outline">
                <ArrowRight className="w-5 h-5 mr-2" />{t("client.src.view_demo")}</Button>
            </Link>
          </div>
          <p className="text-sm text-muted-foreground mt-6">{t("client.src.no_credit_card_required")}</p>
        </motion.div>
      </div>
    </section>;
}