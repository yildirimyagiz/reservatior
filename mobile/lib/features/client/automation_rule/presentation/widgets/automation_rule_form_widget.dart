import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AutomationRuleFormWidget extends ConsumerStatefulWidget {
  final AutomationRule? item;
  final Function(AutomationRule) onSubmit;
  const AutomationRuleFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AutomationRuleFormWidget> createState() =>
      _AutomationRuleFormWidgetState();
}

class _AutomationRuleFormWidgetState
    extends ConsumerState<AutomationRuleFormWidget> {
  String? _ruleName;
  String? _ruleType;
  String? _triggerType;
  bool? _isActive;
  DateTime? _lastExecutedAt;
  int? _executionCount;
  @override
  void initState() {
    super.initState();
    _ruleName = widget.item?.ruleName;
    _ruleType = widget.item?.ruleType;
    _triggerType = widget.item?.triggerType;
    _isActive = widget.item?.isActive;
    _lastExecutedAt = widget.item?.lastExecutedAt;
    _executionCount = widget.item?.executionCount;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.automationrule'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.automationrule'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _ruleName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rulename'.tr()),
              onChanged: (v) => _ruleName = v,
            ),
            TextFormField(
              initialValue: _ruleType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ruletype'.tr()),
              onChanged: (v) => _ruleType = v,
            ),
            TextFormField(
              initialValue: _triggerType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.triggertype'.tr()),
              onChanged: (v) => _triggerType = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_executed_at'.tr()}: ${_lastExecutedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastExecutedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastExecutedAt = d);
              },
            ),
            TextFormField(
              initialValue: _executionCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.executioncount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _executionCount = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_ruleName != null) 'ruleName': _ruleName,
                  if (_ruleType != null) 'ruleType': _ruleType,
                  if (_triggerType != null) 'triggerType': _triggerType,
                  'isActive': _isActive,
                  if (_lastExecutedAt != null)
                    'lastExecutedAt': _lastExecutedAt!.toIso8601String(),
                  if (_executionCount != null)
                    'executionCount': _executionCount,
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
                  widget.onSubmit(AutomationRule.fromJson(json));
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
