import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_property_valuation_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIPropertyValuation Admin Page  |  16 fields
// Auto-generated — edit with care
// ================================================================

class AIPropertyValuationAdminPage extends ConsumerWidget {
  const AIPropertyValuationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiPropertyValuationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Property Valuation Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiPropertyValuationListProvider)),
        ],
      ),
      body: const _AIPropertyValuationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIPropertyValuationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Property Valuation'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIPropertyValuationBody extends ConsumerStatefulWidget {
  const _AIPropertyValuationBody();
  @override ConsumerState<_AIPropertyValuationBody> createState() => __AIPropertyValuationBodyState();
}

class __AIPropertyValuationBodyState extends ConsumerState<_AIPropertyValuationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiPropertyValuationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Property Valuations…',
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
              : items.where((AIPropertyValuation item) {
                  final searchText = [
                    item.id ?? '',
                    item.propertyId ?? '',
                    item.modelId ?? '',
                    item.status ?? '',
                    item.predictedValue?.toString() ?? '',
                  ].join(' ');
                  return searchText.toLowerCase().contains(_q);
                }).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Property Valuations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiPropertyValuationListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text((item.propertyId != null && item.propertyId!.toString().isNotEmpty ? item.propertyId!.toString()[0].toUpperCase() : '?'))),
                    title: Text('Valuation: \$${item.predictedValue?.toStringAsFixed(2) ?? "N/A"}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Property: ${item.propertyId ?? "N/A"} • ${item.status ?? "pending"}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiPropertyValuationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIPropertyValuation item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Property Valuation Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Predicted Value', '\$${item.predictedValue?.toStringAsFixed(2) ?? "N/A"}', Icons.attach_money),
              _row('Confidence Score', item.confidenceScore?.toString() ?? 'N/A', Icons.analytics),
              _row('Valuation Date', _formatDate(item.valuationDate), Icons.calendar_today),
              _row('Model Id', item.modelId?.toString() ?? 'N/A', Icons.model_training),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
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

void _showForm(BuildContext context, WidgetRef ref, {AIPropertyValuation? item}) {
  showDialog(context: context, builder: (ctx) => _AIPropertyValuationForm(item: item, ref: ref));
}

class _AIPropertyValuationForm extends ConsumerStatefulWidget {
  final AIPropertyValuation? item;
  final WidgetRef ref;
  const _AIPropertyValuationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIPropertyValuationForm> createState() => __AIPropertyValuationFormState();
}

class __AIPropertyValuationFormState extends ConsumerState<_AIPropertyValuationForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _modelId;
  double? _predictedValue;
  double? _confidenceScore;
  DateTime? _valuationDate;
  String? _status;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _modelId = widget.item?.modelId?.toString();
    _predictedValue = widget.item?.predictedValue;
    _confidenceScore = widget.item?.confidenceScore;
    _valuationDate = widget.item?.valuationDate;
    _status = widget.item?.status?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_modelId?.isNotEmpty == true) 'modelId': _modelId,
      if (_predictedValue != null) 'predictedValue': _predictedValue,
      if (_confidenceScore != null) 'confidenceScore': _confidenceScore,
      if (_valuationDate != null) 'valuationDate': _valuationDate!.toIso8601String(),
      if (_status?.isNotEmpty == true) 'status': _status,
    };
    if (widget.item == null) {
      widget.ref.read(aiPropertyValuationCreateStateProvider.notifier).state = AIPropertyValuation.fromJson(data);
    } else {
      widget.ref.read(aiPropertyValuationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'data': data,
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
            title: Text(isEdit ? 'Edit Ai Property Valuation' : 'New Ai Property Valuation'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Property Id *', prefixIcon: Icon(Icons.home), border: OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
                    onSaved: (v) => _propertyId = v,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Model Id', prefixIcon: Icon(Icons.model_training), border: OutlineInputBorder()),
                    initialValue: widget.item?.modelId?.toString() ?? '',
                    onSaved: (v) => _modelId = v?.isEmpty == true ? null : v,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Predicted Value *', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.predictedValue?.toString() ?? '',
                    validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
                    onSaved: (v) => _predictedValue = double.tryParse(v ?? ''),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence Score', prefixIcon: Icon(Icons.analytics), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.confidenceScore?.toString() ?? '',
                    onSaved: (v) => _confidenceScore = double.tryParse(v ?? ''),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _valuationDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _valuationDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Valuation Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_valuationDate != null ? _formatDate(_valuationDate) : 'Tap to select date'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Property Valuation'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIPropertyValuation item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Property Valuation?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiPropertyValuationDeleteStateProvider.notifier).state = item.id;
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
