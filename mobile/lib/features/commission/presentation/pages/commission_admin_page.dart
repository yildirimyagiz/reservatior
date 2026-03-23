import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/commission_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Commission Admin Page  |  15 fields
// Auto-generated — edit with care
// ================================================================

class CommissionAdminPage extends ConsumerWidget {
  const CommissionAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(commissionLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commission Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(commissionListProvider)),
        ],
      ),
      body: const _CommissionBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'CommissionFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Commission'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _CommissionBody extends ConsumerStatefulWidget {
  const _CommissionBody({super.key});
  @override ConsumerState<_CommissionBody> createState() => __CommissionBodyState();
}

class __CommissionBodyState extends ConsumerState<_CommissionBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(commissionListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Commissions…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.leaseId?.toString() ?? '') + " " + (item.bookingId?.toString() ?? '') + " " + (item.transactionId?.toString() ?? '') + " " + (item.beneficiaryUserId?.toString() ?? '') + " " + (item.beneficiaryOrgId?.toString() ?? '') + " " + (item.currency?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Commissions yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(commissionListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.currency != null && item.currency!.toString().isNotEmpty ? item.currency!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.currency ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(commissionListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Commission item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Commission Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
              _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
              _row('Booking Id', item.bookingId?.toString() ?? 'N/A', Icons.link),
              _row('Transaction Id', item.transactionId?.toString() ?? 'N/A', Icons.link),
              _row('Beneficiary User Id', item.beneficiaryUserId?.toString() ?? 'N/A', Icons.link),
              _row('Beneficiary Org Id', item.beneficiaryOrgId?.toString() ?? 'N/A', Icons.link),
              _row('Rule Data', item.ruleData?.toString() ?? 'N/A', Icons.text_fields),
              _row('Amount Base', item.amountBase?.toString() ?? 'N/A', Icons.attach_money),
              _row('Commission Amount', item.commissionAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Records', item.records?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {Commission? item}) {
  showDialog(context: context, builder: (ctx) => _CommissionForm(item: item, ref: ref));
}

class _CommissionForm extends ConsumerStatefulWidget {
  final Commission? item;
  final WidgetRef ref;
  const _CommissionForm({super.key, this.item, required this.ref});
  @override ConsumerState<_CommissionForm> createState() => __CommissionFormState();
}

class __CommissionFormState extends ConsumerState<_CommissionForm> {
  final _key = GlobalKey<FormState>();

  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _transactionId;
  String? _beneficiaryUserId;
  String? _beneficiaryOrgId;
  String? _ruleData;
  double? _amountBase;
  double? _commissionAmount;
  String? _currency;
  String? _records;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _bookingId = widget.item?.bookingId?.toString();
    _transactionId = widget.item?.transactionId?.toString();
    _beneficiaryUserId = widget.item?.beneficiaryUserId?.toString();
    _beneficiaryOrgId = widget.item?.beneficiaryOrgId?.toString();
    _ruleData = widget.item?.ruleData?.toString();
    _amountBase = widget.item?.amountBase;
    _commissionAmount = widget.item?.commissionAmount;
    _currency = widget.item?.currency?.toString();
    _records = widget.item?.records?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
      if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
      if (_transactionId?.isNotEmpty == true) 'transactionId': _transactionId,
      if (_beneficiaryUserId?.isNotEmpty == true) 'beneficiaryUserId': _beneficiaryUserId,
      if (_beneficiaryOrgId?.isNotEmpty == true) 'beneficiaryOrgId': _beneficiaryOrgId,
      if (_ruleData?.isNotEmpty == true) 'ruleData': _ruleData,
      if (_amountBase != null) 'amountBase': _amountBase,
      if (_commissionAmount != null) 'commissionAmount': _commissionAmount,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_records?.isNotEmpty == true) 'records': _records,
    };
    if (widget.item == null) {
      widget.ref.read(commissionCreateStateProvider.notifier).state = Commission.fromJson(data);
    } else {
      widget.ref.read(commissionUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'commission': Commission.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Commission' : 'New Commission'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.leaseId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Booking Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.bookingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Transaction Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.transactionId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _transactionId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Beneficiary User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.beneficiaryUserId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _beneficiaryUserId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Beneficiary Org Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.beneficiaryOrgId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _beneficiaryOrgId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Rule Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.ruleData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ruleData = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Amount Base', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.amountBase?.toString() ?? '',
                    onSaved: (v) => _amountBase = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Commission Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.commissionAmount?.toString() ?? '',
                    onSaved: (v) => _commissionAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Records', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.records?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _records = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Commission'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Commission item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Commission?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(commissionDeleteStateProvider.notifier).state = item.id;
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
