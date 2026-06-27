import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpenseFormWidget extends ConsumerStatefulWidget {
  final Expense? item;
  final Function(Expense) onSubmit;
  const ExpenseFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ExpenseFormWidget> createState() => _ExpenseFormWidgetState();
}

class _ExpenseFormWidgetState extends ConsumerState<ExpenseFormWidget> {
  String? _propertyId;
  String? _tenantId;
  String? _agencyId;
  double? _amount;
  String? _currencyId;
  DateTime? _dueDate;
  DateTime? _paidDate;
  String? _notes;
  String? _facilityId;
  String? _includedServiceId;
  String? _extraChargeId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _tenantId = widget.item?.tenantId;
    _agencyId = widget.item?.agencyId;
    _amount = widget.item?.amount;
    _currencyId = widget.item?.currencyId;
    _dueDate = widget.item?.dueDate;
    _paidDate = widget.item?.paidDate;
    _notes = widget.item?.notes;
    _facilityId = widget.item?.facilityId;
    _includedServiceId = widget.item?.includedServiceId;
    _extraChargeId = widget.item?.extraChargeId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.expense'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.expense'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _tenantId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tenantid'.tr()),
              onChanged: (v) => _tenantId = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currencyid'.tr()),
              onChanged: (v) => _currencyId = v,
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
            ListTile(
              title: Text("${'mobile.admin.field_paid_date'.tr()}: ${_paidDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _paidDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _paidDate = d);
              },
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            TextFormField(
              initialValue: _facilityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.facilityid'.tr()),
              onChanged: (v) => _facilityId = v,
            ),
            TextFormField(
              initialValue: _includedServiceId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.includedserviceid'.tr()),
              onChanged: (v) => _includedServiceId = v,
            ),
            TextFormField(
              initialValue: _extraChargeId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.extrachargeid'.tr()),
              onChanged: (v) => _extraChargeId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_tenantId != null) 'tenantId': _tenantId,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_amount != null) 'amount': _amount,
                  if (_currencyId != null) 'currencyId': _currencyId,
                  if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
                  if (_paidDate != null)
                    'paidDate': _paidDate!.toIso8601String(),
                  if (_notes != null) 'notes': _notes,
                  if (_facilityId != null) 'facilityId': _facilityId,
                  if (_includedServiceId != null)
                    'includedServiceId': _includedServiceId,
                  if (_extraChargeId != null) 'extraChargeId': _extraChargeId,
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
                  widget.onSubmit(Expense.fromJson(json));
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
