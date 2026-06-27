import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ProjectAnalyticsFormWidget extends ConsumerStatefulWidget {
  final ProjectAnalytics? item;
  final Function(ProjectAnalytics) onSubmit;
  const ProjectAnalyticsFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ProjectAnalyticsFormWidget> createState() =>
      _ProjectAnalyticsFormWidgetState();
}

class _ProjectAnalyticsFormWidgetState
    extends ConsumerState<ProjectAnalyticsFormWidget> {
  String? _projectId;
  String? _analysisType;
  double? _score;
  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId;
    _analysisType = widget.item?.analysisType;
    _score = widget.item?.score;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.projectanalytics'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.projectanalytics'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _projectId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.projectid'.tr()),
              onChanged: (v) => _projectId = v,
            ),
            TextFormField(
              initialValue: _analysisType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.analysistype'.tr()),
              onChanged: (v) => _analysisType = v,
            ),
            TextFormField(
              initialValue: _score?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.score'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _score = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_projectId != null) 'projectId': _projectId,
                  if (_analysisType != null) 'analysisType': _analysisType,
                  if (_score != null) 'score': _score,
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
                  widget.onSubmit(ProjectAnalytics.fromJson(json));
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
