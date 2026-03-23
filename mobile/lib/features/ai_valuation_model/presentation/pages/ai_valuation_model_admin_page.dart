import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_valuation_model_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIValuationModel Admin Page  |  12 fields
// Auto-generated — edit with care
// ================================================================

class AIValuationModelAdminPage extends ConsumerWidget {
  const AIValuationModelAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiValuationModelLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Valuation Model Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiValuationModelListProvider)),
        ],
      ),
      body: const _AIValuationModelBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIValuationModelFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Valuation Model'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIValuationModelBody extends ConsumerStatefulWidget {
  const _AIValuationModelBody();
  @override ConsumerState<_AIValuationModelBody> createState() => __AIValuationModelBodyState();
}

class __AIValuationModelBodyState extends ConsumerState<_AIValuationModelBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiValuationModelListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Valuation Models…',
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
              : items.where((item) => '${item.orgId ?? ''} ${item.modelName ?? ''} ${item.modelVersion ?? ''}'.toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Valuation Models yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiValuationModelListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.modelName != null && item.modelName!.isNotEmpty ? item.modelName![0].toUpperCase() : '?'),),
                    title: Text(item.modelName ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Version: ${item.modelVersion ?? 'N/A'}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiValuationModelListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIValuationModel item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Valuation Model Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Model Name', item.modelName?.toString() ?? 'N/A', Icons.person),
              _row('Model Version', item.modelVersion?.toString() ?? 'N/A', Icons.text_fields),
              _row('Accuracy', item.accuracy?.toString() ?? 'N/A', Icons.numbers),
              _row('Last Trained At', _formatDate(item.lastTrainedAt), Icons.calendar_today),
              _row('Features', item.features?.toString() ?? 'N/A', Icons.text_fields),
              _row('Hyperparameters', item.hyperparameters?.toString() ?? 'N/A', Icons.text_fields),
              _row('Training Metrics', item.trainingMetrics?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
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

void _showForm(BuildContext context, WidgetRef ref, {AIValuationModel? item}) {
  showDialog(context: context, builder: (ctx) => _AIValuationModelForm(item: item, ref: ref));
}

class _AIValuationModelForm extends ConsumerStatefulWidget {
  final AIValuationModel? item;
  final WidgetRef ref;
  const _AIValuationModelForm({this.item, required this.ref});
  @override ConsumerState<_AIValuationModelForm> createState() => __AIValuationModelFormState();
}

class __AIValuationModelFormState extends ConsumerState<_AIValuationModelForm> {
  final _key = GlobalKey<FormState>();

  String? _modelName;
  String? _modelVersion;
  double? _accuracy;
  DateTime? _lastTrainedAt;
  String? _features;
  String? _hyperparameters;
  String? _trainingMetrics;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _modelName = widget.item?.modelName?.toString();
    _modelVersion = widget.item?.modelVersion?.toString();
    _accuracy = widget.item?.accuracy;
    _lastTrainedAt = widget.item?.lastTrainedAt;
    _features = widget.item?.features?.toString();
    _hyperparameters = widget.item?.hyperparameters?.toString();
    _trainingMetrics = widget.item?.trainingMetrics?.toString();
    _isActive = widget.item?.isActive ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_modelName?.isNotEmpty == true) 'modelName': _modelName,
      if (_modelVersion?.isNotEmpty == true) 'modelVersion': _modelVersion,
      if (_accuracy != null) 'accuracy': _accuracy,
      if (_lastTrainedAt != null) 'lastTrainedAt': _lastTrainedAt!.toIso8601String(),
      if (_features?.isNotEmpty == true) 'features': _features,
      if (_hyperparameters?.isNotEmpty == true) 'hyperparameters': _hyperparameters,
      if (_trainingMetrics?.isNotEmpty == true) 'trainingMetrics': _trainingMetrics,
      'isActive': _isActive,
    };
    if (widget.item == null) {
      widget.ref.read(aiValuationModelCreateStateProvider.notifier).state = AIValuationModel.fromJson(data);
    } else {
      widget.ref.read(aiValuationModelUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiValuationModel': AIValuationModel.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Valuation Model' : 'New Ai Valuation Model'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Model Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    initialValue: widget.item?.modelName ?? '',
                    maxLines: 1,
                    onSaved: (v) => _modelName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Model Version', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.modelVersion ?? '',
                    maxLines: 1,
                    onSaved: (v) => _modelVersion = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Accuracy', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.accuracy?.toString() ?? '',
                    onSaved: (v) => _accuracy = double.tryParse(v ?? ''),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastTrainedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastTrainedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Trained At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastTrainedAt != null ? _formatDate(_lastTrainedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Features', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.features ?? '',
                    maxLines: 1,
                    onSaved: (v) => _features = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Hyperparameters', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.hyperparameters ?? '',
                    maxLines: 1,
                    onSaved: (v) => _hyperparameters = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Training Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.trainingMetrics ?? '',
                    maxLines: 1,
                    onSaved: (v) => _trainingMetrics = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: const Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Valuation Model'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIValuationModel item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Valuation Model?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiValuationModelDeleteStateProvider.notifier).state = item.id;
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
