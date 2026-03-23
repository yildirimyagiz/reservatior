import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── CommunicationLog Form Widget  |  Fields: senderId, receiverId, type, content, entityId, entityType, metadata, isRead, readAt, deliveredAt, timestamp, userId, agencyId, threadId, replyToId, channelId, ticketId, isEdited, editedAt, deletedById, reactions, attachments, readBy

class CommunicationLogFormWidget extends StatefulWidget {
  final CommunicationLog? item;
  final void Function(CommunicationLog)? onSubmit;
  const CommunicationLogFormWidget({super.key, this.item, this.onSubmit});
  @override State<CommunicationLogFormWidget> createState() => _CommunicationLogFormWidgetState();
}

class _CommunicationLogFormWidgetState extends State<CommunicationLogFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _senderId;
  String? _receiverId;
  String? _type;
  String? _content;
  String? _entityId;
  String? _entityType;
  String? _metadata;
  bool _isRead = false;
  DateTime? _readAt;
  DateTime? _deliveredAt;
  DateTime? _timestamp;
  String? _userId;
  String? _agencyId;
  String? _threadId;
  String? _replyToId;
  String? _channelId;
  String? _ticketId;
  bool _isEdited = false;
  DateTime? _editedAt;
  String? _deletedById;
  String? _reactions;
  String? _attachments;
  String? _readBy;

  @override
  void initState() {
    super.initState();
    _senderId = widget.item?.senderId?.toString();
    _receiverId = widget.item?.receiverId?.toString();
    _type = widget.item?.type?.toString();
    _content = widget.item?.content?.toString();
    _entityId = widget.item?.entityId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _metadata = widget.item?.metadata?.toString();
    _isRead = widget.item?.isRead ?? false;
    _readAt = widget.item?.readAt;
    _deliveredAt = widget.item?.deliveredAt;
    _timestamp = widget.item?.timestamp;
    _userId = widget.item?.userId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _threadId = widget.item?.threadId?.toString();
    _replyToId = widget.item?.replyToId?.toString();
    _channelId = widget.item?.channelId?.toString();
    _ticketId = widget.item?.ticketId?.toString();
    _isEdited = widget.item?.isEdited ?? false;
    _editedAt = widget.item?.editedAt;
    _deletedById = widget.item?.deletedById?.toString();
    _reactions = widget.item?.reactions?.toString();
    _attachments = widget.item?.attachments?.toString();
    _readBy = widget.item?.readBy?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_senderId?.isNotEmpty == true) 'senderId': _senderId,
        if (_receiverId?.isNotEmpty == true) 'receiverId': _receiverId,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_content?.isNotEmpty == true) 'content': _content,
        if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
        if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
        if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
        'isRead': _isRead,
        if (_readAt != null) 'readAt': _readAt!.toIso8601String(),
        if (_deliveredAt != null) 'deliveredAt': _deliveredAt!.toIso8601String(),
        if (_timestamp != null) 'timestamp': _timestamp!.toIso8601String(),
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_threadId?.isNotEmpty == true) 'threadId': _threadId,
        if (_replyToId?.isNotEmpty == true) 'replyToId': _replyToId,
        if (_channelId?.isNotEmpty == true) 'channelId': _channelId,
        if (_ticketId?.isNotEmpty == true) 'ticketId': _ticketId,
        'isEdited': _isEdited,
        if (_editedAt != null) 'editedAt': _editedAt!.toIso8601String(),
        if (_deletedById?.isNotEmpty == true) 'deletedById': _deletedById,
        if (_reactions?.isNotEmpty == true) 'reactions': _reactions,
        if (_attachments?.isNotEmpty == true) 'attachments': _attachments,
        if (_readBy?.isNotEmpty == true) 'readBy': _readBy,
    };
    final result = widget.item != null
        ? CommunicationLog.fromJson({...widget.item!.toJson(), ...data})
        : CommunicationLog.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Sender Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _senderId?.toString() ?? '',
                onSaved: (v) => _senderId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Receiver Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _receiverId?.toString() ?? '',
                onSaved: (v) => _receiverId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _type?.toString() ?? '',
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _content?.toString() ?? '',
                onSaved: (v) => _content = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _entityId?.toString() ?? '',
                onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _entityType?.toString() ?? '',
                onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _metadata?.toString() ?? '',
                onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Read'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isRead,
                  onChanged: (v) { ss(() {}); setState(() => _isRead = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _readAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _readAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Read At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_readAt != null ? _fmt(_readAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _deliveredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _deliveredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Delivered At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_deliveredAt != null ? _fmt(_deliveredAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _timestamp ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _timestamp = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Timestamp',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_timestamp != null ? _fmt(_timestamp) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _userId?.toString() ?? '',
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _agencyId?.toString() ?? '',
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Thread Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _threadId?.toString() ?? '',
                onSaved: (v) => _threadId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reply To Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _replyToId?.toString() ?? '',
                onSaved: (v) => _replyToId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Channel Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _channelId?.toString() ?? '',
                onSaved: (v) => _channelId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ticket Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _ticketId?.toString() ?? '',
                onSaved: (v) => _ticketId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Edited'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isEdited,
                  onChanged: (v) { ss(() {}); setState(() => _isEdited = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _editedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _editedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Edited At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_editedAt != null ? _fmt(_editedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deleted By Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _deletedById?.toString() ?? '',
                onSaved: (v) => _deletedById = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reactions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _reactions?.toString() ?? '',
                onSaved: (v) => _reactions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Attachments', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _attachments?.toString() ?? '',
                onSaved: (v) => _attachments = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Read By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _readBy?.toString() ?? '',
                onSaved: (v) => _readBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Communication Log'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}