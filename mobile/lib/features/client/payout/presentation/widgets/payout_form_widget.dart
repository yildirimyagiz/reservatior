import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PayoutFormWidget extends ConsumerStatefulWidget {
  final Payout? item;
  final Function(Payout) onSubmit;
  const PayoutFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PayoutFormWidget> createState() => _PayoutFormWidgetState();
}

class _PayoutFormWidgetState extends ConsumerState<PayoutFormWidget> {
  String? _dealId;
  String? _commissionId;
  String? _recipientId;
  String? _processorId;
  double? _amount;
  double? _grossAmount;
  double? _netAmount;
  double? _taxWithheld;
  double? _fees;
  DateTime? _scheduledDate;
  DateTime? _processedDate;
  DateTime? _completedDate;
  String? _referenceNumber;
  String? _trackingNumber;
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
  bool? _approvalRequired;
  String? _approvedBy;
  DateTime? _approvedAt;
  String? _notes;
  bool? _taxFormGenerated;
  bool? _taxFormSent;
  bool? _yearEndReport;
  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId;
    _commissionId = widget.item?.commissionId;
    _recipientId = widget.item?.recipientId;
    _processorId = widget.item?.processorId;
    _amount = widget.item?.amount;
    _grossAmount = widget.item?.grossAmount;
    _netAmount = widget.item?.netAmount;
    _taxWithheld = widget.item?.taxWithheld;
    _fees = widget.item?.fees;
    _scheduledDate = widget.item?.scheduledDate;
    _processedDate = widget.item?.processedDate;
    _completedDate = widget.item?.completedDate;
    _referenceNumber = widget.item?.referenceNumber;
    _trackingNumber = widget.item?.trackingNumber;
    _checkNumber = widget.item?.checkNumber;
    _wireReference = widget.item?.wireReference;
    _achRouting = widget.item?.achRouting;
    _escrowReleaseDate = widget.item?.escrowReleaseDate;
    _holdReason = widget.item?.holdReason;
    _failureReason = widget.item?.failureReason;
    _retryCount = widget.item?.retryCount;
    _maxRetries = widget.item?.maxRetries;
    _nextRetryDate = widget.item?.nextRetryDate;
    _priority = widget.item?.priority;
    _approvalRequired = widget.item?.approvalRequired;
    _approvedBy = widget.item?.approvedBy;
    _approvedAt = widget.item?.approvedAt;
    _notes = widget.item?.notes;
    _taxFormGenerated = widget.item?.taxFormGenerated;
    _taxFormSent = widget.item?.taxFormSent;
    _yearEndReport = widget.item?.yearEndReport;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.payout'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.payout'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _dealId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dealid'.tr()),
              onChanged: (v) => _dealId = v,
            ),
            TextFormField(
              initialValue: _commissionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionid'.tr()),
              onChanged: (v) => _commissionId = v,
            ),
            TextFormField(
              initialValue: _recipientId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.recipientid'.tr()),
              onChanged: (v) => _recipientId = v,
            ),
            TextFormField(
              initialValue: _processorId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.processorid'.tr()),
              onChanged: (v) => _processorId = v,
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _grossAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.grossamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _grossAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _netAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.netamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _netAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _taxWithheld?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taxwithheld'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _taxWithheld = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _fees?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fees'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _fees = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_scheduled_date'.tr()}: ${_scheduledDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _scheduledDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _scheduledDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_processed_date'.tr()}: ${_processedDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _processedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _processedDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_completed_date'.tr()}: ${_completedDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _completedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _completedDate = d);
              },
            ),
            TextFormField(
              initialValue: _referenceNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.referencenumber'.tr()),
              onChanged: (v) => _referenceNumber = v,
            ),
            TextFormField(
              initialValue: _trackingNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.trackingnumber'.tr()),
              onChanged: (v) => _trackingNumber = v,
            ),
            TextFormField(
              initialValue: _checkNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checknumber'.tr()),
              onChanged: (v) => _checkNumber = v,
            ),
            TextFormField(
              initialValue: _wireReference?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.wirereference'.tr()),
              onChanged: (v) => _wireReference = v,
            ),
            TextFormField(
              initialValue: _achRouting?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.achrouting'.tr()),
              onChanged: (v) => _achRouting = v,
            ),
            ListTile(
              title: Text(
                'escrowReleaseDate: ${_escrowReleaseDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _escrowReleaseDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _escrowReleaseDate = d);
              },
            ),
            TextFormField(
              initialValue: _holdReason?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.holdreason'.tr()),
              onChanged: (v) => _holdReason = v,
            ),
            TextFormField(
              initialValue: _failureReason?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.failurereason'.tr()),
              onChanged: (v) => _failureReason = v,
            ),
            TextFormField(
              initialValue: _retryCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.retrycount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _retryCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxRetries?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxretries'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxRetries = int.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_next_retry_date'.tr()}: ${_nextRetryDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _nextRetryDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _nextRetryDate = d);
              },
            ),
            TextFormField(
              initialValue: _priority?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.priority'.tr()),
              onChanged: (v) => _priority = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.approvalrequired'.tr()),
              value: _approvalRequired ?? false,
              onChanged: (v) => setState(() => _approvalRequired = v),
            ),
            TextFormField(
              initialValue: _approvedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.approvedby'.tr()),
              onChanged: (v) => _approvedBy = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_approved_at'.tr()}: ${_approvedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _approvedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _approvedAt = d);
              },
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.taxformgenerated'.tr()),
              value: _taxFormGenerated ?? false,
              onChanged: (v) => setState(() => _taxFormGenerated = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.taxformsent'.tr()),
              value: _taxFormSent ?? false,
              onChanged: (v) => setState(() => _taxFormSent = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.yearendreport'.tr()),
              value: _yearEndReport ?? false,
              onChanged: (v) => setState(() => _yearEndReport = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_dealId != null) 'dealId': _dealId,
                  if (_commissionId != null) 'commissionId': _commissionId,
                  if (_recipientId != null) 'recipientId': _recipientId,
                  if (_processorId != null) 'processorId': _processorId,
                  if (_amount != null) 'amount': _amount,
                  if (_grossAmount != null) 'grossAmount': _grossAmount,
                  if (_netAmount != null) 'netAmount': _netAmount,
                  if (_taxWithheld != null) 'taxWithheld': _taxWithheld,
                  if (_fees != null) 'fees': _fees,
                  if (_scheduledDate != null)
                    'scheduledDate': _scheduledDate!.toIso8601String(),
                  if (_processedDate != null)
                    'processedDate': _processedDate!.toIso8601String(),
                  if (_completedDate != null)
                    'completedDate': _completedDate!.toIso8601String(),
                  if (_referenceNumber != null)
                    'referenceNumber': _referenceNumber,
                  if (_trackingNumber != null)
                    'trackingNumber': _trackingNumber,
                  if (_checkNumber != null) 'checkNumber': _checkNumber,
                  if (_wireReference != null) 'wireReference': _wireReference,
                  if (_achRouting != null) 'achRouting': _achRouting,
                  if (_escrowReleaseDate != null)
                    'escrowReleaseDate': _escrowReleaseDate!.toIso8601String(),
                  if (_holdReason != null) 'holdReason': _holdReason,
                  if (_failureReason != null) 'failureReason': _failureReason,
                  if (_retryCount != null) 'retryCount': _retryCount,
                  if (_maxRetries != null) 'maxRetries': _maxRetries,
                  if (_nextRetryDate != null)
                    'nextRetryDate': _nextRetryDate!.toIso8601String(),
                  if (_priority != null) 'priority': _priority,
                  'approvalRequired': _approvalRequired,
                  if (_approvedBy != null) 'approvedBy': _approvedBy,
                  if (_approvedAt != null)
                    'approvedAt': _approvedAt!.toIso8601String(),
                  if (_notes != null) 'notes': _notes,
                  'taxFormGenerated': _taxFormGenerated,
                  'taxFormSent': _taxFormSent,
                  'yearEndReport': _yearEndReport,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(Payout.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
