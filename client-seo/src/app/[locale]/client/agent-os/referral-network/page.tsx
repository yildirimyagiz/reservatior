
import { Metadata } from "next";
import ReferralNetwork from "./ReferralNetwork";

export const metadata: Metadata = {
  title: "Referral Network | Reservatior",
  description: "Manage your referral network and passive income",
};

export default function ReferralNetworkPage() {
  return <ReferralNetwork />;
}
