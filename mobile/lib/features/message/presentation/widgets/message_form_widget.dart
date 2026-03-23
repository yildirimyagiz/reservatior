import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Message Form Widget ──
// Fields: threadId, senderType, senderUserId, senderContactId, body, subject, isThreadStarter, threadInfo, readStatus

class MessageFormWidget extends StatefulWidget {
  final Message? item;
  final void Function(Message)? onSubmit;
  const MessageFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<MessageFormWidget> createState() => _MessageFormWidgetState();
}

class _MessageFormWidgetState extends State<MessageFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _threadId;
  String? _senderType;
  String? _senderUserId;
  String? _senderContactId;
  String? _body;
  String? _subject;
  bool _isThreadStarter = false;
  String? _threadInfo;
  String? _readStatus;

  @override
  void initState() {
    super.initState();
    _threadId = widget.item?.threadId?.toString();
    _senderType = widget.item?.senderType?.toString();
    _senderUserId = widget.item?.senderUserId?.toString();
    _senderContactId = widget.item?.senderContactId?.toString();
    _body = widget.item?.body?.toString();
    _subject = widget.item?.subject?.toString();
    _isThreadStarter = widget.item?.isThreadStarter ?? false;
    _threadInfo = widget.item?.threadInfo?.toString();
    _readStatus = widget.item?.readStatus?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_threadId != null) 'threadId': _threadId,
        if (_senderType != null) 'senderType': _senderType,
        if (_senderUserId != null) 'senderUserId': _senderUserId,
        if (_senderContactId != null) 'senderContactId': _senderContactId,
        if (_body != null) 'body': _body,
        if (_subject != null) 'subject': _subject,
        'isThreadStarter': _isThreadStarter,
        if (_threadInfo != null) 'threadInfo': _threadInfo,
        if (_readStatus != null) 'readStatus': _readStatus,
    };
    final result = widget.item != null
        ? Message.fromJson({...widget.item!.toJson(), ...data})
        : Message.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Thread Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _threadId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sender Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _senderType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sender User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _senderUserId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sender Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _senderContactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Body', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _body = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _subject = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Thread Starter'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isThreadStarter,
                  onChanged: (v) { ss(() {}); setState(() => _isThreadStarter = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Thread Info', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _threadInfo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Read Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _readStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Message'),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
