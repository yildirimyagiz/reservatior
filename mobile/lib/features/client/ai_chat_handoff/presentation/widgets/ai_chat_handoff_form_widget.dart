import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiChatHandoffFormWidget extends ConsumerStatefulWidget {
  final AiChatHandoff? item;
  final Function(AiChatHandoff) onSubmit;
  const AiChatHandoffFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AiChatHandoffFormWidget> createState() =>
      _AiChatHandoffFormWidgetState();
}

class _AiChatHandoffFormWidgetState
    extends ConsumerState<AiChatHandoffFormWidget> {
  String? _sessionId;
  String? _handoffReason;
  String? _handoffTo;
  DateTime? _handoffAt;
  DateTime? _resolvedAt;
  String? _resolvedBy;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _sessionId = widget.item?.sessionId;
    _handoffReason = widget.item?.handoffReason;
    _handoffTo = widget.item?.handoffTo;
    _handoffAt = widget.item?.handoffAt;
    _resolvedAt = widget.item?.resolvedAt;
    _resolvedBy = widget.item?.resolvedBy;
    _notes = widget.item?.notes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aichathandoff'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aichathandoff'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _sessionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sessionid'.tr()),
              onChanged: (v) => _sessionId = v,
            ),
            TextFormField(
              initialValue: _handoffReason?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.handoffreason'.tr()),
              onChanged: (v) => _handoffReason = v,
            ),
            TextFormField(
              initialValue: _handoffTo?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.handoffto'.tr()),
              onChanged: (v) => _handoffTo = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_handoff_at'.tr()}: ${_handoffAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _handoffAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _handoffAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_resolved_at'.tr()}: ${_resolvedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _resolvedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _resolvedAt = d);
              },
            ),
            TextFormField(
              initialValue: _resolvedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.resolvedby'.tr()),
              onChanged: (v) => _resolvedBy = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_sessionId != null) 'sessionId': _sessionId,
                  if (_handoffReason != null) 'handoffReason': _handoffReason,
                  if (_handoffTo != null) 'handoffTo': _handoffTo,
                  if (_handoffAt != null)
                    'handoffAt': _handoffAt!.toIso8601String(),
                  if (_resolvedAt != null)
                    'resolvedAt': _resolvedAt!.toIso8601String(),
                  if (_resolvedBy != null) 'resolvedBy': _resolvedBy,
                  if (_notes != null) 'notes': _notes,
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
                  widget.onSubmit(AiChatHandoff.fromJson(json));
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
