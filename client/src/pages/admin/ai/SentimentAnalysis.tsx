import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "@/pages/client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Search, Filter, TrendingUp, TrendingDown, MessageSquare, Star, ThumbsUp, ThumbsDown } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Progress } from "@/components/ui/progress";
// import { useToast } from "@/hooks/use-toast";

// Mock data
const sentimentData = [{
  id: "SENT001",
  sourceType: "review",
  sourceId: "REV001",
  sourceTitle: "Great apartment, excellent location!",
  content: "I've been living here for 6 months and absolutely love it. The location is perfect, amenities are great, and maintenance is responsive.",
  sentimentScore: 0.85,
  sentimentLabel: "positive",
  confidence: 0.92,
  property: "Sunset Apartments - Unit 2A",
  author: "John Smith",
  date: "2024-03-15",
  category: "tenant-feedback",
  keywords: ["location", "amenities", "maintenance"],
  priority: "low"
}, {
  id: "SENT002",
  sourceType: "ticket",
  sourceId: "TKT002",
  sourceTitle: "HVAC issues in winter",
  content: "The heating system has been problematic all winter. Multiple service calls but issues persist. Very frustrating during cold weather.",
  sentimentScore: 0.25,
  sentimentLabel: "negative",
  confidence: 0.88,
  property: "Oakwood Properties - Building A",
  author: "Emily Davis",
  date: "2024-03-14",
  category: "maintenance-complaint",
  keywords: ["heating", "winter", "service", "frustrating"],
  priority: "high"
}, {
  id: "SENT003",
  sourceType: "message",
  sourceId: "MSG003",
  sourceTitle: "Lease renewal inquiry",
  content: "Considering lease renewal. Overall good experience but concerned about rent increase. Would like to discuss options.",
  sentimentScore: 0.55,
  sentimentLabel: "neutral",
  confidence: 0.75,
  property: "Riverside Complex - Unit 1B",
  author: "Sarah Johnson",
  date: "2024-03-13",
  category: "lease-inquiry",
  keywords: ["renewal", "experience", "rent", "options"],
  priority: "medium"
}, {
  id: "SENT004",
  sourceType: "review",
  sourceId: "REV004",
  sourceTitle: "Outstanding property management",
  content: "The property management team is exceptional. Quick response times, professional service, and well-maintained facilities. Highly recommend!",
  sentimentScore: 0.92,
  sentimentLabel: "positive",
  confidence: 0.95,
  property: "Downtown Plaza - Commercial Unit",
  author: "ABC Corporation",
  date: "2024-03-12",
  category: "management-praise",
  keywords: ["exceptional", "professional", "response", "facilities"],
  priority: "low"
}, {
  id: "SENT005",
  sourceType: "ticket",
  sourceId: "TKT005",
  sourceTitle: "Parking space issues",
  content: "Assigned parking space is consistently occupied by unauthorized vehicles. Security doesn't enforce parking rules. Very inconvenient.",
  sentimentScore: 0.15,
  sentimentLabel: "negative",
  confidence: 0.90,
  property: "Metro Center - Penthouse",
  author: "Robert Wilson",
  date: "2024-03-11",
  category: "parking-complaint",
  keywords: ["parking", "security", "unauthorized", "inconvenient"],
  priority: "medium"
}, {
  id: "SENT006",
  sourceType: "message",
  sourceId: "MSG006",
  sourceTitle: "General inquiry",
  content: "Questions about utility billing and payment options. Staff was helpful and provided clear information.",
  sentimentScore: 0.70,
  sentimentLabel: "positive",
  confidence: 0.82,
  property: "Multiple Properties",
  author: "Lisa Anderson",
  date: "2024-03-10",
  category: "billing-inquiry",
  keywords: ["billing", "payment", "helpful", "information"],
  priority: "low"
}];
export default function AISentimentAnalysis() {
  const {
    t
  } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterSentiment, setFilterSentiment] = useState("all");
  const [filterSource, setFilterSource] = useState("all");
  const [filterCategory, setFilterCategory] = useState("all");
  const filteredSentiments = sentimentData.filter(sentiment => {
    const matchesSearch = sentiment.content.toLowerCase().includes(searchTerm.toLowerCase()) || sentiment.sourceTitle.toLowerCase().includes(searchTerm.toLowerCase()) || sentiment.author.toLowerCase().includes(searchTerm.toLowerCase()) || sentiment.property.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesSentiment = filterSentiment === "all" || sentiment.sentimentLabel.toLowerCase() === filterSentiment.toLowerCase();
    const matchesSource = filterSource === "all" || sentiment.sourceType.toLowerCase() === filterSource.toLowerCase();
    const matchesCategory = filterCategory === "all" || sentiment.category.toLowerCase().includes(filterCategory.toLowerCase());
    return matchesSearch && matchesSentiment && matchesSource && matchesCategory;
  });
  const totalSentiments = filteredSentiments.length;
  const positiveSentiments = filteredSentiments.filter(s => s.sentimentLabel === "positive").length;
  const negativeSentiments = filteredSentiments.filter(s => s.sentimentLabel === "negative").length;
  const neutralSentiments = filteredSentiments.filter(s => s.sentimentLabel === "neutral").length;
  const avgConfidence = filteredSentiments.reduce((sum, s) => sum + s.confidence, 0) / totalSentiments || 0;
  const getSentimentColor = (sentiment: string) => {
    switch (sentiment) {
      case "positive":
        return "default";
      case "negative":
        return "destructive";
      case "neutral":
        return "secondary";
      default:
        return "secondary";
    }
  };
  const getSentimentIcon = (sentiment: string) => {
    switch (sentiment) {
      case "positive":
        return <ThumbsUp className="h-4 w-4 text-green-500" />;
      case "negative":
        return <ThumbsDown className="h-4 w-4 text-red-500" />;
      case "neutral":
        return <MessageSquare className="h-4 w-4 text-gray-500" />;
      default:
        return <MessageSquare className="h-4 w-4 text-gray-500" />;
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "high":
        return "destructive";
      case "medium":
        return "secondary";
      case "low":
        return "outline";
      default:
        return "secondary";
    }
  };
  const getSourceIcon = (sourceType: string) => {
    switch (sourceType) {
      case "review":
        return <Star className="h-4 w-4" />;
      case "ticket":
        return <MessageSquare className="h-4 w-4" />;
      case "message":
        return <MessageSquare className="h-4 w-4" />;
      default:
        return <MessageSquare className="h-4 w-4" />;
    }
  };
  return <PageShell title={t("admin.ai.ai_sentiment_analysis")} description={t("admin.ai.aipowered_sentiment_analysis_of")}>
      <div className="space-y-6">
        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-5">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.total_analyzed")}</CardTitle>
              <MessageSquare className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalSentiments}</div>
              <p className="text-xs text-muted-foreground">{t("admin.ai.texts_analyzed")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.positive")}</CardTitle>
              <ThumbsUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">
                {positiveSentiments}
              </div>
              <p className="text-xs text-muted-foreground">
                {(positiveSentiments / totalSentiments * 100).toFixed(1)}{t("admin.ai.positive")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.negative")}</CardTitle>
              <ThumbsDown className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-red-600">
                {negativeSentiments}
              </div>
              <p className="text-xs text-muted-foreground">
                {(negativeSentiments / totalSentiments * 100).toFixed(1)}{t("admin.ai.negative")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.neutral")}</CardTitle>
              <MessageSquare className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-yellow-600">
                {neutralSentiments}
              </div>
              <p className="text-xs text-muted-foreground">
                {(neutralSentiments / totalSentiments * 100).toFixed(1)}{t("admin.ai.neutral")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.avg_confidence")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-blue-600">
                {(avgConfidence * 100).toFixed(1)}%
              </div>
              <p className="text-xs text-muted-foreground">{t("admin.ai.model_confidence")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters */}
        <div className="flex items-center space-x-2">
          <div className="relative">
            <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
            <Input placeholder={t("admin.ai.search_sentiments")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-[250px]" />
          </div>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="outline" size="sm">
                <Filter className="h-4 w-4 mr-2" />{t("admin.ai.sentiment")}{filterSentiment === "all" ? "All" : filterSentiment}
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent>
              <DropdownMenuItem onClick={() => setFilterSentiment("all")}>{t("admin.ai.all_sentiments")}</DropdownMenuItem>
              <DropdownMenuItem onClick={() => setFilterSentiment("positive")}>{t("admin.ai.positive")}</DropdownMenuItem>
              <DropdownMenuItem onClick={() => setFilterSentiment("negative")}>{t("admin.ai.negative")}</DropdownMenuItem>
              <DropdownMenuItem onClick={() => setFilterSentiment("neutral")}>{t("admin.ai.neutral")}</DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="outline" size="sm">{t("admin.ai.source")}{filterSource === "all" ? "All" : filterSource}
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent>
              <DropdownMenuItem onClick={() => setFilterSource("all")}>{t("admin.ai.all_sources")}</DropdownMenuItem>
              <DropdownMenuItem onClick={() => setFilterSource("review")}>{t("admin.ai.reviews")}</DropdownMenuItem>
              <DropdownMenuItem onClick={() => setFilterSource("ticket")}>{t("admin.ai.tickets")}</DropdownMenuItem>
              <DropdownMenuItem onClick={() => setFilterSource("message")}>{t("admin.ai.messages")}</DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="outline" size="sm">{t("admin.ai.category")}{filterCategory === "all" ? "All" : filterCategory}
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent>
              <DropdownMenuItem onClick={() => setFilterCategory("all")}>{t("admin.ai.all_categories")}</DropdownMenuItem>
              {Array.from(new Set(sentimentData.map(s => s.category))).map(category => <DropdownMenuItem key={category} onClick={() => setFilterCategory(category)}>
                  {category.replace("-", " ")}
                </DropdownMenuItem>)}
            </DropdownMenuContent>
          </DropdownMenu>
        </div>

        {/* Sentiment Analysis Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.ai.sentiment_analysis_results")}</CardTitle>
            <CardDescription>{t("admin.ai.aipowered_sentiment_analysis_of")}</CardDescription>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.ai.source")}</TableHead>
                  <TableHead>{t("admin.ai.title")}</TableHead>
                  <TableHead>{t("admin.ai.content")}</TableHead>
                  <TableHead>{t("admin.ai.sentiment")}</TableHead>
                  <TableHead>{t("admin.ai.confidence")}</TableHead>
                  <TableHead>{t("admin.ai.author")}</TableHead>
                  <TableHead>{t("admin.ai.property")}</TableHead>
                  <TableHead>{t("admin.ai.category")}</TableHead>
                  <TableHead>{t("admin.ai.priority")}</TableHead>
                  <TableHead className="w-[50px]"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredSentiments.map(sentiment => <TableRow key={sentiment.id}>
                    <TableCell>
                      <div className="flex items-center space-x-2">
                        {getSourceIcon(sentiment.sourceType)}
                        <Badge variant="outline" className="capitalize">
                          {sentiment.sourceType}
                        </Badge>
                      </div>
                    </TableCell>
                    <TableCell className="font-medium max-w-[200px] truncate">
                      {sentiment.sourceTitle}
                    </TableCell>
                    <TableCell className="max-w-[300px]">
                      <div className="text-sm truncate" title={sentiment.content}>
                        {sentiment.content}
                      </div>
                      {sentiment.keywords.length > 0 && <div className="flex flex-wrap gap-1 mt-1">
                          {sentiment.keywords.slice(0, 2).map(keyword => <span key={keyword} className="text-xs bg-gray-100 px-1 py-0.5 rounded">
                              {keyword}
                            </span>)}
                          {sentiment.keywords.length > 2 && <span className="text-xs text-muted-foreground">+{sentiment.keywords.length - 2}</span>}
                        </div>}
                    </TableCell>
                    <TableCell>
                      <div className="space-y-1">
                        <div className="flex items-center space-x-2">
                          {getSentimentIcon(sentiment.sentimentLabel)}
                          <Badge variant={getSentimentColor(sentiment.sentimentLabel)}>
                            {sentiment.sentimentLabel}
                          </Badge>
                        </div>
                        <Progress value={sentiment.sentimentScore * 100} className="w-[60px]" />
                        <div className="text-xs text-muted-foreground">
                          {(sentiment.sentimentScore * 100).toFixed(0)}%
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className={`font-medium ${sentiment.confidence >= 0.9 ? "text-green-600" : sentiment.confidence >= 0.8 ? "text-yellow-600" : "text-red-600"}`}>
                        {(sentiment.confidence * 100).toFixed(0)}%
                      </div>
                    </TableCell>
                    <TableCell>{sentiment.author}</TableCell>
                    <TableCell className="max-w-[150px] truncate">
                      {sentiment.property}
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline" className="capitalize">
                        {sentiment.category.replace("-", " ")}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge variant={getPriorityColor(sentiment.priority)}>
                        {sentiment.priority}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" size="sm">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent>
                          <DropdownMenuItem>{t("admin.ai.view_full_text")}</DropdownMenuItem>
                          <DropdownMenuItem>{t("admin.ai.view_analysis_details")}</DropdownMenuItem>
                          <DropdownMenuItem>{t("admin.ai.respond_to_source")}</DropdownMenuItem>
                          <DropdownMenuItem>{t("admin.ai.flag_for_review")}</DropdownMenuItem>
                          <DropdownMenuItem>{t("admin.ai.export_data")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* AI Insights */}
        <div className="grid gap-4 md:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin.ai.sentiment_trends")}</CardTitle>
              <CardDescription>{t("admin.ai.weekly_sentiment_analysis_trends")}</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span className="text-sm font-medium">{t("admin.ai.this_week")}</span>
                  <div className="flex items-center space-x-2">
                    <TrendingUp className="h-4 w-4 text-green-500" />
                    <span className="text-sm font-bold text-green-600">+12%</span>
                  </div>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm font-medium">{t("admin.ai.positive_trend")}</span>
                  <div className="flex items-center space-x-2">
                    <TrendingUp className="h-4 w-4 text-green-500" />
                    <span className="text-sm font-bold text-green-600">+8%</span>
                  </div>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm font-medium">{t("admin.ai.negative_trend")}</span>
                  <div className="flex items-center space-x-2">
                    <TrendingDown className="h-4 w-4 text-red-500" />
                    <span className="text-sm font-bold text-red-600">-15%</span>
                  </div>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm font-medium">{t("admin.ai.response_rate")}</span>
                  <span className="text-sm font-bold text-blue-600">87%</span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.ai.key_insights")}</CardTitle>
              <CardDescription>{t("admin.ai.aigenerated_insights_from_sentiment")}</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="p-3 bg-green-50 border border-green-200 rounded">
                  <div className="flex items-center space-x-2 mb-1">
                    <ThumbsUp className="h-4 w-4 text-green-600" />
                    <span className="text-sm font-medium text-green-800">{t("admin.ai.top_positive_driver")}</span>
                  </div>
                  <p className="text-sm text-green-700">{t("admin.ai.maintenance_responsiveness_mentioned_in")}</p>
                </div>
                <div className="p-3 bg-red-50 border border-red-200 rounded">
                  <div className="flex items-center space-x-2 mb-1">
                    <ThumbsDown className="h-4 w-4 text-red-600" />
                    <span className="text-sm font-medium text-red-800">{t("admin.ai.main_concern")}</span>
                  </div>
                  <p className="text-sm text-red-700">{t("admin.ai.hvac_and_heating_issues")}</p>
                </div>
                <div className="p-3 bg-blue-50 border border-blue-200 rounded">
                  <div className="flex items-center space-x-2 mb-1">
                    <MessageSquare className="h-4 w-4 text-blue-600" />
                    <span className="text-sm font-medium text-blue-800">{t("admin.ai.recommendation")}</span>
                  </div>
                  <p className="text-sm text-blue-700">{t("admin.ai.focus_on_hvac_maintenance")}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </PageShell>;
}