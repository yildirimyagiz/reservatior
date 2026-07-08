import ListingDashboard from "@/pages-spa/listing_os/Dashboard";

export const metadata = {
  title: "Listing OS - Reservatior",
  description: "Digital Health Record & Asset Management",
};

export default function ListingOSPage() {
  return (
    <div className="p-8">
      <ListingDashboard />
    </div>
  );
}
