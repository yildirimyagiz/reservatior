import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ProjectAlertFormWidget extends ConsumerStatefulWidget {
  final ProjectAlert? item;
  final Function(ProjectAlert) onSubmit;
  const ProjectAlertFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ProjectAlertFormWidget> createState() =>
      _ProjectAlertFormWidgetState();
}

class _ProjectAlertFormWidgetState
    extends ConsumerState<ProjectAlertFormWidget> {
  String? _projectId;
  String? _alertType;
  String? _title;
  String? _message;
  String? _severity;
  bool? _isRead;
  bool? _isResolved;
  DateTime? _resolvedAt;
  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId;
    _alertType = widget.item?.alertType;
    _title = widget.item?.title;
    _message = widget.item?.message;
    _severity = widget.item?.severity;
    _isRead = widget.item?.isRead;
    _isResolved = widget.item?.isResolved;
    _resolvedAt = widget.item?.resolvedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.projectalert'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.projectalert'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _projectId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.projectid'.tr()),
              onChanged: (v) => _projectId = v,
            ),
            TextFormField(
              initialValue: _alertType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.alerttype'.tr()),
              onChanged: (v) => _alertType = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _message?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.message'.tr()),
              onChanged: (v) => _message = v,
            ),
            TextFormField(
              initialValue: _severity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.severity'.tr()),
              onChanged: (v) => _severity = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isread'.tr()),
              value: _isRead ?? false,
              onChanged: (v) => setState(() => _isRead = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isresolved'.tr()),
              value: _isResolved ?? false,
              onChanged: (v) => setState(() => _isResolved = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_resolved_at'.tr()}: ${_resolvedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _resolvedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _resolvedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_projectId != null) 'projectId': _projectId,
                  if (_alertType != null) 'alertType': _alertType,
                  if (_title != null) 'title': _title,
                  if (_message != null) 'message': _message,
                  if (_severity != null) 'severity': _severity,
                  'isRead': _isRead,
                  'isResolved': _isResolved,
                  if (_resolvedAt != null)
                    'resolvedAt': _resolvedAt!.toIso8601String(),
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
                  widget.onSubmit(ProjectAlert.fromJson(json));
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
