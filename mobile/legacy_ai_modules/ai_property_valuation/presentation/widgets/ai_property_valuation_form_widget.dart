import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiPropertyValuationFormWidget extends ConsumerStatefulWidget {
  final AiPropertyValuation? item;
  final Function(AiPropertyValuation) onSubmit;
  const AiPropertyValuationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiPropertyValuationFormWidget> createState() =>
      _AiPropertyValuationFormWidgetState();
}

class _AiPropertyValuationFormWidgetState
    extends ConsumerState<AiPropertyValuationFormWidget> {
  String? _modelId;
  String? _propertyId;
  double? _predictedValue;
  double? _confidenceScore;
  DateTime? _valuationDate;
  String? _status;
  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId;
    _propertyId = widget.item?.propertyId;
    _predictedValue = widget.item?.predictedValue;
    _confidenceScore = widget.item?.confidenceScore;
    _valuationDate = widget.item?.valuationDate;
    _status = widget.item?.status;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aipropertyvaluation'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aipropertyvaluation'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _modelId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modelid'.tr()),
              onChanged: (v) => _modelId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _predictedValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.predictedvalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _predictedValue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _confidenceScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidencescore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidenceScore = double.tryParse(v ?? ""),
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
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_modelId != null) 'modelId': _modelId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_predictedValue != null)
                    'predictedValue': _predictedValue,
                  if (_confidenceScore != null)
                    'confidenceScore': _confidenceScore,
                  if (_valuationDate != null)
                    'valuationDate': _valuationDate!.toIso8601String(),
                  if (_status != null) 'status': _status,
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
                  widget.onSubmit(AiPropertyValuation.fromJson(json));
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
