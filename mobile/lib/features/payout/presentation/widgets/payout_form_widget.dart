import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Payout Form Widget  |  Fields: dealId, commissionId, recipientId, processorId, payoutStatus, payoutType, amount, grossAmount, netAmount, taxWithheld, fees, paymentMethod, scheduledDate, processedDate, completedDate, referenceNumber, trackingNumber, bankAccount, checkNumber, wireReference, achRouting, escrowReleaseDate, holdReason, failureReason, retryCount, maxRetries, nextRetryDate, priority, approvalRequired, approvedBy, approvedAt, notes, taxFormGenerated, taxFormSent, yearEndReport

class PayoutFormWidget extends StatefulWidget {
  final Payout? item;
  final void Function(Payout)? onSubmit;
  const PayoutFormWidget({super.key, this.item, this.onSubmit});
  @override State<PayoutFormWidget> createState() => _PayoutFormWidgetState();
}

class _PayoutFormWidgetState extends State<PayoutFormWidget> {
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

  @override
  void dispose() {
    super.dispose();
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
    final result = widget.item != null
        ? Payout.fromJson({...widget.item!.toJson(), ...data})
        : Payout.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Commission Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _commissionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Recipient Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _recipientId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Processor Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _processorId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payout Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _payoutStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payout Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _payoutType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Gross Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _grossAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Net Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _netAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tax Withheld', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _taxWithheld = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fees', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _fees = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payment Method', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _paymentMethod = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _scheduledDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _scheduledDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Scheduled Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_scheduledDate != null ? _fmt(_scheduledDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _processedDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _processedDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Processed Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_processedDate != null ? _fmt(_processedDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _completedDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _completedDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Completed Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_completedDate != null ? _fmt(_completedDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reference Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _referenceNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tracking Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _trackingNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bank Account', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _bankAccount = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Check Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _checkNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Wire Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _wireReference = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ach Routing', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _achRouting = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _escrowReleaseDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _escrowReleaseDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Escrow Release Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_escrowReleaseDate != null ? _fmt(_escrowReleaseDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hold Reason', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _holdReason = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Failure Reason', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _failureReason = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Retry Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _retryCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Retries', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxRetries = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _nextRetryDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _nextRetryDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Next Retry Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_nextRetryDate != null ? _fmt(_nextRetryDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Priority', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _priority = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Approval Required'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _approvalRequired,
                  onChanged: (v) { ss(() {}); setState(() => _approvalRequired = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Approved By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _approvedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _approvedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _approvedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Approved At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_approvedAt != null ? _fmt(_approvedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Tax Form Generated'),
                  secondary: const Icon(Icons.attach_money),
                  value: _taxFormGenerated,
                  onChanged: (v) { ss(() {}); setState(() => _taxFormGenerated = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Tax Form Sent'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _taxFormSent,
                  onChanged: (v) { ss(() {}); setState(() => _taxFormSent = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Year End Report'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _yearEndReport,
                  onChanged: (v) { ss(() {}); setState(() => _yearEndReport = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Payout'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}