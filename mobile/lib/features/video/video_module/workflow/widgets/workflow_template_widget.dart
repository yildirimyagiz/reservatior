import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/video_bloc.dart';
import '../../domain/entities/video_content_entity.dart';
import 'video_card_widget.dart';

// ══════════════════════════════════════════════════════════════
// VIDEO SEARCH WIDGET
// Tam metin + tag + tür + durum filtreli arama.
// ══════════════════════════════════════════════════════════════

class VideoSearchWidget extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String query)? onSearch;
  final void Function(VideoContentEntity)? onVideoTap;
  final bool showResults;

  const VideoSearchWidget({
    super.key,
    this.controller,
    this.onSearch,
    this.onVideoTap,
    this.showResults = true,
  });

  @override
  State<VideoSearchWidget> createState() => _VideoSearchWidgetState();
}

class _VideoSearchWidgetState extends State<VideoSearchWidget> {
  late final TextEditingController _ctrl;
  final FocusNode _focus = FocusNode();
  bool _showSuggestions = false;
  String _query = '';

  VideoType? _typeFilter;
  VideoStatus? _statusFilter;
  VideoQuality? _qualityFilter;

  static const _popularTags = [
    'emlak', 'villa', 'daire', 'tanıtım', 'tur', 'mimari',
    'lüks', 'bahçe', 'deniz', 'şehir', 'modern', 'satılık',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = widget.controller ?? TextEditingController();
    _focus.addListener(() {
      if (mounted) setState(() => _showSuggestions = _focus.hasFocus && _query.isEmpty);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _search(String q) {
    setState(() { _query = q; _showSuggestions = false; });
    widget.onSearch?.call(q);
    context.read<VideoBloc>().add(SearchVideos(q));
  }

  void _applyFilters() {
    // Rebuild filtered search
    _search(_query);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        Row(children: [
          Expanded(
            child: TextField(
              controller: _ctrl,
              focusNode: _focus,
              decoration: InputDecoration(
                hintText: 'Video ara… başlık, tag, tür',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () { _ctrl.clear(); _search(''); })
                    : null,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (v) {
                setState(() { _query = v; _showSuggestions = v.isEmpty; });
                if (v.length >= 2) _search(v);
              },
              onSubmitted: _search,
            ),
          ),
          const SizedBox(width: 8),
          IconButton.outlined(
            icon: Stack(children: [
              const Icon(Icons.filter_list),
              if (_typeFilter != null || _statusFilter != null || _qualityFilter != null)
                Positioned(
                  top: 0, right: 0,
                  child: Container(width: 6, height: 6,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                ),
            ]),
            onPressed: () => _showFilterSheet(context),
            tooltip: 'Filtrele',
          ),
        ]),

        // Active filter chips
        if (_typeFilter != null || _statusFilter != null || _qualityFilter != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Wrap(spacing: 8, children: [
              if (_typeFilter != null) Chip(
                label: Text(_typeFilter!.name, style: const TextStyle(fontSize: 11)),
                deleteIcon: const Icon(Icons.close, size: 14),
                onDeleted: () { setState(() => _typeFilter = null); _applyFilters(); },
                visualDensity: VisualDensity.compact,
              ),
              if (_statusFilter != null) Chip(
                label: Text(_statusFilter!.name, style: const TextStyle(fontSize: 11)),
                deleteIcon: const Icon(Icons.close, size: 14),
                onDeleted: () { setState(() => _statusFilter = null); _applyFilters(); },
                visualDensity: VisualDensity.compact,
              ),
              if (_qualityFilter != null) Chip(
                label: Text(_qualityFilter!.name, style: const TextStyle(fontSize: 11)),
                deleteIcon: const Icon(Icons.close, size: 14),
                onDeleted: () { setState(() => _qualityFilter = null); _applyFilters(); },
                visualDensity: VisualDensity.compact,
              ),
            ]),
          ),

        // Quick tag suggestions
        if (_showSuggestions) ...[
          const SizedBox(height: 12),
          const Text('Popüler Etiketler', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: _popularTags.map((tag) => ActionChip(
            label: Text('#$tag', style: const TextStyle(fontSize: 12)),
            onPressed: () => _search(tag),
            visualDensity: VisualDensity.compact,
          )).toList()),
        ],

        // Search results
        if (widget.showResults && _query.isNotEmpty)
          BlocBuilder<VideoBloc, VideoState>(
            builder: (ctx, state) {
              if (state is VideoLoading) return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              );

              List<VideoContentEntity> results = [];
              if (state is VideosSearchLoaded) results = state.videos;
              if (state is VideosLoaded) {
                results = state.videos.where((v) =>
                    v.title.toLowerCase().contains(_query.toLowerCase()) ||
                    (v.description?.toLowerCase().contains(_query.toLowerCase()) ?? false) ||
                    v.tags.any((t) => t.toLowerCase().contains(_query.toLowerCase()))
                ).toList();
                if (_typeFilter != null) results = results.where((v) => v.type == _typeFilter).toList();
                if (_statusFilter != null) results = results.where((v) => v.status == _statusFilter).toList();
                if (_qualityFilter != null) results = results.where((v) => v.quality == _qualityFilter).toList();
              }

              if (results.isEmpty) return Padding(
                padding: const EdgeInsets.all(24),
                child: Center(child: Text('"$_query" için sonuç bulunamadı',
                    style: TextStyle(color: Colors.grey[500]))),
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text('${results.length} sonuç bulundu',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  ...results.take(5).map((v) => VideoListTile(
                    video: v,
                    onTap: () => widget.onVideoTap?.call(v),
                  )),
                  if (results.length > 5)
                    TextButton(
                      onPressed: () {},
                      child: Text('${results.length - 5} sonuç daha gör'),
                    ),
                ],
              );
            },
          ),
      ],
    );
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
            TextButton(onPressed: () {
              setState(() { _typeFilter = null; _statusFilter = null; _qualityFilter = null; });
              _applyFilters(); Navigator.pop(ctx);
            }, child: const Text('Temizle')),
            FilledButton(onPressed: () { setState(() {}); _applyFilters(); Navigator.pop(ctx); },
                child: const Text('Uygula')),
          ]),
          const Divider(),
          const Text('Video Türü', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 6, children: VideoType.values.map((t) => FilterChip(
            label: Text(t.name, style: const TextStyle(fontSize: 12)),
            selected: _typeFilter == t,
            onSelected: (v) { setModal(() => _typeFilter = v ? t : null); },
          )).toList()),
          const SizedBox(height: 12),
          const Text('Durum', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 6, children: VideoStatus.values.map((s) => FilterChip(
            label: Text(s.name, style: const TextStyle(fontSize: 12)),
            selected: _statusFilter == s,
            onSelected: (v) { setModal(() => _statusFilter = v ? s : null); },
          )).toList()),
          const SizedBox(height: 12),
          const Text('Kalite', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 6, children: VideoQuality.values.map((q) => FilterChip(
            label: Text(q.name, style: const TextStyle(fontSize: 12)),
            selected: _qualityFilter == q,
            onSelected: (v) { setModal(() => _qualityFilter = v ? q : null); },
          )).toList()),
          const SizedBox(height: 20),
        ]),
      )),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// WORKFLOW TEMPLATE WIDGET
// Hazır iş akışı şablonları — tek tıkla oluştur.
// ══════════════════════════════════════════════════════════════

class WorkflowTemplateWidget extends StatelessWidget {
  final void Function(WorkflowTemplate template)? onSelect;

  const WorkflowTemplateWidget({super.key, this.onSelect});

  static const _templates = [
    WorkflowTemplate(
      id: 'new_booking_notify',
      name: 'Yeni Rezervasyon Bildirimi',
      description: 'Rezervasyon oluşturulduğunda ev sahibine ve misafire e-posta gönder.',
      category: 'Rezervasyon',
      icon: Icons.event_available,
      color: Colors.teal,
      trigger: 'on_create (Booking)',
      actions: ['E-posta Gönder → Ev Sahibi', 'E-posta Gönder → Misafir', 'Görev Oluştur'],
      popularity: 89,
    ),
    WorkflowTemplate(
      id: 'payment_overdue',
      name: 'Gecikmiş Ödeme Uyarısı',
      description: 'Ödeme vadesi geçtiğinde kiracıya SMS + e-posta gönder.',
      category: 'Finans',
      icon: Icons.payment,
      color: Colors.orange,
      trigger: 'on_date_reached (Payment.dueDate)',
      actions: ['SMS Gönder', 'E-posta Gönder', 'Görev Oluştur → Takip'],
      popularity: 94,
    ),
    WorkflowTemplate(
      id: 'lease_expiry',
      name: 'Kira Sözleşmesi Yenileme',
      description: '60 gün önce kiracıya yenileme teklifi gönder.',
      category: 'Kiralama',
      icon: Icons.description,
      color: Colors.purple,
      trigger: 'on_date_reached (Lease.endDate - 60d)',
      actions: ['E-posta Gönder → Yenileme Teklifi', 'Görev Oluştur → Agent'],
      popularity: 82,
    ),
    WorkflowTemplate(
      id: 'maintenance_request',
      name: 'Bakım Talebi İşleme',
      description: 'Bakım talebi geldiğinde teknik ekibe ata ve bildir.',
      category: 'Bakım',
      icon: Icons.build,
      color: Colors.amber,
      trigger: 'on_create (MaintenanceWorkOrder)',
      actions: ['Kullanıcı Ata → Teknik', 'Bildirim Gönder', 'Durum Güncelle → pending'],
      popularity: 78,
    ),
    WorkflowTemplate(
      id: 'lead_followup',
      name: 'Lead Takip Otomasyonu',
      description: 'Yeni lead geldiğinde 24 saat içinde agent ata ve hatırlatıcı kur.',
      category: 'CRM',
      icon: Icons.person_add,
      color: Colors.blue,
      trigger: 'on_create (Lead)',
      actions: ['Kullanıcı Ata → Agent', 'Görev Oluştur → 24h', 'E-posta Gönder → Lead'],
      popularity: 91,
    ),
    WorkflowTemplate(
      id: 'contract_signed',
      name: 'Sözleşme İmzalandı',
      description: 'İmza tamamlandığında ilgili tüm taraflara bildir ve dosyaları oluştur.',
      category: 'Sözleşme',
      icon: Icons.draw,
      color: Colors.indigo,
      trigger: 'on_update (Contract.status = signed)',
      actions: ['E-posta Gönder → Tüm Taraflar', 'Görev Oluştur → Kayıt', 'Webhook → Muhasebe'],
      popularity: 76,
    ),
    WorkflowTemplate(
      id: 'ai_video_ready',
      name: 'AI Video Hazır',
      description: 'AI video işlemi tamamlandığında otomatik yayınla ve bildir.',
      category: 'Video',
      icon: Icons.video_library,
      color: Colors.deepPurple,
      trigger: 'on_update (VideoContent.status = ready)',
      actions: ['Durum Güncelle → published', 'Bildirim Gönder', 'Webhook → İlan Sistemi'],
      popularity: 68,
    ),
    WorkflowTemplate(
      id: 'review_request',
      name: 'Değerlendirme İsteği',
      description: 'Check-out\'tan 2 gün sonra misafire değerlendirme e-postası gönder.',
      category: 'Misafir',
      icon: Icons.star_rate,
      color: Colors.amber,
      trigger: 'on_date_reached (Booking.endDate + 2d)',
      actions: ['Bekleme → 2 gün', 'E-posta Gönder → Değerlendirme'],
      popularity: 85,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Group by category
    final Map<String, List<WorkflowTemplate>> byCategory = {};
    for (final t in _templates) {
      byCategory.putIfAbsent(t.category, () => []).add(t);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        const Text('Hazır Şablonlar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('Tek tıkla iş akışı oluşturun — özelleştirilebilir',
            style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        const SizedBox(height: 16),

        // Popularity sorting hint
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.07),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            const Icon(Icons.trending_up, color: Colors.blue, size: 16),
            const SizedBox(width: 8),
            const Text('En çok kullanılan şablonlar öne alındı',
                style: TextStyle(fontSize: 12)),
          ]),
        ),
        const SizedBox(height: 16),

        // Templates by category
        ...byCategory.entries.map((entry) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.key, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            ...entry.value.map((t) => _TemplateCard(template: t, onSelect: onSelect)),
            const SizedBox(height: 16),
          ],
        )),
      ],
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final WorkflowTemplate template;
  final void Function(WorkflowTemplate)? onSelect;

  const _TemplateCard({required this.template, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showPreview(context),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: template.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(template.icon, color: template.color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(template.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(template.description, style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
              ])),
              // Popularity
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.favorite, size: 12, color: Colors.red),
                  const SizedBox(width: 3),
                  Text('${template.popularity}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ]),
              ]),
            ]),
            const SizedBox(height: 10),
            // Trigger
            Row(children: [
              const Icon(Icons.bolt, size: 14, color: Colors.orange),
              const SizedBox(width: 4),
              Expanded(child: Text(template.trigger,
                  style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                  overflow: TextOverflow.ellipsis)),
            ]),
            const SizedBox(height: 6),
            // Actions preview
            Wrap(spacing: 6, children: template.actions.take(3).map((a) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.withOpacity(0.25)),
              ),
              child: Text(a, style: const TextStyle(fontSize: 10, color: Colors.green)),
            )).toList()),
          ]),
        ),
      ),
    );
  }

  void _showPreview(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: template.color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
              child: Icon(template.icon, color: template.color, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(template.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(template.category, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ])),
          ]),
          const SizedBox(height: 14),
          Text(template.description, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 16),
          const Text('Tetikleyici', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.orange.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
            child: Row(children: [
              const Icon(Icons.bolt, color: Colors.orange, size: 16),
              const SizedBox(width: 8),
              Expanded(child: Text(template.trigger, style: const TextStyle(fontFamily: 'monospace', fontSize: 13))),
            ]),
          ),
          const SizedBox(height: 12),
          const Text('Aksiyonlar', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          ...template.actions.asMap().entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(children: [
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: Center(child: Text('${e.key + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 10),
              Text(e.value, style: const TextStyle(fontSize: 13)),
            ]),
          )),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: OutlinedButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('İptal'),
            )),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: FilledButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                onSelect?.call(template);
              },
              icon: const Icon(Icons.rocket_launch, size: 16),
              label: const Text('Bu Şablonu Kullan'),
              style: FilledButton.styleFrom(backgroundColor: template.color),
            )),
          ]),
        ]),
      ),
    );
  }
}

class WorkflowTemplate {
  final String id, name, description, category, trigger;
  final IconData icon;
  final Color color;
  final List<String> actions;
  final int popularity;

  const WorkflowTemplate({
    required this.id, required this.name, required this.description,
    required this.category, required this.icon, required this.color,
    required this.trigger, required this.actions, required this.popularity,
  });
}
