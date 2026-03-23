import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/performance_alert_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// PerformanceAlert Admin Page  |  15 fields
// Auto-generated — edit with care
// ================================================================

class PerformanceAlertAdminPage extends ConsumerWidget {
  const PerformanceAlertAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(performanceAlertLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Alert Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(performanceAlertListProvider)),
        ],
      ),
      body: const _PerformanceAlertBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PerformanceAlertFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Performance Alert'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _PerformanceAlertBody extends ConsumerStatefulWidget {
  const _PerformanceAlertBody({super.key});
  @override ConsumerState<_PerformanceAlertBody> createState() => __PerformanceAlertBodyState();
}

class __PerformanceAlertBodyState extends ConsumerState<_PerformanceAlertBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(performanceAlertListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Performance Alerts…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.alertType?.toString() ?? '') + " " + (item.severity?.toString() ?? '') + " " + (item.metricName?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.status?.toString() ?? '') + " " + (item.acknowledgedBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Performance Alerts yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(performanceAlertListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.description != null && item.description!.toString().isNotEmpty ? item.description!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.description ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ' + item.status?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.status != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(performanceAlertListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(PerformanceAlert item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, PerformanceAlert item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Performance Alert Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Alert Type', item.alertType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Severity', item.severity?.toString() ?? 'N/A', Icons.text_fields),
              _row('Metric Name', item.metricName?.toString() ?? 'N/A', Icons.person),
              _row('Threshold', item.threshold?.toString() ?? 'N/A', Icons.numbers),
              _row('Actual Value', item.actualValue?.toString() ?? 'N/A', Icons.numbers),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Affected Services', item.affectedServices?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Acknowledged At', _formatDate(item.acknowledgedAt), Icons.calendar_today),
              _row('Acknowledged By', item.acknowledgedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Resolved At', _formatDate(item.resolvedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {PerformanceAlert? item}) {
  showDialog(context: context, builder: (ctx) => _PerformanceAlertForm(item: item, ref: ref));
}

class _PerformanceAlertForm extends ConsumerStatefulWidget {
  final PerformanceAlert? item;
  final WidgetRef ref;
  const _PerformanceAlertForm({super.key, this.item, required this.ref});
  @override ConsumerState<_PerformanceAlertForm> createState() => __PerformanceAlertFormState();
}

class __PerformanceAlertFormState extends ConsumerState<_PerformanceAlertForm> {
  final _key = GlobalKey<FormState>();

  String? _alertType;
  String? _severity;
  String? _metricName;
  double? _threshold;
  double? _actualValue;
  String? _description;
  String? _affectedServices;
  String? _status;
  DateTime? _acknowledgedAt;
  String? _acknowledgedBy;
  DateTime? _resolvedAt;

  @override
  void initState() {
    super.initState();
    _alertType = widget.item?.alertType?.toString();
    _severity = widget.item?.severity?.toString();
    _metricName = widget.item?.metricName?.toString();
    _threshold = widget.item?.threshold;
    _actualValue = widget.item?.actualValue;
    _description = widget.item?.description?.toString();
    _affectedServices = widget.item?.affectedServices?.toString();
    _status = widget.item?.status?.toString();
    _acknowledgedAt = widget.item?.acknowledgedAt;
    _acknowledgedBy = widget.item?.acknowledgedBy?.toString();
    _resolvedAt = widget.item?.resolvedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_alertType?.isNotEmpty == true) 'alertType': _alertType,
      if (_severity?.isNotEmpty == true) 'severity': _severity,
      if (_metricName?.isNotEmpty == true) 'metricName': _metricName,
      if (_threshold != null) 'threshold': _threshold,
      if (_actualValue != null) 'actualValue': _actualValue,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_affectedServices?.isNotEmpty == true) 'affectedServices': _affectedServices,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_acknowledgedAt != null) 'acknowledgedAt': _acknowledgedAt!.toIso8601String(),
      if (_acknowledgedBy?.isNotEmpty == true) 'acknowledgedBy': _acknowledgedBy,
      if (_resolvedAt != null) 'resolvedAt': _resolvedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(performanceAlertCreateStateProvider.notifier).state = PerformanceAlert.fromJson(data);
    } else {
      widget.ref.read(performanceAlertUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'performanceAlert': PerformanceAlert.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Performance Alert' : 'New Performance Alert'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Alert Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.alertType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _alertType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Severity', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.severity?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _severity = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Metric Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.metricName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _metricName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.threshold?.toString() ?? '',
                    onSaved: (v) => _threshold = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Actual Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.actualValue?.toString() ?? '',
                    onSaved: (v) => _actualValue = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Affected Services', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.affectedServices?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _affectedServices = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _acknowledgedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _acknowledgedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Acknowledged At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_acknowledgedAt != null ? _formatDate(_acknowledgedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Acknowledged By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.acknowledgedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _acknowledgedBy = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _resolvedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _resolvedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Resolved At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_resolvedAt != null ? _formatDate(_resolvedAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Performance Alert'),
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

void _confirmDel(BuildContext context, WidgetRef ref, PerformanceAlert item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Performance Alert?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(performanceAlertDeleteStateProvider.notifier).state = item.id;
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
