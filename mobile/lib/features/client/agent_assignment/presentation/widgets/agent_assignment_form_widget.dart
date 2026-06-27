import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AgentAssignmentFormWidget extends ConsumerStatefulWidget {
  final AgentAssignment? item;
  final Function(AgentAssignment) onSubmit;
  const AgentAssignmentFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AgentAssignmentFormWidget> createState() =>
      _AgentAssignmentFormWidgetState();
}

class _AgentAssignmentFormWidgetState
    extends ConsumerState<AgentAssignmentFormWidget> {
  String? _listingId;
  String? _agentUserId;
  String? _agencyOrgId;
  int? _commissionBps;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _agentUserId = widget.item?.agentUserId;
    _agencyOrgId = widget.item?.agencyOrgId;
    _commissionBps = widget.item?.commissionBps;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.agentassignment'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.agentassignment'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _agentUserId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentuserid'.tr()),
              onChanged: (v) => _agentUserId = v,
            ),
            TextFormField(
              initialValue: _agencyOrgId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyorgid'.tr()),
              onChanged: (v) => _agencyOrgId = v,
            ),
            TextFormField(
              initialValue: _commissionBps?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionbps'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionBps = int.tryParse(v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_agentUserId != null) 'agentUserId': _agentUserId,
                  if (_agencyOrgId != null) 'agencyOrgId': _agencyOrgId,
                  if (_commissionBps != null) 'commissionBps': _commissionBps,
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
                  widget.onSubmit(AgentAssignment.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('mobile.auto.error_occurred'.tr())),
                  );
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
