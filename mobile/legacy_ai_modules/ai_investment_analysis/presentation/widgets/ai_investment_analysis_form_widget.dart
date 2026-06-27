import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiInvestmentAnalysisFormWidget extends ConsumerStatefulWidget {
  final AiInvestmentAnalysis? item;
  final Function(AiInvestmentAnalysis) onSubmit;
  const AiInvestmentAnalysisFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiInvestmentAnalysisFormWidget> createState() =>
      _AiInvestmentAnalysisFormWidgetState();
}

class _AiInvestmentAnalysisFormWidgetState
    extends ConsumerState<AiInvestmentAnalysisFormWidget> {
  String? _propertyId;
  String? _analysisType;
  String? _timeHorizon;
  double? _confidence;
  DateTime? _generatedAt;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _analysisType = widget.item?.analysisType;
    _timeHorizon = widget.item?.timeHorizon;
    _confidence = widget.item?.confidence;
    _generatedAt = widget.item?.generatedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aiinvestmentanalysis'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aiinvestmentanalysis'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _analysisType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.analysistype'.tr()),
              onChanged: (v) => _analysisType = v,
            ),
            TextFormField(
              initialValue: _timeHorizon?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.timehorizon'.tr()),
              onChanged: (v) => _timeHorizon = v,
            ),
            TextFormField(
              initialValue: _confidence?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidence'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidence = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_generated_at'.tr()}: ${_generatedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _generatedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _generatedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_analysisType != null) 'analysisType': _analysisType,
                  if (_timeHorizon != null) 'timeHorizon': _timeHorizon,
                  if (_confidence != null) 'confidence': _confidence,
                  if (_generatedAt != null)
                    'generatedAt': _generatedAt!.toIso8601String(),
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
                  widget.onSubmit(AiInvestmentAnalysis.fromJson(json));
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
