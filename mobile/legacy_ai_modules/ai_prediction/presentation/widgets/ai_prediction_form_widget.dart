import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiPredictionFormWidget extends ConsumerStatefulWidget {
  final AiPrediction? item;
  final Function(AiPrediction) onSubmit;
  const AiPredictionFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AiPredictionFormWidget> createState() =>
      _AiPredictionFormWidgetState();
}

class _AiPredictionFormWidgetState
    extends ConsumerState<AiPredictionFormWidget> {
  String? _modelId;
  String? _requestId;
  String? _batchId;
  String? _modelType;
  double? _confidence;
  int? _processingTimeMs;
  int? _processingTime;
  String? _status;
  bool? _succes;
  String? _errorMessage;
  String? _userId;
  String? _propertyId;
  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId;
    _requestId = widget.item?.requestId;
    _batchId = widget.item?.batchId;
    _modelType = widget.item?.modelType;
    _confidence = widget.item?.confidence;
    _processingTimeMs = widget.item?.processingTimeMs;
    _processingTime = widget.item?.processingTime;
    _status = widget.item?.status;
    _succes = widget.item?.succes;
    _errorMessage = widget.item?.errorMessage;
    _userId = widget.item?.userId;
    _propertyId = widget.item?.propertyId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aiprediction'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aiprediction'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _modelId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modelid'.tr()),
              onChanged: (v) => _modelId = v,
            ),
            TextFormField(
              initialValue: _requestId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.requestid'.tr()),
              onChanged: (v) => _requestId = v,
            ),
            TextFormField(
              initialValue: _batchId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.batchid'.tr()),
              onChanged: (v) => _batchId = v,
            ),
            TextFormField(
              initialValue: _modelType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modeltype'.tr()),
              onChanged: (v) => _modelType = v,
            ),
            TextFormField(
              initialValue: _confidence?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidence'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidence = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _processingTimeMs?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.processingtimems'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _processingTimeMs = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _processingTime?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.processingtime'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _processingTime = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.succes'.tr()),
              value: _succes ?? false,
              onChanged: (v) => setState(() => _succes = v),
            ),
            TextFormField(
              initialValue: _errorMessage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.errormessage'.tr()),
              onChanged: (v) => _errorMessage = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_modelId != null) 'modelId': _modelId,
                  if (_requestId != null) 'requestId': _requestId,
                  if (_batchId != null) 'batchId': _batchId,
                  if (_modelType != null) 'modelType': _modelType,
                  if (_confidence != null) 'confidence': _confidence,
                  if (_processingTimeMs != null)
                    'processingTimeMs': _processingTimeMs,
                  if (_processingTime != null)
                    'processingTime': _processingTime,
                  if (_status != null) 'status': _status,
                  'succes': _succes,
                  if (_errorMessage != null) 'errorMessage': _errorMessage,
                  if (_userId != null) 'userId': _userId,
                  if (_propertyId != null) 'propertyId': _propertyId,
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
                  widget.onSubmit(AiPrediction.fromJson(json));
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
