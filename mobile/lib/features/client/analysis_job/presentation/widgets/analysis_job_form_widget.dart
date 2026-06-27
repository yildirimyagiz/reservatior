import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AnalysisJobFormWidget extends ConsumerStatefulWidget {
  final AnalysisJob? item;
  final Function(AnalysisJob) onSubmit;
  const AnalysisJobFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AnalysisJobFormWidget> createState() =>
      _AnalysisJobFormWidgetState();
}

class _AnalysisJobFormWidgetState extends ConsumerState<AnalysisJobFormWidget> {
  String? _documentId;
  String? _status;
  String? _type;
  String? _priority;
  DateTime? _startedAt;
  DateTime? _completedAt;
  int? _processingTime;
  String? _errorMessage;
  @override
  void initState() {
    super.initState();
    _documentId = widget.item?.documentId;
    _status = widget.item?.status;
    _type = widget.item?.type;
    _priority = widget.item?.priority;
    _startedAt = widget.item?.startedAt;
    _completedAt = widget.item?.completedAt;
    _processingTime = widget.item?.processingTime;
    _errorMessage = widget.item?.errorMessage;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.analysisjob'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.analysisjob'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _documentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.documentid'.tr()),
              onChanged: (v) => _documentId = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _type?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.type'.tr()),
              onChanged: (v) => _type = v,
            ),
            TextFormField(
              initialValue: _priority?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.priority'.tr()),
              onChanged: (v) => _priority = v,
            ),
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
              title: Text("${'mobile.admin.field_completed_at'.tr()}: ${_completedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _completedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _completedAt = d);
              },
            ),
            TextFormField(
              initialValue: _processingTime?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.processingtime'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _processingTime = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _errorMessage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.errormessage'.tr()),
              onChanged: (v) => _errorMessage = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_documentId != null) 'documentId': _documentId,
                  if (_status != null) 'status': _status,
                  if (_type != null) 'type': _type,
                  if (_priority != null) 'priority': _priority,
                  if (_startedAt != null)
                    'startedAt': _startedAt!.toIso8601String(),
                  if (_completedAt != null)
                    'completedAt': _completedAt!.toIso8601String(),
                  if (_processingTime != null)
                    'processingTime': _processingTime,
                  if (_errorMessage != null) 'errorMessage': _errorMessage,
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
                  widget.onSubmit(AnalysisJob.fromJson(json));
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
