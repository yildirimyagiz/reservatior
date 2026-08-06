"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Plus, Search, Filter, FileText, CheckCircle, AlertCircle } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { useQuery } from "@tanstack/react-query";
import { homeInformationPacksApi } from "@/lib/api/home-information-packs";
import { propertiesApi, type Property } from "@/lib/api/properties";

// Type definitions
interface HomeInformationPack {
  id: string;
  orgId: string;
  propertyId: string;
  title: string;
  description?: string;
  fileUrl: string;
  fileName: string;
  fileSize: number;
  mimeType: string;
  checksum: string;
  version: number;
  isActive: boolean;
  createdBy?: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
  property?: {
    id: string;
    name: string;
    addressLine1: string;
    city: string;
    state: string;
    zipCode: string;
  };
}
export default function PropertyDisclosures({ propertyId }: { propertyId?: string }) {
  const {
    t
  } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [isAddDialogOpen, setIsAddDialogOpen] = useState(false);
  const { data: disclosuresResponse, isLoading: loadingDisclosures, refetch: refetchDisclosures } = useQuery({
    queryKey: ['disclosures'],
    queryFn: () => homeInformationPacksApi.getAll({ page: 1, limit: 50 })
  });
  const disclosures = (disclosuresResponse as any)?.data || [];

  const { data: properties = [], isLoading: loadingProperties } = useQuery({
    queryKey: ['properties'],
    queryFn: () => propertiesApi.getAll()
  });

  const [newDisc, setNewDisc] = useState({
    propertyId: propertyId || "",
    title: "",
    description: ""
  });
  
  const { toast } = useToast();

  const loading = loadingDisclosures || loadingProperties;
  const filteredDisclosures = disclosures.filter((disclosure: any) => {
    const matchesSearch = disclosure.title?.toLowerCase().includes(searchTerm.toLowerCase()) || disclosure.property?.name?.toLowerCase().includes(searchTerm.toLowerCase()) || disclosure.property?.addressLine1?.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatusFilter = filterStatus === "all" || filterStatus === "active" && disclosure.isActive || filterStatus === "inactive" && !disclosure.isActive;
    const matchesProperty = !propertyId || disclosure.propertyId === propertyId;
    return matchesSearch && matchesStatusFilter && matchesProperty;
  });
  const totalDisclosures = filteredDisclosures.length;
  const activeDisclosures = filteredDisclosures.filter((d: any) => d.isActive).length;
  const totalSize = filteredDisclosures.reduce((sum: number, d: any) => sum + d.fileSize, 0);
  const handleAddDisclosure = async (data: any) => {
    try {
      await homeInformationPacksApi.create(data);
      setIsAddDialogOpen(false);
      toast({
        title: t("client.src.disclosure_pack_created"),
        description: t("client.src.new_property_disclosure_pack")
      });
      // Refresh data
      refetchDisclosures();
    } catch (error) {
      console.error('Error creating disclosure:', error);
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_create_disclosure"),
        variant: "destructive"
      });
    }
  };
  const getStatusColor = (isActive: boolean) => {
    return isActive ? "default" : "secondary";
  };
  const getStatusIcon = (isActive: boolean) => {
    return isActive ? <CheckCircle className="h-4 w-4 text-blue-500" /> : <AlertCircle className="h-4 w-4 text-red-500" />;
  };
  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  };
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  return <PageShell title={t("client.src.property_disclosures")} description={t("client.src.manage_property_disclosure_packs")}>
      <div className="space-y-6">
        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.total_packs")}</CardTitle>
              <FileText className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalDisclosures}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.all_disclosure_packs")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("common.active")}</CardTitle>
              <CheckCircle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-blue-600">
                {activeDisclosures}
              </div>
              <p className="text-xs text-muted-foreground">
                {totalDisclosures > 0 ? (activeDisclosures / totalDisclosures * 100).toFixed(1) : 0}{t("common.active")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.total_size")}</CardTitle>
              <FileText className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-brand">
                {formatFileSize(totalSize)}
              </div>
              <p className="text-xs text-muted-foreground">{t("client.src.storage_used")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("common.properties")}</CardTitle>
              <FileText className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {new Set(disclosures.map((d: any) => d.propertyId)).size}
              </div>
              <p className="text-xs text-muted-foreground">{t("client.src.properties_with_packs")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-2">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
              <Input placeholder={t("client.src.search_disclosures")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-[250px]" />
            </div>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="outline" size="sm">
                  <Filter className="h-4 w-4 mr-2" />{t("common.status")}{filterStatus === "all" ? "All" : filterStatus}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                <DropdownMenuItem onClick={() => setFilterStatus("all")}>{t("common.all_status")}</DropdownMenuItem>
                <DropdownMenuItem onClick={() => setFilterStatus("active")}>{t("common.active")}</DropdownMenuItem>
                <DropdownMenuItem onClick={() => setFilterStatus("inactive")}>{t("common.inactive")}</DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
          <Dialog open={isAddDialogOpen} onOpenChange={setIsAddDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("client.src.new_disclosure_pack")}</Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px]">
              <DialogHeader>
                <DialogTitle>{t("client.src.create_disclosure_pack")}</DialogTitle>
                <DialogDescription>{t("client.src.start_a_new_property")}</DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="property" className="text-right">{t("common.property")}</Label>
                  <Select value={newDisc.propertyId} onValueChange={v => setNewDisc({
                  ...newDisc,
                  propertyId: v
                })}>
                    <SelectTrigger className="col-span-3">
                      <SelectValue placeholder={t("common.select_property")} />
                    </SelectTrigger>
                    <SelectContent>
                      {properties.map(p => <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="title" className="text-right">{t("common.title")}</Label>
                  <Input id="title" placeholder={t("client.src.enter_pack_title")} className="col-span-3" value={newDisc.title} onChange={e => setNewDisc({
                  ...newDisc,
                  title: e.target.value
                })} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="description" className="text-right">{t("common.description")}</Label>
                  <Input id="description" placeholder={t("client.src.pack_description")} className="col-span-3" value={newDisc.description} onChange={e => setNewDisc({
                  ...newDisc,
                  description: e.target.value
                })} />
                </div>
              </div>
              <div className="flex justify-end space-x-2">
                <Button variant="outline" onClick={() => setIsAddDialogOpen(false)}>{t("common.cancel")}</Button>
                <Button onClick={() => handleAddDisclosure(newDisc)}>{t("client.src.create_pack")}</Button>
              </div>
            </DialogContent>
          </Dialog>
        </div>

        {/* Disclosure Packs Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.property_disclosure_packs")}</CardTitle>
            <CardDescription>{t("client.src.track_legal_documentation_and")}</CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? <div className="flex items-center justify-center py-8">
                <div className="text-sm text-muted-foreground">{t("common.loading")}</div>
              </div> : <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>{t("common.property")}</TableHead>
                    <TableHead>{t("common.title")}</TableHead>
                    <TableHead>{t("common.status")}</TableHead>
                    <TableHead>{t("client.src.version")}</TableHead>
                    <TableHead>{t("client.src.file_size")}</TableHead>
                    <TableHead>{t("common.created")}</TableHead>
                    <TableHead>{t("client.src.updated")}</TableHead>
                    <TableHead className="w-[50px]"></TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredDisclosures.map((disclosure: any) => <TableRow key={disclosure.id}>
                      <TableCell className="font-medium">
                        <div>
                          <div className="font-medium">{disclosure.property?.name}</div>
                          <div className="text-sm text-muted-foreground">
                            {disclosure.property?.addressLine1}, {disclosure.property?.city}
                          </div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div>
                          <div className="font-medium">{disclosure.title}</div>
                          {disclosure.description && <div className="text-sm text-muted-foreground truncate max-w-[200px]">
                              {disclosure.description}
                            </div>}
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center space-x-2">
                          {getStatusIcon(disclosure.isActive)}
                          <Badge variant={getStatusColor(disclosure.isActive)}>
                            {disclosure.isActive ? "Active" : "Inactive"}
                          </Badge>
                        </div>
                      </TableCell>
                      <TableCell>
                        <span className="text-sm font-medium">v{disclosure.version}</span>
                      </TableCell>
                      <TableCell>
                        <span className="text-sm">{formatFileSize(disclosure.fileSize)}</span>
                      </TableCell>
                      <TableCell>{formatDate(disclosure.createdAt)}</TableCell>
                      <TableCell>{formatDate(disclosure.updatedAt)}</TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="sm" aria-label={t("common.more")}>
                              <MoreHorizontal className="h-4 w-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent>
                            <DropdownMenuItem>{t("common.view_details")}</DropdownMenuItem>
                            <DropdownMenuItem>{t("client.src.download_file")}</DropdownMenuItem>
                            <DropdownMenuItem>{t("client.src.edit_pack")}</DropdownMenuItem>
                            <DropdownMenuItem>{t("client.src.upload_new_version")}</DropdownMenuItem>
                            <DropdownMenuItem className="text-red-600">{t("client.src.deactivate")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>)}
                </TableBody>
              </Table>}
          </CardContent>
        </Card>
      </div>
    </PageShell>;
}