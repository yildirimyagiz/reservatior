import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiChatbotSessionFormWidget extends ConsumerStatefulWidget {
  final AiChatbotSession? item;
  final Function(AiChatbotSession) onSubmit;
  const AiChatbotSessionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiChatbotSessionFormWidget> createState() =>
      _AiChatbotSessionFormWidgetState();
}

class _AiChatbotSessionFormWidgetState
    extends ConsumerState<AiChatbotSessionFormWidget> {
  String? _userId;
  String? _contactId;
  String? _sessionId;
  String? _intent;
  double? _confidence;
  String? _status;
  String? _transferredTo;
  DateTime? _startedAt;
  DateTime? _lastActivityAt;
  DateTime? _endedAt;
  int? _satisfaction;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _contactId = widget.item?.contactId;
    _sessionId = widget.item?.sessionId;
    _intent = widget.item?.intent;
    _confidence = widget.item?.confidence;
    _status = widget.item?.status;
    _transferredTo = widget.item?.transferredTo;
    _startedAt = widget.item?.startedAt;
    _lastActivityAt = widget.item?.lastActivityAt;
    _endedAt = widget.item?.endedAt;
    _satisfaction = widget.item?.satisfaction;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aichatbotsession'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aichatbotsession'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _sessionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sessionid'.tr()),
              onChanged: (v) => _sessionId = v,
            ),
            TextFormField(
              initialValue: _intent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.intent'.tr()),
              onChanged: (v) => _intent = v,
            ),
            TextFormField(
              initialValue: _confidence?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidence'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidence = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _transferredTo?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.transferredto'.tr()),
              onChanged: (v) => _transferredTo = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_started_at'.tr()}: ${_startedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_activity_at'.tr()}: ${_lastActivityAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastActivityAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastActivityAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_ended_at'.tr()}: ${_endedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endedAt = d);
              },
            ),
            TextFormField(
              initialValue: _satisfaction?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.satisfaction'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _satisfaction = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_sessionId != null) 'sessionId': _sessionId,
                  if (_intent != null) 'intent': _intent,
                  if (_confidence != null) 'confidence': _confidence,
                  if (_status != null) 'status': _status,
                  if (_transferredTo != null) 'transferredTo': _transferredTo,
                  if (_startedAt != null)
                    'startedAt': _startedAt!.toIso8601String(),
                  if (_lastActivityAt != null)
                    'lastActivityAt': _lastActivityAt!.toIso8601String(),
                  if (_endedAt != null) 'endedAt': _endedAt!.toIso8601String(),
                  if (_satisfaction != null) 'satisfaction': _satisfaction,
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
                  widget.onSubmit(AiChatbotSession.fromJson(json));
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
