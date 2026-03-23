import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/financial_record_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// FinancialRecord Admin Page  |  23 fields
// Auto-generated — edit with care
// ================================================================

class FinancialRecordAdminPage extends ConsumerWidget {
  const FinancialRecordAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(financialRecordLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Record Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(financialRecordListProvider)),
        ],
      ),
      body: const _FinancialRecordBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'FinancialRecordFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Financial Record'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _FinancialRecordBody extends ConsumerStatefulWidget {
  const _FinancialRecordBody({super.key});
  @override ConsumerState<_FinancialRecordBody> createState() => __FinancialRecordBodyState();
}

class __FinancialRecordBodyState extends ConsumerState<_FinancialRecordBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(financialRecordListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Financial Records…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.leaseId?.toString() ?? '') + " " + (item.bookingId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.vendorContactId?.toString() ?? '') + " " + (item.type?.toString() ?? '') + " " + (item.currency?.toString() ?? '') + " " + (item.category?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.notes?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Financial Records yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(financialRecordListProvider),
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
                    subtitle: Text('Payment Status: ' + item.paymentStatus?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.paymentStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.paymentStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(financialRecordListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(FinancialRecord item) {
    final s = item.paymentStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, FinancialRecord item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Financial Record Details'),
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
              _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
              _row('Vendor Contact Id', item.vendorContactId?.toString() ?? 'N/A', Icons.link),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Record Type', item.recordType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Occurred At', _formatDate(item.occurredAt), Icons.calendar_today),
              _row('Due Date', _formatDate(item.dueDate), Icons.calendar_today),
              _row('Bill Data', item.billData?.toString() ?? 'N/A', Icons.text_fields),
              _row('Category', item.category?.toString() ?? 'N/A', Icons.text_fields),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
              _row('Payment Status', item.paymentStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Paid At', _formatDate(item.paidAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {FinancialRecord? item}) {
  showDialog(context: context, builder: (ctx) => _FinancialRecordForm(item: item, ref: ref));
}

class _FinancialRecordForm extends ConsumerStatefulWidget {
  final FinancialRecord? item;
  final WidgetRef ref;
  const _FinancialRecordForm({super.key, this.item, required this.ref});
  @override ConsumerState<_FinancialRecordForm> createState() => __FinancialRecordFormState();
}

class __FinancialRecordFormState extends ConsumerState<_FinancialRecordForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _reservationId;
  String? _vendorContactId;
  String? _type;
  String? _recordType;
  double? _amount;
  String? _currency;
  DateTime? _occurredAt;
  DateTime? _dueDate;
  String? _billData;
  String? _category;
  String? _description;
  String? _notes;
  String? _paymentStatus;
  DateTime? _paidAt;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _bookingId = widget.item?.bookingId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _vendorContactId = widget.item?.vendorContactId?.toString();
    _type = widget.item?.type?.toString();
    _recordType = widget.item?.recordType?.toString();
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _occurredAt = widget.item?.occurredAt;
    _dueDate = widget.item?.dueDate;
    _billData = widget.item?.billData?.toString();
    _category = widget.item?.category?.toString();
    _description = widget.item?.description?.toString();
    _notes = widget.item?.notes?.toString();
    _paymentStatus = widget.item?.paymentStatus?.toString();
    _paidAt = widget.item?.paidAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
      if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
      if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
      if (_vendorContactId?.isNotEmpty == true) 'vendorContactId': _vendorContactId,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_recordType?.isNotEmpty == true) 'recordType': _recordType,
      if (_amount != null) 'amount': _amount,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_occurredAt != null) 'occurredAt': _occurredAt!.toIso8601String(),
      if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
      if (_billData?.isNotEmpty == true) 'billData': _billData,
      if (_category?.isNotEmpty == true) 'category': _category,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_notes?.isNotEmpty == true) 'notes': _notes,
      if (_paymentStatus?.isNotEmpty == true) 'paymentStatus': _paymentStatus,
      if (_paidAt != null) 'paidAt': _paidAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(financialRecordCreateStateProvider.notifier).state = FinancialRecord.fromJson(data);
    } else {
      widget.ref.read(financialRecordUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'financialRecord': FinancialRecord.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Financial Record' : 'New Financial Record'),
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
                    decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.reservationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Vendor Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.vendorContactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _vendorContactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Record Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.recordType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _recordType = v?.isEmpty == true ? null : v,
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
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _dueDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Due Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_dueDate != null ? _formatDate(_dueDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Bill Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.billData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _billData = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.category?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _category = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Payment Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.paymentStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _paymentStatus = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _paidAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _paidAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Paid At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_paidAt != null ? _formatDate(_paidAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Financial Record'),
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

void _confirmDel(BuildContext context, WidgetRef ref, FinancialRecord item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Financial Record?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(financialRecordDeleteStateProvider.notifier).state = item.id;
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
