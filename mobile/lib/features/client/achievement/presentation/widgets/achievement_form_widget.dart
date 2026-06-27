import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AchievementFormWidget extends ConsumerStatefulWidget {
  final Achievement? item;
  final Function(Achievement) onSubmit;
  const AchievementFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AchievementFormWidget> createState() =>
      _AchievementFormWidgetState();
}

class _AchievementFormWidgetState extends ConsumerState<AchievementFormWidget> {
  String? _userId;
  int? _goalValue;
  int? _currentValue;
  bool? _isCompleted;
  DateTime? _completedAt;
  int? _pointsReward;
  String? _bonusReward;
  String? _organizationId;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _goalValue = widget.item?.goalValue;
    _currentValue = widget.item?.currentValue;
    _isCompleted = widget.item?.isCompleted;
    _completedAt = widget.item?.completedAt;
    _pointsReward = widget.item?.pointsReward;
    _bonusReward = widget.item?.bonusReward;
    _organizationId = widget.item?.organizationId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.achievement'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.achievement'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _goalValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.goalvalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _goalValue = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currentValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currentvalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _currentValue = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.iscompleted'.tr()),
              value: _isCompleted ?? false,
              onChanged: (v) => setState(() => _isCompleted = v),
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
              initialValue: _pointsReward?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pointsreward'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _pointsReward = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _bonusReward?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bonusreward'.tr()),
              onChanged: (v) => _bonusReward = v,
            ),
            TextFormField(
              initialValue: _organizationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.organizationid'.tr()),
              onChanged: (v) => _organizationId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_goalValue != null) 'goalValue': _goalValue,
                  if (_currentValue != null) 'currentValue': _currentValue,
                  'isCompleted': _isCompleted,
                  if (_completedAt != null)
                    'completedAt': _completedAt!.toIso8601String(),
                  if (_pointsReward != null) 'pointsReward': _pointsReward,
                  if (_bonusReward != null) 'bonusReward': _bonusReward,
                  if (_organizationId != null)
                    'organizationId': _organizationId,
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
                  widget.onSubmit(Achievement.fromJson(json));
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
