import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/shared/providers/providers.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Contract Admin Page  |  16 fields
// Auto-generated — edit with care
// ================================================================

class ContractAdminPage extends ConsumerWidget {
  const ContractAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(contractListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contract Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (async.isLoading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(contractListProvider)),
        ],
      ),
      body: _ContractBody(async: async),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'ContractFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Contract'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _ContractBody extends ConsumerStatefulWidget {
  const _ContractBody({required this.async});
  final AsyncValue<List<Contract>> async;
  @override ConsumerState<_ContractBody> createState() => __ContractBodyState();
}

class __ContractBodyState extends ConsumerState<_ContractBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Contracts…',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _q.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _ctrl.clear(); setState(() => _q = ''); })
                : null,
            border: const OutlineInputBorder(), isDense: true,
          ),
          onChanged: (v) => setState(() => _q = v.toLowerCase()),
        ),
      ),
      Expanded(child: widget.async.when(
        data: (items) {
          final list = _q.isEmpty
              ? items
              : items.where((Contract item) {
                  final searchStr = '${item.orgId?.toString() ?? ''} ${item.propertyId?.toString() ?? ''} ${item.listingId?.toString() ?? ''} ${item.leaseId?.toString() ?? ''} ${item.bookingId?.toString() ?? ''} ${item.title?.toString() ?? ''} ${item.createdBy?.toString() ?? ''}';
                  return searchStr.toLowerCase().contains(_q);
                }).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Contracts yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(contractListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.title != null && item.title!.toString().isNotEmpty ? item.title!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.title ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ${item.status?.toString() ?? 'N/A'}'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.status != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withValues(alpha: 0.4)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(contractListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Contract item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Contract item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contract Details'),
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
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
              _row('Effective From', _formatDate(item.effectiveFrom), Icons.calendar_today),
              _row('Effective To', _formatDate(item.effectiveTo), Icons.calendar_today),
              _row('Next Renewal At', _formatDate(item.nextRenewalAt), Icons.calendar_today),
              _row('Renewal Notice Days', item.renewalNoticeDays?.toString() ?? 'N/A', Icons.numbers),
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

void _showForm(BuildContext context, WidgetRef ref, {Contract? item}) {
  showDialog(context: context, builder: (ctx) => _ContractForm(item: item, ref: ref));
}

class _ContractForm extends ConsumerStatefulWidget {
  final Contract? item;
  final WidgetRef ref;
  const _ContractForm({this.item, required this.ref});
  @override ConsumerState<_ContractForm> createState() => __ContractFormState();
}

class __ContractFormState extends ConsumerState<_ContractForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _type;
  String? _status;
  String? _title;
  DateTime? _effectiveFrom;
  DateTime? _effectiveTo;
  DateTime? _nextRenewalAt;
  int? _renewalNoticeDays;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _bookingId = widget.item?.bookingId?.toString();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _title = widget.item?.title?.toString();
    _effectiveFrom = widget.item?.effectiveFrom;
    _effectiveTo = widget.item?.effectiveTo;
    _nextRenewalAt = widget.item?.nextRenewalAt;
    _renewalNoticeDays = widget.item?.renewalNoticeDays;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
      if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_title?.isNotEmpty == true) 'title': _title,
      if (_effectiveFrom != null) 'effectiveFrom': _effectiveFrom!.toIso8601String(),
      if (_effectiveTo != null) 'effectiveTo': _effectiveTo!.toIso8601String(),
      if (_nextRenewalAt != null) 'nextRenewalAt': _nextRenewalAt!.toIso8601String(),
      if (_renewalNoticeDays != null) 'renewalNoticeDays': _renewalNoticeDays,
    };
    if (widget.item == null) {
      widget.ref.read(contractCreateStateProvider.notifier).state = Contract.fromJson(data);
    } else {
      widget.ref.read(contractUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'contract': Contract.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Contract' : 'New Contract'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Listing Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Lease Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.leaseId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Booking Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.bookingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.title?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _title = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _effectiveFrom ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _effectiveFrom = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Effective From',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_effectiveFrom != null ? _formatDate(_effectiveFrom) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _effectiveTo ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _effectiveTo = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Effective To',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_effectiveTo != null ? _formatDate(_effectiveTo) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _nextRenewalAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _nextRenewalAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Next Renewal At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_nextRenewalAt != null ? _formatDate(_nextRenewalAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Renewal Notice Days', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.renewalNoticeDays?.toString() ?? '',
                    onSaved: (v) => _renewalNoticeDays = int.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Contract'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Contract item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Contract?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(contractDeleteStateProvider.notifier).state = item.id;
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
