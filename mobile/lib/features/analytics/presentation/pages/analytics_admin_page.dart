import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/analytics_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Analytics Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class AnalyticsAdminPage extends ConsumerWidget {
  const AnalyticsAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(analyticsLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(analyticsListProvider)),
        ],
      ),
      body: const _AnalyticsBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AnalyticsFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Analytics'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AnalyticsBody extends ConsumerStatefulWidget {
  const _AnalyticsBody({super.key});
  @override ConsumerState<_AnalyticsBody> createState() => __AnalyticsBodyState();
}

class __AnalyticsBodyState extends ConsumerState<_AnalyticsBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(analyticsListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Analyticss…',
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
              : items.where((item) => ((item.entityId?.toString() ?? '') + " " + (item.entityType?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.agentId?.toString() ?? '') + " " + (item.agencyId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.taskId?.toString() ?? '') + " " + (item.taxRecordId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Analyticss yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(analyticsListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.type != null && item.type!.toString().isNotEmpty ? item.type!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.type?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Entity Id: ${item.entityId ?? 'N/A'}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(analyticsListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Analytics item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analytics Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
              _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Data', item.data?.toString() ?? 'N/A', Icons.text_fields),
              _row('Timestamp', _formatDate(item.timestamp), Icons.calendar_today),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Agent Id', item.agentId?.toString() ?? 'N/A', Icons.link),
              _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
              _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
              _row('Task Id', item.taskId?.toString() ?? 'N/A', Icons.link),
              _row('Tax Record Id', item.taxRecordId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {Analytics? item}) {
  showDialog(context: context, builder: (ctx) => _AnalyticsForm(item: item, ref: ref));
}

class _AnalyticsForm extends ConsumerStatefulWidget {
  final Analytics? item;
  final WidgetRef ref;
  const _AnalyticsForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AnalyticsForm> createState() => __AnalyticsFormState();
}

class __AnalyticsFormState extends ConsumerState<_AnalyticsForm> {
  final _key = GlobalKey<FormState>();

  String? _entityId;
  String? _entityType;
  String? _type;
  String? _data;
  DateTime? _timestamp;
  String? _propertyId;
  String? _userId;
  String? _agentId;
  String? _agencyId;
  String? _reservationId;
  String? _taskId;
  String? _taxRecordId;

  @override
  void initState() {
    super.initState();
    _entityId = widget.item?.entityId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _type = widget.item?.type?.toString();
    _data = widget.item?.data?.toString();
    _timestamp = widget.item?.timestamp;
    _propertyId = widget.item?.propertyId?.toString();
    _userId = widget.item?.userId?.toString();
    _agentId = widget.item?.agentId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _taskId = widget.item?.taskId?.toString();
    _taxRecordId = widget.item?.taxRecordId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
      if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_data?.isNotEmpty == true) 'data': _data,
      if (_timestamp != null) 'timestamp': _timestamp!.toIso8601String(),
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
      if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
      if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
      if (_taskId?.isNotEmpty == true) 'taskId': _taskId,
      if (_taxRecordId?.isNotEmpty == true) 'taxRecordId': _taxRecordId,
    };
    if (widget.item == null) {
      widget.ref.read(analyticsCreateStateProvider.notifier).state = Analytics.fromJson(data);
    } else {
      widget.ref.read(analyticsUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'analytics': Analytics.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Analytics' : 'New Analytics'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.entityId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.entityType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.data?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _data = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _timestamp ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _timestamp = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Timestamp',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_timestamp != null ? _formatDate(_timestamp) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.agentId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.agencyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.reservationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Task Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.taskId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taskId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tax Record Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.taxRecordId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taxRecordId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Analytics'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Analytics item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Analytics?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(analyticsDeleteStateProvider.notifier).state = item.id;
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
