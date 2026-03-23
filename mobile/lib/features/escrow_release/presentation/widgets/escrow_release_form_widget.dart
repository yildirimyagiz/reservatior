import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── EscrowRelease Form Widget  |  Fields: escrowId, triggerEvent, releasePercent, amount, currency, status, scheduledAt, releasedAt, approvals, approvalCompletedAt, approvedBy, failureReason, retryCount, notes

class EscrowReleaseFormWidget extends StatefulWidget {
  final EscrowRelease? item;
  final void Function(EscrowRelease)? onSubmit;
  const EscrowReleaseFormWidget({super.key, this.item, this.onSubmit});
  @override State<EscrowReleaseFormWidget> createState() => _EscrowReleaseFormWidgetState();
}

class _EscrowReleaseFormWidgetState extends State<EscrowReleaseFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _escrowId;
  String? _triggerEvent;
  double? _releasePercent;
  double? _amount;
  String? _currency;
  String? _status;
  DateTime? _scheduledAt;
  DateTime? _releasedAt;
  String? _approvals;
  DateTime? _approvalCompletedAt;
  String? _approvedBy;
  String? _failureReason;
  int? _retryCount;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _escrowId = widget.item?.escrowId?.toString();
    _triggerEvent = widget.item?.triggerEvent?.toString();
    _releasePercent = widget.item?.releasePercent;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _scheduledAt = widget.item?.scheduledAt;
    _releasedAt = widget.item?.releasedAt;
    _approvals = widget.item?.approvals?.toString();
    _approvalCompletedAt = widget.item?.approvalCompletedAt;
    _approvedBy = widget.item?.approvedBy?.toString();
    _failureReason = widget.item?.failureReason?.toString();
    _retryCount = widget.item?.retryCount;
    _notes = widget.item?.notes?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_escrowId?.isNotEmpty == true) 'escrowId': _escrowId,
        if (_triggerEvent?.isNotEmpty == true) 'triggerEvent': _triggerEvent,
        if (_releasePercent != null) 'releasePercent': _releasePercent,
        if (_amount != null) 'amount': _amount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_scheduledAt != null) 'scheduledAt': _scheduledAt!.toIso8601String(),
        if (_releasedAt != null) 'releasedAt': _releasedAt!.toIso8601String(),
        if (_approvals?.isNotEmpty == true) 'approvals': _approvals,
        if (_approvalCompletedAt != null) 'approvalCompletedAt': _approvalCompletedAt!.toIso8601String(),
        if (_approvedBy?.isNotEmpty == true) 'approvedBy': _approvedBy,
        if (_failureReason?.isNotEmpty == true) 'failureReason': _failureReason,
        if (_retryCount != null) 'retryCount': _retryCount,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? EscrowRelease.fromJson({...widget.item!.toJson(), ...data})
        : EscrowRelease.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Escrow Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _escrowId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Trigger Event', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _triggerEvent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Release Percent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _releasePercent = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _scheduledAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _scheduledAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Scheduled At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_scheduledAt != null ? _fmt(_scheduledAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _releasedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _releasedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Released At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_releasedAt != null ? _fmt(_releasedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Approvals', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _approvals = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _approvalCompletedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _approvalCompletedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Approval Completed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_approvalCompletedAt != null ? _fmt(_approvalCompletedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Approved By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _approvedBy = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Escrow Release'),
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