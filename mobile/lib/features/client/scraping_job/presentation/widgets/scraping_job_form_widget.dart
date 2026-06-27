import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ScrapingJobFormWidget extends ConsumerStatefulWidget {
  final ScrapingJob? item;
  final Function(ScrapingJob) onSubmit;
  const ScrapingJobFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ScrapingJobFormWidget> createState() =>
      _ScrapingJobFormWidgetState();
}

class _ScrapingJobFormWidgetState extends ConsumerState<ScrapingJobFormWidget> {
  String? _jobType;
  String? _status;
  DateTime? _startTime;
  DateTime? _endTime;
  int? _projectsScraped;
  @override
  void initState() {
    super.initState();
    _jobType = widget.item?.jobType;
    _status = widget.item?.status;
    _startTime = widget.item?.startTime;
    _endTime = widget.item?.endTime;
    _projectsScraped = widget.item?.projectsScraped;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.scrapingjob'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.scrapingjob'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _jobType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.jobtype'.tr()),
              onChanged: (v) => _jobType = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_start_time'.tr()}: ${_startTime ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startTime ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startTime = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_end_time'.tr()}: ${_endTime ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endTime ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endTime = d);
              },
            ),
            TextFormField(
              initialValue: _projectsScraped?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.projectsscraped'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _projectsScraped = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_jobType != null) 'jobType': _jobType,
                  if (_status != null) 'status': _status,
                  if (_startTime != null)
                    'startTime': _startTime!.toIso8601String(),
                  if (_endTime != null) 'endTime': _endTime!.toIso8601String(),
                  if (_projectsScraped != null)
                    'projectsScraped': _projectsScraped,
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
                  widget.onSubmit(ScrapingJob.fromJson(json));
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
