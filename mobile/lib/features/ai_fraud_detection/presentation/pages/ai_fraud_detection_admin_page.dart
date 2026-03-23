import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_fraud_detection_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIFraudDetection Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class AIFraudDetectionAdminPage extends ConsumerWidget {
  const AIFraudDetectionAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiFraudDetectionLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Fraud Detection Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiFraudDetectionListProvider)),
        ],
      ),
      body: const _AIFraudDetectionBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIFraudDetectionFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Fraud Detection'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIFraudDetectionBody extends ConsumerStatefulWidget {
  const _AIFraudDetectionBody();
  @override ConsumerState<_AIFraudDetectionBody> createState() => __AIFraudDetectionBodyState();
}

class __AIFraudDetectionBodyState extends ConsumerState<_AIFraudDetectionBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiFraudDetectionListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Fraud Detections…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.entityType?.toString() ?? '') + " " + (item.entityId?.toString() ?? '') + " " + (item.riskCategory?.toString() ?? '') + " " + (item.reviewedBy?.toString() ?? '') + " " + (item.resolution?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Fraud Detections yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiFraudDetectionListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.entityType != null && item.entityType!.toString().isNotEmpty ? item.entityType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.entityType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiFraudDetectionListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIFraudDetection item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Fraud Detection Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
              _row('Risk Score', item.riskScore?.toString() ?? 'N/A', Icons.numbers),
              _row('Risk Factors', item.riskFactors?.toString() ?? 'N/A', Icons.text_fields),
              _row('Risk Category', item.riskCategory?.toString() ?? 'N/A', Icons.text_fields),
              _row('Recommended Actions', item.recommendedActions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Detected At', _formatDate(item.detectedAt), Icons.calendar_today),
              _row('Reviewed At', _formatDate(item.reviewedAt), Icons.calendar_today),
              _row('Reviewed By', item.reviewedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Resolution', item.resolution?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {AIFraudDetection? item}) {
  showDialog(context: context, builder: (ctx) => _AIFraudDetectionForm(item: item, ref: ref));
}

class _AIFraudDetectionForm extends ConsumerStatefulWidget {
  final AIFraudDetection? item;
  final WidgetRef ref;
  const _AIFraudDetectionForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIFraudDetectionForm> createState() => __AIFraudDetectionFormState();
}

class __AIFraudDetectionFormState extends ConsumerState<_AIFraudDetectionForm> {
  final _key = GlobalKey<FormState>();

  String? _entityType;
  String? _entityId;
  double? _riskScore;
  String? _riskFactors;
  String? _riskCategory;
  String? _recommendedActions;
  DateTime? _detectedAt;
  DateTime? _reviewedAt;
  String? _reviewedBy;
  String? _resolution;

  @override
  void initState() {
    super.initState();
    _entityType = widget.item?.entityType?.toString();
    _entityId = widget.item?.entityId?.toString();
    _riskScore = widget.item?.riskScore;
    _riskFactors = widget.item?.riskFactors?.toString();
    _riskCategory = widget.item?.riskCategory?.toString();
    _recommendedActions = widget.item?.recommendedActions?.toString();
    _detectedAt = widget.item?.detectedAt;
    _reviewedAt = widget.item?.reviewedAt;
    _reviewedBy = widget.item?.reviewedBy?.toString();
    _resolution = widget.item?.resolution?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
      if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
      if (_riskScore != null) 'riskScore': _riskScore,
      if (_riskFactors?.isNotEmpty == true) 'riskFactors': _riskFactors,
      if (_riskCategory?.isNotEmpty == true) 'riskCategory': _riskCategory,
      if (_recommendedActions?.isNotEmpty == true) 'recommendedActions': _recommendedActions,
      if (_detectedAt != null) 'detectedAt': _detectedAt!.toIso8601String(),
      if (_reviewedAt != null) 'reviewedAt': _reviewedAt!.toIso8601String(),
      if (_reviewedBy?.isNotEmpty == true) 'reviewedBy': _reviewedBy,
      if (_resolution?.isNotEmpty == true) 'resolution': _resolution,
    };
    if (widget.item == null) {
      widget.ref.read(aiFraudDetectionCreateStateProvider.notifier).state = AIFraudDetection.fromJson(data);
    } else {
      widget.ref.read(aiFraudDetectionUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiFraudDetection': AIFraudDetection.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Fraud Detection' : 'New Ai Fraud Detection'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.entityType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.entityId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Risk Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.riskScore?.toString() ?? '',
                    onSaved: (v) => _riskScore = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Risk Factors', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.riskFactors?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _riskFactors = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Risk Category', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.riskCategory?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _riskCategory = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Recommended Actions', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.recommendedActions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _recommendedActions = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _detectedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _detectedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Detected At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_detectedAt != null ? _formatDate(_detectedAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _reviewedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _reviewedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Reviewed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_reviewedAt != null ? _formatDate(_reviewedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reviewed By', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.reviewedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reviewedBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Resolution', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.resolution?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _resolution = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Fraud Detection'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIFraudDetection item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Fraud Detection?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiFraudDetectionDeleteStateProvider.notifier).state = item.id;
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
