import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiSentimentAnalysisFormWidget extends ConsumerStatefulWidget {
  final AiSentimentAnalysis? item;
  final Function(AiSentimentAnalysis) onSubmit;
  const AiSentimentAnalysisFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiSentimentAnalysisFormWidget> createState() =>
      _AiSentimentAnalysisFormWidgetState();
}

class _AiSentimentAnalysisFormWidgetState
    extends ConsumerState<AiSentimentAnalysisFormWidget> {
  String? _contentType;
  String? _contentId;
  String? _contentText;
  String? _sentiment;
  double? _sentimentScore;
  double? _confidence;
  DateTime? _analyzedAt;
  @override
  void initState() {
    super.initState();
    _contentType = widget.item?.contentType;
    _contentId = widget.item?.contentId;
    _contentText = widget.item?.contentText;
    _sentiment = widget.item?.sentiment;
    _sentimentScore = widget.item?.sentimentScore;
    _confidence = widget.item?.confidence;
    _analyzedAt = widget.item?.analyzedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aisentimentanalysis'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aisentimentanalysis'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _contentType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contenttype'.tr()),
              onChanged: (v) => _contentType = v,
            ),
            TextFormField(
              initialValue: _contentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contentid'.tr()),
              onChanged: (v) => _contentId = v,
            ),
            TextFormField(
              initialValue: _contentText?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contenttext'.tr()),
              onChanged: (v) => _contentText = v,
            ),
            TextFormField(
              initialValue: _sentiment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sentiment'.tr()),
              onChanged: (v) => _sentiment = v,
            ),
            TextFormField(
              initialValue: _sentimentScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sentimentscore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _sentimentScore = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _confidence?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidence'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidence = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_analyzed_at'.tr()}: ${_analyzedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _analyzedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _analyzedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_contentType != null) 'contentType': _contentType,
                  if (_contentId != null) 'contentId': _contentId,
                  if (_contentText != null) 'contentText': _contentText,
                  if (_sentiment != null) 'sentiment': _sentiment,
                  if (_sentimentScore != null)
                    'sentimentScore': _sentimentScore,
                  if (_confidence != null) 'confidence': _confidence,
                  if (_analyzedAt != null)
                    'analyzedAt': _analyzedAt!.toIso8601String(),
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
                  widget.onSubmit(AiSentimentAnalysis.fromJson(json));
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
