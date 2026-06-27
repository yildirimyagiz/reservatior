import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class CommunicationLogFormWidget extends ConsumerStatefulWidget {
  final CommunicationLog? item;
  final Function(CommunicationLog) onSubmit;
  const CommunicationLogFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<CommunicationLogFormWidget> createState() =>
      _CommunicationLogFormWidgetState();
}

class _CommunicationLogFormWidgetState
    extends ConsumerState<CommunicationLogFormWidget> {
  String? _senderId;
  String? _receiverId;
  String? _content;
  String? _entityId;
  String? _entityType;
  bool? _isRead;
  DateTime? _readAt;
  DateTime? _deliveredAt;
  DateTime? _timestamp;
  String? _userId;
  String? _agencyId;
  String? _threadId;
  String? _replyToId;
  String? _channelId;
  String? _ticketId;
  bool? _isEdited;
  DateTime? _editedAt;
  String? _deletedById;
  @override
  void initState() {
    super.initState();
    _senderId = widget.item?.senderId;
    _receiverId = widget.item?.receiverId;
    _content = widget.item?.content;
    _entityId = widget.item?.entityId;
    _entityType = widget.item?.entityType;
    _isRead = widget.item?.isRead;
    _readAt = widget.item?.readAt;
    _deliveredAt = widget.item?.deliveredAt;
    _timestamp = widget.item?.timestamp;
    _userId = widget.item?.userId;
    _agencyId = widget.item?.agencyId;
    _threadId = widget.item?.threadId;
    _replyToId = widget.item?.replyToId;
    _channelId = widget.item?.channelId;
    _ticketId = widget.item?.ticketId;
    _isEdited = widget.item?.isEdited;
    _editedAt = widget.item?.editedAt;
    _deletedById = widget.item?.deletedById;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.communicationlog'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.communicationlog'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _senderId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.senderid'.tr()),
              onChanged: (v) => _senderId = v,
            ),
            TextFormField(
              initialValue: _receiverId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.receiverid'.tr()),
              onChanged: (v) => _receiverId = v,
            ),
            TextFormField(
              initialValue: _content?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.content'.tr()),
              onChanged: (v) => _content = v,
            ),
            TextFormField(
              initialValue: _entityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entityid'.tr()),
              onChanged: (v) => _entityId = v,
            ),
            TextFormField(
              initialValue: _entityType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entitytype'.tr()),
              onChanged: (v) => _entityType = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isread'.tr()),
              value: _isRead ?? false,
              onChanged: (v) => setState(() => _isRead = v),
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
            ListTile(
              title: Text("${'mobile.admin.field_delivered_at'.tr()}: ${_deliveredAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _deliveredAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _deliveredAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_timestamp'.tr()}: ${_timestamp ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _timestamp ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _timestamp = d);
              },
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _threadId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.threadid'.tr()),
              onChanged: (v) => _threadId = v,
            ),
            TextFormField(
              initialValue: _replyToId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.replytoid'.tr()),
              onChanged: (v) => _replyToId = v,
            ),
            TextFormField(
              initialValue: _channelId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.channelid'.tr()),
              onChanged: (v) => _channelId = v,
            ),
            TextFormField(
              initialValue: _ticketId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ticketid'.tr()),
              onChanged: (v) => _ticketId = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isedited'.tr()),
              value: _isEdited ?? false,
              onChanged: (v) => setState(() => _isEdited = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_edited_at'.tr()}: ${_editedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _editedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _editedAt = d);
              },
            ),
            TextFormField(
              initialValue: _deletedById?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.deletedbyid'.tr()),
              onChanged: (v) => _deletedById = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_senderId != null) 'senderId': _senderId,
                  if (_receiverId != null) 'receiverId': _receiverId,
                  if (_content != null) 'content': _content,
                  if (_entityId != null) 'entityId': _entityId,
                  if (_entityType != null) 'entityType': _entityType,
                  'isRead': _isRead,
                  if (_readAt != null) 'readAt': _readAt!.toIso8601String(),
                  if (_deliveredAt != null)
                    'deliveredAt': _deliveredAt!.toIso8601String(),
                  if (_timestamp != null)
                    'timestamp': _timestamp!.toIso8601String(),
                  if (_userId != null) 'userId': _userId,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_threadId != null) 'threadId': _threadId,
                  if (_replyToId != null) 'replyToId': _replyToId,
                  if (_channelId != null) 'channelId': _channelId,
                  if (_ticketId != null) 'ticketId': _ticketId,
                  'isEdited': _isEdited,
                  if (_editedAt != null)
                    'editedAt': _editedAt!.toIso8601String(),
                  if (_deletedById != null) 'deletedById': _deletedById,
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
                  widget.onSubmit(CommunicationLog.fromJson(json));
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
