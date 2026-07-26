import { redirect } from "next/navigation";

export default function SpaPageWrapper({ params }: { params: { locale: string; spa: string[] } }) {
  redirect(`/${params.locale || "en"}`);
}
