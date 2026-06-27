import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class TicketFormWidget extends ConsumerStatefulWidget {
  final Ticket? item;
  final Function(Ticket) onSubmit;
  const TicketFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<TicketFormWidget> createState() => _TicketFormWidgetState();
}

class _TicketFormWidgetState extends ConsumerState<TicketFormWidget> {
  String? _cuid;
  String? _subject;
  String? _description;
  DateTime? _closedAt;
  String? _userId;
  String? _agentId;
  @override
  void initState() {
    super.initState();
    _cuid = widget.item?.cuid;
    _subject = widget.item?.subject;
    _description = widget.item?.description;
    _closedAt = widget.item?.closedAt;
    _userId = widget.item?.userId;
    _agentId = widget.item?.agentId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.ticket'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.ticket'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _cuid?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.cuid'.tr()),
              onChanged: (v) => _cuid = v,
            ),
            TextFormField(
              initialValue: _subject?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.subject'.tr()),
              onChanged: (v) => _subject = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_closed_at'.tr()}: ${_closedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _closedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _closedAt = d);
              },
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_cuid != null) 'cuid': _cuid,
                  if (_subject != null) 'subject': _subject,
                  if (_description != null) 'description': _description,
                  if (_closedAt != null)
                    'closedAt': _closedAt!.toIso8601String(),
                  if (_userId != null) 'userId': _userId,
                  if (_agentId != null) 'agentId': _agentId,
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
                  widget.onSubmit(Ticket.fromJson(json));
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
