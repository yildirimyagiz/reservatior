import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useTranslation } from "react-i18next";
import { AlertCircle } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Button } from "@/components/ui/button";

interface SocialAuthModalProps {
  isOpen: boolean;
  onClose: () => void;
  provider: string;
}

export function SocialAuthModal({ isOpen, onClose, provider }: SocialAuthModalProps) {
  const { t } = useTranslation();
  
  const providerName = provider ? provider.charAt(0).toUpperCase() + provider.slice(1) : '';
  
  return (
    <Dialog open={isOpen} onOpenChange={(open) => !open && onClose()}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{t("client.src.social_login") || "Social Login"}</DialogTitle>
          <DialogDescription>
            {t("client.src.social_login_description") || `Connecting to ${providerName}...`}
          </DialogDescription>
        </DialogHeader>
        <div className="py-4">
          <Alert>
            <AlertCircle className="h-4 w-4" />
            <AlertDescription>
              {t("client.src.social_login_coming_soon") || `${providerName} login is currently being set up. Please use email/password for now.`}
            </AlertDescription>
          </Alert>
        </div>
        <div className="flex justify-end">
          <Button onClick={onClose}>{t("common.close") || "Close"}</Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
