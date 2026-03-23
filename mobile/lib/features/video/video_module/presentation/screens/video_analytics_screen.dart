import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/video_bloc.dart';
import '../../domain/entities/video_content_entity.dart';

// ── Video Analytics Screen ──────────────────────────────────────
// Tek video veya tüm kütüphane analitiği: izlenme, süre, etkileşim.

class VideoAnalyticsScreen extends StatefulWidget {
  final VideoContentEntity? video; // null → genel kütüphane analitiği
  const VideoAnalyticsScreen({super.key, this.video});

  @override
  State<VideoAnalyticsScreen> createState() => _VideoAnalyticsScreenState();
}

class _VideoAnalyticsScreenState extends State<VideoAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  String _period = '7d';
  final List<String> _periods = ['24h', '7d', '30d', '90d', 'all'];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: widget.video != null ? 4 : 3, vsync: this);
    if (widget.video != null) {
      context.read<VideoBloc>().add(GetVideoAnalytics(widget.video!.id));
    }
  }

  @override
  void dispose() { _tabs.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final title = widget.video != null
        ? '"${widget.video!.title}" Analitiği'
        : 'Video Kütüphanesi Analitiği';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            const Tab(text: 'Genel Bakış'),
            const Tab(text: 'İzlenme'),
            const Tab(text: 'Etkileşim'),
            if (widget.video != null) const Tab(text: 'İşlem Geçmişi'),
          ],
        ),
        actions: [
          // Period selector
          PopupMenuButton<String>(
            initialValue: _period,
            onSelected: (v) => setState(() => _period = v),
            icon: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(_period, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const Icon(Icons.arrow_drop_down, size: 20),
            ]),
            itemBuilder: (_) => _periods.map((p) => PopupMenuItem(
              value: p,
              child: Text(p),
            )).toList(),
          ),
        ],
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (ctx, state) {
          final isLoading = state is VideoLoading;
          return TabBarView(
            controller: _tabs,
            children: [
              _OverviewTab(video: widget.video, period: _period, isLoading: isLoading),
              _ViewsTab(video: widget.video, period: _period),
              _EngagementTab(video: widget.video),
              if (widget.video != null) _ProcessingTab(video: widget.video!),
            ],
          );
        },
      ),
    );
  }
}

// ── Overview Tab ───────────────────────────────────────────────
class _OverviewTab extends StatelessWidget {
  final VideoContentEntity? video;
  final String period;
  final bool isLoading;
  const _OverviewTab({this.video, required this.period, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.6,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _KpiCard(
                label: 'Toplam İzlenme',
                value: _fmt(video?.viewCount ?? 0),
                icon: Icons.visibility,
                color: Colors.blue,
                trend: '+12%',
                trendUp: true,
              ),
              _KpiCard(
                label: 'Toplam Beğeni',
                value: _fmt(video?.likeCount ?? 0),
                icon: Icons.favorite,
                color: Colors.red,
                trend: '+8%',
                trendUp: true,
              ),
              _KpiCard(
                label: 'Yorumlar',
                value: _fmt(video?.commentCount ?? 0),
                icon: Icons.comment,
                color: Colors.orange,
                trend: '+3%',
                trendUp: true,
              ),
              _KpiCard(
                label: 'Paylaşımlar',
                value: '—',
                icon: Icons.share,
                color: Colors.teal,
                trend: '—',
                trendUp: true,
              ),
              _KpiCard(
                label: 'Tamamlanma Oranı',
                value: '—',
                icon: Icons.check_circle_outline,
                color: Colors.green,
                trend: '—',
                trendUp: true,
              ),
              _KpiCard(
                label: 'Ort. İzleme Süresi',
                value: '—',
                icon: Icons.timer_outlined,
                color: Colors.purple,
                trend: '—',
                trendUp: false,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Video info if single
          if (video != null) ...[
            _SectionHeader('Video Bilgileri'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  _InfoRow('Başlık', video!.title),
                  _InfoRow('Tür', video!.type.name),
                  _InfoRow('Durum', video!.status.name),
                  _InfoRow('Kalite', video!.quality.name),
                  _InfoRow('Format', video!.format.name),
                  _InfoRow('Süre', _fmtDur(video!.duration)),
                  _InfoRow('Dosya Boyutu', _fmtSize(video!.fileSize)),
                  _InfoRow('Çözünürlük', '${video!.width}×${video!.height}'),
                  _InfoRow('İşlem Aşaması', video!.processingStage.name),
                  if (video!.publishedAt != null)
                    _InfoRow('Yayın Tarihi', video!.publishedAt!.toString().substring(0, 10)),
                ]),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Top content summary
          _SectionHeader('İçerik Performansı'),
          _PerformanceBar(label: 'İzlenme', value: 0.72, color: Colors.blue),
          _PerformanceBar(label: 'Beğeni Oranı', value: 0.45, color: Colors.red),
          _PerformanceBar(label: 'Tamamlanma', value: 0.63, color: Colors.green),
          _PerformanceBar(label: 'Paylaşım', value: 0.21, color: Colors.teal),
        ],
      ),
    );
  }

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return n.toString();
  }

  String _fmtDur(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  String _fmtSize(int b) => '${(b / (1024 * 1024)).toStringAsFixed(1)} MB';
}

// ── Views Tab ─────────────────────────────────────────────────
class _ViewsTab extends StatelessWidget {
  final VideoContentEntity? video;
  final String period;
  const _ViewsTab({this.video, required this.period});

  @override
  Widget build(BuildContext context) {
    // Simulated daily data
    final days = List.generate(7, (i) => 100 + (i * 47) % 200);
    final maxVal = days.reduce((a, b) => a > b ? a : b).toDouble();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader('Günlük İzlenme Trendi'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Son $period', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 160,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: days.asMap().entries.map((e) {
                        final ratio = e.value / maxVal;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${e.value}', style: const TextStyle(fontSize: 9, color: Colors.grey)),
                                const SizedBox(height: 2),
                                Container(
                                  height: 120 * ratio,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.blue[700]!, Colors.blue[400]!],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text('G${e.key + 1}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionHeader('İzlenme Kaynakları'),
          Card(
            child: Column(children: [
              _SourceRow('Organik Arama', 0.42, Colors.blue),
              _SourceRow('Doğrudan Bağlantı', 0.28, Colors.teal),
              _SourceRow('Sosyal Medya', 0.18, Colors.orange),
              _SourceRow('Gömülü', 0.12, Colors.purple),
            ]),
          ),
          const SizedBox(height: 16),
          _SectionHeader('İzleyici Konumları'),
          Card(
            child: Column(children: [
              _LocationRow('🇹🇷', 'Türkiye', 0.58),
              _LocationRow('🇩🇪', 'Almanya', 0.15),
              _LocationRow('🇬🇧', 'İngiltere', 0.12),
              _LocationRow('🇺🇸', 'ABD', 0.08),
              _LocationRow('🌍', 'Diğer', 0.07),
            ]),
          ),
        ],
      ),
    );
  }
}

// ── Engagement Tab ─────────────────────────────────────────────
class _EngagementTab extends StatelessWidget {
  final VideoContentEntity? video;
  const _EngagementTab({this.video});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader('Etkileşim Özeti'),
          Row(children: [
            Expanded(child: _MetricTile('Beğeni Oranı', '—', Icons.favorite, Colors.red)),
            const SizedBox(width: 12),
            Expanded(child: _MetricTile('Yorum Oranı', '—', Icons.comment, Colors.orange)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _MetricTile('Paylaşım Oranı', '—', Icons.share, Colors.teal)),
            const SizedBox(width: 12),
            Expanded(child: _MetricTile('Tamamlanma', '—', Icons.check_circle, Colors.green)),
          ]),
          const SizedBox(height: 24),
          _SectionHeader('İzleme Süresi Dağılımı'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                _WatchSegment('0-25%', 0.15, Colors.red[300]!),
                _WatchSegment('25-50%', 0.22, Colors.orange[300]!),
                _WatchSegment('50-75%', 0.31, Colors.blue[300]!),
                _WatchSegment('75-100%', 0.32, Colors.green[300]!),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          _SectionHeader('Cihaz Dağılımı'),
          Card(
            child: Column(children: [
              _DeviceRow(Icons.phone_android, 'Mobil', 0.62),
              _DeviceRow(Icons.tablet_mac, 'Tablet', 0.18),
              _DeviceRow(Icons.laptop, 'Masaüstü', 0.20),
            ]),
          ),
        ],
      ),
    );
  }
}

// ── Processing Tab ────────────────────────────────────────────
class _ProcessingTab extends StatelessWidget {
  final VideoContentEntity video;
  const _ProcessingTab({required this.video});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader('İşlem Durumu'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    _statusIcon(video.status),
                    const SizedBox(width: 12),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(video.status.name.toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(video.processingStage.name,
                            style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                      ],
                    )),
                    Text('${(video.processingProgress * 100).toInt()}%',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ]),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: video.processingProgress,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                    backgroundColor: Colors.grey[200],
                  ),
                  if (video.errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Row(children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Text(video.errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 13))),
                      ]),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionHeader('İşlem Aşamaları'),
          Card(
            child: Column(
              children: ProcessingStage.values.map((s) {
                final isDone = s.index < video.processingStage.index;
                final isCurrent = s == video.processingStage;
                return ListTile(
                  dense: true,
                  leading: Icon(
                    isDone ? Icons.check_circle : isCurrent ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: isDone ? Colors.green : isCurrent ? Colors.blue : Colors.grey[350],
                    size: 20,
                  ),
                  title: Text(s.name, style: TextStyle(
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isDone ? Colors.grey[600] : isCurrent ? Colors.black : Colors.grey[400],
                  )),
                  trailing: isCurrent ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : null,
                );
              }).toList(),
            ),
          ),
          if (video.loraConfig != null) ...[
            const SizedBox(height: 16),
            _SectionHeader('LoRA Konfigürasyonu'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  _InfoRow('Model Adı', video.loraConfig!.name),
                  _InfoRow('Tür', video.loraConfig!.type.name),
                  _InfoRow('Güç', video.loraConfig!.strength.toStringAsFixed(2)),
                  _InfoRow('Adımlar', video.loraConfig!.steps.toString()),
                  _InfoRow('Öğrenme Hızı', video.loraConfig!.learningRate.toString()),
                  if (video.loraConfig!.triggerWord != null)
                    _InfoRow('Tetikleyici Kelime', video.loraConfig!.triggerWord!),
                ]),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _statusIcon(VideoStatus s) {
    switch (s) {
      case VideoStatus.ready: return const Icon(Icons.check_circle, color: Colors.green, size: 32);
      case VideoStatus.processing: return const SizedBox(width: 32, height: 32, child: CircularProgressIndicator(strokeWidth: 3));
      case VideoStatus.failed: return const Icon(Icons.error, color: Colors.red, size: 32);
      default: return const Icon(Icons.hourglass_empty, color: Colors.grey, size: 32);
    }
  }
}

// ── Shared helpers ─────────────────────────────────────────────

class _KpiCard extends StatelessWidget {
  final String label, value, trend;
  final IconData icon;
  final Color color;
  final bool trendUp;

  const _KpiCard({required this.label, required this.value, required this.icon,
      required this.color, required this.trend, required this.trendUp});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, color: color, size: 18),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: (trendUp ? Colors.green : Colors.red).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(trend,
                  style: TextStyle(fontSize: 10, color: trendUp ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600)),
            ),
          ]),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ]),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
  );
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow(this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      SizedBox(width: 140, child: Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13))),
      Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
    ]),
  );
}

class _PerformanceBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _PerformanceBar({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(children: [
      SizedBox(width: 120, child: Text(label, style: const TextStyle(fontSize: 13))),
      Expanded(child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(value: value, minHeight: 8, backgroundColor: Colors.grey[200], color: color),
      )),
      const SizedBox(width: 8),
      Text('${(value * 100).toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _SourceRow extends StatelessWidget {
  final String label;
  final double pct;
  final Color color;
  const _SourceRow(this.label, this.pct, this.color);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 10),
      Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
      Text('${(pct * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    ]),
  );
}

class _LocationRow extends StatelessWidget {
  final String flag, country;
  final double pct;
  const _LocationRow(this.flag, this.country, this.pct);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(children: [
      Text(flag, style: const TextStyle(fontSize: 20)),
      const SizedBox(width: 10),
      Expanded(child: Text(country, style: const TextStyle(fontSize: 13))),
      Text('${(pct * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    ]),
  );
}

class _MetricTile extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _MetricTile(this.label, this.value, this.icon, this.color);
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      Icon(icon, color: color, size: 28),
      const SizedBox(height: 8),
      Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600]), textAlign: TextAlign.center),
    ])),
  );
}

class _WatchSegment extends StatelessWidget {
  final String label;
  final double pct;
  final Color color;
  const _WatchSegment(this.label, this.pct, this.color);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(children: [
      SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 12))),
      Expanded(child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(value: pct, minHeight: 12, backgroundColor: Colors.grey[200], color: color),
      )),
      const SizedBox(width: 8),
      Text('${(pct * 100).toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _DeviceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final double pct;
  const _DeviceRow(this.icon, this.label, this.pct);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(children: [
      Icon(icon, size: 20, color: Colors.grey[600]),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          const Spacer(),
          Text('${(pct * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ]),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(value: pct, minHeight: 5, backgroundColor: Colors.grey[200], color: Colors.blue),
        ),
      ])),
    ]),
  );
}
