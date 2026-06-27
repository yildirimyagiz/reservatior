import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportFormWidget extends ConsumerStatefulWidget {
  final Report? item;
  final Function(Report) onSubmit;
  const ReportFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ReportFormWidget> createState() => _ReportFormWidgetState();
}

class _ReportFormWidgetState extends ConsumerState<ReportFormWidget> {
  String? _userId;
  String? _name;
  String? _description;
  String? _reportType;
  DateTime? _lastRunAt;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _reportType = widget.item?.reportType;
    _lastRunAt = widget.item?.lastRunAt;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.report'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.report'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _reportType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reporttype'.tr()),
              onChanged: (v) => _reportType = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_run_at'.tr()}: ${_lastRunAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastRunAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastRunAt = d);
              },
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_reportType != null) 'reportType': _reportType,
                  if (_lastRunAt != null)
                    'lastRunAt': _lastRunAt!.toIso8601String(),
                  'isActive': _isActive,
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
                  widget.onSubmit(Report.fromJson(json));
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
