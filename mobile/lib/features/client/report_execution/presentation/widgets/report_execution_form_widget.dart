import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportExecutionFormWidget extends ConsumerStatefulWidget {
  final ReportExecution? item;
  final Function(ReportExecution) onSubmit;
  const ReportExecutionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ReportExecutionFormWidget> createState() =>
      _ReportExecutionFormWidgetState();
}

class _ReportExecutionFormWidgetState
    extends ConsumerState<ReportExecutionFormWidget> {
  String? _reportId;
  DateTime? _executedAt;
  String? _executedBy;
  String? _status;
  String? _resultUrl;
  String? _errorMessage;
  @override
  void initState() {
    super.initState();
    _reportId = widget.item?.reportId;
    _executedAt = widget.item?.executedAt;
    _executedBy = widget.item?.executedBy;
    _status = widget.item?.status;
    _resultUrl = widget.item?.resultUrl;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.reportexecution'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.reportexecution'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _reportId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reportid'.tr()),
              onChanged: (v) => _reportId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_executed_at'.tr()}: ${_executedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _executedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _executedAt = d);
              },
            ),
            TextFormField(
              initialValue: _executedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.executedby'.tr()),
              onChanged: (v) => _executedBy = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _resultUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.resulturl'.tr()),
              onChanged: (v) => _resultUrl = v,
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
                  if (_reportId != null) 'reportId': _reportId,
                  if (_executedAt != null)
                    'executedAt': _executedAt!.toIso8601String(),
                  if (_executedBy != null) 'executedBy': _executedBy,
                  if (_status != null) 'status': _status,
                  if (_resultUrl != null) 'resultUrl': _resultUrl,
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
                  widget.onSubmit(ReportExecution.fromJson(json));
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
