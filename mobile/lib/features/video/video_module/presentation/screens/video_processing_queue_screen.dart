import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/video_bloc.dart';
import '../../domain/entities/video_content_entity.dart';

// ── Video Processing Queue Screen ──────────────────────────────
// İşlem kuyruğu: bekleyen, işlenen, tamamlanan, hatalı videolar.

class VideoProcessingQueueScreen extends StatefulWidget {
  const VideoProcessingQueueScreen({super.key});

  @override
  State<VideoProcessingQueueScreen> createState() =>
      _VideoProcessingQueueScreenState();
}

class _VideoProcessingQueueScreenState
    extends State<VideoProcessingQueueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  Timer? _refreshTimer;
  bool _autoRefresh = true;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
    context.read<VideoBloc>().add(LoadVideos());
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_autoRefresh && mounted) {
        context.read<VideoBloc>().add(LoadVideos());
      }
    });
  }

  @override
  void dispose() {
    _tabs.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İşlem Kuyruğu'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(icon: Icon(Icons.queue, size: 18), text: 'Tümü'),
            Tab(icon: Icon(Icons.hourglass_top, size: 18), text: 'Bekliyor'),
            Tab(icon: Icon(Icons.sync, size: 18), text: 'İşleniyor'),
            Tab(icon: Icon(Icons.error_outline, size: 18), text: 'Hatalı'),
          ],
        ),
        actions: [
          // Auto-refresh toggle
          IconButton(
            icon: Icon(_autoRefresh ? Icons.pause_circle_outline : Icons.play_circle_outline),
            tooltip: _autoRefresh ? 'Otomatik yenilemeyi durdur' : 'Otomatik yenile',
            onPressed: () => setState(() => _autoRefresh = !_autoRefresh),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Yenile',
            onPressed: () => context.read<VideoBloc>().add(LoadVideos()),
          ),
        ],
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (ctx, state) {
          final all = state is VideosLoaded ? state.videos : <VideoContentEntity>[];
          final processing = all.where((v) => v.status == VideoStatus.processing).toList();
          final pending = all.where((v) => v.processingStage == ProcessingStage.uploaded &&
              v.status == VideoStatus.processing).toList();
          final failed = all.where((v) => v.status == VideoStatus.failed).toList();

          if (state is VideoLoading && all.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Queue stats bar
              _QueueStatsBar(
                total: all.length,
                processing: processing.length,
                pending: pending.length,
                failed: failed.length,
                completed: all.where((v) => v.status == VideoStatus.ready).length,
                autoRefresh: _autoRefresh,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabs,
                  children: [
                    _QueueList(videos: all, showAll: true),
                    _QueueList(videos: pending, emptyMsg: 'Bekleyen video yok'),
                    _QueueList(videos: processing, emptyMsg: 'İşlenen video yok'),
                    _QueueList(videos: failed, emptyMsg: 'Hatalı video yok', isError: true),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _QueueStatsBar extends StatelessWidget {
  final int total, processing, pending, failed, completed;
  final bool autoRefresh;
  const _QueueStatsBar({required this.total, required this.processing,
      required this.pending, required this.failed, required this.completed,
      required this.autoRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.grey[50],
      child: Row(children: [
        _Stat('Toplam', total, Colors.grey[700]!),
        _Stat('İşleniyor', processing, Colors.orange),
        _Stat('Bekliyor', pending, Colors.blue),
        _Stat('Hatalı', failed, Colors.red),
        _Stat('Hazır', completed, Colors.green),
        const Spacer(),
        if (autoRefresh) Row(children: [
          SizedBox(width: 12, height: 12, child: CircularProgressIndicator(
            strokeWidth: 2, color: Colors.orange[300])),
          const SizedBox(width: 6),
          Text('Canlı', style: TextStyle(fontSize: 11, color: Colors.orange[700], fontWeight: FontWeight.w600)),
        ]),
      ]),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _Stat(this.label, this.count, this.color);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(count.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    ),
  );
}

class _QueueList extends StatelessWidget {
  final List<VideoContentEntity> videos;
  final String emptyMsg;
  final bool showAll;
  final bool isError;

  const _QueueList({
    required this.videos,
    this.emptyMsg = 'Bu kategoride video yok',
    this.showAll = false,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(isError ? Icons.check_circle_outline : Icons.inbox_outlined,
            size: 56, color: isError ? Colors.green[300] : Colors.grey[350]),
        const SizedBox(height: 12),
        Text(emptyMsg, style: TextStyle(color: Colors.grey[500])),
      ]));
    }

    return RefreshIndicator(
      onRefresh: () async => context.read<VideoBloc>().add(LoadVideos()),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: videos.length,
        itemBuilder: (_, i) => _ProcessingCard(video: videos[i]),
      ),
    );
  }
}

class _ProcessingCard extends StatelessWidget {
  final VideoContentEntity video;
  const _ProcessingCard({required this.video});

  @override
  Widget build(BuildContext context) {
    final isProcessing = video.status == VideoStatus.processing;
    final isFailed = video.status == VideoStatus.failed;
    final isReady = video.status == VideoStatus.ready;

    Color statusColor = isProcessing ? Colors.orange
        : isFailed ? Colors.red
        : isReady ? Colors.green
        : Colors.grey;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Status indicator
                Container(
                  width: 10, height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: statusColor,
                    boxShadow: isProcessing ? [BoxShadow(color: statusColor.withOpacity(0.4), blurRadius: 6)] : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(video.title,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                // Stage chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(video.processingStage.name,
                      style: TextStyle(fontSize: 10, color: statusColor, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Progress bar (only when processing)
            if (isProcessing) ...[
              Row(children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: video.processingProgress,
                      minHeight: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(statusColor),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text('${(video.processingProgress * 100).toInt()}%',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: statusColor)),
              ]),
              const SizedBox(height: 8),
            ],

            // Error message
            if (isFailed && video.errorMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(video.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 12))),
                ]),
              ),

            // Meta info row
            Row(children: [
              _MetaChip(video.type.name, Icons.category),
              const SizedBox(width: 8),
              _MetaChip(video.quality.name, Icons.high_quality),
              const SizedBox(width: 8),
              _MetaChip('${(video.fileSize / (1024 * 1024)).toStringAsFixed(1)} MB', Icons.storage),
              const Spacer(),
              // Actions
              if (isFailed) TextButton.icon(
                onPressed: () => context.read<VideoBloc>().add(ProcessVideo(video.id, [])),
                icon: const Icon(Icons.replay, size: 16),
                label: const Text('Yeniden Dene', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(foregroundColor: Colors.orange, padding: EdgeInsets.zero),
              ),
              if (isReady) const Icon(Icons.check_circle, color: Colors.green, size: 20),
            ]),

            // Stages timeline
            const SizedBox(height: 10),
            _StagesTimeline(current: video.processingStage, status: video.status),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _MetaChip(this.label, this.icon);
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 12, color: Colors.grey[500]),
    const SizedBox(width: 3),
    Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
  ]);
}

class _StagesTimeline extends StatelessWidget {
  final ProcessingStage current;
  final VideoStatus status;
  const _StagesTimeline({required this.current, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ProcessingStage.values.asMap().entries.map((e) {
        final stage = e.value;
        final isDone = stage.index < current.index ||
            (stage == current && status == VideoStatus.ready);
        final isCurrent = stage == current && status == VideoStatus.processing;
        final isFailed = stage == current && status == VideoStatus.failed;

        Color color = isDone ? Colors.green
            : isCurrent ? Colors.orange
            : isFailed ? Colors.red
            : Colors.grey[300]!;

        return Expanded(child: Row(children: [
          Expanded(child: Container(
            height: 3,
            color: e.key == 0 ? Colors.transparent : color,
          )),
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ]));
      }).toList(),
    );
  }
}
