import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class RentScheduleFormWidget extends ConsumerStatefulWidget {
  final RentSchedule? item;
  final Function(RentSchedule) onSubmit;
  const RentScheduleFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<RentScheduleFormWidget> createState() =>
      _RentScheduleFormWidgetState();
}

class _RentScheduleFormWidgetState
    extends ConsumerState<RentScheduleFormWidget> {
  String? _leaseId;
  DateTime? _dueDate;
  double? _amount;
  String? _currency;
  DateTime? _paidAt;
  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId;
    _dueDate = widget.item?.dueDate;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency;
    _paidAt = widget.item?.paidAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.rentschedule'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.rentschedule'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_due_date'.tr()}: ${_dueDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _dueDate = d);
              },
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
              title: Text("${'mobile.admin.field_paid_at'.tr()}: ${_paidAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _paidAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _paidAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
                  if (_amount != null) 'amount': _amount,
                  if (_currency != null) 'currency': _currency,
                  if (_paidAt != null) 'paidAt': _paidAt!.toIso8601String(),
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
                  widget.onSubmit(RentSchedule.fromJson(json));
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
