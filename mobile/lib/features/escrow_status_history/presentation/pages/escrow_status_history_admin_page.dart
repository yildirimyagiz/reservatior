import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/escrow_status_history_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// EscrowStatusHistory Admin Page  |  9 fields
// Auto-generated — edit with care
// ================================================================

class EscrowStatusHistoryAdminPage extends ConsumerWidget {
  const EscrowStatusHistoryAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(escrowStatusHistoryLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escrow Status History Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(escrowStatusHistoryListProvider)),
        ],
      ),
      body: const _EscrowStatusHistoryBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'EscrowStatusHistoryFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Escrow Status History'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _EscrowStatusHistoryBody extends ConsumerStatefulWidget {
  const _EscrowStatusHistoryBody({super.key});
  @override ConsumerState<_EscrowStatusHistoryBody> createState() => __EscrowStatusHistoryBodyState();
}

class __EscrowStatusHistoryBodyState extends ConsumerState<_EscrowStatusHistoryBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(escrowStatusHistoryListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Escrow Status Historys…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.escrowId?.toString() ?? '') + " " + (item.changedBy?.toString() ?? '') + " " + (item.reason?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Escrow Status Historys yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(escrowStatusHistoryListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.changedBy != null && item.changedBy!.toString().isNotEmpty ? item.changedBy!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.changedBy ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Escrow Id: ' + item.escrowId?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.fromStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.fromStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(escrowStatusHistoryListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(EscrowStatusHistory item) {
    final s = item.fromStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, EscrowStatusHistory item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escrow Status History Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Escrow Id', item.escrowId?.toString() ?? 'N/A', Icons.link),
              _row('From Status', item.fromStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('To Status', item.toStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Changed By', item.changedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Reason', item.reason?.toString() ?? 'N/A', Icons.text_fields),
              _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
              _row('Changed At', _formatDate(item.changedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {EscrowStatusHistory? item}) {
  showDialog(context: context, builder: (ctx) => _EscrowStatusHistoryForm(item: item, ref: ref));
}

class _EscrowStatusHistoryForm extends ConsumerStatefulWidget {
  final EscrowStatusHistory? item;
  final WidgetRef ref;
  const _EscrowStatusHistoryForm({super.key, this.item, required this.ref});
  @override ConsumerState<_EscrowStatusHistoryForm> createState() => __EscrowStatusHistoryFormState();
}

class __EscrowStatusHistoryFormState extends ConsumerState<_EscrowStatusHistoryForm> {
  final _key = GlobalKey<FormState>();

  String? _escrowId;
  String? _fromStatus;
  String? _toStatus;
  String? _changedBy;
  String? _reason;
  String? _metadata;
  DateTime? _changedAt;

  @override
  void initState() {
    super.initState();
    _escrowId = widget.item?.escrowId?.toString();
    _fromStatus = widget.item?.fromStatus?.toString();
    _toStatus = widget.item?.toStatus?.toString();
    _changedBy = widget.item?.changedBy?.toString();
    _reason = widget.item?.reason?.toString();
    _metadata = widget.item?.metadata?.toString();
    _changedAt = widget.item?.changedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_escrowId?.isNotEmpty == true) 'escrowId': _escrowId,
      if (_fromStatus?.isNotEmpty == true) 'fromStatus': _fromStatus,
      if (_toStatus?.isNotEmpty == true) 'toStatus': _toStatus,
      if (_changedBy?.isNotEmpty == true) 'changedBy': _changedBy,
      if (_reason?.isNotEmpty == true) 'reason': _reason,
      if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
      if (_changedAt != null) 'changedAt': _changedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(escrowStatusHistoryCreateStateProvider.notifier).state = EscrowStatusHistory.fromJson(data);
    } else {
      widget.ref.read(escrowStatusHistoryUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'escrowStatusHistory': EscrowStatusHistory.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Escrow Status History' : 'New Escrow Status History'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Escrow Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.escrowId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _escrowId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'From Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.fromStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fromStatus = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'To Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.toStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _toStatus = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Changed By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.changedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _changedBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reason', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.reason?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reason = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.metadata?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _changedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _changedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Changed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_changedAt != null ? _formatDate(_changedAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Escrow Status History'),
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

void _confirmDel(BuildContext context, WidgetRef ref, EscrowStatusHistory item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Escrow Status History?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(escrowStatusHistoryDeleteStateProvider.notifier).state = item.id;
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
