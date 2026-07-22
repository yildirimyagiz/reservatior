"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  FileText, 
  Folder, 
  Eye, 
  Download, 
  Search, 
  RefreshCw, 
  Trash2, 
  Share, 
  FileCode, 
  FileVideo,
  ArrowUpRight,
  Upload
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

interface FileEntry {
  id: string;
  name: string;
  type: 'file' | 'folder';
  size: string;
  extension: string;
  modifiedAt: string;
  access: 'public' | 'private' | 'shared';
}

const mockFiles: FileEntry[] = [
  { id: "1", name: "Property Contracts", type: "folder", size: "12 items", extension: "", modifiedAt: "2024-01-15", access: "private" },
  { id: "2", name: "Lease Agreement.pdf", type: "file", size: "2.4 MB", extension: "pdf", modifiedAt: "2024-01-14", access: "private" },
  { id: "3", name: "Property Photos", type: "folder", size: "45 items", extension: "", modifiedAt: "2024-01-13", access: "shared" },
  { id: "4", name: "Villa Tour.mp4", type: "file", size: "156 MB", extension: "mp4", modifiedAt: "2024-01-12", access: "public" },
  { id: "5", name: "Financial Reports", type: "folder", size: "8 items", extension: "", modifiedAt: "2024-01-11", access: "private" },
  { id: "6", name: "Q4 2023 Report.xlsx", type: "file", size: "1.2 MB", extension: "xlsx", modifiedAt: "2024-01-10", access: "private" },
  { id: "7", name: "Property Blueprint.dwg", type: "file", size: "8.5 MB", extension: "dwg", modifiedAt: "2024-01-09", access: "shared" },
  { id: "8", name: "Legal Documents", type: "folder", size: "23 items", extension: "", modifiedAt: "2024-01-08", access: "private" }
];

const FILE_ICONS: Record<string, React.ComponentType<{ className?: string }>> = {
  pdf: FileText,
  xlsx: FileCode,
  mp4: FileVideo,
  dwg: FileCode,
  default: FileText
};

const ACCESS_COLORS: Record<string, string> = {
  public: "bg-green-500/20 text-green-400",
  private: "bg-red-500/20 text-red-400",
  shared: "bg-blue-500/20 text-blue-400"
};

export default function FilesPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [viewMode, setViewMode] = useState<'list' | 'grid'>('list');

  const filteredFiles = mockFiles.filter(file => 
    file.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("files.filespage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("files.filespage.auto_ext_2")}</p>
            </div>
            <div className="flex gap-3">
              <Button
                onClick={() => router.push('/dashboard')}
                className="bg-purple-600 hover:bg-purple-700"
              >
                <ArrowUpRight className="w-4 h-4 mr-2" />
                {t("files.filespage.auto_ext_3")}
                                            </Button>
              <Button className="bg-blue-600 hover:bg-blue-700">
                <Upload className="w-4 h-4 mr-2" />
                {t("files.filespage.auto_ext_4")}
                                            </Button>
            </div>
          </div>
        </m.div>

        {/* Toolbar */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search files..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <RefreshCw className="w-4 h-4 mr-2" />
                  {t("files.filespage.auto_ext_5")}
                                                  </Button>
                <Button
                  variant="outline"
                  className="bg-white/10 border-purple-500/30 text-white"
                  onClick={() => setViewMode(viewMode === 'list' ? 'grid' : 'list')}
                >
                  {viewMode === 'list' ? <FileText className="w-4 h-4" /> : <Folder className="w-4 h-4" />}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Files */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          {viewMode === 'list' ? (
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-0">
                <div className="divide-y divide-purple-500/20">
                  {filteredFiles.map((file) => {
                      const { t } = useTranslation();
                    const Icon = file.type === 'folder' ? Folder : (FILE_ICONS[file.extension] || FILE_ICONS.default);
                    return (
                      <div
                        key={file.id}
                        className="flex items-center gap-4 p-4 hover:bg-white/5 transition-colors group"
                      >
                        <div className="p-2 rounded-lg bg-purple-500/20">
                          <Icon className="w-5 h-5 text-purple-400" />
                        </div>
                        <div className="flex-1">
                          <div className="text-white font-medium">{file.name}</div>
                          <div className="text-gray-400 text-sm">{file.size} {t("files.filespage.auto_ext_6")} {file.modifiedAt}</div>
                        </div>
                        <Badge className={ACCESS_COLORS[file.access]}>{file.access}</Badge>
                        <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                          <Button variant="ghost" size="icon" className="h-8 w-8">
                            <Eye className="w-4 h-4" />
                          </Button>
                          <Button variant="ghost" size="icon" className="h-8 w-8">
                            <Download className="w-4 h-4" />
                          </Button>
                          <Button variant="ghost" size="icon" className="h-8 w-8">
                            <Share className="w-4 h-4" />
                          </Button>
                          <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400">
                            <Trash2 className="w-4 h-4" />
                          </Button>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
          ) : (
            <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
              {filteredFiles.map((file) => {
                  const { t } = useTranslation();
                const Icon = file.type === 'folder' ? Folder : (FILE_ICONS[file.extension] || FILE_ICONS.default);
                return (
                  <Card
                    key={file.id}
                    className="bg-white/5 backdrop-blur-xl border-purple-500/20 hover:bg-white/10 transition-colors cursor-pointer"
                  >
                    <CardContent className="p-4 text-center">
                      <div className="p-4 rounded-xl bg-purple-500/20 mx-auto mb-3 w-fit">
                        <Icon className="w-8 h-8 text-purple-400" />
                      </div>
                      <div className="text-white text-sm font-medium truncate">{file.name}</div>
                      <div className="text-gray-400 text-xs mt-1">{file.size}</div>
                      <Badge className={ACCESS_COLORS[file.access] + " mt-2"}>{file.access}</Badge>
                    </CardContent>
                  </Card>
                );
              })}
            </div>
          )}
        </m.div>
      </div>
    </div>
  );
}
