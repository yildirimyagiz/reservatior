import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Achievement Form Widget  |  Fields: userId, goalType, goalValue, currentValue, isCompleted, completedAt, pointsReward, bonusReward, organizationId

class AchievementFormWidget extends StatefulWidget {
  final Achievement? item;
  final void Function(Achievement)? onSubmit;
  const AchievementFormWidget({super.key, this.item, this.onSubmit});
  @override State<AchievementFormWidget> createState() => _AchievementFormWidgetState();
}

class _AchievementFormWidgetState extends State<AchievementFormWidget> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _cUserId;
  late final TextEditingController _cGoalType;
  late final TextEditingController _cGoalValue;
  late final TextEditingController _cCurrentValue;
  late final TextEditingController _cPointsReward;
  late final TextEditingController _cBonusReward;
  late final TextEditingController _cOrganizationId;
  String? _userId;
  String? _goalType;
  int? _goalValue;
  int? _currentValue;
  bool _isCompleted = false;
  DateTime? _completedAt;
  int? _pointsReward;
  String? _bonusReward;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _cUserId = TextEditingController(text: widget.item?.userId?.toString() ?? '');
    _cGoalType = TextEditingController(text: widget.item?.goalType?.toString() ?? '');
    _cGoalValue = TextEditingController(text: widget.item?.goalValue?.toString() ?? '');
    _cCurrentValue = TextEditingController(text: widget.item?.currentValue?.toString() ?? '');
    _cPointsReward = TextEditingController(text: widget.item?.pointsReward?.toString() ?? '');
    _cBonusReward = TextEditingController(text: widget.item?.bonusReward?.toString() ?? '');
    _cOrganizationId = TextEditingController(text: widget.item?.organizationId?.toString() ?? '');
    _userId = widget.item?.userId?.toString();
    _goalType = widget.item?.goalType?.toString();
    _goalValue = widget.item?.goalValue;
    _currentValue = widget.item?.currentValue;
    _isCompleted = widget.item?.isCompleted ?? false;
    _completedAt = widget.item?.completedAt;
    _pointsReward = widget.item?.pointsReward;
    _bonusReward = widget.item?.bonusReward?.toString();
    _organizationId = widget.item?.organizationId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_goalType?.isNotEmpty == true) 'goalType': _goalType,
        if (_goalValue != null) 'goalValue': _goalValue,
        if (_currentValue != null) 'currentValue': _currentValue,
        'isCompleted': _isCompleted,
        if (_completedAt != null) 'completedAt': _completedAt!.toIso8601String(),
        if (_pointsReward != null) 'pointsReward': _pointsReward,
        if (_bonusReward?.isNotEmpty == true) 'bonusReward': _bonusReward,
        if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
    };
    final result = widget.item != null
        ? Achievement.fromJson({...widget.item!.toJson(), ...data})
        : Achievement.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cUserId, maxLines: 1,
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Goal Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cGoalType, maxLines: 1,
                onSaved: (v) => _goalType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Goal Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number, controller: _cGoalValue,
                onSaved: (v) => _goalValue = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Current Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number, controller: _cCurrentValue,
                onSaved: (v) => _currentValue = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: const Text('Is Completed'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isCompleted,
                  onChanged: (v) { ss(() {}); setState(() => _isCompleted = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _completedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _completedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Completed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_completedAt != null ? _fmt(_completedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Points Reward', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number, controller: _cPointsReward,
                onSaved: (v) => _pointsReward = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bonus Reward', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cBonusReward, maxLines: 1,
                onSaved: (v) => _bonusReward = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Organization Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cOrganizationId, maxLines: 1,
                onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Achievement'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}