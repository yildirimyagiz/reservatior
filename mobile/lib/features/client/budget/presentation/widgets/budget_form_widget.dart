import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class BudgetFormWidget extends ConsumerStatefulWidget {
  final Budget? item;
  final Function(Budget) onSubmit;
  const BudgetFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<BudgetFormWidget> createState() => _BudgetFormWidgetState();
}

class _BudgetFormWidgetState extends ConsumerState<BudgetFormWidget> {
  String? _userId;
  String? _name;
  String? _description;
  String? _budgetType;
  String? _period;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _totalAmount;
  String? _currency;
  double? _actualSpent;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _budgetType = widget.item?.budgetType;
    _period = widget.item?.period;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency;
    _actualSpent = widget.item?.actualSpent;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.budget'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.budget'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _budgetType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.budgettype'.tr()),
              onChanged: (v) => _budgetType = v,
            ),
            TextFormField(
              initialValue: _period?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.period'.tr()),
              onChanged: (v) => _period = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_start_date'.tr()}: ${_startDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_end_date'.tr()}: ${_endDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endDate = d);
              },
            ),
            TextFormField(
              initialValue: _totalAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _actualSpent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.actualspent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _actualSpent = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_budgetType != null) 'budgetType': _budgetType,
                  if (_period != null) 'period': _period,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_totalAmount != null) 'totalAmount': _totalAmount,
                  if (_currency != null) 'currency': _currency,
                  if (_actualSpent != null) 'actualSpent': _actualSpent,
                  'isActive': _isActive,
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
                  widget.onSubmit(Budget.fromJson(json));
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
