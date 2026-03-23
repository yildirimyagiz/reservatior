import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/video_bloc.dart';
import '../../domain/entities/video_content_entity.dart';
import '../widgets/video_card_widget.dart';
import '../widgets/video_upload_widget.dart';
import '../widgets/video_player_widget.dart';

// ── Video Library Screen ────────────────────────────────────────
// Tam video kütüphanesi: grid/list, arama, filtre, yükle, oynat.

class VideoLibraryScreen extends StatefulWidget {
  final bool isAdmin;
  const VideoLibraryScreen({super.key, this.isAdmin = false});

  @override
  State<VideoLibraryScreen> createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  final _searchCtrl = TextEditingController();
  bool _isGrid = true;
  String _searchQuery = '';
  VideoType? _filterType;
  VideoStatus? _filterStatus;
  VideoQuality? _filterQuality;
  bool? _filterPublic;
  bool? _filterFeatured;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 5, vsync: this);
    context.read<VideoBloc>().add(LoadVideos());
  }

  @override
  void dispose() {
    _tabs.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  List<VideoContentEntity> _applyFilters(List<VideoContentEntity> all) {
    return all.where((v) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = v.title.toLowerCase().contains(q) ||
            (v.description?.toLowerCase().contains(q) ?? false) ||
            v.tags.any((t) => t.toLowerCase().contains(q));
        if (!match) return false;
      }
      if (_filterType != null && v.type != _filterType) return false;
      if (_filterStatus != null && v.status != _filterStatus) return false;
      if (_filterQuality != null && v.quality != _filterQuality) return false;
      if (_filterPublic != null && v.isPublic != _filterPublic) return false;
      if (_filterFeatured != null && v.isFeatured != _filterFeatured) return false;
      return true;
    }).toList();
  }

  List<VideoContentEntity> _byTab(List<VideoContentEntity> all) {
    switch (_tabs.index) {
      case 0: return _applyFilters(all);
      case 1: return _applyFilters(all.where((v) => v.status == VideoStatus.ready).toList());
      case 2: return _applyFilters(all.where((v) => v.status == VideoStatus.processing).toList());
      case 3: return _applyFilters(all.where((v) => v.isFeatured).toList());
      case 4: return _applyFilters(all.where((v) => !v.isPublic).toList());
      default: return _applyFilters(all);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Kütüphanesi'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          onTap: (_) => setState(() {}),
          tabs: const [
            Tab(text: 'Tümü'),
            Tab(text: 'Hazır'),
            Tab(text: 'İşleniyor'),
            Tab(text: 'Öne Çıkan'),
            Tab(text: 'Gizli'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
          if (widget.isAdmin)
            FilledButton.icon(
              onPressed: () => _showUploadDialog(context),
              icon: const Icon(Icons.upload, size: 18),
              label: const Text('Yükle'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                visualDensity: VisualDensity.compact,
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText: 'Video ara…',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _searchCtrl.clear(); setState(() => _searchQuery = ''); })
                  : null,
              border: const OutlineInputBorder(), isDense: true,
            ),
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
        ),
        // Active filters
        if (_filterType != null || _filterStatus != null || _filterQuality != null || _filterPublic != null || _filterFeatured != null)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(children: [
              if (_filterType != null) _filterChip('Tür: ${_filterType!.name}', () => setState(() => _filterType = null)),
              if (_filterStatus != null) _filterChip('Durum: ${_filterStatus!.name}', () => setState(() => _filterStatus = null)),
              if (_filterQuality != null) _filterChip('Kalite: ${_filterQuality!.name}', () => setState(() => _filterQuality = null)),
              if (_filterPublic != null) _filterChip(_filterPublic! ? 'Herkese Açık' : 'Gizli', () => setState(() => _filterPublic = null)),
              if (_filterFeatured != null) _filterChip('Öne Çıkan', () => setState(() => _filterFeatured = null)),
              TextButton(onPressed: _clearFilters, child: const Text('Temizle', style: TextStyle(fontSize: 12))),
            ]),
          ),
        // Content
        Expanded(
          child: BlocBuilder<VideoBloc, VideoState>(
            builder: (ctx, state) {
              if (state is VideoLoading) return const Center(child: CircularProgressIndicator());
              if (state is VideoError) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(state.message, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => ctx.read<VideoBloc>().add(LoadVideos()),
                  icon: const Icon(Icons.refresh), label: const Text('Tekrar Dene'),
                ),
              ]));

              final all = state is VideosLoaded ? state.videos : <VideoContentEntity>[];
              final filtered = _byTab(all);

              if (filtered.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.video_library_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text(_searchQuery.isNotEmpty ? '"$_searchQuery" için sonuç bulunamadı' : 'Bu kategoride video yok',
                    style: TextStyle(color: Colors.grey[500])),
                if (widget.isAdmin) ...[
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _showUploadDialog(context),
                    icon: const Icon(Icons.upload), label: const Text('Video Yükle'),
                  ),
                ]
              ]));

              // Stats bar
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(children: [
                    Text('${filtered.length} video', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const Spacer(),
                    Text('${all.where((v) => v.status == VideoStatus.ready).length} hazır, ${all.where((v) => v.status == VideoStatus.processing).length} işleniyor',
                        style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                  ]),
                ),
                Expanded(child: _isGrid ? _buildGrid(filtered) : _buildList(filtered)),
              ]);
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildGrid(List<VideoContentEntity> videos) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 280,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: videos.length,
      itemBuilder: (_, i) => VideoCardWidget(
        video: videos[i],
        isAdmin: widget.isAdmin,
        onTap: () => _openPlayer(context, videos[i]),
        onLike: () => context.read<VideoBloc>().add(LikeVideo(videos[i].id)),
        onShare: () => _shareVideo(videos[i]),
        onDownload: () => _downloadVideo(videos[i]),
        onEdit: widget.isAdmin ? () => _showEditDialog(context, videos[i]) : null,
        onDelete: widget.isAdmin ? () => _confirmDelete(context, videos[i]) : null,
      ),
    );
  }

  Widget _buildList(List<VideoContentEntity> videos) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
      itemCount: videos.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) => VideoListTile(
        video: videos[i],
        onTap: () => _openPlayer(context, videos[i]),
        onDelete: widget.isAdmin ? () => _confirmDelete(context, videos[i]) : null,
      ),
    );
  }

  void _openPlayer(BuildContext context, VideoContentEntity video) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => _VideoPlayerPage(video: video)));
  }

  void _showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520, maxHeight: 680),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Video Yükle'),
              automaticallyImplyLeading: false,
              actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: VideoUploadWidget(
                onCancel: () => Navigator.pop(ctx),
                onUpload: (path, title, type, quality) {
                  Navigator.pop(ctx);
                  context.read<VideoBloc>().add(LoadVideos());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('"$title" yüklendi'), backgroundColor: Colors.green),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, VideoContentEntity video) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('"${video.title}" düzenleniyor')));
  }

  void _shareVideo(VideoContentEntity video) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('"${video.title}" paylaşıldı')));
  }

  void _downloadVideo(VideoContentEntity video) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('"${video.title}" indiriliyor')));
  }

  void _confirmDelete(BuildContext context, VideoContentEntity video) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
      title: const Text('Videoyu Sil?'),
      content: Text('"${video.title}" kalıcı olarak silinecek.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
        FilledButton.icon(
          onPressed: () {
            ctx.read<VideoBloc>().add(DeleteVideo(video.id));
            Navigator.pop(ctx);
          },
          icon: const Icon(Icons.delete), label: const Text('Sil'),
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    ));
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(builder: (ctx2, setModal) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('Filtrele', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            TextButton(onPressed: () { _clearFilters(); Navigator.pop(ctx); }, child: const Text('Temizle')),
            FilledButton(onPressed: () { setState(() {}); Navigator.pop(ctx); }, child: const Text('Uygula')),
          ]),
          const Divider(),
          const Text('Video Türü', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: VideoType.values.map((t) => FilterChip(
            label: Text(t.name, style: const TextStyle(fontSize: 12)),
            selected: _filterType == t,
            onSelected: (v) => setModal(() => _filterType = v ? t : null),
          )).toList()),
          const SizedBox(height: 12),
          const Text('Durum', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: VideoStatus.values.map((s) => FilterChip(
            label: Text(s.name, style: const TextStyle(fontSize: 12)),
            selected: _filterStatus == s,
            onSelected: (v) => setModal(() => _filterStatus = v ? s : null),
          )).toList()),
          const SizedBox(height: 12),
          const Text('Kalite', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: VideoQuality.values.map((q) => FilterChip(
            label: Text(q.name, style: const TextStyle(fontSize: 12)),
            selected: _filterQuality == q,
            onSelected: (v) => setModal(() => _filterQuality = v ? q : null),
          )).toList()),
          const SizedBox(height: 20),
        ]),
      )),
    );
  }

  void _clearFilters() => setState(() {
    _filterType = null; _filterStatus = null; _filterQuality = null;
    _filterPublic = null; _filterFeatured = null;
  });

  Widget _filterChip(String label, VoidCallback onRemove) => Chip(
    label: Text(label, style: const TextStyle(fontSize: 11)),
    deleteIcon: const Icon(Icons.close, size: 14),
    onDeleted: onRemove,
    visualDensity: VisualDensity.compact,
  );
}

// ── Full-page player ────────────────────────────────────────────
class _VideoPlayerPage extends StatelessWidget {
  final VideoContentEntity video;
  const _VideoPlayerPage({required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black, foregroundColor: Colors.white,
        title: Text(video.title, style: const TextStyle(fontSize: 14)),
      ),
      body: Column(children: [
        VideoPlayerWidget(videoUrl: video.filePath, thumbnailUrl: video.thumbnailPath, video: video, autoPlay: true),
        Expanded(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(video.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(children: [
                  _badge(video.type.name, Colors.blue),
                  const SizedBox(width: 8),
                  _badge(video.quality.name, Colors.teal),
                  const SizedBox(width: 8),
                  _badge(video.format.name, Colors.purple),
                  const Spacer(),
                  Icon(Icons.visibility, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text('${video.viewCount}', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  const SizedBox(width: 12),
                  Icon(Icons.favorite, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text('${video.likeCount}', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ]),
                if (video.description?.isNotEmpty == true) ...[
                  const SizedBox(height: 12),
                  Text(video.description!, style: TextStyle(color: Colors.grey[700])),
                ],
                if (video.tags.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, children: video.tags.map((t) => Chip(
                    label: Text('#$t', style: const TextStyle(fontSize: 11)),
                    visualDensity: VisualDensity.compact,
                  )).toList()),
                ],
                const SizedBox(height: 12),
                // Technical info
                _infoRow(Icons.timer, 'Süre', '${video.duration ~/ 60}d ${video.duration % 60}s'),
                _infoRow(Icons.aspect_ratio, 'Çözünürlük', '${video.width}×${video.height}'),
                _infoRow(Icons.speed, 'Kare Hızı', '${video.frameRate.toStringAsFixed(1)} fps'),
                _infoRow(Icons.storage, 'Dosya Boyutu', '${(video.fileSize / (1024 * 1024)).toStringAsFixed(1)} MB'),
                if (video.publishedAt != null)
                  _infoRow(Icons.publish, 'Yayın Tarihi', video.publishedAt!.toString().substring(0, 10)),
              ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _badge(String t, Color c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: c.withOpacity(0.3))),
    child: Text(t, style: TextStyle(fontSize: 11, color: c, fontWeight: FontWeight.w600)),
  );

  Widget _infoRow(IconData icon, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Icon(icon, size: 16, color: Colors.grey),
      const SizedBox(width: 8),
      Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      const Spacer(),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
    ]),
  );
}
