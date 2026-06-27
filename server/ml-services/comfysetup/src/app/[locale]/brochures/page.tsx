import { BrochureGenerator } from "./components/BrochureGenerator";

export default function BrochuresPage() {
  return (
    <div className="container mx-auto py-10">
      <h1 className="text-3xl font-bold mb-8">Marketing Materials</h1>
      <BrochureGenerator />
    </div>
  );
}
