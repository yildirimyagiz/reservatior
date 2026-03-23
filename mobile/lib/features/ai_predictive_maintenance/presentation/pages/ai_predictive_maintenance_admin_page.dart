import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_predictive_maintenance_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIPredictiveMaintenance Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class AIPredictiveMaintenanceAdminPage extends ConsumerWidget {
  const AIPredictiveMaintenanceAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiPredictiveMaintenanceLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Predictive Maintenance Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiPredictiveMaintenanceListProvider)),
        ],
      ),
      body: const _AIPredictiveMaintenanceBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIPredictiveMaintenanceFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Predictive Maintenance'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIPredictiveMaintenanceBody extends ConsumerStatefulWidget {
  const _AIPredictiveMaintenanceBody();
  @override ConsumerState<_AIPredictiveMaintenanceBody> createState() => __AIPredictiveMaintenanceBodyState();
}

class __AIPredictiveMaintenanceBodyState extends ConsumerState<_AIPredictiveMaintenanceBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiPredictiveMaintenanceListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Predictive Maintenances…',
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
              : items.where((AIPredictiveMaintenance item) {
                  final searchText = [
                    item.orgId ?? '',
                    item.propertyId ?? '',
                    item.componentType ?? '',
                    item.riskLevel ?? '',
                    item.recommendedAction ?? '',
                  ].join(' ');
                  return searchText.toLowerCase().contains(_q);
                }).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Predictive Maintenances yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiPredictiveMaintenanceListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.componentType != null && item.componentType!.toString().isNotEmpty ? item.componentType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.componentType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiPredictiveMaintenanceListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIPredictiveMaintenance item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Predictive Maintenance Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Component Type', item.componentType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Failure Probability', item.failureProbability?.toString() ?? 'N/A', Icons.numbers),
              _row('Predicted Failure Date', _formatDate(item.predictedFailureDate), Icons.calendar_today),
              _row('Risk Level', item.riskLevel?.toString() ?? 'N/A', Icons.text_fields),
              _row('Estimated Cost', item.estimatedCost?.toString() ?? 'N/A', Icons.attach_money),
              _row('Contributing Factors', item.contributingFactors?.toString() ?? 'N/A', Icons.text_fields),
              _row('Last Inspection Date', _formatDate(item.lastInspectionDate), Icons.calendar_today),
              _row('Recommended Action', item.recommendedAction?.toString() ?? 'N/A', Icons.text_fields),
              _row('Generated At', _formatDate(item.generatedAt), Icons.attach_money),
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

void _showForm(BuildContext context, WidgetRef ref, {AIPredictiveMaintenance? item}) {
  showDialog(context: context, builder: (ctx) => _AIPredictiveMaintenanceForm(item: item, ref: ref));
}

class _AIPredictiveMaintenanceForm extends ConsumerStatefulWidget {
  final AIPredictiveMaintenance? item;
  final WidgetRef ref;
  const _AIPredictiveMaintenanceForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIPredictiveMaintenanceForm> createState() => __AIPredictiveMaintenanceFormState();
}

class __AIPredictiveMaintenanceFormState extends ConsumerState<_AIPredictiveMaintenanceForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _componentType;
  double? _failureProbability;
  DateTime? _predictedFailureDate;
  String? _riskLevel;
  double? _estimatedCost;
  String? _contributingFactors;
  DateTime? _lastInspectionDate;
  String? _recommendedAction;
  DateTime? _generatedAt;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _componentType = widget.item?.componentType?.toString();
    _failureProbability = widget.item?.failureProbability;
    _predictedFailureDate = widget.item?.predictedFailureDate;
    _riskLevel = widget.item?.riskLevel?.toString();
    _estimatedCost = widget.item?.estimatedCost;
    _contributingFactors = widget.item?.contributingFactors?.toString();
    _lastInspectionDate = widget.item?.lastInspectionDate;
    _recommendedAction = widget.item?.recommendedAction?.toString();
    _generatedAt = widget.item?.generatedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_componentType?.isNotEmpty == true) 'componentType': _componentType,
      if (_failureProbability != null) 'failureProbability': _failureProbability,
      if (_predictedFailureDate != null) 'predictedFailureDate': _predictedFailureDate!.toIso8601String(),
      if (_riskLevel?.isNotEmpty == true) 'riskLevel': _riskLevel,
      if (_estimatedCost != null) 'estimatedCost': _estimatedCost,
      if (_contributingFactors?.isNotEmpty == true) 'contributingFactors': _contributingFactors,
      if (_lastInspectionDate != null) 'lastInspectionDate': _lastInspectionDate!.toIso8601String(),
      if (_recommendedAction?.isNotEmpty == true) 'recommendedAction': _recommendedAction,
      if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(aiPredictiveMaintenanceCreateStateProvider.notifier).state = AIPredictiveMaintenance.fromJson(data);
    } else {
      widget.ref.read(aiPredictiveMaintenanceUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiPredictiveMaintenance': AIPredictiveMaintenance.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Predictive Maintenance' : 'New Ai Predictive Maintenance'),
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
                    decoration: InputDecoration(labelText: 'Component Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.componentType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _componentType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Failure Probability', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.failureProbability?.toString() ?? '',
                    onSaved: (v) => _failureProbability = double.tryParse(v ?? ''),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _predictedFailureDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _predictedFailureDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Predicted Failure Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_predictedFailureDate != null ? _formatDate(_predictedFailureDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Risk Level', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.riskLevel?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _riskLevel = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Estimated Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.estimatedCost?.toString() ?? '',
                    onSaved: (v) => _estimatedCost = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contributing Factors', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.contributingFactors?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contributingFactors = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastInspectionDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastInspectionDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Inspection Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastInspectionDate != null ? _formatDate(_lastInspectionDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Recommended Action', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.recommendedAction?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _recommendedAction = v?.isEmpty == true ? null : v,
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
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Predictive Maintenance'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIPredictiveMaintenance item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Predictive Maintenance?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiPredictiveMaintenanceDeleteStateProvider.notifier).state = item.id;
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
