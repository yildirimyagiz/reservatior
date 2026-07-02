"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { 
  Star, 
  ArrowUpRight,
  Calendar
} from "lucide-react";
import { motion } from "framer-motion";

interface Review {
  id: string;
  reviewerName: string;
  property: string;
  rating: number;
  comment: string;
  date: string;
}

const mockReviews: Review[] = [
  { id: "1", reviewerName: "John Doe", property: "Luxury Villa", rating: 5, comment: "Amazing property! Everything was perfect.", date: "2024-04-15" },
  { id: "2", reviewerName: "Jane Smith", property: "Downtown Apartment", rating: 4, comment: "Great location, clean apartment.", date: "2024-04-14" },
  { id: "3", reviewerName: "Bob Wilson", property: "Beachfront Condo", rating: 5, comment: "Stunning views and excellent amenities.", date: "2024-04-13" },
  { id: "4", reviewerName: "Alice Brown", property: "Studio Loft", rating: 4, comment: "Cozy and well-maintained space.", date: "2024-04-12" }
];

export default function ProfileReviewsPage() {
  const router = useRouter();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">My Reviews</h1>
              <p className="text-gray-400">Reviews you&apos;ve received</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              Dashboard
            </Button>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white">All Reviews ({mockReviews.length})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {mockReviews.map((review) => (
                  <div
                    key={review.id}
                    className="p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-start justify-between mb-3">
                      <div className="flex items-center gap-3">
                        <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center text-purple-400 font-bold">
                          {review.reviewerName.split(' ').map(n => n[0]).join('')}
                        </div>
                        <div>
                          <div className="text-white font-medium">{review.reviewerName}</div>
                          <div className="text-sm text-gray-400">{review.property}</div>
                        </div>
                      </div>
                      <div className="text-sm text-gray-400 flex items-center gap-1">
                        <Calendar className="w-3 h-3" />
                        {review.date}
                      </div>
                    </div>
                    <div className="flex items-center gap-1 mb-2">
                      {[...Array(5)].map((_, i) => (
                        <Star
                          key={i}
                          className={`w-4 h-4 ${i < review.rating ? 'text-yellow-400 fill-yellow-400' : 'text-gray-600'}`}
                        />
                      ))}
                    </div>
                    <p className="text-gray-300">{review.comment}</p>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
