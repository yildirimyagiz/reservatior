import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationFormWidget extends ConsumerStatefulWidget {
  final Notification? item;
  final Function(Notification) onSubmit;
  const NotificationFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<NotificationFormWidget> createState() =>
      _NotificationFormWidgetState();
}

class _NotificationFormWidgetState
    extends ConsumerState<NotificationFormWidget> {
  String? _userId;
  String? _title;
  String? _body;
  DateTime? _sentAt;
  DateTime? _readAt;
  String? _ruleKey;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _title = widget.item?.title;
    _body = widget.item?.body;
    _sentAt = widget.item?.sentAt;
    _readAt = widget.item?.readAt;
    _ruleKey = widget.item?.ruleKey;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.notification'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.notification'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _body?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.body'.tr()),
              onChanged: (v) => _body = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_sent_at'.tr()}: ${_sentAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _sentAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _sentAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_read_at'.tr()}: ${_readAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _readAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _readAt = d);
              },
            ),
            TextFormField(
              initialValue: _ruleKey?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rulekey'.tr()),
              onChanged: (v) => _ruleKey = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_title != null) 'title': _title,
                  if (_body != null) 'body': _body,
                  if (_sentAt != null) 'sentAt': _sentAt!.toIso8601String(),
                  if (_readAt != null) 'readAt': _readAt!.toIso8601String(),
                  if (_ruleKey != null) 'ruleKey': _ruleKey,
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
                  widget.onSubmit(Notification.fromJson(json));
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
