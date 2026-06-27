import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MessageFormWidget extends ConsumerStatefulWidget {
  final Message? item;
  final Function(Message) onSubmit;
  const MessageFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MessageFormWidget> createState() => _MessageFormWidgetState();
}

class _MessageFormWidgetState extends ConsumerState<MessageFormWidget> {
  String? _threadId;
  String? _senderUserId;
  String? _senderContactId;
  String? _body;
  String? _subject;
  bool? _isThreadStarter;
  @override
  void initState() {
    super.initState();
    _threadId = widget.item?.threadId;
    _senderUserId = widget.item?.senderUserId;
    _senderContactId = widget.item?.senderContactId;
    _body = widget.item?.body;
    _subject = widget.item?.subject;
    _isThreadStarter = widget.item?.isThreadStarter;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.message'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.message'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _threadId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.threadid'.tr()),
              onChanged: (v) => _threadId = v,
            ),
            TextFormField(
              initialValue: _senderUserId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.senderuserid'.tr()),
              onChanged: (v) => _senderUserId = v,
            ),
            TextFormField(
              initialValue: _senderContactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sendercontactid'.tr()),
              onChanged: (v) => _senderContactId = v,
            ),
            TextFormField(
              initialValue: _body?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.body'.tr()),
              onChanged: (v) => _body = v,
            ),
            TextFormField(
              initialValue: _subject?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.subject'.tr()),
              onChanged: (v) => _subject = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isthreadstarter'.tr()),
              value: _isThreadStarter ?? false,
              onChanged: (v) => setState(() => _isThreadStarter = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_threadId != null) 'threadId': _threadId,
                  if (_senderUserId != null) 'senderUserId': _senderUserId,
                  if (_senderContactId != null)
                    'senderContactId': _senderContactId,
                  if (_body != null) 'body': _body,
                  if (_subject != null) 'subject': _subject,
                  'isThreadStarter': _isThreadStarter,
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
                  widget.onSubmit(Message.fromJson(json));
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
