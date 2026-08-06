"use client";

import { useState } from 'react';
import { useAIStreamSearch } from '@/hooks/useAIStreamSearch';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Sparkles, Loader2, Search, X, MapPin, Home as HomeIcon } from 'lucide-react';
import { useTranslation } from "react-i18next";

export default function AISearchPage() {
    const { t } = useTranslation();
  const [query, setQuery] = useState('');
  const { isStreaming, events, error, streamSearch, abort, reset } = useAIStreamSearch();

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (query.trim()) {
      streamSearch(query);
    }
  };

  const handleClear = () => {
    reset();
    setQuery('');
  };

  const properties: Record<string, unknown>[] = (events.find(e => e.type === 'stage:properties')?.data.properties as Record<string, unknown>[]) || [];
  const analysis = events.find(e => e.type === 'stage:analysis')?.data;
  const intent = events.find(e => e.type === 'stage:intent')?.data;

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-20">
        <div className="max-w-4xl mx-auto">
          {/* Header */}
          <div className="text-center mb-12">
            <div className="flex items-center justify-center gap-3 mb-4">
              <Sparkles className="w-8 h-8 text-purple-400" />
              <h1 className="text-4xl font-bold text-white">{t("ai_search.aisearchpage.auto_ext_1")}</h1>
            </div>
            <p className="text-lg text-gray-300">
              {t("ai_search.aisearchpage.auto_ext_2")}
                                      </p>
          </div>

          {/* Search Form */}
          <Card className="mb-8 border-purple-500/20 bg-white/5 backdrop-blur-xl">
            <CardContent className="p-6">
              <form onSubmit={handleSearch} className="flex gap-3">
                <div className="flex-1 relative">
                  <Input
                    value={query}
                    onChange={(e) => setQuery(e.target.value)}
                    placeholder="e.g., 'Modern 3-bedroom apartment in downtown with balcony under $500k'"
                    className="bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400 pr-10"
                    disabled={isStreaming}
                  />
                  {query && (
                    <button
                      type="button"
                      onClick={handleClear}
                      aria-label="Clear search"
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-white"
                    >
                      <X className="w-4 h-4" />
                    </button>
                  )}
                </div>
                <Button
                  type="submit"
                  disabled={isStreaming || !query.trim()}
                  className="bg-purple-600 hover:bg-purple-700 text-white px-6"
                >
                  {isStreaming ? (
                    <>
                      <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                      {t("ai_search.aisearchpage.auto_ext_3")}
                                                              </>
                  ) : (
                    <>
                      <Search className="w-4 h-4 mr-2" />
                      {t("ai_search.aisearchpage.auto_ext_4")}
                                                                  </>
                  )}
                </Button>
                {isStreaming && (
                  <Button
                    type="button"
                    onClick={abort}
                    variant="outline"
                    className="border-red-500/30 text-red-400 hover:bg-red-500/10"
                  >
                    {t("ai_search.aisearchpage.auto_ext_5")}
                                                        </Button>
                )}
              </form>
            </CardContent>
          </Card>

          {/* Error */}
          {error && (
            <Card className="mb-6 border-red-500/30 bg-red-500/10">
              <CardContent className="p-4">
                <p className="text-red-400 text-sm">{error}</p>
              </CardContent>
            </Card>
          )}

          {/* Intent Analysis */}
          {intent && (
            <Card className="mb-6 border-blue-500/20 bg-blue-500/10">
              <CardHeader>
                <CardTitle className="text-white flex items-center gap-2">
                  <Sparkles className="w-5 h-5" />
                  {t("ai_search.aisearchpage.auto_ext_6")}
                                                  </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  <div>
                    <span className="text-sm text-gray-400">{t("ai_search.aisearchpage.auto_ext_7")}</span>
                    <Badge variant="outline" className="ml-2 border-blue-500/30 text-blue-300">
                      {intent.routeUsed}
                    </Badge>
                  </div>
                  {intent.filters && Object.keys(intent.filters).length > 0 && (
                    <div>
                      <span className="text-sm text-gray-400 block mb-2">{t("ai_search.aisearchpage.auto_ext_8")}</span>
                      <div className="flex flex-wrap gap-2">
                        {Object.entries(intent.filters).map(([key, value]) => (
                          <Badge key={key} variant="secondary" className="bg-blue-500/20 text-blue-300">
                            {key}: {String(value)}
                          </Badge>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              </CardContent>
            </Card>
          )}

          {/* Properties */}
          {properties.length > 0 && (
            <div className="space-y-4 mb-6">
              <h2 className="text-2xl font-bold text-white mb-4">
                {t("ai_search.aisearchpage.auto_ext_9")} {properties.length} {t("ai_search.aisearchpage.auto_ext_10")}
                                            </h2>
              {properties.map((property: Record<string, unknown>, index: number) => (
                <Card key={index} className="border-purple-500/20 bg-white/5 backdrop-blur-xl hover:bg-white/10 transition-colors">
                  <CardContent className="p-6">
                    <div className="flex justify-between items-start mb-4">
                      <div>
                        <h3 className="text-xl font-bold text-white mb-2">{(property.name as string) || 'Property'}</h3>
                        <div className="flex items-center gap-2 text-gray-300">
                          <MapPin className="w-4 h-4" />
                          <span>{(property.address as string) || 'Location not specified'}</span>
                        </div>
                      </div>
                      {!!property.price && (
                        <div className="text-right">
                          <div className="text-2xl font-bold text-blue-400">
                            ${Number(property.price as string).toLocaleString()}
                          </div>
                        </div>
                      )}
                    </div>
                    <div className="flex gap-4 text-sm text-gray-400">
                      {!!property.beds && (
                        <div className="flex items-center gap-1">
                          <HomeIcon className="w-4 h-4" />
                          <span>{(property.beds as number)} {t("ai_search.aisearchpage.auto_ext_11")}</span>
                        </div>
                      )}
                      {!!property.baths && (
                        <div className="flex items-center gap-1">
                          <span>{(property.baths as number)} {t("ai_search.aisearchpage.auto_ext_12")}</span>
                        </div>
                      )}
                      {!!property.sqm && (
                        <div className="flex items-center gap-1">
                          <span>{(property.sqm as number)} {t("ai_search.aisearchpage.auto_ext_13")}</span>
                        </div>
                      )}
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}

          {/* AI Analysis Text */}
          {analysis && (
            <Card className="border-purple-500/20 bg-purple-500/10">
              <CardHeader>
                <CardTitle className="text-white">{t("ai_search.aisearchpage.auto_ext_14")}</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-gray-300 leading-relaxed">{analysis.text}</p>
                {analysis.marketContext && (
                  <div className="mt-4 pt-4 border-t border-purple-500/20">
                    <span className="text-sm text-gray-400">{t("ai_search.aisearchpage.auto_ext_15")}</span>
                    <p className="text-gray-300 mt-2 text-sm">{JSON.stringify(analysis.marketContext, null, 2)}</p>
                  </div>
                )}
              </CardContent>
            </Card>
          )}

          {/* Loading State */}
          {isStreaming && events.length === 0 && (
            <Card className="border-purple-500/20 bg-white/5 backdrop-blur-xl">
              <CardContent className="p-12 text-center">
                <Loader2 className="w-12 h-12 animate-spin text-purple-400 mx-auto mb-4" />
                <p className="text-gray-300">{t("ai_search.aisearchpage.auto_ext_16")}</p>
              </CardContent>
            </Card>
          )}
        </div>
      </div>
    </div>
  );
}
