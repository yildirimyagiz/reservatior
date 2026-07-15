"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Textarea } from"@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { aiApi, type AiVideoGeneration } from"@/lib/api/ai";
import { Video, Play, Plus, Edit, Trash2, MoreHorizontal, Eye } from"lucide-react";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";

export default function AiVideoGenerationPage() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [selectedVideo, setSelectedVideo] = useState<AiVideoGeneration | null>(null);
 const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
 const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
 const [isViewDialogOpen, setIsViewDialogOpen] = useState(false);
 const [form, setForm] = useState({
 propertyId: '',
 listingId: '',
 videoUrl: '',
 thumbnailUrl: '',
 status: 'PENDING',
 duration: 0,
 metadata: ''
 });

 const { data: videos = [], isLoading: loading } = useQuery({
 queryKey: ['aiVideoGenerations'],
 queryFn: async () => {
 const response = await aiApi.getServiceTasks({
 taskType: 'REELS_VIDEO_GEN'
 });
 const mockVideos: AiVideoGeneration[] = response.map(task => ({
 id: task.id,
 propertyId: task.propertyId || '',
 listingId: task.listingId,
 videoUrl: `https://example.com/video/${task.id}.mp4`,
 thumbnailUrl: `https://example.com/thumbnail/${task.id}.jpg`,
 status: task.status as any,
 duration: 30,
 metadata: task.inputData
 }));
 return mockVideos;
 }
 });

 const createMutation = useMutation({
 mutationFn: () => aiApi.createServiceTask({
 propertyId: form.propertyId || undefined,
 listingId: form.listingId || undefined,
 taskType: 'REELS_VIDEO_GEN',
 inputData: JSON.parse(form.metadata || '{}')
 }),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['aiVideoGenerations'] });
 setIsCreateDialogOpen(false);
 resetForm();
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_video_generation_task_created")
 });
 },
 onError: () => {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_create_video"),
 variant:"destructive"
 });
 }
 });

 const updateMutation = useMutation({
 mutationFn: (progress: number) => {
 if (!selectedVideo) throw new Error("No selected video");
 return aiApi.updateServiceTask(selectedVideo.id, { progress });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['aiVideoGenerations'] });
 setIsEditDialogOpen(false);
 setSelectedVideo(null);
 resetForm();
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_video_generation_updated_successfully")
 });
 },
 onError: () => {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_update_video"),
 variant:"destructive"
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: (id: string) => aiApi.cancelServiceTask(id),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['aiVideoGenerations'] });
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_video_generation_deleted_successfully")
 });
 },
 onError: () => {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_delete_video"),
 variant:"destructive"
 });
 }
 });

 const resetForm = () => {
 setForm({
 propertyId: '',
 listingId: '',
 videoUrl: '',
 thumbnailUrl: '',
 status: 'PENDING',
 duration: 0,
 metadata: ''
 });
 };

 const openEdit = (video: AiVideoGeneration) => {
 setSelectedVideo(video);
 setForm({
 propertyId: video.propertyId,
 listingId: video.listingId || '',
 videoUrl: video.videoUrl,
 thumbnailUrl: video.thumbnailUrl || '',
 status: video.status,
 duration: video.duration || 0,
 metadata: JSON.stringify(video.metadata, null, 2)
 });
 setIsEditDialogOpen(true);
 };

 const openView = (video: AiVideoGeneration) => {
 setSelectedVideo(video);
 setForm({
 propertyId: video.propertyId,
 listingId: video.listingId || '',
 videoUrl: video.videoUrl,
 thumbnailUrl: video.thumbnailUrl || '',
 status: video.status,
 duration: video.duration || 0,
 metadata: JSON.stringify(video.metadata, null, 2)
 });
 setIsViewDialogOpen(true);
 };

 const getStatusColor = (status: string) => {
 switch (status) {
 case 'COMPLETED':
 return 'bg-green-100 text-green-800';
 case 'FAILED':
 return 'bg-red-100 text-red-800';
 case 'PROCESSING':
 return 'bg-slate-100 text-slate-800';
 case 'PENDING':
 return 'bg-yellow-100 text-yellow-800';
 default:
 return 'bg-card text-slate-300';
 }
 };

 if (loading) {
 return <PageShell title={t("admin_ai_ai_video_generation_management")}>
 <div className="flex items-center justify-center h-64">
 <Video className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }

 return <PageShell title={t("admin_ai_ai_video_generation_management")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6">
 <div className="flex justify-between items-center">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_ai_ai_video_generation")}</h1>
 <p className="text-muted-foreground">{t("admin_ai_manage_aigenerated_property_videos")}</p>
 </div>
 <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />{t("admin_ai_generate_video")}</Button>
 </DialogTrigger>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_ai_generate_new_property_video")}</DialogTitle>
 <DialogDescription>{t("admin_ai_create_a_new_aigenerated")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="propertyId" className="text-right">{t("admin_ai_property_id")}</Label>
 <Input id="propertyId" value={form.propertyId} onChange={e => setForm({
 ...form,
 propertyId: e.target.value
 })} className="col-span-3" placeholder={t("admin_ai_prop")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="listingId" className="text-right">{t("admin_ai_listing_id")}</Label>
 <Input id="listingId" value={form.listingId} onChange={e => setForm({
 ...form,
 listingId: e.target.value
 })} className="col-span-3" placeholder={t("admin_ai_listing")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="videoUrl" className="text-right">{t("admin_ai_video_url")}</Label>
 <Input id="videoUrl" value={form.videoUrl} onChange={e => setForm({
 ...form,
 videoUrl: e.target.value
 })} className="col-span-3" placeholder={t("admin_ai_https")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="thumbnailUrl" className="text-right">{t("admin_ai_thumbnail_url")}</Label>
 <Input id="thumbnailUrl" value={form.thumbnailUrl} onChange={e => setForm({
 ...form,
 thumbnailUrl: e.target.value
 })} className="col-span-3" placeholder={t("admin_ai_https")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="status" className="text-right">{t("admin_ai_status")}</Label>
 <Select value={form.status} onValueChange={value => setForm({
 ...form,
 status: value
 })}>
 <SelectTrigger className="col-span-3">
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="PENDING">{t("admin_ai_pending")}</SelectItem>
 <SelectItem value="PROCESSING">{t("admin_ai_processing")}</SelectItem>
 <SelectItem value="COMPLETED">{t("admin_ai_completed")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_ai_failed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="duration" className="text-right">{t("admin_ai_duration_sec")}</Label>
 <Input id="duration" type="number" value={form.duration} onChange={e => setForm({
 ...form,
 duration: parseInt(e.target.value)
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-start gap-4">
 <Label htmlFor="metadata" className="text-right pt-2">{t("admin_ai_metadata_json")}</Label>
 <Textarea id="metadata" value={form.metadata} onChange={e => setForm({
 ...form,
 metadata: e.target.value
 })} className="col-span-3 min-h-32" placeholder={t("admin_ai_style_modern_music_upbeat")} />
 </div>
 </div>
 <DialogFooter>
 <Button onClick={() => createMutation.mutate()} disabled={createMutation.isPending}>{t("admin_ai_generate_video")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_ai_generated_videos")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_ai_property")}</TableHead>
 <TableHead>{t("admin_ai_status")}</TableHead>
 <TableHead>{t("admin_ai_duration")}</TableHead>
 <TableHead>{t("admin_ai_video_url")}</TableHead>
 <TableHead className="text-right">{t("admin_ai_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {videos.map((video: AiVideoGeneration) => <TableRow key={video.id}>
 <TableCell className="font-medium">
 <div className="flex items-center gap-2">
 <Video className="h-4 w-4" />
 <div>
 <div>{video.propertyId}</div>
 {video.listingId && <div className="text-xs text-muted-foreground">{video.listingId}</div>}
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge className={getStatusColor(video.status)}>
 {video.status}
 </Badge>
 </TableCell>
 <TableCell>
 {video.duration ? `${video.duration}s` : 'N/A'}
 </TableCell>
 <TableCell>
 <Button variant="link" className="p-0 h-auto font-mono text-xs" onClick={() => window.open(video.videoUrl, '_blank')}>
 {video.videoUrl.split('/').pop()}
 </Button>
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0">
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_ai_actions")}</DropdownMenuLabel>
 <DropdownMenuItem onClick={() => openView(video)}>
 <Eye className="h-4 w-4 mr-2" />{t("admin_ai_view_details")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => openEdit(video)}>
 <Edit className="h-4 w-4 mr-2" />{t("admin_ai_edit")}</DropdownMenuItem>
 <DropdownMenuSeparator />
 <DropdownMenuItem onClick={() => deleteMutation.mutate(video.id)} className="text-red-600">
 <Trash2 className="h-4 w-4 mr-2" />{t("admin_ai_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_ai_edit_video_generation")}</DialogTitle>
 <DialogDescription>{t("admin_ai_update_the_video_generation")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-status" className="text-right">{t("admin_ai_status")}</Label>
 <Select value={form.status} onValueChange={value => setForm({
 ...form,
 status: value
 })}>
 <SelectTrigger className="col-span-3">
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="PENDING">{t("admin_ai_pending")}</SelectItem>
 <SelectItem value="PROCESSING">{t("admin_ai_processing")}</SelectItem>
 <SelectItem value="COMPLETED">{t("admin_ai_completed")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_ai_failed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-duration" className="text-right">{t("admin_ai_duration_sec")}</Label>
 <Input id="edit-duration" type="number" value={form.duration} onChange={e => setForm({
 ...form,
 duration: parseInt(e.target.value)
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-start gap-4">
 <Label htmlFor="edit-metadata" className="text-right pt-2">{t("admin_ai_metadata_json")}</Label>
 <Textarea id="edit-metadata" value={form.metadata} onChange={e => setForm({
 ...form,
 metadata: e.target.value
 })} className="col-span-3 min-h-32" />
 </div>
 </div>
 <DialogFooter>
 <Button onClick={() => updateMutation.mutate(selectedVideo?.status === 'COMPLETED' ? 100 : 50)} disabled={updateMutation.isPending}>{t("admin_ai_update_video")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 <Dialog open={isViewDialogOpen} onOpenChange={setIsViewDialogOpen}>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_ai_view_video_details")}</DialogTitle>
 <DialogDescription>{t("admin_ai_detailed_view_of_the")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right font-medium">{t("admin_ai_property_id")}</Label>
 <span className="col-span-3 font-mono text-sm">{form.propertyId}</span>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right font-medium">{t("admin_ai_listing_id")}</Label>
 <span className="col-span-3 font-mono text-sm">{form.listingId || 'N/A'}</span>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right font-medium">{t("admin_ai_status")}</Label>
 <Badge className={getStatusColor(form.status)}>{form.status}</Badge>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right font-medium">{t("admin_ai_duration")}</Label>
 <span className="col-span-3">{form.duration}{t("admin_auto_s", "s")}</span>
 </div>
 <div className="grid grid-cols-4 items-start gap-4">
 <Label className="text-right pt-2 font-medium">{t("admin_ai_metadata")}</Label>
 <pre className="col-span-3 bg-card p-2 rounded-lg text-xs overflow-auto max-h-48">
 {form.metadata}
 </pre>
 </div>
 </div>
 </DialogContent>
 </Dialog>
 </div>
 </PageShell>;
}