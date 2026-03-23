import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/escrow_dispute_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// EscrowDispute Admin Page  |  20 fields
// Auto-generated — edit with care
// ================================================================

class EscrowDisputeAdminPage extends ConsumerWidget {
  const EscrowDisputeAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(escrowDisputeLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escrow Dispute Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(escrowDisputeListProvider)),
        ],
      ),
      body: const _EscrowDisputeBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'EscrowDisputeFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Escrow Dispute'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _EscrowDisputeBody extends ConsumerStatefulWidget {
  const _EscrowDisputeBody({super.key});
  @override ConsumerState<_EscrowDisputeBody> createState() => __EscrowDisputeBodyState();
}

class __EscrowDisputeBodyState extends ConsumerState<_EscrowDisputeBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(escrowDisputeListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Escrow Disputes…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.escrowAccountId?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.currency?.toString() ?? '') + " " + (item.resolution?.toString() ?? '') + " " + (item.resolvedBy?.toString() ?? '') + " " + (item.moderatorNotes?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Escrow Disputes yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(escrowDisputeListProvider),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(escrowDisputeListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(EscrowDispute item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, EscrowDispute item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escrow Dispute Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
              _row('Escrow Account Id', item.escrowAccountId?.toString() ?? 'N/A', Icons.link),
              _row('Opened By', item.openedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Dispute Type', item.disputeType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Claimed Amount', item.claimedAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Evidence', item.evidence?.toString() ?? 'N/A', Icons.text_fields),
              _row('Resolution', item.resolution?.toString() ?? 'N/A', Icons.text_fields),
              _row('Resolved Amount', item.resolvedAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Resolved At', _formatDate(item.resolvedAt), Icons.calendar_today),
              _row('Resolved By', item.resolvedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Moderator Notes', item.moderatorNotes?.toString() ?? 'N/A', Icons.notes),
              _row('Escalated At', _formatDate(item.escalatedAt), Icons.calendar_today),
              _row('Deadline At', _formatDate(item.deadlineAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {EscrowDispute? item}) {
  showDialog(context: context, builder: (ctx) => _EscrowDisputeForm(item: item, ref: ref));
}

class _EscrowDisputeForm extends ConsumerStatefulWidget {
  final EscrowDispute? item;
  final WidgetRef ref;
  const _EscrowDisputeForm({super.key, this.item, required this.ref});
  @override ConsumerState<_EscrowDisputeForm> createState() => __EscrowDisputeFormState();
}

class __EscrowDisputeFormState extends ConsumerState<_EscrowDisputeForm> {
  final _key = GlobalKey<FormState>();

  String? _reservationId;
  String? _escrowAccountId;
  String? _openedBy;
  String? _disputeType;
  String? _description;
  double? _claimedAmount;
  String? _currency;
  String? _status;
  String? _evidence;
  String? _resolution;
  double? _resolvedAmount;
  DateTime? _resolvedAt;
  String? _resolvedBy;
  String? _moderatorNotes;
  DateTime? _escalatedAt;
  DateTime? _deadlineAt;

  @override
  void initState() {
    super.initState();
    _reservationId = widget.item?.reservationId?.toString();
    _escrowAccountId = widget.item?.escrowAccountId?.toString();
    _openedBy = widget.item?.openedBy?.toString();
    _disputeType = widget.item?.disputeType?.toString();
    _description = widget.item?.description?.toString();
    _claimedAmount = widget.item?.claimedAmount;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _evidence = widget.item?.evidence?.toString();
    _resolution = widget.item?.resolution?.toString();
    _resolvedAmount = widget.item?.resolvedAmount;
    _resolvedAt = widget.item?.resolvedAt;
    _resolvedBy = widget.item?.resolvedBy?.toString();
    _moderatorNotes = widget.item?.moderatorNotes?.toString();
    _escalatedAt = widget.item?.escalatedAt;
    _deadlineAt = widget.item?.deadlineAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
      if (_escrowAccountId?.isNotEmpty == true) 'escrowAccountId': _escrowAccountId,
      if (_openedBy?.isNotEmpty == true) 'openedBy': _openedBy,
      if (_disputeType?.isNotEmpty == true) 'disputeType': _disputeType,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_claimedAmount != null) 'claimedAmount': _claimedAmount,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_evidence?.isNotEmpty == true) 'evidence': _evidence,
      if (_resolution?.isNotEmpty == true) 'resolution': _resolution,
      if (_resolvedAmount != null) 'resolvedAmount': _resolvedAmount,
      if (_resolvedAt != null) 'resolvedAt': _resolvedAt!.toIso8601String(),
      if (_resolvedBy?.isNotEmpty == true) 'resolvedBy': _resolvedBy,
      if (_moderatorNotes?.isNotEmpty == true) 'moderatorNotes': _moderatorNotes,
      if (_escalatedAt != null) 'escalatedAt': _escalatedAt!.toIso8601String(),
      if (_deadlineAt != null) 'deadlineAt': _deadlineAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(escrowDisputeCreateStateProvider.notifier).state = EscrowDispute.fromJson(data);
    } else {
      widget.ref.read(escrowDisputeUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'escrowDispute': EscrowDispute.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Escrow Dispute' : 'New Escrow Dispute'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.reservationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Escrow Account Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.escrowAccountId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _escrowAccountId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Opened By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.openedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _openedBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Dispute Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.disputeType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _disputeType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Claimed Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.claimedAmount?.toString() ?? '',
                    onSaved: (v) => _claimedAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Evidence', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.evidence?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _evidence = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Resolution', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.resolution?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _resolution = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Resolved Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.resolvedAmount?.toString() ?? '',
                    onSaved: (v) => _resolvedAmount = double.tryParse(v ?? ''),
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
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Resolved By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.resolvedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _resolvedBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Moderator Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.moderatorNotes?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _moderatorNotes = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _escalatedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _escalatedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Escalated At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_escalatedAt != null ? _formatDate(_escalatedAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _deadlineAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _deadlineAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Deadline At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_deadlineAt != null ? _formatDate(_deadlineAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Escrow Dispute'),
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

void _confirmDel(BuildContext context, WidgetRef ref, EscrowDispute item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Escrow Dispute?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(escrowDisputeDeleteStateProvider.notifier).state = item.id;
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
