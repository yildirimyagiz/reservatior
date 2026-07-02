"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Linkedin } from "lucide-react";

const API_BASE = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000";

export function LinkedInShare({ text, onSuccess, onError }: {
  text: string;
  onSuccess?: (postId: string) => void;
  onError?: (error: string) => void;
}) {
  const [loading, setLoading] = useState(false);

  const handleShare = async () => {
    setLoading(true);
    try {
      const tokenRes = await fetch(`${API_BASE}/api/auth/linkedin/account`, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("accessToken") || ""}`,
        },
      });

      if (!tokenRes.ok) {
        if (tokenRes.status === 404) {
          const loginUrl = `${API_BASE}/api/auth/linkedin`;
          window.open(loginUrl, "_blank", "width=600,height=700");
          onError?.("LinkedIn hesabını bağlaman gerekiyor. Yeni sekmede yönlendiriliyorsun.");
        } else {
          onError?.("LinkedIn hesabı bulunamadı. Lütfen önce LinkedIn ile giriş yap.");
        }
        return;
      }

      const { accessToken, authorId } = await tokenRes.json();

      const shareRes = await fetch(`${API_BASE}/api/linkedin/share`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ accessToken, authorId, text }),
      });

      const result = await shareRes.json();
      if (!shareRes.ok) {
        onError?.(result.error || "Paylaşım başarısız");
        return;
      }

      onSuccess?.(result.postId);
    } catch (e) {
      onError?.("Bir hata oluştu");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Button
      variant="outline"
      onClick={handleShare}
      disabled={loading}
      className="h-11 bg-[#0A66C2] hover:bg-[#004182] text-white border-none rounded-xl transition-all"
    >
      <Linkedin className="h-4 w-4 mr-2" />
      {loading ? "Paylaşılıyor..." : "LinkedIn'de Paylaş"}
    </Button>
  );
}
