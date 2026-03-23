import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ledger_entry_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// LedgerEntry Admin Page  |  18 fields
// Auto-generated — edit with care
// ================================================================

class LedgerEntryAdminPage extends ConsumerWidget {
  const LedgerEntryAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(ledgerEntryLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ledger Entry Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(ledgerEntryListProvider)),
        ],
      ),
      body: const _LedgerEntryBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'LedgerEntryFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ledger Entry'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _LedgerEntryBody extends ConsumerStatefulWidget {
  const _LedgerEntryBody({super.key});
  @override ConsumerState<_LedgerEntryBody> createState() => __LedgerEntryBodyState();
}

class __LedgerEntryBodyState extends ConsumerState<_LedgerEntryBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(ledgerEntryListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ledger Entrys…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.leaseId?.toString() ?? '') + " " + (item.bookingId?.toString() ?? '') + " " + (item.contractId?.toString() ?? '') + " " + (item.billId?.toString() ?? '') + " " + (item.transactionId?.toString() ?? '') + " " + (item.currency?.toString() ?? '') + " " + (item.note?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ledger Entrys yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(ledgerEntryListProvider),
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
                    subtitle: Text('Amount: ' + item.amount?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(ledgerEntryListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, LedgerEntry item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ledger Entry Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
              _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
              _row('Booking Id', item.bookingId?.toString() ?? 'N/A', Icons.link),
              _row('Contract Id', item.contractId?.toString() ?? 'N/A', Icons.link),
              _row('Bill Id', item.billId?.toString() ?? 'N/A', Icons.link),
              _row('Transaction Id', item.transactionId?.toString() ?? 'N/A', Icons.link),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Occurred At', _formatDate(item.occurredAt), Icons.calendar_today),
              _row('Note', item.note?.toString() ?? 'N/A', Icons.notes),
              _row('Meta', item.meta?.toString() ?? 'N/A', Icons.text_fields),
              _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {LedgerEntry? item}) {
  showDialog(context: context, builder: (ctx) => _LedgerEntryForm(item: item, ref: ref));
}

class _LedgerEntryForm extends ConsumerStatefulWidget {
  final LedgerEntry? item;
  final WidgetRef ref;
  const _LedgerEntryForm({super.key, this.item, required this.ref});
  @override ConsumerState<_LedgerEntryForm> createState() => __LedgerEntryFormState();
}

class __LedgerEntryFormState extends ConsumerState<_LedgerEntryForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _contractId;
  String? _billId;
  String? _transactionId;
  String? _type;
  double? _amount;
  String? _currency;
  DateTime? _occurredAt;
  String? _note;
  String? _meta;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _bookingId = widget.item?.bookingId?.toString();
    _contractId = widget.item?.contractId?.toString();
    _billId = widget.item?.billId?.toString();
    _transactionId = widget.item?.transactionId?.toString();
    _type = widget.item?.type?.toString();
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _occurredAt = widget.item?.occurredAt;
    _note = widget.item?.note?.toString();
    _meta = widget.item?.meta?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
      if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
      if (_contractId?.isNotEmpty == true) 'contractId': _contractId,
      if (_billId?.isNotEmpty == true) 'billId': _billId,
      if (_transactionId?.isNotEmpty == true) 'transactionId': _transactionId,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_amount != null) 'amount': _amount,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_occurredAt != null) 'occurredAt': _occurredAt!.toIso8601String(),
      if (_note?.isNotEmpty == true) 'note': _note,
      if (_meta?.isNotEmpty == true) 'meta': _meta,
    };
    if (widget.item == null) {
      widget.ref.read(ledgerEntryCreateStateProvider.notifier).state = LedgerEntry.fromJson(data);
    } else {
      widget.ref.read(ledgerEntryUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'ledgerEntry': LedgerEntry.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ledger Entry' : 'New Ledger Entry'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.leaseId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Booking Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.bookingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contract Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.contractId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contractId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Bill Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.billId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _billId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Transaction Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.transactionId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _transactionId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.amount?.toString() ?? '',
                    onSaved: (v) => _amount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _occurredAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _occurredAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Occurred At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_occurredAt != null ? _formatDate(_occurredAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Note', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.note?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _note = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Meta', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.meta?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _meta = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ledger Entry'),
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

void _confirmDel(BuildContext context, WidgetRef ref, LedgerEntry item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ledger Entry?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(ledgerEntryDeleteStateProvider.notifier).state = item.id;
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
