import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AgentPerformanceFormWidget extends ConsumerStatefulWidget {
  final AgentPerformance? item;
  final Function(AgentPerformance) onSubmit;
  const AgentPerformanceFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AgentPerformanceFormWidget> createState() =>
      _AgentPerformanceFormWidgetState();
}

class _AgentPerformanceFormWidgetState
    extends ConsumerState<AgentPerformanceFormWidget> {
  String? _userId;
  String? _period;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _leadsGenerated;
  int? _showingsCompleted;
  int? _offersSubmitted;
  int? _dealsClosed;
  double? _commissionEarned;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _period = widget.item?.period;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _leadsGenerated = widget.item?.leadsGenerated;
    _showingsCompleted = widget.item?.showingsCompleted;
    _offersSubmitted = widget.item?.offersSubmitted;
    _dealsClosed = widget.item?.dealsClosed;
    _commissionEarned = widget.item?.commissionEarned;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.agentperformance'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.agentperformance'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _period?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.period'.tr()),
              onChanged: (v) => _period = v,
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
              initialValue: _leadsGenerated?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leadsgenerated'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _leadsGenerated = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _showingsCompleted?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.showingscompleted'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _showingsCompleted = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _offersSubmitted?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.offerssubmitted'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _offersSubmitted = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _dealsClosed?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dealsclosed'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _dealsClosed = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _commissionEarned?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionearned'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionEarned = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_period != null) 'period': _period,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_leadsGenerated != null)
                    'leadsGenerated': _leadsGenerated,
                  if (_showingsCompleted != null)
                    'showingsCompleted': _showingsCompleted,
                  if (_offersSubmitted != null)
                    'offersSubmitted': _offersSubmitted,
                  if (_dealsClosed != null) 'dealsClosed': _dealsClosed,
                  if (_commissionEarned != null)
                    'commissionEarned': _commissionEarned,
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
                  widget.onSubmit(AgentPerformance.fromJson(json));
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
