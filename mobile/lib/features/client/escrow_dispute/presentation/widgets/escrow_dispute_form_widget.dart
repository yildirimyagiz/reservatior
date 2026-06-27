import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class EscrowDisputeFormWidget extends ConsumerStatefulWidget {
  final EscrowDispute? item;
  final Function(EscrowDispute) onSubmit;
  const EscrowDisputeFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<EscrowDisputeFormWidget> createState() =>
      _EscrowDisputeFormWidgetState();
}

class _EscrowDisputeFormWidgetState
    extends ConsumerState<EscrowDisputeFormWidget> {
  String? _reservationId;
  String? _escrowAccountId;
  String? _description;
  double? _claimedAmount;
  String? _currency;
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
    _reservationId = widget.item?.reservationId;
    _escrowAccountId = widget.item?.escrowAccountId;
    _description = widget.item?.description;
    _claimedAmount = widget.item?.claimedAmount;
    _currency = widget.item?.currency;
    _resolution = widget.item?.resolution;
    _resolvedAmount = widget.item?.resolvedAmount;
    _resolvedAt = widget.item?.resolvedAt;
    _resolvedBy = widget.item?.resolvedBy;
    _moderatorNotes = widget.item?.moderatorNotes;
    _escalatedAt = widget.item?.escalatedAt;
    _deadlineAt = widget.item?.deadlineAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.escrowdispute'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.escrowdispute'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _escrowAccountId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.escrowaccountid'.tr()),
              onChanged: (v) => _escrowAccountId = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _claimedAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.claimedamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _claimedAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _resolution?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.resolution'.tr()),
              onChanged: (v) => _resolution = v,
            ),
            TextFormField(
              initialValue: _resolvedAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.resolvedamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _resolvedAmount = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_resolved_at'.tr()}: ${_resolvedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _resolvedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _resolvedAt = d);
              },
            ),
            TextFormField(
              initialValue: _resolvedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.resolvedby'.tr()),
              onChanged: (v) => _resolvedBy = v,
            ),
            TextFormField(
              initialValue: _moderatorNotes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.moderatornotes'.tr()),
              onChanged: (v) => _moderatorNotes = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_escalated_at'.tr()}: ${_escalatedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _escalatedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _escalatedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_deadline_at'.tr()}: ${_deadlineAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _deadlineAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _deadlineAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_escrowAccountId != null)
                    'escrowAccountId': _escrowAccountId,
                  if (_description != null) 'description': _description,
                  if (_claimedAmount != null) 'claimedAmount': _claimedAmount,
                  if (_currency != null) 'currency': _currency,
                  if (_resolution != null) 'resolution': _resolution,
                  if (_resolvedAmount != null)
                    'resolvedAmount': _resolvedAmount,
                  if (_resolvedAt != null)
                    'resolvedAt': _resolvedAt!.toIso8601String(),
                  if (_resolvedBy != null) 'resolvedBy': _resolvedBy,
                  if (_moderatorNotes != null)
                    'moderatorNotes': _moderatorNotes,
                  if (_escalatedAt != null)
                    'escalatedAt': _escalatedAt!.toIso8601String(),
                  if (_deadlineAt != null)
                    'deadlineAt': _deadlineAt!.toIso8601String(),
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
                  widget.onSubmit(EscrowDispute.fromJson(json));
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
