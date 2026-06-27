import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiMarketAnalysisFormWidget extends ConsumerStatefulWidget {
  final AiMarketAnalysis? item;
  final Function(AiMarketAnalysis) onSubmit;
  const AiMarketAnalysisFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiMarketAnalysisFormWidget> createState() =>
      _AiMarketAnalysisFormWidgetState();
}

class _AiMarketAnalysisFormWidgetState
    extends ConsumerState<AiMarketAnalysisFormWidget> {
  String? _analysisType;
  String? _location;
  String? _analysisPeriod;
  double? _confidence;
  DateTime? _generatedAt;
  String? _status;
  @override
  void initState() {
    super.initState();
    _analysisType = widget.item?.analysisType;
    _location = widget.item?.location;
    _analysisPeriod = widget.item?.analysisPeriod;
    _confidence = widget.item?.confidence;
    _generatedAt = widget.item?.generatedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aimarketanalysis'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aimarketanalysis'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _analysisType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.analysistype'.tr()),
              onChanged: (v) => _analysisType = v,
            ),
            TextFormField(
              initialValue: _location?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.location'.tr()),
              onChanged: (v) => _location = v,
            ),
            TextFormField(
              initialValue: _analysisPeriod?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.analysisperiod'.tr()),
              onChanged: (v) => _analysisPeriod = v,
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
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_analysisType != null) 'analysisType': _analysisType,
                  if (_location != null) 'location': _location,
                  if (_analysisPeriod != null)
                    'analysisPeriod': _analysisPeriod,
                  if (_confidence != null) 'confidence': _confidence,
                  if (_generatedAt != null)
                    'generatedAt': _generatedAt!.toIso8601String(),
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
                  widget.onSubmit(AiMarketAnalysis.fromJson(json));
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
