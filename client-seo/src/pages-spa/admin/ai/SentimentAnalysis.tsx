"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { MoreHorizontal, Search, Filter, TrendingUp, TrendingDown, MessageSquare, Star, ThumbsUp, ThumbsDown, Activity } from"lucide-react";
import { Input } from"@/components/ui/input";
import { Progress } from"@/components/ui/progress";
import { apiClient } from"@/lib/api/client";
import { useQuery } from"@tanstack/react-query";

// Fallback mock data
const fallbackSentimentData = [{
 id:"SENT001",
 sourceType:"review",
 sourceId:"REV001",
 sourceTitle:"Great apartment, excellent location!",
 content:"I've been living here for 6 months and absolutely love it. The location is perfect, amenities are great, and maintenance is responsive.",
 sentimentScore: 0.85,
 sentimentLabel:"positive",
 confidence: 0.92,
 property:"Sunset Apartments - Unit 2A",
 author:"John Smith",
 date:"2024-03-15",
 category:"tenant-feedback",
 keywords: ["location","amenities","maintenance"],
 priority:"low"
}, {
 id:"SENT002",
 sourceType:"ticket",
 sourceId:"TKT002",
 sourceTitle:"HVAC issues in winter",
 content:"The heating system has been problematic all winter. Multiple service calls but issues persist. Very frustrating during cold weather.",
 sentimentScore: 0.25,
 sentimentLabel:"negative",
 confidence: 0.88,
 property:"Oakwood Properties - Building A",
 author:"Emily Davis",
 date:"2024-03-14",
 category:"maintenance-complaint",
 keywords: ["heating","winter","service","frustrating"],
 priority:"high"
}, {
 id:"SENT003",
 sourceType:"message",
 sourceId:"MSG003",
 sourceTitle:"Lease renewal inquiry",
 content:"Considering lease renewal. Overall good experience but concerned about rent increase. Would like to discuss options.",
 sentimentScore: 0.55,
 sentimentLabel:"neutral",
 confidence: 0.75,
 property:"Riverside Complex - Unit 1B",
 author:"Sarah Johnson",
 date:"2024-03-13",
 category:"lease-inquiry",
 keywords: ["renewal","experience","rent","options"],
 priority:"medium"
}, {
 id:"SENT004",
 sourceType:"review",
 sourceId:"REV004",
 sourceTitle:"Outstanding property management",
 content:"The property management team is exceptional. Quick response times, professional service, and well-maintained facilities. Highly recommend!",
 sentimentScore: 0.92,
 sentimentLabel:"positive",
 confidence: 0.95,
 property:"Downtown Plaza - Commercial Unit",
 author:"ABC Corporation",
 date:"2024-03-12",
 category:"management-praise",
 keywords: ["exceptional","professional","response","facilities"],
 priority:"low"
}, {
 id:"SENT005",
 sourceType:"ticket",
 sourceId:"TKT005",
 sourceTitle:"Parking space issues",
 content:"Assigned parking space is consistently occupied by unauthorized vehicles. Security doesn't enforce parking rules. Very inconvenient.",
 sentimentScore: 0.15,
 sentimentLabel:"negative",
 confidence: 0.90,
 property:"Metro Center - Penthouse",
 author:"Robert Wilson",
 date:"2024-03-11",
 category:"parking-complaint",
 keywords: ["parking","security","unauthorized","inconvenient"],
 priority:"medium"
}, {
 id:"SENT006",
 sourceType:"message",
 sourceId:"MSG006",
 sourceTitle:"General inquiry",
 content:"Questions about utility billing and payment options. Staff was helpful and provided clear information.",
 sentimentScore: 0.70,
 sentimentLabel:"positive",
 confidence: 0.82,
 property:"Multiple Properties",
 author:"Lisa Anderson",
 date:"2024-03-10",
 category:"billing-inquiry",
 keywords: ["billing","payment","helpful","information"],
 priority:"low"
}];

interface SentimentItem {
 id: string;
 sourceType: string;
 sourceId: string;
 sourceTitle: string;
 content: string;
 sentimentScore: number;
 sentimentLabel: string;
 confidence: number;
 property: string;
 author: string;
 date: string;
 category: string;
 keywords: string[];
 priority: string;
}

export default function AISentimentAnalysis() {
 const { t } = useTranslation();
 const [searchTerm, setSearchTerm] = useState("");
 const [filterSentiment, setFilterSentiment] = useState("all");
 const [filterSource, setFilterSource] = useState("all");
 const [filterCategory, setFilterCategory] = useState("all");

 const { data: sentimentData = fallbackSentimentData } = useQuery({
 queryKey: ['sentiment-analysis'],
 queryFn: async () => {
 const res = await apiClient.get('/ai-sentiment-analyses');
 const data = (res as any)?.data;
 return data && data.length > 0 ? data : fallbackSentimentData;
 },
 });

 const filteredSentiments = (sentimentData as SentimentItem[]).filter(sentiment => {
 const matchesSearch = sentiment.content.toLowerCase().includes(searchTerm.toLowerCase()) || sentiment.sourceTitle.toLowerCase().includes(searchTerm.toLowerCase()) || sentiment.author.toLowerCase().includes(searchTerm.toLowerCase()) || sentiment.property.toLowerCase().includes(searchTerm.toLowerCase());
 const matchesSentiment = filterSentiment ==="all" || sentiment.sentimentLabel.toLowerCase() === filterSentiment.toLowerCase();
 const matchesSource = filterSource ==="all" || sentiment.sourceType.toLowerCase() === filterSource.toLowerCase();
 const matchesCategory = filterCategory ==="all" || sentiment.category.toLowerCase().includes(filterCategory.toLowerCase());
 return matchesSearch && matchesSentiment && matchesSource && matchesCategory;
 });
 const totalSentiments = filteredSentiments.length;
 const positiveSentiments = filteredSentiments.filter(s => s.sentimentLabel ==="positive").length;
 const negativeSentiments = filteredSentiments.filter(s => s.sentimentLabel ==="negative").length;
 const neutralSentiments = filteredSentiments.filter(s => s.sentimentLabel ==="neutral").length;
 const avgConfidence = filteredSentiments.reduce((sum, s) => sum + s.confidence, 0) / totalSentiments || 0;
 const getSentimentColor = (sentiment: string) => {
 switch (sentiment) {
 case"positive":
 return"default";
 case"negative":
 return"destructive";
 case"neutral":
 return"secondary";
 default:
 return"secondary";
 }
 };
 const getSentimentIcon = (sentiment: string) => {
 switch (sentiment) {
 case"positive":
 return <ThumbsUp className="h-4 w-4 text-green-500" />;
 case"negative":
 return <ThumbsDown className="h-4 w-4 text-red-500" />;
 case"neutral":
 return <MessageSquare className="h-4 w-4 text-muted-foreground" />;
 default:
 return <MessageSquare className="h-4 w-4 text-muted-foreground" />;
 }
 };
 const getPriorityColor = (priority: string) => {
 switch (priority) {
 case"high":
 return"destructive";
 case"medium":
 return"secondary";
 case"low":
 return"outline";
 default:
 return"secondary";
 }
 };
 const getSourceIcon = (sourceType: string) => {
 switch (sourceType) {
 case"review":
 return <Star className="h-4 w-4" />;
 case"ticket":
 return <MessageSquare className="h-4 w-4" />;
 case"message":
 return <MessageSquare className="h-4 w-4" />;
 default:
 return <MessageSquare className="h-4 w-4" />;
 }
 };
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen p-4 md:p-8 space-y-6">
 <div className="space-y-6">
 {/* Header */}
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-3xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_ai_ai_sentiment_analysis")}</h1>
 <p className="text-muted-foreground mt-1">{t("admin_ai_aipowered_sentiment_analysis_of")}</p>
 </div>

 {/* Summary Cards */}
 <div className="grid gap-4 md:grid-cols-5">
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_total_analyzed")}</CardTitle>
 <MessageSquare className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{totalSentiments}</div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_texts_analyzed")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_positive")}</CardTitle>
 <ThumbsUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-green-600">
 {positiveSentiments}
 </div>
 <p className="text-xs text-muted-foreground">
 {(positiveSentiments / totalSentiments * 100).toFixed(1)}%
 </p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_negative")}</CardTitle>
 <ThumbsDown className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-red-600">
 {negativeSentiments}
 </div>
 <p className="text-xs text-muted-foreground">
 {(negativeSentiments / totalSentiments * 100).toFixed(1)}%
 </p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_neutral")}</CardTitle>
 <MessageSquare className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-yellow-600">
 {neutralSentiments}
 </div>
 <p className="text-xs text-muted-foreground">
 {(neutralSentiments / totalSentiments * 100).toFixed(1)}%
 </p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_avg_confidence")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">
 {(avgConfidence * 100).toFixed(1)}%
 </div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_model_confidence")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Filters */}
 <div className="flex items-center space-x-2">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_ai_search_sentiments")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-[250px] bg-card border-border text-foreground" />
 </div>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="outline" size="sm" className="border-border text-muted-foreground">
 <Filter className="h-4 w-4 mr-2" />{t("admin_ai_sentiment")}{filterSentiment ==="all" ?"All" : filterSentiment}
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent className="bg-card border-border text-foreground">
 <DropdownMenuItem onClick={() => setFilterSentiment("all")}>{t("admin_ai_all_sentiments")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => setFilterSentiment("positive")}>{t("admin_ai_positive")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => setFilterSentiment("negative")}>{t("admin_ai_negative")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => setFilterSentiment("neutral")}>{t("admin_ai_neutral")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="outline" size="sm" className="border-border text-muted-foreground">{t("admin_ai_source")}{filterSource ==="all" ?"All" : filterSource}
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent className="bg-card border-border text-foreground">
 <DropdownMenuItem onClick={() => setFilterSource("all")}>{t("admin_ai_all_sources")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => setFilterSource("review")}>{t("admin_ai_reviews")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => setFilterSource("ticket")}>{t("admin_ai_tickets")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => setFilterSource("message")}>{t("admin_ai_messages")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="outline" size="sm" className="border-border text-muted-foreground">{t("admin_ai_category")}{filterCategory ==="all" ?"All" : filterCategory}
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent className="bg-card border-border text-foreground">
 <DropdownMenuItem onClick={() => setFilterCategory("all")}>{t("admin_ai_all_categories")}</DropdownMenuItem>
 {Array.from(new Set(fallbackSentimentData.map(s => s.category))).map(category => <DropdownMenuItem key={category} onClick={() => setFilterCategory(category)}>
 {category.replace("-","")}
 </DropdownMenuItem>)}
 </DropdownMenuContent>
 </DropdownMenu>
 </div>

 {/* Sentiment Analysis Table */}
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_ai_sentiment_analysis_results")}</CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_ai_aipowered_sentiment_analysis_of")}</CardDescription>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_ai_source")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_title")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_content")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_sentiment")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_confidence")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_author")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_property")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_category")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_priority")}</TableHead>
 <TableHead className="w-[50px]"></TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredSentiments.map(sentiment => <TableRow key={sentiment.id} className="border-border">
 <TableCell>
 <div className="flex items-center space-x-2">
 <span className="text-foreground">{getSourceIcon(sentiment.sourceType)}</span>
 <Badge variant="outline" className="capitalize text-muted-foreground">
 {sentiment.sourceType}
 </Badge>
 </div>
 </TableCell>
 <TableCell className="font-medium max-w-[200px] truncate text-foreground">
 {sentiment.sourceTitle}
 </TableCell>
 <TableCell className="max-w-[300px]">
 <div className="text-sm truncate text-muted-foreground" title={sentiment.content}>
 {sentiment.content}
 </div>
 {sentiment.keywords.length > 0 && <div className="flex flex-wrap gap-1 mt-1">
 {sentiment.keywords.slice(0, 2).map(keyword => <span key={keyword} className="text-xs bg-card text-muted-foreground px-1 py-0.5 rounded-lg">
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
 <div className={`font-medium ${sentiment.confidence >= 0.9 ?"text-green-600" : sentiment.confidence >= 0.8 ?"text-yellow-600" :"text-red-600"}`}>
 {(sentiment.confidence * 100).toFixed(0)}%
 </div>
 </TableCell>
 <TableCell className="text-foreground">{sentiment.author}</TableCell>
 <TableCell className="max-w-[150px] truncate text-muted-foreground">
 {sentiment.property}
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="capitalize text-muted-foreground">
 {sentiment.category.replace("-","")}
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
 <Button variant="ghost" size="sm" className="text-muted-foreground">
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent className="bg-card border-border text-foreground">
 <DropdownMenuItem>{t("admin_ai_view_full_text")}</DropdownMenuItem>
 <DropdownMenuItem>{t("admin_ai_view_analysis_details")}</DropdownMenuItem>
 <DropdownMenuItem>{t("admin_ai_respond_to_source")}</DropdownMenuItem>
 <DropdownMenuItem>{t("admin_ai_flag_for_review")}</DropdownMenuItem>
 <DropdownMenuItem>{t("admin_ai_export_data")}</DropdownMenuItem>
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
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_ai_sentiment_trends")}</CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_ai_weekly_sentiment_analysis_trends")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="flex justify-between items-center">
 <span className="text-sm font-medium text-foreground">{t("admin_ai_this_week")}</span>
 <div className="flex items-center space-x-2">
 <TrendingUp className="h-4 w-4 text-green-500" />
 <span className="text-sm font-bold text-green-600">+12%</span>
 </div>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm font-medium text-foreground">{t("admin_ai_positive_trend")}</span>
 <div className="flex items-center space-x-2">
 <TrendingUp className="h-4 w-4 text-green-500" />
 <span className="text-sm font-bold text-green-600">+8%</span>
 </div>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm font-medium text-foreground">{t("admin_ai_negative_trend")}</span>
 <div className="flex items-center space-x-2">
 <TrendingDown className="h-4 w-4 text-red-500" />
 <span className="text-sm font-bold text-red-600">-15%</span>
 </div>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm font-medium text-foreground">{t("admin_ai_response_rate")}</span>
 <span className="text-sm font-bold text-slate-600">87%</span>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_ai_key_insights")}</CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_ai_aigenerated_insights_from_sentiment")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="p-3 bg-green-500/10 border border-green-500/20 rounded-lg">
 <div className="flex items-center space-x-2 mb-1">
 <ThumbsUp className="h-4 w-4 text-green-600" />
 <span className="text-sm font-medium text-green-400">{t("admin_ai_top_positive_driver")}</span>
 </div>
 <p className="text-sm text-green-300">{t("admin_ai_maintenance_responsiveness_mentioned_in")}</p>
 </div>
 <div className="p-3 bg-red-500/10 border border-red-500/20 rounded-lg">
 <div className="flex items-center space-x-2 mb-1">
 <ThumbsDown className="h-4 w-4 text-red-600" />
 <span className="text-sm font-medium text-red-400">{t("admin_ai_main_concern")}</span>
 </div>
 <p className="text-sm text-red-300">{t("admin_ai_hvac_and_heating_issues")}</p>
 </div>
 <div className="p-3 bg-muted0/10 border border-slate-500/20 rounded-lg">
 <div className="flex items-center space-x-2 mb-1">
 <MessageSquare className="h-4 w-4 text-slate-600" />
 <span className="text-sm font-medium text-muted-foreground">{t("admin_ai_recommendation")}</span>
 </div>
 <p className="text-sm text-slate-300">{t("admin_ai_focus_on_hvac_maintenance")}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 </div>;
}
