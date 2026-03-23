import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_market_analysis_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIMarketAnalysis Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class AIMarketAnalysisAdminPage extends ConsumerWidget {
  const AIMarketAnalysisAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiMarketAnalysisListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Market Analysis Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiMarketAnalysisListProvider)),
        ],
      ),
      body: const _AIMarketAnalysisBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIMarketAnalysisFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Market Analysis'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIMarketAnalysisBody extends ConsumerStatefulWidget {
  const _AIMarketAnalysisBody();
  @override ConsumerState<_AIMarketAnalysisBody> createState() => __AIMarketAnalysisBodyState();
}

class __AIMarketAnalysisBodyState extends ConsumerState<_AIMarketAnalysisBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiMarketAnalysisListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Market Analysiss…',
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
              : items.where((item) {
  if (item == null) return false;
  final orgId = (item as dynamic).orgId?.toString() ?? '';
  final analysisType = (item as dynamic).analysisType?.toString() ?? '';
  final location = (item as dynamic).location?.toString() ?? '';
  final analysisPeriod = (item as dynamic).analysisPeriod?.toString() ?? '';
  final status = (item as dynamic).status?.toString() ?? '';
  return '$orgId $analysisType $location $analysisPeriod $status'.toLowerCase().contains(_q);
}).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Market Analyses yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiMarketAnalysisListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.analysisType != null && item.analysisType!.toString().isNotEmpty ? item.analysisType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.analysisType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ${item.status?.toString() ?? 'N/A'}'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.status != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withValues(alpha: 0.4)),
                    ),
                    child: Text(item.status!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
                  ),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiMarketAnalysisListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(AIMarketAnalysis item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIMarketAnalysis item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Market Analysis Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Analysis Type', item.analysisType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Location', item.location?.toString() ?? 'N/A', Icons.text_fields),
              _row('Analysis Period', item.analysisPeriod?.toString() ?? 'N/A', Icons.text_fields),
              _row('Data Points', item.dataPoints?.toString() ?? 'N/A', Icons.text_fields),
              _row('Predictions', item.predictions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Insights', item.insights?.toString() ?? 'N/A', Icons.text_fields),
              _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
              _row('Generated At', _formatDate(item.generatedAt), Icons.attach_money),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {AIMarketAnalysis? item}) {
  showDialog(context: context, builder: (ctx) => _AIMarketAnalysisForm(item: item, ref: ref));
}

class _AIMarketAnalysisForm extends ConsumerStatefulWidget {
  final AIMarketAnalysis? item;
  final WidgetRef ref;
  const _AIMarketAnalysisForm({this.item, required this.ref});
  @override ConsumerState<_AIMarketAnalysisForm> createState() => __AIMarketAnalysisFormState();
}

class __AIMarketAnalysisFormState extends ConsumerState<_AIMarketAnalysisForm> {
  final _key = GlobalKey<FormState>();

  String? _analysisType;
  String? _location;
  String? _analysisPeriod;
  String? _dataPoints;
  String? _predictions;
  String? _insights;
  double? _confidence;
  DateTime? _generatedAt;
  String? _status;

  @override
  void initState() {
    super.initState();
    _analysisType = widget.item?.analysisType?.toString();
    _location = widget.item?.location?.toString();
    _analysisPeriod = widget.item?.analysisPeriod?.toString();
    _dataPoints = widget.item?.dataPoints?.toString();
    _predictions = widget.item?.predictions?.toString();
    _insights = widget.item?.insights?.toString();
    _confidence = widget.item?.confidence;
    _generatedAt = widget.item?.generatedAt;
    _status = widget.item?.status?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_analysisType?.isNotEmpty == true) 'analysisType': _analysisType,
      if (_location?.isNotEmpty == true) 'location': _location,
      if (_analysisPeriod?.isNotEmpty == true) 'analysisPeriod': _analysisPeriod,
      if (_dataPoints?.isNotEmpty == true) 'dataPoints': _dataPoints,
      if (_predictions?.isNotEmpty == true) 'predictions': _predictions,
      if (_insights?.isNotEmpty == true) 'insights': _insights,
      if (_confidence != null) 'confidence': _confidence,
      if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
      if (_status?.isNotEmpty == true) 'status': _status,
    };
    if (widget.item == null) {
      widget.ref.read(aiMarketAnalysisCreateStateProvider.notifier).state = AIMarketAnalysis.fromJson(data);
    } else {
      widget.ref.read(aiMarketAnalysisUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiMarketAnalysis': AIMarketAnalysis.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Market Analysis' : 'New Ai Market Analysis'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Analysis Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.analysisType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Location', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item.location?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _location = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Analysis Period', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.analysisPeriod?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisPeriod = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Data Points', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.dataPoints?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dataPoints = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Predictions', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.predictions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _predictions = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Insights', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.insights?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _insights = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.confidence?.toString() ?? '',
                    onSaved: (v) => _confidence = double.tryParse(v ?? ''),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _generatedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _generatedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Generated At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_generatedAt != null ? _formatDate(_generatedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Market Analysis'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIMarketAnalysis item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Market Analysis?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiMarketAnalysisDeleteStateProvider.notifier).state = item.id;
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
