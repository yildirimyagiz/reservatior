import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/payout_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Payout Admin Page  |  40 fields
// Auto-generated — edit with care
// ================================================================

class PayoutAdminPage extends ConsumerWidget {
  const PayoutAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(payoutLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payout Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(payoutListProvider)),
        ],
      ),
      body: const _PayoutBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PayoutFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Payout'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _PayoutBody extends ConsumerStatefulWidget {
  const _PayoutBody({super.key});
  @override ConsumerState<_PayoutBody> createState() => __PayoutBodyState();
}

class __PayoutBodyState extends ConsumerState<_PayoutBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(payoutListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Payouts…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.dealId?.toString() ?? '') + " " + (item.commissionId?.toString() ?? '') + " " + (item.recipientId?.toString() ?? '') + " " + (item.processorId?.toString() ?? '') + " " + (item.referenceNumber?.toString() ?? '') + " " + (item.trackingNumber?.toString() ?? '') + " " + (item.checkNumber?.toString() ?? '') + " " + (item.wireReference?.toString() ?? '') + " " + (item.achRouting?.toString() ?? '') + " " + (item.holdReason?.toString() ?? '') + " " + (item.failureReason?.toString() ?? '') + " " + (item.priority?.toString() ?? '') + " " + (item.approvedBy?.toString() ?? '') + " " + (item.notes?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Payouts yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(payoutListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.referenceNumber != null && item.referenceNumber!.toString().isNotEmpty ? item.referenceNumber!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.referenceNumber ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Amount: ' + item.amount?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.payoutStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.payoutStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(payoutListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Payout item) {
    final s = item.payoutStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Payout item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payout Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Deal Id', item.dealId?.toString() ?? 'N/A', Icons.link),
              _row('Commission Id', item.commissionId?.toString() ?? 'N/A', Icons.link),
              _row('Recipient Id', item.recipientId?.toString() ?? 'N/A', Icons.link),
              _row('Processor Id', item.processorId?.toString() ?? 'N/A', Icons.link),
              _row('Payout Status', item.payoutStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Payout Type', item.payoutType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Gross Amount', item.grossAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Net Amount', item.netAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Tax Withheld', item.taxWithheld?.toString() ?? 'N/A', Icons.numbers),
              _row('Fees', item.fees?.toString() ?? 'N/A', Icons.attach_money),
              _row('Payment Method', item.paymentMethod?.toString() ?? 'N/A', Icons.text_fields),
              _row('Scheduled Date', _formatDate(item.scheduledDate), Icons.calendar_today),
              _row('Processed Date', _formatDate(item.processedDate), Icons.calendar_today),
              _row('Completed Date', _formatDate(item.completedDate), Icons.calendar_today),
              _row('Reference Number', item.referenceNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Tracking Number', item.trackingNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Bank Account', item.bankAccount?.toString() ?? 'N/A', Icons.text_fields),
              _row('Check Number', item.checkNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Wire Reference', item.wireReference?.toString() ?? 'N/A', Icons.text_fields),
              _row('Ach Routing', item.achRouting?.toString() ?? 'N/A', Icons.text_fields),
              _row('Escrow Release Date', _formatDate(item.escrowReleaseDate), Icons.calendar_today),
              _row('Hold Reason', item.holdReason?.toString() ?? 'N/A', Icons.text_fields),
              _row('Failure Reason', item.failureReason?.toString() ?? 'N/A', Icons.text_fields),
              _row('Retry Count', item.retryCount?.toString() ?? 'N/A', Icons.numbers),
              _row('Max Retries', item.maxRetries?.toString() ?? 'N/A', Icons.numbers),
              _row('Next Retry Date', _formatDate(item.nextRetryDate), Icons.calendar_today),
              _row('Priority', item.priority?.toString() ?? 'N/A', Icons.text_fields),
              _row('Approval Required', (item.approvalRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Approved By', item.approvedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Approved At', _formatDate(item.approvedAt), Icons.calendar_today),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
              _row('Tax Form Generated', (item.taxFormGenerated == true ? 'Yes' : 'No'), Icons.attach_money),
              _row('Tax Form Sent', (item.taxFormSent == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Year End Report', (item.yearEndReport == true ? 'Yes' : 'No'), Icons.toggle_on),
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

void _showForm(BuildContext context, WidgetRef ref, {Payout? item}) {
  showDialog(context: context, builder: (ctx) => _PayoutForm(item: item, ref: ref));
}

class _PayoutForm extends ConsumerStatefulWidget {
  final Payout? item;
  final WidgetRef ref;
  const _PayoutForm({super.key, this.item, required this.ref});
  @override ConsumerState<_PayoutForm> createState() => __PayoutFormState();
}

class __PayoutFormState extends ConsumerState<_PayoutForm> {
  final _key = GlobalKey<FormState>();

  String? _dealId;
  String? _commissionId;
  String? _recipientId;
  String? _processorId;
  String? _payoutStatus;
  String? _payoutType;
  double? _amount;
  double? _grossAmount;
  double? _netAmount;
  double? _taxWithheld;
  double? _fees;
  String? _paymentMethod;
  DateTime? _scheduledDate;
  DateTime? _processedDate;
  DateTime? _completedDate;
  String? _referenceNumber;
  String? _trackingNumber;
  String? _bankAccount;
  String? _checkNumber;
  String? _wireReference;
  String? _achRouting;
  DateTime? _escrowReleaseDate;
  String? _holdReason;
  String? _failureReason;
  int? _retryCount;
  int? _maxRetries;
  DateTime? _nextRetryDate;
  String? _priority;
  bool _approvalRequired = false;
  String? _approvedBy;
  DateTime? _approvedAt;
  String? _notes;
  bool _taxFormGenerated = false;
  bool _taxFormSent = false;
  bool _yearEndReport = false;

  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId?.toString();
    _commissionId = widget.item?.commissionId?.toString();
    _recipientId = widget.item?.recipientId?.toString();
    _processorId = widget.item?.processorId?.toString();
    _payoutStatus = widget.item?.payoutStatus?.toString();
    _payoutType = widget.item?.payoutType?.toString();
    _amount = widget.item?.amount;
    _grossAmount = widget.item?.grossAmount;
    _netAmount = widget.item?.netAmount;
    _taxWithheld = widget.item?.taxWithheld;
    _fees = widget.item?.fees;
    _paymentMethod = widget.item?.paymentMethod?.toString();
    _scheduledDate = widget.item?.scheduledDate;
    _processedDate = widget.item?.processedDate;
    _completedDate = widget.item?.completedDate;
    _referenceNumber = widget.item?.referenceNumber?.toString();
    _trackingNumber = widget.item?.trackingNumber?.toString();
    _bankAccount = widget.item?.bankAccount?.toString();
    _checkNumber = widget.item?.checkNumber?.toString();
    _wireReference = widget.item?.wireReference?.toString();
    _achRouting = widget.item?.achRouting?.toString();
    _escrowReleaseDate = widget.item?.escrowReleaseDate;
    _holdReason = widget.item?.holdReason?.toString();
    _failureReason = widget.item?.failureReason?.toString();
    _retryCount = widget.item?.retryCount;
    _maxRetries = widget.item?.maxRetries;
    _nextRetryDate = widget.item?.nextRetryDate;
    _priority = widget.item?.priority?.toString();
    _approvalRequired = widget.item?.approvalRequired ?? false;
    _approvedBy = widget.item?.approvedBy?.toString();
    _approvedAt = widget.item?.approvedAt;
    _notes = widget.item?.notes?.toString();
    _taxFormGenerated = widget.item?.taxFormGenerated ?? false;
    _taxFormSent = widget.item?.taxFormSent ?? false;
    _yearEndReport = widget.item?.yearEndReport ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_dealId?.isNotEmpty == true) 'dealId': _dealId,
      if (_commissionId?.isNotEmpty == true) 'commissionId': _commissionId,
      if (_recipientId?.isNotEmpty == true) 'recipientId': _recipientId,
      if (_processorId?.isNotEmpty == true) 'processorId': _processorId,
      if (_payoutStatus?.isNotEmpty == true) 'payoutStatus': _payoutStatus,
      if (_payoutType?.isNotEmpty == true) 'payoutType': _payoutType,
      if (_amount != null) 'amount': _amount,
      if (_grossAmount != null) 'grossAmount': _grossAmount,
      if (_netAmount != null) 'netAmount': _netAmount,
      if (_taxWithheld != null) 'taxWithheld': _taxWithheld,
      if (_fees != null) 'fees': _fees,
      if (_paymentMethod?.isNotEmpty == true) 'paymentMethod': _paymentMethod,
      if (_scheduledDate != null) 'scheduledDate': _scheduledDate!.toIso8601String(),
      if (_processedDate != null) 'processedDate': _processedDate!.toIso8601String(),
      if (_completedDate != null) 'completedDate': _completedDate!.toIso8601String(),
      if (_referenceNumber?.isNotEmpty == true) 'referenceNumber': _referenceNumber,
      if (_trackingNumber?.isNotEmpty == true) 'trackingNumber': _trackingNumber,
      if (_bankAccount?.isNotEmpty == true) 'bankAccount': _bankAccount,
      if (_checkNumber?.isNotEmpty == true) 'checkNumber': _checkNumber,
      if (_wireReference?.isNotEmpty == true) 'wireReference': _wireReference,
      if (_achRouting?.isNotEmpty == true) 'achRouting': _achRouting,
      if (_escrowReleaseDate != null) 'escrowReleaseDate': _escrowReleaseDate!.toIso8601String(),
      if (_holdReason?.isNotEmpty == true) 'holdReason': _holdReason,
      if (_failureReason?.isNotEmpty == true) 'failureReason': _failureReason,
      if (_retryCount != null) 'retryCount': _retryCount,
      if (_maxRetries != null) 'maxRetries': _maxRetries,
      if (_nextRetryDate != null) 'nextRetryDate': _nextRetryDate!.toIso8601String(),
      if (_priority?.isNotEmpty == true) 'priority': _priority,
      'approvalRequired': _approvalRequired,
      if (_approvedBy?.isNotEmpty == true) 'approvedBy': _approvedBy,
      if (_approvedAt != null) 'approvedAt': _approvedAt!.toIso8601String(),
      if (_notes?.isNotEmpty == true) 'notes': _notes,
      'taxFormGenerated': _taxFormGenerated,
      'taxFormSent': _taxFormSent,
      'yearEndReport': _yearEndReport,
    };
    if (widget.item == null) {
      widget.ref.read(payoutCreateStateProvider.notifier).state = Payout.fromJson(data);
    } else {
      widget.ref.read(payoutUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'payout': Payout.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Payout' : 'New Payout'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.dealId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Commission Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.commissionId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _commissionId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Recipient Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.recipientId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _recipientId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Processor Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.processorId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _processorId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Payout Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.payoutStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _payoutStatus = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Payout Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.payoutType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _payoutType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.amount?.toString() ?? '',
                    onSaved: (v) => _amount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Gross Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.grossAmount?.toString() ?? '',
                    onSaved: (v) => _grossAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Net Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.netAmount?.toString() ?? '',
                    onSaved: (v) => _netAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Tax Withheld', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.taxWithheld?.toString() ?? '',
                    onSaved: (v) => _taxWithheld = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Fees', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.fees?.toString() ?? '',
                    onSaved: (v) => _fees = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Payment Method', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.paymentMethod?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _paymentMethod = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _scheduledDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _scheduledDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Scheduled Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_scheduledDate != null ? _formatDate(_scheduledDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _processedDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _processedDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Processed Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_processedDate != null ? _formatDate(_processedDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _completedDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _completedDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Completed Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_completedDate != null ? _formatDate(_completedDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reference Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.referenceNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _referenceNumber = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tracking Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.trackingNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _trackingNumber = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Bank Account', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.bankAccount?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _bankAccount = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Check Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.checkNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _checkNumber = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Wire Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.wireReference?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _wireReference = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Ach Routing', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.achRouting?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _achRouting = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _escrowReleaseDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _escrowReleaseDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Escrow Release Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_escrowReleaseDate != null ? _formatDate(_escrowReleaseDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Hold Reason', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.holdReason?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _holdReason = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Failure Reason', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.failureReason?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _failureReason = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Retry Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.retryCount?.toString() ?? '',
                    onSaved: (v) => _retryCount = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Retries', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.maxRetries?.toString() ?? '',
                    onSaved: (v) => _maxRetries = int.tryParse(v ?? ''),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _nextRetryDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _nextRetryDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Next Retry Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_nextRetryDate != null ? _formatDate(_nextRetryDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Priority', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.priority?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _priority = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Approval Required'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.approvalRequired ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _approvalRequired = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Approved By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.approvedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _approvedBy = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _approvedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _approvedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Approved At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_approvedAt != null ? _formatDate(_approvedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Tax Form Generated'),
                      secondary: const Icon(Icons.attach_money),
                      value: widget.item.taxFormGenerated ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _taxFormGenerated = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Tax Form Sent'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.taxFormSent ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _taxFormSent = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Year End Report'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.yearEndReport ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _yearEndReport = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Payout'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Payout item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Payout?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(payoutDeleteStateProvider.notifier).state = item.id;
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
