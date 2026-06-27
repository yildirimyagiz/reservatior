import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class EscrowStatusHistoryFormWidget extends ConsumerStatefulWidget {
  final EscrowStatusHistory? item;
  final Function(EscrowStatusHistory) onSubmit;
  const EscrowStatusHistoryFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<EscrowStatusHistoryFormWidget> createState() =>
      _EscrowStatusHistoryFormWidgetState();
}

class _EscrowStatusHistoryFormWidgetState
    extends ConsumerState<EscrowStatusHistoryFormWidget> {
  String? _escrowId;
  String? _changedBy;
  String? _reason;
  DateTime? _changedAt;
  @override
  void initState() {
    super.initState();
    _escrowId = widget.item?.escrowId;
    _changedBy = widget.item?.changedBy;
    _reason = widget.item?.reason;
    _changedAt = widget.item?.changedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.escrowstatushistory'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.escrowstatushistory'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _escrowId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.escrowid'.tr()),
              onChanged: (v) => _escrowId = v,
            ),
            TextFormField(
              initialValue: _changedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.changedby'.tr()),
              onChanged: (v) => _changedBy = v,
            ),
            TextFormField(
              initialValue: _reason?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reason'.tr()),
              onChanged: (v) => _reason = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_changed_at'.tr()}: ${_changedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _changedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _changedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_escrowId != null) 'escrowId': _escrowId,
                  if (_changedBy != null) 'changedBy': _changedBy,
                  if (_reason != null) 'reason': _reason,
                  if (_changedAt != null)
                    'changedAt': _changedAt!.toIso8601String(),
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
                  widget.onSubmit(EscrowStatusHistory.fromJson(json));
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
