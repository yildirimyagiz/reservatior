import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class JobFormWidget extends ConsumerStatefulWidget {
  final Job? item;
  final Function(Job) onSubmit;
  const JobFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<JobFormWidget> createState() => _JobFormWidgetState();
}

class _JobFormWidgetState extends ConsumerState<JobFormWidget> {
  String? _type;
  DateTime? _runAt;
  int? _attempts;
  String? _lastError;
  DateTime? _lockedAt;
  String? _lockedBy;
  @override
  void initState() {
    super.initState();
    _type = widget.item?.type;
    _runAt = widget.item?.runAt;
    _attempts = widget.item?.attempts;
    _lastError = widget.item?.lastError;
    _lockedAt = widget.item?.lockedAt;
    _lockedBy = widget.item?.lockedBy;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.job'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.job'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _type?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.type'.tr()),
              onChanged: (v) => _type = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_run_at'.tr()}: ${_runAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _runAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _runAt = d);
              },
            ),
            TextFormField(
              initialValue: _attempts?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.attempts'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _attempts = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lastError?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lasterror'.tr()),
              onChanged: (v) => _lastError = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_locked_at'.tr()}: ${_lockedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lockedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lockedAt = d);
              },
            ),
            TextFormField(
              initialValue: _lockedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lockedby'.tr()),
              onChanged: (v) => _lockedBy = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_type != null) 'type': _type,
                  if (_runAt != null) 'runAt': _runAt!.toIso8601String(),
                  if (_attempts != null) 'attempts': _attempts,
                  if (_lastError != null) 'lastError': _lastError,
                  if (_lockedAt != null)
                    'lockedAt': _lockedAt!.toIso8601String(),
                  if (_lockedBy != null) 'lockedBy': _lockedBy,
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
                  widget.onSubmit(Job.fromJson(json));
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
