import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AutomationExecutionFormWidget extends ConsumerStatefulWidget {
  final AutomationExecution? item;
  final Function(AutomationExecution) onSubmit;
  const AutomationExecutionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AutomationExecutionFormWidget> createState() =>
      _AutomationExecutionFormWidgetState();
}

class _AutomationExecutionFormWidgetState
    extends ConsumerState<AutomationExecutionFormWidget> {
  String? _ruleId;
  String? _status;
  DateTime? _executedAt;
  int? _processingTimeMs;
  @override
  void initState() {
    super.initState();
    _ruleId = widget.item?.ruleId;
    _status = widget.item?.status;
    _executedAt = widget.item?.executedAt;
    _processingTimeMs = widget.item?.processingTimeMs;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.automationexecution'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.automationexecution'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _ruleId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ruleid'.tr()),
              onChanged: (v) => _ruleId = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
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
              initialValue: _processingTimeMs?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.processingtimems'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _processingTimeMs = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_ruleId != null) 'ruleId': _ruleId,
                  if (_status != null) 'status': _status,
                  if (_executedAt != null)
                    'executedAt': _executedAt!.toIso8601String(),
                  if (_processingTimeMs != null)
                    'processingTimeMs': _processingTimeMs,
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
                  widget.onSubmit(AutomationExecution.fromJson(json));
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
