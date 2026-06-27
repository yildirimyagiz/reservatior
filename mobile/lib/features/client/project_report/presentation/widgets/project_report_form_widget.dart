import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ProjectReportFormWidget extends ConsumerStatefulWidget {
  final ProjectReport? item;
  final Function(ProjectReport) onSubmit;
  const ProjectReportFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ProjectReportFormWidget> createState() =>
      _ProjectReportFormWidgetState();
}

class _ProjectReportFormWidgetState
    extends ConsumerState<ProjectReportFormWidget> {
  String? _projectId;
  String? _reportType;
  String? _title;
  String? _content;
  String? _generatedBy;
  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId;
    _reportType = widget.item?.reportType;
    _title = widget.item?.title;
    _content = widget.item?.content;
    _generatedBy = widget.item?.generatedBy;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.projectreport'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.projectreport'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _projectId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.projectid'.tr()),
              onChanged: (v) => _projectId = v,
            ),
            TextFormField(
              initialValue: _reportType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reporttype'.tr()),
              onChanged: (v) => _reportType = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _content?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.content'.tr()),
              onChanged: (v) => _content = v,
            ),
            TextFormField(
              initialValue: _generatedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.generatedby'.tr()),
              onChanged: (v) => _generatedBy = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_projectId != null) 'projectId': _projectId,
                  if (_reportType != null) 'reportType': _reportType,
                  if (_title != null) 'title': _title,
                  if (_content != null) 'content': _content,
                  if (_generatedBy != null) 'generatedBy': _generatedBy,
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
                  widget.onSubmit(ProjectReport.fromJson(json));
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
