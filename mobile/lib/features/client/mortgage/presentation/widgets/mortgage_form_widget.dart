import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MortgageFormWidget extends ConsumerStatefulWidget {
  final Mortgage? item;
  final Function(Mortgage) onSubmit;
  const MortgageFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MortgageFormWidget> createState() => _MortgageFormWidgetState();
}

class _MortgageFormWidgetState extends ConsumerState<MortgageFormWidget> {
  String? _propertyId;
  String? _lender;
  double? _principal;
  double? _interestRate;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _lender = widget.item?.lender;
    _principal = widget.item?.principal;
    _interestRate = widget.item?.interestRate;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mortgage'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mortgage'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _lender?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lender'.tr()),
              onChanged: (v) => _lender = v,
            ),
            TextFormField(
              initialValue: _principal?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.principal'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _principal = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _interestRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.interestrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _interestRate = double.tryParse(v ?? ""),
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
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_lender != null) 'lender': _lender,
                  if (_principal != null) 'principal': _principal,
                  if (_interestRate != null) 'interestRate': _interestRate,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
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
                  widget.onSubmit(Mortgage.fromJson(json));
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
