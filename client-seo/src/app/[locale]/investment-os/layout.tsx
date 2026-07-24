import { InvestmentOSLayout } from "@/components/spa-layouts/investment_os/InvestmentOSLayout";

export default function InvestmentOSLayoutWrapper({ children }: { children: React.ReactNode }) {
  return <InvestmentOSLayout>{children}</InvestmentOSLayout>;
}
