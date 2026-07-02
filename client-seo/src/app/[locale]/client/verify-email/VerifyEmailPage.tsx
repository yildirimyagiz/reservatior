"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Mail, ArrowLeft, ArrowRight, CheckCircle, RefreshCw } from "lucide-react";
import { motion } from "framer-motion";

export default function VerifyEmailPage() {
  const router = useRouter();
  const [code, setCode] = useState("");
  const [isVerified, setIsVerified] = useState(false);
  const [isResending, setIsResending] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setIsVerified(true);
    // Handle verification logic here
  };

  const handleResend = () => {
    setIsResending(true);
    setTimeout(() => setIsResending(false), 2000);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 flex items-center justify-center p-4">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="w-full max-w-md"
      >
        <Button
          variant="ghost"
          onClick={() => router.push('/login')}
          className="mb-6 text-gray-400 hover:text-white"
        >
          <ArrowLeft className="w-4 h-4 mr-2" />
          Back to Login
        </Button>

        <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
          <CardHeader className="text-center">
            <div className="p-6 rounded-full bg-purple-500/20 mx-auto mb-6 w-fit">
              <Mail className="w-16 h-16 text-purple-400" />
            </div>
            <CardTitle className="text-3xl font-bold text-white mb-2">
              {isVerified ? "Email Verified" : "Verify Your Email"}
            </CardTitle>
            <p className="text-gray-400">
              {isVerified 
                ? "Your email has been successfully verified"
                : "Enter the verification code sent to your email"}
            </p>
          </CardHeader>
          <CardContent>
            {!isVerified ? (
              <form onSubmit={handleSubmit} className="space-y-6">
                <div className="space-y-2">
                  <div className="text-white text-center text-sm mb-2">Verification Code</div>
                  <Input
                    id="code"
                    type="text"
                    placeholder="123456"
                    value={code}
                    onChange={(e) => setCode(e.target.value)}
                    className="text-center text-2xl tracking-widest bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    maxLength={6}
                    required
                  />
                </div>

                <Button type="submit" className="w-full bg-purple-600 hover:bg-purple-700">
                  Verify Email
                  <ArrowRight className="w-4 h-4 ml-2" />
                </Button>

                <div className="text-center">
                  <button
                    type="button"
                    onClick={handleResend}
                    disabled={isResending}
                    className="text-sm text-purple-400 hover:text-purple-300 disabled:text-gray-400"
                  >
                    {isResending ? (
                      <span className="flex items-center justify-center gap-2">
                        <RefreshCw className="w-4 h-4 animate-spin" />
                        Sending...
                      </span>
                    ) : (
                      "Resend Code"
                    )}
                  </button>
                </div>
              </form>
            ) : (
              <div className="text-center space-y-6">
                <div className="p-6 rounded-full bg-green-500/20 mx-auto w-fit">
                  <CheckCircle className="w-16 h-16 text-green-400" />
                </div>
                <div className="space-y-4">
                  <p className="text-gray-300">
                    Your email has been successfully verified. You can now access all features.
                  </p>
                </div>
                <Button
                  onClick={() => router.push('/dashboard')}
                  className="w-full bg-purple-600 hover:bg-purple-700"
                >
                  Continue to Dashboard
                  <ArrowRight className="w-4 h-4 ml-2" />
                </Button>
              </div>
            )}
          </CardContent>
        </Card>
      </motion.div>
    </div>
  );
}
