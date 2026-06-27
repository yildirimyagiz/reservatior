import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AutomationTaskFormWidget extends ConsumerStatefulWidget {
  final AutomationTask? item;
  final Function(AutomationTask) onSubmit;
  const AutomationTaskFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AutomationTaskFormWidget> createState() =>
      _AutomationTaskFormWidgetState();
}

class _AutomationTaskFormWidgetState
    extends ConsumerState<AutomationTaskFormWidget> {
  String? _taskType;
  String? _persona;
  String? _command;
  String? _status;
  String? _schedule;
  DateTime? _lastRun;
  DateTime? _nextRun;
  String? _error;
  @override
  void initState() {
    super.initState();
    _taskType = widget.item?.taskType;
    _persona = widget.item?.persona;
    _command = widget.item?.command;
    _status = widget.item?.status;
    _schedule = widget.item?.schedule;
    _lastRun = widget.item?.lastRun;
    _nextRun = widget.item?.nextRun;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.automationtask'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.automationtask'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _taskType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tasktype'.tr()),
              onChanged: (v) => _taskType = v,
            ),
            TextFormField(
              initialValue: _persona?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.persona'.tr()),
              onChanged: (v) => _persona = v,
            ),
            TextFormField(
              initialValue: _command?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.command'.tr()),
              onChanged: (v) => _command = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _schedule?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.schedule'.tr()),
              onChanged: (v) => _schedule = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_run'.tr()}: ${_lastRun ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastRun ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastRun = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_next_run'.tr()}: ${_nextRun ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _nextRun ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _nextRun = d);
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
                  if (_taskType != null) 'taskType': _taskType,
                  if (_persona != null) 'persona': _persona,
                  if (_command != null) 'command': _command,
                  if (_status != null) 'status': _status,
                  if (_schedule != null) 'schedule': _schedule,
                  if (_lastRun != null) 'lastRun': _lastRun!.toIso8601String(),
                  if (_nextRun != null) 'nextRun': _nextRun!.toIso8601String(),
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
                  widget.onSubmit(AutomationTask.fromJson(json));
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
