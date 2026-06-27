import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class TaxDepreciationFormWidget extends ConsumerStatefulWidget {
  final TaxDepreciation? item;
  final Function(TaxDepreciation) onSubmit;
  const TaxDepreciationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<TaxDepreciationFormWidget> createState() =>
      _TaxDepreciationFormWidgetState();
}

class _TaxDepreciationFormWidgetState
    extends ConsumerState<TaxDepreciationFormWidget> {
  String? _propertyId;
  double? _costBasis;
  int? _usefulLife;
  double? _salvageValue;
  DateTime? _startDate;
  double? _accumulatedDepreciation;
  String? _organizationId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _costBasis = widget.item?.costBasis;
    _usefulLife = widget.item?.usefulLife;
    _salvageValue = widget.item?.salvageValue;
    _startDate = widget.item?.startDate;
    _accumulatedDepreciation = widget.item?.accumulatedDepreciation;
    _organizationId = widget.item?.organizationId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.taxdepreciation'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.taxdepreciation'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _costBasis?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.costbasis'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _costBasis = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _usefulLife?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.usefullife'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _usefulLife = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _salvageValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.salvagevalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _salvageValue = double.tryParse(v ?? ""),
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
            TextFormField(
              initialValue: _accumulatedDepreciation?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.accumulateddepreciation'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) =>
                  _accumulatedDepreciation = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _organizationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.organizationid'.tr()),
              onChanged: (v) => _organizationId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_costBasis != null) 'costBasis': _costBasis,
                  if (_usefulLife != null) 'usefulLife': _usefulLife,
                  if (_salvageValue != null) 'salvageValue': _salvageValue,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_accumulatedDepreciation != null)
                    'accumulatedDepreciation': _accumulatedDepreciation,
                  if (_organizationId != null)
                    'organizationId': _organizationId,
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
                  widget.onSubmit(TaxDepreciation.fromJson(json));
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
