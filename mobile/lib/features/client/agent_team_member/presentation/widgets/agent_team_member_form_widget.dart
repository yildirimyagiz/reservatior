import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AgentTeamMemberFormWidget extends ConsumerStatefulWidget {
  final AgentTeamMember? item;
  final Function(AgentTeamMember) onSubmit;
  const AgentTeamMemberFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AgentTeamMemberFormWidget> createState() =>
      _AgentTeamMemberFormWidgetState();
}

class _AgentTeamMemberFormWidgetState
    extends ConsumerState<AgentTeamMemberFormWidget> {
  String? _teamId;
  String? _userId;
  String? _role;
  @override
  void initState() {
    super.initState();
    _teamId = widget.item?.teamId;
    _userId = widget.item?.userId;
    _role = widget.item?.role;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.agentteammember'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.agentteammember'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _teamId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.teamid'.tr()),
              onChanged: (v) => _teamId = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _role?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.role'.tr()),
              onChanged: (v) => _role = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_teamId != null) 'teamId': _teamId,
                  if (_userId != null) 'userId': _userId,
                  if (_role != null) 'role': _role,
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
                  widget.onSubmit(AgentTeamMember.fromJson(json));
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
