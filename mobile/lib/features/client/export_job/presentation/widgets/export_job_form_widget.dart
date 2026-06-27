import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ExportJobFormWidget extends ConsumerStatefulWidget {
  final ExportJob? item;
  final Function(ExportJob) onSubmit;
  const ExportJobFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ExportJobFormWidget> createState() =>
      _ExportJobFormWidgetState();
}

class _ExportJobFormWidgetState extends ConsumerState<ExportJobFormWidget> {
  DateTime? _startedAt;
  DateTime? _finishedAt;
  String? _error;
  @override
  void initState() {
    super.initState();
    _startedAt = widget.item?.startedAt;
    _finishedAt = widget.item?.finishedAt;
    _error = widget.item?.error;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.exportjob'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.exportjob'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text("${'mobile.admin.field_started_at'.tr()}: ${_startedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_finished_at'.tr()}: ${_finishedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _finishedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _finishedAt = d);
              },
            ),
            TextFormField(
              initialValue: _error?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.error'.tr()),
              onChanged: (v) => _error = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_startedAt != null)
                    'startedAt': _startedAt!.toIso8601String(),
                  if (_finishedAt != null)
                    'finishedAt': _finishedAt!.toIso8601String(),
                  if (_error != null) 'error': _error,
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
                  widget.onSubmit(ExportJob.fromJson(json));
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
