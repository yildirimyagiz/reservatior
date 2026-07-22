"use client";

import { t } from "i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { FileText, Folder, Eye, Download, Search, Filter, RefreshCw, Trash2, Edit, Share, Users, FileCode, FileImage, FileVideo, FileAudio, Archive } from "lucide-react";
import { useTranslation } from "react-i18next";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";
interface FileEntry {
  id: string;
  name: string;
  type: 'file' | 'folder';
  size?: number;
  extension?: string;
  mimeType?: string;
  path: string;
  parentId?: string;
  createdAt: Date;
  updatedAt: Date;
  modifiedBy?: string;
  permissions: {
    read: boolean;
    write: boolean;
    delete: boolean;
    share: boolean;
  };
  metadata?: {
    description?: string;
    tags?: string[];
    version?: number;
    checksum?: string;
    thumbnail?: string;
  };
  status: 'active' | 'archived' | 'deleted';
  access: 'public' | 'private' | 'shared';
  sharedWith?: Array<{
    userId: string;
    userName: string;
    permission: 'read' | 'write' | 'admin';
  }>;
}
interface FileFilter {
  type?: string;
  extension?: string;
  status?: string;
  access?: string;
  tags?: string[];
  search?: string;
  dateRange?: 'today' | 'week' | 'month' | 'all';
}
export default function FileManagement() {
  const {
    t
  } = useTranslation();
  const { toast } = useToast();
  const [files, setFiles] = useState<FileEntry[]>([]);
  const [filteredFiles, setFilteredFiles] = useState<FileEntry[]>([]);
  const [filter, setFilter] = useState<FileFilter>({});
  const [selectedFile, setSelectedFile] = useState<FileEntry | null>(null);
  const [viewMode, setViewMode] = useState<'list' | 'grid'>('list');
  const [sortBy, setSortBy] = useState<'name' | 'size' | 'date'>('name');
  const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('asc');

  // Mock data generation
  const generateMockFiles = (): FileEntry[] => {
    const mockFiles: FileEntry[] = [{
      id: "1",
      name: "Project Documentation",
      type: "folder",
      path: "/Project Documentation",
      createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 7),
      updatedAt: new Date(Date.now() - 1000 * 60 * 60 * 24),
      modifiedBy: "Admin User",
      permissions: {
        read: true,
        write: true,
        delete: true,
        share: true
      },
      metadata: {
        description: t("client.src.main_project_documentations"),
        tags: ["project", "documentation", "important"],
        version: 1
      },
      status: "active",
      access: "shared",
      sharedWith: [{
        userId: "user2",
        userName: "Sarah Johnson",
        permission: "write"
      }, {
        userId: "user3",
        userName: "John Doe",
        permission: "read"
      }]
    }, {
      id: "2",
      name: "report-2024.pdf",
      type: "file",
      size: 2048576,
      extension: "pdf",
      mimeType: "application/pdf",
      path: "/report-2024.pdf",
      createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 3),
      updatedAt: new Date(Date.now() - 1000 * 60 * 60 * 12),
      modifiedBy: "Admin User",
      permissions: {
        read: true,
        write: true,
        delete: false,
        share: true
      },
      metadata: {
        description: t("client.src.2024_annual_report"),
        tags: ["report", "2024", "annual"],
        version: 2,
        checksum: "abc123def456"
      },
      status: "active",
      access: "private"
    }, {
      id: "3",
      name: "data.xlsx",
      type: "file",
      size: 1024000,
      extension: "xlsx",
      mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      path: "/data.xlsx",
      createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 2),
      updatedAt: new Date(Date.now() - 1000 * 60 * 60 * 6),
      modifiedBy: "Sarah Johnson",
      permissions: {
        read: true,
        write: true,
        delete: true,
        share: false
      },
      metadata: {
        description: t("client.src.analyst_data"),
        tags: ["data", "excel", "analysis"],
        version: 1
      },
      status: "active",
      access: "shared",
      sharedWith: [{
        userId: "user3",
        userName: "John Doe",
        permission: "read"
      }]
    }, {
      id: "4",
      name: "presentation.pptx",
      type: "file",
      size: 5242880,
      extension: "pptx",
      mimeType: "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      path: "/presentation.pptx",
      createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24),
      updatedAt: new Date(Date.now() - 1000 * 60 * 60 * 2),
      modifiedBy: "John Doe",
      permissions: {
        read: true,
        write: false,
        delete: false,
        share: true
      },
      metadata: {
        description: t("client.src.customer_presentation"),
        tags: ["presentation", "customer", "ppt"],
        version: 3
      },
      status: "active",
      access: "public"
    }, {
      id: "5",
      name: "logo.png",
      type: "file",
      size: 51200,
      extension: "png",
      mimeType: "image/png",
      path: "/logo.png",
      createdAt: new Date(Date.now() - 1000 * 60 * 60 * 48),
      updatedAt: new Date(Date.now() - 1000 * 60 * 60 * 24),
      modifiedBy: "Admin User",
      permissions: {
        read: true,
        write: true,
        delete: true,
        share: true
      },
      metadata: {
        description: t("client.src.company_logo"),
        tags: ["logo", "brand", "visual"],
        version: 1,
        thumbnail: "/thumbnails/logo.png"
      },
      status: "active",
      access: "public"
    }, {
      id: "6",
      name: "archive.zip",
      type: "file",
      size: 10485760,
      extension: "zip",
      mimeType: "application/zip",
      path: "/archive.zip",
      createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 30),
      updatedAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 15),
      modifiedBy: "Admin User",
      permissions: {
        read: true,
        write: false,
        delete: true,
        share: false
      },
      metadata: {
        description: t("client.src.old_project_archive"),
        tags: ["archive", "old", "project"],
        version: 1
      },
      status: "archived",
      access: "private"
    }];
    return mockFiles;
  };

  // Initialize with mock data
  useEffect(() => {
    const mockFiles = generateMockFiles();
    setFiles(mockFiles);
    setFilteredFiles(mockFiles);
  }, []);

  // Apply filters and sorting
  useEffect(() => {
    let filtered = [...files];

    // Apply filters
    if (filter.type) {
      filtered = filtered.filter(file => file.type === filter.type);
    }
    if (filter.extension) {
      filtered = filtered.filter(file => file.extension === filter.extension);
    }
    if (filter.status) {
      filtered = filtered.filter(file => file.status === filter.status);
    }
    if (filter.access) {
      filtered = filtered.filter(file => file.access === filter.access);
    }
    if (filter.tags && filter.tags.length > 0) {
      filtered = filtered.filter(file => file.metadata?.tags?.some(tag => filter.tags!.includes(tag)));
    }
    if (filter.search) {
      filtered = filtered.filter(file => file.name.toLowerCase().includes(filter.search!.toLowerCase()) || file.metadata?.description?.toLowerCase().includes(filter.search!.toLowerCase()) || file.metadata?.tags?.some(tag => tag.toLowerCase().includes(filter.search!.toLowerCase())));
    }
    if (filter.dateRange && filter.dateRange !== 'all') {
      const now = new Date();
      let cutoffDate: Date;
      switch (filter.dateRange) {
        case 'today':
          cutoffDate = new Date(now.getFullYear(), now.getMonth(), now.getDate());
          break;
        case 'week':
          cutoffDate = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
          break;
        case 'month':
          cutoffDate = new Date(now.getFullYear(), now.getMonth(), 1);
          break;
        default:
          cutoffDate = new Date(0);
      }
      filtered = filtered.filter(file => file.updatedAt >= cutoffDate);
    }

    // Apply sorting
    filtered.sort((a, b) => {
      let aValue: any, bValue: any;
      switch (sortBy) {
        case 'name':
          aValue = a.name.toLowerCase();
          bValue = b.name.toLowerCase();
          break;
        case 'size':
          aValue = a.size || 0;
          bValue = b.size || 0;
          break;
        case 'date':
          aValue = a.updatedAt.getTime();
          bValue = b.updatedAt.getTime();
          break;
        default:
          aValue = a.name.toLowerCase();
          bValue = b.name.toLowerCase();
      }
      if (sortOrder === 'asc') {
        return aValue < bValue ? -1 : aValue > bValue ? 1 : 0;
      } else {
        return aValue > bValue ? -1 : aValue < bValue ? 1 : 0;
      }
    });
    setFilteredFiles(filtered);
  }, [files, filter, sortBy, sortOrder]);
  const getFileIcon = (extension?: string, type?: string) => {
    if (type === 'folder') return <Folder className="w-5 h-5 text-blue-500" />;
    switch (extension) {
      case 'pdf':
        return <FileText className="w-5 h-5 text-red-500" />;
      case 'doc':
      case 'docx':
        return <FileText className="w-5 h-5 text-blue-600" />;
      case 'xls':
      case 'xlsx':
        return <FileCode className="w-5 h-5 text-green-600" />;
      case 'ppt':
      case 'pptx':
        return <FileText className="w-5 h-5 text-orange-600" />;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return <FileImage className="w-5 h-5 text-purple-500" />;
      case 'mp4':
      case 'avi':
      case 'mov':
        return <FileVideo className="w-5 h-5 text-pink-500" />;
      case 'mp3':
      case 'wav':
        return <FileAudio className="w-5 h-5 text-yellow-500" />;
      case 'zip':
      case 'rar':
      case '7z':
        return <Archive className="w-5 h-5 text-gray-500" />;
      default:
        return <FileText className="w-5 h-5 text-gray-400" />;
    }
  };
  const formatFileSize = (bytes?: number) => {
    if (!bytes) return '-';
    const sizes = ['B', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(1024));
    return `${(bytes / Math.pow(1024, i)).toFixed(1)} ${sizes[i]}`;
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'active':
        return 'bg-green-100 text-green-800';
      case 'archived':
        return 'bg-yellow-100 text-yellow-800';
      case 'deleted':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const getAccessColor = (access: string) => {
    switch (access) {
      case 'public':
        return 'bg-blue-100 text-blue-800';
      case 'private':
        return 'bg-gray-100 text-gray-800';
      case 'shared':
        return 'bg-purple-100 text-purple-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const handleFileAction = (action: string, file: FileEntry) => {
    switch (action) {
      case 'view':
        setSelectedFile(file);
        break;
      case 'download':
        toast({ title: t("client.src.downloading_file") || "Downloading file", description: file.name });
        break;
      case 'share':
        toast({ title: t("client.src.sharing_file") || "Sharing file", description: file.name });
        break;
      case 'edit':
        toast({ title: t("client.src.editing_file") || "Editing file", description: file.name });
        break;
      case 'delete':
        toast({ title: t("client.src.deleting_file") || "Deleting file", description: file.name, variant: "destructive" });
        break;
    }
  };
  const exportFileList = () => {
    const csv = ['Name,Type,Size,Extension,Access,Status,Created,Updated,Modified By,Tags', ...filteredFiles.map(file => `"${file.name}",${file.type},${file.size || 0},${file.extension || ''},${file.access},${file.status},${file.createdAt.toISOString()},${file.updatedAt.toISOString()},${file.modifiedBy || ''},"${file.metadata?.tags?.join(',') || ''}"`)].join('\n');
    const blob = new Blob([csv], {
      type: 'text/csv'
    });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `file-list-${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  };
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 overflow-x-hidden">
      <div className="max-w-[1600px] mx-auto space-y-12">
        
        {/* Tactical Header HUD */}
        <header className="relative py-12 px-10 rounded-[40px] bg-[#1a1b1e]/40 border border-white/5 border-l border-t overflow-hidden shadow-3xl">
           <div className="absolute top-0 right-0 p-40 opacity-5 pointer-events-none text-blue-600">
              <Folder className="w-96 h-96" />
           </div>
           <div className="absolute -top-24 -left-24 w-96 h-96 bg-blue-600/10 blur-[120px] rounded-full pointer-events-none"></div>
           
           <div className="relative z-10 flex flex-col md:flex-row items-center justify-between gap-10">
              <div className="flex items-center gap-8">
                 <div className="relative group">
                    <div className="absolute inset-0 bg-blue-600/20 blur-2xl group-hover:bg-blue-600/40 transition-all rounded-full animate-pulse-slow"></div>
                    <div className="relative p-6 rounded-3xl bg-gradient-to-br from-blue-500/20 to-purple-500/20 border border-blue-500/30 backdrop-blur-xl shadow-2xl">
                       <Folder className="w-10 h-10 text-blue-400" />
                    </div>
                 </div>
                 <div className="space-y-2">
                    <div className="flex items-center gap-3">
                       <h1 className="text-5xl font-black text-white italic tracking-tighter leading-none">{t("filesTitle")}</h1>
                       <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/20 font-black italic tracking-widest text-[10px] px-3 py-1 rounded-full">
                        {t("filesActivenodes")}
                       </Badge>
                    </div>
                    <p className="text-lg font-black text-slate-500 italic tracking-widest leading-none mt-2">{t("filesSubtitle")}</p>
                 </div>
              </div>
              
              <div className="flex gap-4">
                 <Button onClick={() => setFiles(generateMockFiles())} className="h-16 px-10 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic text-xs tracking-widest shadow-xl transition-all hover:scale-105 active:scale-95">
                    <RefreshCw className="w-4 h-4 mr-3" />
                    {t("filesControlsRefresh")}
                 </Button>
                 <Button onClick={exportFileList} variant="outline" className="h-16 w-16 rounded-2xl border-white/5 bg-white/5 text-slate-400 hover:text-white transition-all backdrop-blur-xl">
                    <Download className="w-6 h-6" />
                 </Button>
              </div>
           </div>
        </header>

        {/* Real-time Metrics Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("total"),
          value: files.length,
          icon: FileText,
          color: "text-blue-400",
          bg: "bg-blue-500/10"
        }, {
          label: t("filesCapacity"),
          value: formatFileSize(files.reduce((total, file) => total + (file.size || 0), 0)),
          icon: Archive,
          color: "text-emerald-400",
          bg: "bg-emerald-500/10"
        }, {
          label: t("shared"),
          value: files.filter(file => file.access === 'shared' || file.access === 'public').length,
          icon: Users,
          color: "text-purple-400",
          bg: "bg-purple-500/10"
        }, {
          label: t("archived"),
          value: files.filter(file => file.status === 'archived').length,
          icon: Archive,
          color: "text-orange-400",
          bg: "bg-orange-500/10"
        }].map((stat, idx) => <Card key={idx} className="border-white/5 bg-[#1a1b1e]/60 backdrop-blur-3xl rounded-[32px] overflow-hidden shadow-2xl relative border-l border-t">
                <CardContent className="p-8">
                   <div className="flex justify-between items-start mb-6">
                      <div className={cn("p-4 rounded-2xl bg-black/40 border border-white/5", stat.color)}>
                         <stat.icon className="h-6 w-6" />
                      </div>
                      <Badge className="bg-white/5 text-slate-500 border-none text-[8px] font-black italic tracking-widest">{t("client.src.realtime")}</Badge>
                   </div>
                   <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{stat.label}</p>
                   <h2 className="text-3xl font-black text-white italic tracking-tighter mt-1">{stat.value}</h2>
                </CardContent>
             </Card>)}
        </div>

        {/* Controls and Search */}
        <div className="flex flex-col md:flex-row items-center justify-between gap-8 bg-[#1a1b1e]/40 p-8 rounded-[40px] border border-white/5 shadow-2xl">
           <div className="relative w-full md:w-96">
              <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600" />
               <input type="text" aria-label="Search files" placeholder={t("filesControlsSearch")} className="w-full bg-black/40 border border-white/5 rounded-3xl py-5 pl-16 pr-8 text-xs font-black tracking-widest italic text-white placeholder:text-slate-700 focus:outline-none focus:border-blue-500/50 transition-all shadow-inner" value={filter.search || ''} onChange={e => setFilter({
            ...filter,
            search: e.target.value || undefined
          })} />
           </div>

           <div className="flex flex-wrap gap-4">
              {[{
            key: 'type',
            options: [{
              val: '',
              label: t("client.files.filters.allTypes")
            }, {
              val: 'file',
              label: t("client.src.file")
            }, {
              val: 'folder',
              label: t("client.src.folder")
            }]
          }, {
            key: 'access',
            options: [{
              val: '',
              label: t("allAccess")
            }, {
              val: 'public',
              label: t("client.src.public")
            }, {
              val: 'private',
              label: t("client.src.private")
            }, {
              val: 'shared',
              label: t("client.src.shared")
            }]
          }].map(f => <select key={f.key} aria-label={`Filter by ${f.key}`} className="bg-[#1a1b1e] border border-white/5 rounded-2xl px-6 py-4 text-[10px] font-black italic tracking-widest text-slate-400 focus:outline-none focus:border-blue-500/50 transition-all cursor-pointer" value={(filter as any)[f.key] || ''} onChange={e => setFilter({
            ...filter,
            [f.key]: e.target.value || undefined
          })}>
                  {f.options.map(opt => <option key={opt.val} value={opt.val}>{opt.label}</option>)}
                </select>)}
              
              <div className="flex bg-black/40 p-1.5 rounded-2xl border border-white/5">
                 <Button variant="ghost" className={cn("h-12 px-6 rounded-xl font-black  italic text-[10px] tracking-widest transition-all", viewMode === 'list' ? "bg-blue-600 text-white shadow-lg" : "text-slate-500 hover:text-white")} onClick={() => setViewMode('list')}>
                    {t("filesViewList")}
                 </Button>
                 <Button variant="ghost" className={cn("h-12 px-6 rounded-xl font-black  italic text-[10px] tracking-widest transition-all", viewMode === 'grid' ? "bg-blue-600 text-white shadow-lg" : "text-slate-500 hover:text-white")} onClick={() => setViewMode('grid')}>
                    {t("filesViewGrid")}
                 </Button>
              </div>
           </div>
        </div>

        {/* File List */}
        <Card>
          <CardHeader>
            <div className="flex items-center justify-between">
              <CardTitle>{t("client.src.files")}</CardTitle>
              <div className="flex gap-2">
                <Button variant={viewMode === 'list' ? 'default' : 'outline'} size="sm" onClick={() => setViewMode('list')}>{t("client.src.list")}</Button>
                <Button variant={viewMode === 'grid' ? 'default' : 'outline'} size="sm" onClick={() => setViewMode('grid')}>{t("client.src.grid")}</Button>
              </div>
            </div>
          </CardHeader>
          <CardContent>
            {viewMode === 'list' ? <div className="space-y-2">
                {filteredFiles.map(file => <div key={file.id} className="flex items-center gap-3 p-3 border rounded-lg hover:bg-muted/50 transition-colors">
                    <div className="mt-1">
                      {getFileIcon(file.extension, file.type)}
                    </div>
                    
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1">
                        <h4 className="font-medium truncate">{file.name}</h4>
                        <Badge className={getAccessColor(file.access)}>
                          {t(`client.files.labels.${file.access}`)}
                        </Badge>
                        <Badge className={getStatusColor(file.status)}>
                          {t(`client.files.labels.${file.status}`)}
                        </Badge>
                      </div>
                      
                      <div className="flex items-center gap-4 text-xs text-muted-foreground">
                        <span>{file.size ? formatFileSize(file.size) : '-'}</span>
                        <span>{file.extension?.toUpperCase() || '-'}</span>
                        <span>{file.updatedAt.toLocaleDateString()}</span>
                        {file.modifiedBy && <span>{t("modifiedBy", {
                      name: file.modifiedBy
                    })}</span>}
                        {file.sharedWith && file.sharedWith.length > 0 && <span>{t("sharedCount", {
                      count: file.sharedWith.length
                    })}</span>}
                      </div>
                      
                      {file.metadata?.tags && file.metadata.tags.length > 0 && <div className="flex gap-1 mt-1">
                          {file.metadata.tags.map((tag, index) => <Badge key={index} variant="outline" className="text-xs">
                              {tag}
                            </Badge>)}
                        </div>}
                    </div>
                    
                    <div className="flex items-center gap-1">
                      <Button variant="ghost" size="sm" onClick={() => handleFileAction('view', file)}>
                        <Eye className="w-4 h-4" />
                      </Button>
                      <Button variant="ghost" size="sm" onClick={() => handleFileAction('download', file)}>
                        <Download className="w-4 h-4" />
                      </Button>
                      <Button variant="ghost" size="sm" onClick={() => handleFileAction('share', file)}>
                        <Share className="w-4 h-4" />
                      </Button>
                      {file.permissions.write && <Button variant="ghost" size="sm" onClick={() => handleFileAction('edit', file)}>
                          <Edit className="w-4 h-4" />
                        </Button>}
                      {file.permissions.delete && <Button variant="ghost" size="sm" className="text-red-600" onClick={() => handleFileAction('delete', file)}>
                          <Trash2 className="w-4 h-4" />
                        </Button>}
                    </div>
                  </div>)}
              </div> : <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                {filteredFiles.map(file => <div key={file.id} className="flex flex-col items-center p-4 border rounded-lg hover:bg-muted/50 transition-colors cursor-pointer" onClick={() => setSelectedFile(file)}>
                    <div className="mb-3">
                      {getFileIcon(file.extension, file.type)}
                    </div>
                    
                    <h4 className="font-medium text-center truncate w-full mb-2">
                      {file.name}
                    </h4>
                    
                    <div className="flex gap-1 mb-2">
                      <Badge className={getAccessColor(file.access)} variant="outline">
                        {t(`client.files.labels.${file.access}`)}
                      </Badge>
                      <Badge className={getStatusColor(file.status)} variant="outline">
                        {t(`client.files.labels.${file.status}`)}
                      </Badge>
                    </div>
                    
                    <div className="text-xs text-muted-foreground text-center">
                      <div>{file.size ? formatFileSize(file.size) : '-'}</div>
                      <div>{file.updatedAt.toLocaleDateString()}</div>
                    </div>
                  </div>)}
              </div>}
          </CardContent>
        </Card>

        {/* Detail Modal */}
        {selectedFile && <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
            <Card className="w-full max-w-2xl max-h-[80vh] overflow-auto">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle>{t("fileDetail")}</CardTitle>
                  <Button variant="ghost" size="sm" onClick={() => setSelectedFile(null)}>
                    <Trash2 className="w-4 h-4" />
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center gap-3 mb-4">
                  {getFileIcon(selectedFile.extension, selectedFile.type)}
                  <div>
                    <h3 className="text-lg font-medium">{selectedFile.name}</h3>
                    <div className="flex gap-2 mt-1">
                      <Badge className={getAccessColor(selectedFile.access)}>
                        {t(`client.files.labels.${selectedFile.access}`)}
                      </Badge>
                      <Badge className={getStatusColor(selectedFile.status)}>
                        {t(`client.files.labels.${selectedFile.status}`)}
                      </Badge>
                    </div>
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.type")}</p>
                    <p className="font-medium">{selectedFile.type === 'folder' ? 'Folder' : 'File'}</p>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.size")}</p>
                    <p className="font-medium">{formatFileSize(selectedFile.size)}</p>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.extension")}</p>
                    <p className="font-medium">{selectedFile.extension?.toUpperCase() || '-'}</p>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.mime_type")}</p>
                    <p className="font-medium">{selectedFile.mimeType || '-'}</p>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.created")}</p>
                    <p className="font-medium">{selectedFile.createdAt.toLocaleString()}</p>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.updated")}</p>
                    <p className="font-medium">{selectedFile.updatedAt.toLocaleString()}</p>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.modified_by")}</p>
                    <p className="font-medium">{selectedFile.modifiedBy || '-'}</p>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.path")}</p>
                    <p className="font-medium">{selectedFile.path}</p>
                  </div>
                </div>

                {selectedFile.metadata?.description && <div>
                    <p className="text-sm font-medium text-muted-foreground mb-2">{t("client.src.description")}</p>
                    <p className="text-sm">{selectedFile.metadata.description}</p>
                  </div>}

                 {selectedFile.metadata?.tags && selectedFile.metadata.tags.length > 0 && <div>
                    <p className="text-sm font-medium text-muted-foreground mb-2">{t("client.src.tags")}</p>
                    <div className="flex gap-1 flex-wrap">
                      {selectedFile.metadata.tags.map((tag, index) => <Badge key={index} variant="outline">
                          {tag}
                        </Badge>)}
                    </div>
                  </div>}

                {selectedFile.sharedWith && selectedFile.sharedWith.length > 0 && <div>
                    <p className="text-sm font-medium text-muted-foreground mb-2">{t("client.src.shared_people")}</p>
                    <div className="space-y-2">
                      {selectedFile.sharedWith.map((share, index) => <div key={index} className="flex items-center justify-between p-2 bg-muted rounded">
                          <span className="text-sm">{share.userName}</span>
                          <Badge variant="outline">
                            {share.permission === 'read' ? 'Read' : share.permission === 'write' ? 'Write' : 'Admin'}
                          </Badge>
                        </div>)}
                    </div>
                  </div>}

                <div className="flex gap-2 pt-4 border-t">
                  <Button onClick={() => handleFileAction('download', selectedFile)}>
                    <Download className="w-4 h-4 mr-2" />
                    {t("filesDownload")}
                  </Button>
                  <Button variant="outline" onClick={() => handleFileAction('share', selectedFile)}>
                    <Share className="w-4 h-4 mr-2" />
                    {t("share")}
                  </Button>
                  {selectedFile.permissions.write && <Button variant="outline" onClick={() => handleFileAction('edit', selectedFile)}>
                      <Edit className="w-4 h-4 mr-2" />
                      {t("edit")}
                    </Button>}
                  {selectedFile.permissions.delete && <Button variant="outline" className="text-red-600" onClick={() => handleFileAction('delete', selectedFile)}>
                      <Trash2 className="w-4 h-4 mr-2" />
                      {t("delete")}
                    </Button>}
                </div>
              </CardContent>
            </Card>
          </div>}
      </div>
    </div>;
}