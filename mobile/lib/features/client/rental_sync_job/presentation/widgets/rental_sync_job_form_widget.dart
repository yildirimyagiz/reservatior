import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class RentalSyncJobFormWidget extends ConsumerStatefulWidget {
  final RentalSyncJob? item;
  final Function(RentalSyncJob) onSubmit;
  const RentalSyncJobFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<RentalSyncJobFormWidget> createState() =>
      _RentalSyncJobFormWidgetState();
}

class _RentalSyncJobFormWidgetState
    extends ConsumerState<RentalSyncJobFormWidget> {
  String? _integrationId;
  String? _jobType;
  DateTime? _startedAt;
  DateTime? _finishedAt;
  String? _error;
  @override
  void initState() {
    super.initState();
    _integrationId = widget.item?.integrationId;
    _jobType = widget.item?.jobType;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.rentalsyncjob'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.rentalsyncjob'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _integrationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.integrationid'.tr()),
              onChanged: (v) => _integrationId = v,
            ),
            TextFormField(
              initialValue: _jobType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.jobtype'.tr()),
              onChanged: (v) => _jobType = v,
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
                  if (_integrationId != null) 'integrationId': _integrationId,
                  if (_jobType != null) 'jobType': _jobType,
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
                  widget.onSubmit(RentalSyncJob.fromJson(json));
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
