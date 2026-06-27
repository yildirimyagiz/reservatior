import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class DocumentAnalysisFormWidget extends ConsumerStatefulWidget {
  final DocumentAnalysis? item;
  final Function(DocumentAnalysis) onSubmit;
  const DocumentAnalysisFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<DocumentAnalysisFormWidget> createState() =>
      _DocumentAnalysisFormWidgetState();
}

class _DocumentAnalysisFormWidgetState
    extends ConsumerState<DocumentAnalysisFormWidget> {
  String? _documentName;
  String? _type;
  String? _status;
  double? _confidence;
  Map<String, dynamic>? _extractedFields;
  @override
  void initState() {
    super.initState();
    _documentName = widget.item?.documentName;
    _type = widget.item?.type;
    _status = widget.item?.status;
    _confidence = widget.item?.confidence;
    _extractedFields = widget.item?.extractedFields;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.documentanalysis'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.documentanalysis'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _documentName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.documentname'.tr()),
              onChanged: (v) => _documentName = v,
            ),
            TextFormField(
              initialValue: _type?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.type'.tr()),
              onChanged: (v) => _type = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
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
                  if (_documentName != null) 'documentName': _documentName,
                  if (_type != null) 'type': _type,
                  if (_status != null) 'status': _status,
                  if (_confidence != null) 'confidence': _confidence,
                  if (_extractedFields != null)
                    'extractedFields': _extractedFields,
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
                  widget.onSubmit(DocumentAnalysis.fromJson(json));
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
