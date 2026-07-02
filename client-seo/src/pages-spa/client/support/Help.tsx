import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Search, BookOpen, MessageCircle, Video, FileText, Phone, Mail, CreditCard } from "lucide-react";
export default function Help() {
  const {
    t
  } = useTranslation();
  const [searchQuery, setSearchQuery] = useState("");
  const [supportTicket, setSupportTicket] = useState({
    subject: "",
    category: "",
    message: ""
  });
  const faqCategories = [{
    name: "General",
    icon: BookOpen,
    questions: [{
      q: "How can I create an account?",
      a: "You can easily create an account by clicking the 'Sign Up' button on the home page."
    }, {
      q: "I forgot my password, what should I do?",
      a: "You can reset your password using the 'Forgot Password' link on the login page."
    }]
  }, {
    name: "Payments",
    icon: CreditCard,
    questions: [{
      q: "What are the payment methods?",
      a: "You can pay with credit card, bank transfer, and digital wallets."
    }, {
      q: "How can I see my invoice?",
      a: "You can view your billing history on the Payments page."
    }]
  }, {
    name: "Technical",
    icon: FileText,
    questions: [{
      q: "What is the API limit?",
      a: "The API limit varies by plan; for the Professional plan, it is 1000 requests/minute."
    }, {
      q: "Is my data safe?",
      a: "Yes, all your data is protected with SSL encryption."
    }]
  }];
  const supportCategories = ["Technical Support", "Payment Issues", "Account Settings", "Suggestions and Complaints", "Other"];
  const quickActions = [{
    title: t("client.src.live_chat"),
    description: t("client.src.get_instant_help"),
    icon: MessageCircle,
    action: "chat",
    available: true
  }, {
    title: t("client.src.video_tutorials"),
    description: t("client.src.stepbystep_guides"),
    icon: Video,
    action: "videos",
    available: true
  }, {
    title: t("client.src.phone_support"),
    description: t("client.src.mondayfriday_9001800"),
    icon: Phone,
    action: "phone",
    available: false
  }, {
    title: t("client.src.email_support"),
    description: t("client.src.response_within_24_hours"),
    icon: Mail,
    action: "email",
    available: true
  }];
  const handleSupportSubmit = () => {
    console.log("Support ticket submitted:", supportTicket);
    // Handle support ticket submission
  };
  return <div className="min-h-screen bg-background">
      <div className="container mx-auto p-6">
        <div className="mb-6">
          <h1 className="text-3xl font-bold">{t("client.src.help_center")}</h1>
          <p className="text-muted-foreground">{t("client.src.how_can_we_help")}</p>
        </div>

        {/* Search */}
        <div className="mb-8">
          <div className="relative max-w-md">
            <Search className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
            <Input placeholder={t("client.src.search_for_help")} value={searchQuery} onChange={e => setSearchQuery(e.target.value)} className="pl-10" />
          </div>
        </div>

        {/* Quick Actions */}
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4 mb-8">
          {quickActions.map(action => <Card key={action.title} className={`cursor-pointer transition-colors ${!action.available ? "opacity-50" : "hover:bg-accent"}`}>
              <CardContent className="p-4">
                <div className="flex items-center gap-3">
                  <action.icon className="w-8 h-8 text-primary" />
                  <div>
                    <h3 className="font-medium">{action.title}</h3>
                    <p className="text-sm text-muted-foreground">{action.description}</p>
                  </div>
                </div>
                {!action.available && <Badge variant="secondary" className="mt-2">{t("client.src.coming_soon")}</Badge>}
              </CardContent>
            </Card>)}
        </div>

        <Tabs defaultValue="faq" className="w-full">
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="faq">{t("client.src.frequently_asked_questions")}</TabsTrigger>
            <TabsTrigger value="support">{t("client.src.support_request")}</TabsTrigger>
            <TabsTrigger value="guides">{t("client.src.user_guides")}</TabsTrigger>
          </TabsList>

          <TabsContent value="faq" className="space-y-6">
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
              {faqCategories.map(category => <Card key={category.name}>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <category.icon className="w-5 h-5" />
                      {category.name}
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-4">
                      {category.questions.map((item, index) => <div key={index} className="border-b last:border-b-0 pb-3 last:pb-0">
                          <p className="font-medium text-sm mb-2">{item.q}</p>
                          <p className="text-sm text-muted-foreground">{item.a}</p>
                        </div>)}
                    </div>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>

          <TabsContent value="support" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.create_support_request")}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="subject">{t("client.src.subject")}</Label>
                  <Input id="subject" placeholder={t("client.src.briefly_describe_your_issue")} value={supportTicket.subject} onChange={e => setSupportTicket({
                  ...supportTicket,
                  subject: e.target.value
                })} />
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="category">{t("client.src.category")}</Label>
                  <select id="category" className="w-full p-2 border rounded-md" value={supportTicket.category} onChange={e => setSupportTicket({
                  ...supportTicket,
                  category: e.target.value
                })}>
                    <option value="">{t("client.src.select_category")}</option>
                    {supportCategories.map(cat => <option key={cat} value={cat}>{cat}</option>)}
                  </select>
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="message">{t("client.src.message")}</Label>
                  <Textarea id="message" placeholder={t("client.src.describe_the_details_of")} rows={6} value={supportTicket.message} onChange={e => setSupportTicket({
                  ...supportTicket,
                  message: e.target.value
                })} />
                </div>
                
                <Button onClick={handleSupportSubmit} className="w-full">{t("client.src.send_support_request")}</Button>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.previous_requests")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <div className="text-center text-muted-foreground py-8">
                    <p>{t("client.src.no_support_requests_yet")}</p>
                    <p className="text-sm">{t("client.src.use_the_form_above")}</p>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="guides" className="space-y-6">
            <div className="grid gap-6 md:grid-cols-2">
              <Card>
                <CardHeader>
                  <CardTitle>{t("client.src.quick_start")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 bg-primary text-primary-foreground rounded-full flex items-center justify-center text-sm font-medium">
                        1
                      </div>
                      <div>
                        <p className="font-medium">{t("client.src.account_creation")}</p>
                        <p className="text-sm text-muted-foreground">{t("client.src.sign_up_and_complete")}</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 bg-primary text-primary-foreground rounded-full flex items-center justify-center text-sm font-medium">
                        2
                      </div>
                      <div>
                        <p className="font-medium">{t("client.src.first_project")}</p>
                        <p className="text-sm text-muted-foreground">{t("client.src.create_your_first_project")}</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 bg-primary text-primary-foreground rounded-full flex items-center justify-center text-sm font-medium">
                        3
                      </div>
                      <div>
                        <p className="font-medium">{t("client.src.team_invitation")}</p>
                        <p className="text-sm text-muted-foreground">{t("client.src.invite_your_team")}</p>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>{t("client.src.video_tutorials")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    <div className="p-3 border rounded-lg">
                      <h4 className="font-medium">{t("client.src.platform_introduction")}</h4>
                      <p className="text-sm text-muted-foreground mb-2">{t("client.src.learn_the_basic_features")}</p>
                      <Button variant="outline" size="sm">{t("client.src.watch")}</Button>
                    </div>
                    <div className="p-3 border rounded-lg">
                      <h4 className="font-medium">{t("client.src.project_management")}</h4>
                      <p className="text-sm text-muted-foreground mb-2">{t("client.src.effective_project_management_techniques")}</p>
                      <Button variant="outline" size="sm">{t("client.src.watch")}</Button>
                    </div>
                    <div className="p-3 border rounded-lg">
                      <h4 className="font-medium">{t("client.src.reporting")}</h4>
                      <p className="text-sm text-muted-foreground mb-2">{t("client.src.create_detailed_reports")}</p>
                      <Button variant="outline" size="sm">{t("client.src.watch")}</Button>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>;
}