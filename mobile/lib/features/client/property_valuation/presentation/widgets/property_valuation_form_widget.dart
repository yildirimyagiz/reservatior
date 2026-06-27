import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyValuationFormWidget extends ConsumerStatefulWidget {
  final PropertyValuation? item;
  final Function(PropertyValuation) onSubmit;
  const PropertyValuationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PropertyValuationFormWidget> createState() =>
      _PropertyValuationFormWidgetState();
}

class _PropertyValuationFormWidgetState
    extends ConsumerState<PropertyValuationFormWidget> {
  String? _propertyId;
  DateTime? _valuationDate;
  double? _value;
  String? _source;
  double? _confidence;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _valuationDate = widget.item?.valuationDate;
    _value = widget.item?.value;
    _source = widget.item?.source;
    _confidence = widget.item?.confidence;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertyvaluation'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertyvaluation'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_valuation_date'.tr()}: ${_valuationDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _valuationDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _valuationDate = d);
              },
            ),
            TextFormField(
              initialValue: _value?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.value'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _value = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _source?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.source'.tr()),
              onChanged: (v) => _source = v,
            ),
            TextFormField(
              initialValue: _confidence?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidence'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidence = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_valuationDate != null)
                    'valuationDate': _valuationDate!.toIso8601String(),
                  if (_value != null) 'value': _value,
                  if (_source != null) 'source': _source,
                  if (_confidence != null) 'confidence': _confidence,
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
                  widget.onSubmit(PropertyValuation.fromJson(json));
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
