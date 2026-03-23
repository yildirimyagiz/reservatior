import 'package:flutter/material.dart';
import '../../domain/entities/video_content_entity.dart';

// ── Video Card Widget ───────────────────────────────────────────
// Grid/list item. Thumbnail, status badge, duration, actions.

class VideoCardWidget extends StatelessWidget {
  final VideoContentEntity video;
  final VoidCallback onTap;
  final VoidCallback? onLike;
  final VoidCallback? onShare;
  final VoidCallback? onDownload;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final bool isAdmin;

  const VideoCardWidget({
    super.key,
    required this.video,
    required this.onTap,
    this.onLike,
    this.onShare,
    this.onDownload,
    this.onDelete,
    this.onEdit,
    this.isAdmin = false,
  });

  String _fmtDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return seconds >= 3600
        ? '${seconds ~/ 3600}:${((seconds % 3600) ~/ 60).toString().padLeft(2, '0')}:$s'
        : '$m:$s';
  }

  String _fmtSize(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Color _statusColor(VideoStatus s) {
    switch (s) {
      case VideoStatus.ready: return Colors.green;
      case VideoStatus.processing: return Colors.orange;
      case VideoStatus.failed: return Colors.red;
      case VideoStatus.archived: return Colors.blueGrey;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail ──
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  video.thumbnailPath != null
                      ? Image.network(video.thumbnailPath!, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholderThumb())
                      : _placeholderThumb(),
                  // Status badge
                  Positioned(
                    top: 8, left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _statusColor(video.status),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(video.status.name, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  // Duration badge
                  Positioned(
                    bottom: 8, right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(_fmtDuration(video.duration),
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  // Featured badge
                  if (video.isFeatured)
                    const Positioned(
                      top: 8, right: 8,
                      child: Icon(Icons.star, color: Colors.amber, size: 20),
                    ),
                  // Processing overlay
                  if (video.status == VideoStatus.processing)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black54,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          CircularProgressIndicator(value: video.processingProgress, color: Colors.white),
                          const SizedBox(height: 8),
                          Text('${(video.processingProgress * 100).toInt()}%',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                ],
              ),
            ),
            // ── Info ──
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(video.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 4),
                    Row(children: [
                      Icon(Icons.video_library, size: 12, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(video.type.name, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                      const Spacer(),
                      Text(_fmtSize(video.fileSize), style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                    ]),
                    const SizedBox(height: 4),
                    // Quality + format chips
                    Row(children: [
                      _chip(video.quality.name.toUpperCase(), Colors.blue),
                      const SizedBox(width: 4),
                      _chip(video.format.name.toUpperCase(), Colors.teal),
                    ]),
                    const Spacer(),
                    // Stats row
                    Row(children: [
                      Icon(Icons.visibility, size: 12, color: Colors.grey[400]),
                      const SizedBox(width: 2),
                      Text('${video.viewCount}', style: TextStyle(fontSize: 11, color: Colors.grey[400])),
                      const SizedBox(width: 8),
                      Icon(Icons.favorite, size: 12, color: Colors.grey[400]),
                      const SizedBox(width: 2),
                      Text('${video.likeCount}', style: TextStyle(fontSize: 11, color: Colors.grey[400])),
                      const Spacer(),
                      // Action menu
                      SizedBox(
                        width: 24, height: 24,
                        child: PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          onSelected: (v) {
                            if (v == 'like') onLike?.call();
                            if (v == 'share') onShare?.call();
                            if (v == 'download') onDownload?.call();
                            if (v == 'edit') onEdit?.call();
                            if (v == 'delete') onDelete?.call();
                          },
                          itemBuilder: (_) => [
                            const PopupMenuItem(value: 'like', child: ListTile(dense: true, leading: Icon(Icons.favorite_border), title: Text('Like'))),
                            const PopupMenuItem(value: 'share', child: ListTile(dense: true, leading: Icon(Icons.share), title: Text('Share'))),
                            const PopupMenuItem(value: 'download', child: ListTile(dense: true, leading: Icon(Icons.download), title: Text('Download'))),
                            if (isAdmin) const PopupMenuItem(value: 'edit', child: ListTile(dense: true, leading: Icon(Icons.edit), title: Text('Edit'))),
                            if (isAdmin) const PopupMenuItem(value: 'delete', child: ListTile(dense: true, leading: Icon(Icons.delete, color: Colors.red), title: Text('Delete', style: TextStyle(color: Colors.red)))),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderThumb() => Container(
    color: Colors.grey[200],
    child: const Center(child: Icon(Icons.video_library, size: 48, color: Colors.grey)),
  );

  Widget _chip(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color.withOpacity(0.3))),
    child: Text(label, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w600)),
  );
}

// ── Compact list version ─────────────────────────────────────────
class VideoListTile extends StatelessWidget {
  final VideoContentEntity video;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const VideoListTile({super.key, required this.video, required this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: SizedBox(
          width: 60, height: 45,
          child: video.thumbnailPath != null
              ? Image.network(video.thumbnailPath!, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: Colors.grey[200], child: const Icon(Icons.video_library, color: Colors.grey)))
              : Container(color: Colors.grey[200], child: const Icon(Icons.video_library, color: Colors.grey)),
        ),
      ),
      title: Text(video.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      subtitle: Text('${video.type.name} · ${video.duration ~/ 60}m ${video.duration % 60}s · ${video.status.name}',
          style: const TextStyle(fontSize: 11)),
      trailing: onDelete != null
          ? IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20), onPressed: onDelete)
          : const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }
}
