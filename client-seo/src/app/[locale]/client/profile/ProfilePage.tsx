"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Switch } from "@/components/ui/switch";
import { useAuth } from "@/lib/auth/hooks";
import { 
  Bell, 
  Camera, 
  Save, 
  ArrowUpRight,
  MapPin,
  Briefcase,
  Calendar,
  Lock
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

export default function ProfilePage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [isLoading, setIsLoading] = useState(false);
  const { user } = useAuth();
  const [activeTab, setActiveTab] = useState("profile");

  const handleSave = async () => {
    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
    }, 1000);
  };

  if (!user) return null;

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("profile.profilepage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("profile.profilepage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("profile.profilepage.auto_ext_3")}
                                      </Button>
          </div>
        </motion.div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Profile Card */}
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex flex-col items-center text-center">
                  <div className="relative mb-4">
                    <Avatar className="w-24 h-24 rounded-2xl border-4 border-purple-500/30">
                      <AvatarImage src={user.imageUrl || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user.email}`} />
                      <AvatarFallback className="bg-purple-600/20 text-purple-400 font-bold text-2xl">
                        {user.name?.substring(0, 2).toUpperCase() || user.email.substring(0, 2).toUpperCase()}
                      </AvatarFallback>
                    </Avatar>
                    <Button
                      size="icon"
                      className="absolute -bottom-2 -right-2 rounded-full bg-purple-600 hover:bg-purple-700"
                    >
                      <Camera className="w-4 h-4" />
                    </Button>
                  </div>
                  <h2 className="text-xl font-bold text-white mb-1">{user.name || 'User'}</h2>
                  <p className="text-gray-400 text-sm mb-4">{user.email}</p>
                  <Badge variant="outline" className="bg-purple-500/20 text-purple-300 border-purple-500/30">
                    {user.role || 'USER'}
                  </Badge>
                </div>

                <div className="mt-6 pt-6 border-t border-purple-500/20 space-y-3">
                  <div className="flex items-center gap-3 text-sm text-gray-400">
                    <MapPin className="w-4 h-4" />
                    <span>{t("profile.profilepage.auto_ext_4")}</span>
                  </div>
                  <div className="flex items-center gap-3 text-sm text-gray-400">
                    <Briefcase className="w-4 h-4" />
                    <span>{t("profile.profilepage.auto_ext_5")}</span>
                  </div>
                  <div className="flex items-center gap-3 text-sm text-gray-400">
                    <Calendar className="w-4 h-4" />
                    <span>{t("profile.profilepage.auto_ext_6")} {new Date().toLocaleDateString()}</span>
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          {/* Settings Tabs */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.2 }}
            className="lg:col-span-2"
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <Tabs value={activeTab} onValueChange={setActiveTab}>
                <TabsList className="bg-white/5 border-purple-500/20 w-full justify-start">
                  <TabsTrigger value="profile" className="data-[state=active]:bg-purple-600">{t("profile.profilepage.auto_ext_7")}</TabsTrigger>
                  <TabsTrigger value="security" className="data-[state=active]:bg-purple-600">{t("profile.profilepage.auto_ext_8")}</TabsTrigger>
                  <TabsTrigger value="notifications" className="data-[state=active]:bg-purple-600">{t("profile.profilepage.auto_ext_9")}</TabsTrigger>
                </TabsList>

                <CardContent className="p-6">
                  <TabsContent value="profile">
                    <div className="space-y-6">
                      <div className="grid grid-cols-2 gap-4">
                        <div className="space-y-2">
                          <Label className="text-gray-400">{t("profile.profilepage.auto_ext_10")}</Label>
                          <Input
                            defaultValue={user.firstName || ''}
                            className="bg-white/10 border-purple-500/30 text-white"
                          />
                        </div>
                        <div className="space-y-2">
                          <Label className="text-gray-400">{t("profile.profilepage.auto_ext_11")}</Label>
                          <Input
                            defaultValue={user.lastName || ''}
                            className="bg-white/10 border-purple-500/30 text-white"
                          />
                        </div>
                      </div>

                      <div className="space-y-2">
                        <Label className="text-gray-400">{t("profile.profilepage.auto_ext_12")}</Label>
                        <Input
                          defaultValue={user.email}
                          className="bg-white/10 border-purple-500/30 text-white"
                        />
                      </div>

                      <div className="space-y-2">
                        <Label className="text-gray-400">{t("profile.profilepage.auto_ext_13")}</Label>
                        <Input
                          placeholder="+1 (555) 000-0000"
                          className="bg-white/10 border-purple-500/30 text-white"
                        />
                      </div>

                      <div className="space-y-2">
                        <Label className="text-gray-400">{t("profile.profilepage.auto_ext_14")}</Label>
                        <Textarea
                          placeholder="Tell us about yourself..."
                          className="bg-white/10 border-purple-500/30 text-white min-h-[100px]"
                        />
                      </div>

                      <Button
                        onClick={handleSave}
                        disabled={isLoading}
                        className="bg-purple-600 hover:bg-purple-700 w-full"
                      >
                        {isLoading ? (
                          <>
                            <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin mr-2" />
                            {t("profile.profilepage.auto_ext_15")}
                                                                                </>
                        ) : (
                          <>
                            <Save className="w-4 h-4 mr-2" />
                            {t("profile.profilepage.auto_ext_16")}
                                                                                    </>
                        )}
                      </Button>
                    </div>
                  </TabsContent>

                  <TabsContent value="security">
                    <div className="space-y-6">
                      <div className="space-y-2">
                        <Label className="text-gray-400">{t("profile.profilepage.auto_ext_17")}</Label>
                        <Input
                          type="password"
                          placeholder="Enter current password"
                          className="bg-white/10 border-purple-500/30 text-white"
                        />
                      </div>

                      <div className="space-y-2">
                        <Label className="text-gray-400">{t("profile.profilepage.auto_ext_18")}</Label>
                        <Input
                          type="password"
                          placeholder="Enter new password"
                          className="bg-white/10 border-purple-500/30 text-white"
                        />
                      </div>

                      <div className="space-y-2">
                        <Label className="text-gray-400">{t("profile.profilepage.auto_ext_19")}</Label>
                        <Input
                          type="password"
                          placeholder="Confirm new password"
                          className="bg-white/10 border-purple-500/30 text-white"
                        />
                      </div>

                      <div className="pt-4 border-t border-purple-500/20">
                        <h3 className="text-white font-medium mb-4">{t("profile.profilepage.auto_ext_20")}</h3>
                        <div className="flex items-center justify-between">
                          <div>
                            <div className="text-white">{t("profile.profilepage.auto_ext_21")}</div>
                            <div className="text-gray-400 text-sm">{t("profile.profilepage.auto_ext_22")}</div>
                          </div>
                          <Switch />
                        </div>
                      </div>

                      <Button
                        onClick={handleSave}
                        disabled={isLoading}
                        className="bg-purple-600 hover:bg-purple-700 w-full"
                      >
                        <Lock className="w-4 h-4 mr-2" />
                        {t("profile.profilepage.auto_ext_23")}
                                                                    </Button>
                    </div>
                  </TabsContent>

                  <TabsContent value="notifications">
                    <div className="space-y-6">
                      <div className="flex items-center justify-between">
                        <div>
                          <div className="text-white">{t("profile.profilepage.auto_ext_24")}</div>
                          <div className="text-gray-400 text-sm">{t("profile.profilepage.auto_ext_25")}</div>
                        </div>
                        <Switch defaultChecked />
                      </div>

                      <div className="flex items-center justify-between">
                        <div>
                          <div className="text-white">{t("profile.profilepage.auto_ext_26")}</div>
                          <div className="text-gray-400 text-sm">{t("profile.profilepage.auto_ext_27")}</div>
                        </div>
                        <Switch defaultChecked />
                      </div>

                      <div className="flex items-center justify-between">
                        <div>
                          <div className="text-white">{t("profile.profilepage.auto_ext_28")}</div>
                          <div className="text-gray-400 text-sm">{t("profile.profilepage.auto_ext_29")}</div>
                        </div>
                        <Switch defaultChecked />
                      </div>

                      <div className="flex items-center justify-between">
                        <div>
                          <div className="text-white">{t("profile.profilepage.auto_ext_30")}</div>
                          <div className="text-gray-400 text-sm">{t("profile.profilepage.auto_ext_31")}</div>
                        </div>
                        <Switch />
                      </div>

                      <div className="flex items-center justify-between">
                        <div>
                          <div className="text-white">{t("profile.profilepage.auto_ext_32")}</div>
                          <div className="text-gray-400 text-sm">{t("profile.profilepage.auto_ext_33")}</div>
                        </div>
                        <Switch />
                      </div>

                      <Button
                        onClick={handleSave}
                        disabled={isLoading}
                        className="bg-purple-600 hover:bg-purple-700 w-full"
                      >
                        <Bell className="w-4 h-4 mr-2" />
                        {t("profile.profilepage.auto_ext_34")}
                                                                    </Button>
                    </div>
                  </TabsContent>
                </CardContent>
              </Tabs>
            </Card>
          </motion.div>
        </div>
      </div>
    </div>
  );
}
