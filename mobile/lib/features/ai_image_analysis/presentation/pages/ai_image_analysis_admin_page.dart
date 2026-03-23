import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_image_analysis_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIImageAnalysis Admin Page  |  14 fields
// Auto-generated — edit with care
// ================================================================

class AIImageAnalysisAdminPage extends ConsumerWidget {
  const AIImageAnalysisAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiImageAnalysisLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Image Analysis Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiImageAnalysisListProvider)),
        ],
      ),
      body: const _AIImageAnalysisBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIImageAnalysisFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Image Analysis'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIImageAnalysisBody extends ConsumerStatefulWidget {
  const _AIImageAnalysisBody();
  @override ConsumerState<_AIImageAnalysisBody> createState() => __AIImageAnalysisBodyState();
}

class __AIImageAnalysisBodyState extends ConsumerState<_AIImageAnalysisBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiImageAnalysisListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Image Analysiss…',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _q.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _ctrl.clear(); setState(() => _q = ''); })
                : null,
            border: const OutlineInputBorder(), isDense: true,
          ),
          onChanged: (v) => setState(() => _q = v.toLowerCase()),
        ),
      ),
      Expanded(child: async.when(
        data: (items) {
          final list = _q.isEmpty
              ? items
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.photoId?.toString() ?? '') + " " + (item.analysisType?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Image Analysiss yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiImageAnalysisListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.analysisType != null && item.analysisType!.toString().isNotEmpty ? item.analysisType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.analysisType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                      IconButton(icon: const Icon(Icons.edit_outlined, size: 20), tooltip: 'Edit',
                          onPressed: () => _showForm(context, ref, item: item)),
                      IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20), tooltip: 'Delete',
                          onPressed: () => _confirmDel(context, ref, item)),
                    ]),
                    onTap: () => _showDetail(context, item),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          SelectableText('$e', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiImageAnalysisListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIImageAnalysis item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Image Analysis Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Photo Id', item.photoId?.toString() ?? 'N/A', Icons.link),
              _row('Analysis Type', item.analysisType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Detected Rooms', item.detectedRooms?.toString() ?? 'N/A', Icons.text_fields),
              _row('Quality Score', item.qualityScore?.toString() ?? 'N/A', Icons.numbers),
              _row('Style Tags', item.styleTags?.toString() ?? 'N/A', Icons.text_fields),
              _row('Color Palette', item.colorPalette?.toString() ?? 'N/A', Icons.text_fields),
              _row('Lighting Quality', item.lightingQuality?.toString() ?? 'N/A', Icons.numbers),
              _row('Recommendations', item.recommendations?.toString() ?? 'N/A', Icons.text_fields),
              _row('Analyzed At', _formatDate(item.analyzedAt), Icons.calendar_today),
              _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
          ]),
        ),
      ),
    ),
  ));
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value),
    ])),
  ]),
);

// ─── Form Dialog ─────────────────────────────────────────────────

void _showForm(BuildContext context, WidgetRef ref, {AIImageAnalysis? item}) {
  showDialog(context: context, builder: (ctx) => _AIImageAnalysisForm(item: item, ref: ref));
}

class _AIImageAnalysisForm extends ConsumerStatefulWidget {
  final AIImageAnalysis? item;
  final WidgetRef ref;
  const _AIImageAnalysisForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIImageAnalysisForm> createState() => __AIImageAnalysisFormState();
}

class __AIImageAnalysisFormState extends ConsumerState<_AIImageAnalysisForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _photoId;
  String? _analysisType;
  String? _detectedRooms;
  double? _qualityScore;
  String? _styleTags;
  String? _colorPalette;
  double? _lightingQuality;
  String? _recommendations;
  DateTime? _analyzedAt;
  double? _confidence;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _photoId = widget.item?.photoId?.toString();
    _analysisType = widget.item?.analysisType?.toString();
    _detectedRooms = widget.item?.detectedRooms?.toString();
    _qualityScore = widget.item?.qualityScore;
    _styleTags = widget.item?.styleTags?.toString();
    _colorPalette = widget.item?.colorPalette?.toString();
    _lightingQuality = widget.item?.lightingQuality;
    _recommendations = widget.item?.recommendations?.toString();
    _analyzedAt = widget.item?.analyzedAt;
    _confidence = widget.item?.confidence;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_photoId?.isNotEmpty == true) 'photoId': _photoId,
      if (_analysisType?.isNotEmpty == true) 'analysisType': _analysisType,
      if (_detectedRooms?.isNotEmpty == true) 'detectedRooms': _detectedRooms,
      if (_qualityScore != null) 'qualityScore': _qualityScore,
      if (_styleTags?.isNotEmpty == true) 'styleTags': _styleTags,
      if (_colorPalette?.isNotEmpty == true) 'colorPalette': _colorPalette,
      if (_lightingQuality != null) 'lightingQuality': _lightingQuality,
      if (_recommendations?.isNotEmpty == true) 'recommendations': _recommendations,
      if (_analyzedAt != null) 'analyzedAt': _analyzedAt!.toIso8601String(),
      if (_confidence != null) 'confidence': _confidence,
    };
    if (widget.item == null) {
      widget.ref.read(aiImageAnalysisCreateStateProvider.notifier).state = AIImageAnalysis.fromJson(data);
    } else {
      widget.ref.read(aiImageAnalysisUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiImageAnalysis': AIImageAnalysis.fromJson({...widget.item!.toJson(), ...data}),
      };
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 700),
        child: Scaffold(
          appBar: AppBar(
            title: Text(isEdit ? 'Edit Ai Image Analysis' : 'New Ai Image Analysis'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Photo Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.photoId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _photoId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Analysis Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.analysisType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Detected Rooms', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.detectedRooms?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _detectedRooms = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Quality Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.qualityScore?.toString() ?? '',
                    onSaved: (v) => _qualityScore = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Style Tags', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.styleTags?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _styleTags = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Color Palette', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.colorPalette?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _colorPalette = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Lighting Quality', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.lightingQuality?.toString() ?? '',
                    onSaved: (v) => _lightingQuality = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Recommendations', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.recommendations?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _recommendations = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _analyzedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _analyzedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Analyzed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_analyzedAt != null ? _formatDate(_analyzedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.confidence?.toString() ?? '',
                    onSaved: (v) => _confidence = double.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Image Analysis'),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Delete Confirm ──────────────────────────────────────────────

void _confirmDel(BuildContext context, WidgetRef ref, AIImageAnalysis item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Image Analysis?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiImageAnalysisDeleteStateProvider.notifier).state = item.id;
          Navigator.pop(ctx);
        },
        icon: const Icon(Icons.delete), label: const Text('Delete'),
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
      ),
    ],
  ));
}

// ─── Helpers ─────────────────────────────────────────────────────

String _formatDate(DateTime? d) {
  if (d == null) return 'N/A';
  final y = d.year; final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0'); final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '$y-$mo-$day $h:$mi';
}
