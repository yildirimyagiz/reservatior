import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class EscrowReleaseFormWidget extends ConsumerStatefulWidget {
  final EscrowRelease? item;
  final Function(EscrowRelease) onSubmit;
  const EscrowReleaseFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<EscrowReleaseFormWidget> createState() =>
      _EscrowReleaseFormWidgetState();
}

class _EscrowReleaseFormWidgetState
    extends ConsumerState<EscrowReleaseFormWidget> {
  String? _escrowId;
  double? _releasePercent;
  double? _amount;
  String? _currency;
  DateTime? _scheduledAt;
  DateTime? _releasedAt;
  DateTime? _approvalCompletedAt;
  String? _approvedBy;
  String? _failureReason;
  int? _retryCount;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _escrowId = widget.item?.escrowId;
    _releasePercent = widget.item?.releasePercent;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency;
    _scheduledAt = widget.item?.scheduledAt;
    _releasedAt = widget.item?.releasedAt;
    _approvalCompletedAt = widget.item?.approvalCompletedAt;
    _approvedBy = widget.item?.approvedBy;
    _failureReason = widget.item?.failureReason;
    _retryCount = widget.item?.retryCount;
    _notes = widget.item?.notes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.escrowrelease'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.escrowrelease'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _escrowId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.escrowid'.tr()),
              onChanged: (v) => _escrowId = v,
            ),
            TextFormField(
              initialValue: _releasePercent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.releasepercent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _releasePercent = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_scheduled_at'.tr()}: ${_scheduledAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _scheduledAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _scheduledAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_released_at'.tr()}: ${_releasedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _releasedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _releasedAt = d);
              },
            ),
            ListTile(
              title: Text(
                'approvalCompletedAt: ${_approvalCompletedAt ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _approvalCompletedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _approvalCompletedAt = d);
              },
            ),
            TextFormField(
              initialValue: _approvedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.approvedby'.tr()),
              onChanged: (v) => _approvedBy = v,
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
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_escrowId != null) 'escrowId': _escrowId,
                  if (_releasePercent != null)
                    'releasePercent': _releasePercent,
                  if (_amount != null) 'amount': _amount,
                  if (_currency != null) 'currency': _currency,
                  if (_scheduledAt != null)
                    'scheduledAt': _scheduledAt!.toIso8601String(),
                  if (_releasedAt != null)
                    'releasedAt': _releasedAt!.toIso8601String(),
                  if (_approvalCompletedAt != null)
                    'approvalCompletedAt': _approvalCompletedAt!
                        .toIso8601String(),
                  if (_approvedBy != null) 'approvedBy': _approvedBy,
                  if (_failureReason != null) 'failureReason': _failureReason,
                  if (_retryCount != null) 'retryCount': _retryCount,
                  if (_notes != null) 'notes': _notes,
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
                  widget.onSubmit(EscrowRelease.fromJson(json));
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
