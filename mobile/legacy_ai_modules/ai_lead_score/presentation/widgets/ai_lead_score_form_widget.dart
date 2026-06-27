import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiLeadScoreFormWidget extends ConsumerStatefulWidget {
  final AiLeadScore? item;
  final Function(AiLeadScore) onSubmit;
  const AiLeadScoreFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AiLeadScoreFormWidget> createState() =>
      _AiLeadScoreFormWidgetState();
}

class _AiLeadScoreFormWidgetState extends ConsumerState<AiLeadScoreFormWidget> {
  String? _modelId;
  String? _leadId;
  double? _score;
  double? _confidence;
  DateTime? _scoredAt;
  String? _status;
  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId;
    _leadId = widget.item?.leadId;
    _score = widget.item?.score;
    _confidence = widget.item?.confidence;
    _scoredAt = widget.item?.scoredAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aileadscore'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aileadscore'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _modelId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modelid'.tr()),
              onChanged: (v) => _modelId = v,
            ),
            TextFormField(
              initialValue: _leadId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leadid'.tr()),
              onChanged: (v) => _leadId = v,
            ),
            TextFormField(
              initialValue: _score?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.score'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _score = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _confidence?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidence'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidence = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_scored_at'.tr()}: ${_scoredAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _scoredAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _scoredAt = d);
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
                  if (_leadId != null) 'leadId': _leadId,
                  if (_score != null) 'score': _score,
                  if (_confidence != null) 'confidence': _confidence,
                  if (_scoredAt != null)
                    'scoredAt': _scoredAt!.toIso8601String(),
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
                  widget.onSubmit(AiLeadScore.fromJson(json));
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
