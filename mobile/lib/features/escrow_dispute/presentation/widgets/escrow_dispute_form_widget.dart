import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── EscrowDispute Form Widget  |  Fields: reservationId, escrowAccountId, openedBy, disputeType, description, claimedAmount, currency, status, evidence, resolution, resolvedAmount, resolvedAt, resolvedBy, moderatorNotes, escalatedAt, deadlineAt

class EscrowDisputeFormWidget extends StatefulWidget {
  final EscrowDispute? item;
  final void Function(EscrowDispute)? onSubmit;
  const EscrowDisputeFormWidget({super.key, this.item, this.onSubmit});
  @override State<EscrowDisputeFormWidget> createState() => _EscrowDisputeFormWidgetState();
}

class _EscrowDisputeFormWidgetState extends State<EscrowDisputeFormWidget> {
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

  @override
  void dispose() {
    super.dispose();
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
    final result = widget.item != null
        ? EscrowDispute.fromJson({...widget.item!.toJson(), ...data})
        : EscrowDispute.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Escrow Account Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _escrowAccountId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Opened By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _openedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dispute Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _disputeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Claimed Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _claimedAmount = double.tryParse(v ?? ''),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Evidence', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _evidence = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Resolution', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _resolution = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Resolved Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _resolvedAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _resolvedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _resolvedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Resolved At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_resolvedAt != null ? _fmt(_resolvedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Resolved By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _resolvedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Moderator Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _moderatorNotes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _escalatedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _escalatedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Escalated At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_escalatedAt != null ? _fmt(_escalatedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _deadlineAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _deadlineAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Deadline At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_deadlineAt != null ? _fmt(_deadlineAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Escrow Dispute'),
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