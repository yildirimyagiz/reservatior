import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class CommissionRuleFormWidget extends ConsumerStatefulWidget {
  final CommissionRule? item;
  final Function(CommissionRule) onSubmit;
  const CommissionRuleFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<CommissionRuleFormWidget> createState() =>
      _CommissionRuleFormWidgetState();
}

class _CommissionRuleFormWidgetState
    extends ConsumerState<CommissionRuleFormWidget> {
  String? _providerId;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _commission;
  int? _minVolume;
  int? _maxVolume;
  @override
  void initState() {
    super.initState();
    _providerId = widget.item?.providerId;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _commission = widget.item?.commission;
    _minVolume = widget.item?.minVolume;
    _maxVolume = widget.item?.maxVolume;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.commissionrule'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.commissionrule'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _providerId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.providerid'.tr()),
              onChanged: (v) => _providerId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_start_date'.tr()}: ${_startDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_end_date'.tr()}: ${_endDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endDate = d);
              },
            ),
            TextFormField(
              initialValue: _commission?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commission'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commission = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _minVolume?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.minvolume'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _minVolume = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxVolume?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxvolume'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxVolume = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_providerId != null) 'providerId': _providerId,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_commission != null) 'commission': _commission,
                  if (_minVolume != null) 'minVolume': _minVolume,
                  if (_maxVolume != null) 'maxVolume': _maxVolume,
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
                  widget.onSubmit(CommissionRule.fromJson(json));
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
