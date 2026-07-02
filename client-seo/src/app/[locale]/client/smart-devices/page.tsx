import type { Metadata } from "next";
import { IoTContent } from "./IoTContent";

export const metadata: Metadata = {
  title: "IoT & Smart Devices | Reservatior",
  description: "Manage smart locks, thermostats, and property sensors remotely.",
  robots: { index: false, follow: false },
};

export default function SmartDevicesPage() {
  return <IoTContent />;
}
