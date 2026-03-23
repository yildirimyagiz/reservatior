import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/offline_sync_queue_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// OfflineSyncQueue Admin Page  |  12 fields
// Auto-generated — edit with care
// ================================================================

class OfflineSyncQueueAdminPage extends ConsumerWidget {
  const OfflineSyncQueueAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(offlineSyncQueueLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Sync Queue Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(offlineSyncQueueListProvider)),
        ],
      ),
      body: const _OfflineSyncQueueBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'OfflineSyncQueueFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Offline Sync Queue'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _OfflineSyncQueueBody extends ConsumerStatefulWidget {
  const _OfflineSyncQueueBody({super.key});
  @override ConsumerState<_OfflineSyncQueueBody> createState() => __OfflineSyncQueueBodyState();
}

class __OfflineSyncQueueBodyState extends ConsumerState<_OfflineSyncQueueBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(offlineSyncQueueListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Offline Sync Queues…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.deviceId?.toString() ?? '') + " " + (item.entityType?.toString() ?? '') + " " + (item.entityId?.toString() ?? '') + " " + (item.operation?.toString() ?? '') + " " + (item.syncStatus?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Offline Sync Queues yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(offlineSyncQueueListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.entityType != null && item.entityType!.toString().isNotEmpty ? item.entityType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.entityType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.syncStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.syncStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(offlineSyncQueueListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(OfflineSyncQueue item) {
    final s = item.syncStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, OfflineSyncQueue item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Offline Sync Queue Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Device Id', item.deviceId?.toString() ?? 'N/A', Icons.link),
              _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
              _row('Operation', item.operation?.toString() ?? 'N/A', Icons.text_fields),
              _row('Data', item.data?.toString() ?? 'N/A', Icons.text_fields),
              _row('Version', item.version?.toString() ?? 'N/A', Icons.numbers),
              _row('Sync Status', item.syncStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Synced At', _formatDate(item.syncedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {OfflineSyncQueue? item}) {
  showDialog(context: context, builder: (ctx) => _OfflineSyncQueueForm(item: item, ref: ref));
}

class _OfflineSyncQueueForm extends ConsumerStatefulWidget {
  final OfflineSyncQueue? item;
  final WidgetRef ref;
  const _OfflineSyncQueueForm({super.key, this.item, required this.ref});
  @override ConsumerState<_OfflineSyncQueueForm> createState() => __OfflineSyncQueueFormState();
}

class __OfflineSyncQueueFormState extends ConsumerState<_OfflineSyncQueueForm> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _deviceId;
  String? _entityType;
  String? _entityId;
  String? _operation;
  String? _data;
  int? _version;
  String? _syncStatus;
  DateTime? _syncedAt;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _deviceId = widget.item?.deviceId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _entityId = widget.item?.entityId?.toString();
    _operation = widget.item?.operation?.toString();
    _data = widget.item?.data?.toString();
    _version = widget.item?.version;
    _syncStatus = widget.item?.syncStatus?.toString();
    _syncedAt = widget.item?.syncedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_deviceId?.isNotEmpty == true) 'deviceId': _deviceId,
      if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
      if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
      if (_operation?.isNotEmpty == true) 'operation': _operation,
      if (_data?.isNotEmpty == true) 'data': _data,
      if (_version != null) 'version': _version,
      if (_syncStatus?.isNotEmpty == true) 'syncStatus': _syncStatus,
      if (_syncedAt != null) 'syncedAt': _syncedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(offlineSyncQueueCreateStateProvider.notifier).state = OfflineSyncQueue.fromJson(data);
    } else {
      widget.ref.read(offlineSyncQueueUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'offlineSyncQueue': OfflineSyncQueue.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Offline Sync Queue' : 'New Offline Sync Queue'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Device Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.deviceId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _deviceId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.entityType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.entityId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Operation', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.operation?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _operation = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.data?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _data = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Version', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.version?.toString() ?? '',
                    onSaved: (v) => _version = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sync Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.syncStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _syncStatus = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _syncedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _syncedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Synced At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_syncedAt != null ? _formatDate(_syncedAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Offline Sync Queue'),
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

void _confirmDel(BuildContext context, WidgetRef ref, OfflineSyncQueue item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Offline Sync Queue?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(offlineSyncQueueDeleteStateProvider.notifier).state = item.id;
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
