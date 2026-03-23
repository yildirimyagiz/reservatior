import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Mention Form Widget  |  Fields: mentionedById, mentionedToId, type, taskId, propertyId, content, isRead, agencyId, userId

class MentionFormWidget extends StatefulWidget {
  final Mention? item;
  final void Function(Mention)? onSubmit;
  const MentionFormWidget({super.key, this.item, this.onSubmit});
  @override State<MentionFormWidget> createState() => _MentionFormWidgetState();
}

class _MentionFormWidgetState extends State<MentionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _mentionedById;
  String? _mentionedToId;
  String? _type;
  String? _taskId;
  String? _propertyId;
  String? _content;
  bool _isRead = false;
  String? _agencyId;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _mentionedById = widget.item?.mentionedById?.toString();
    _mentionedToId = widget.item?.mentionedToId?.toString();
    _type = widget.item?.type?.toString();
    _taskId = widget.item?.taskId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _content = widget.item?.content?.toString();
    _isRead = widget.item?.isRead ?? false;
    _agencyId = widget.item?.agencyId?.toString();
    _userId = widget.item?.userId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_mentionedById?.isNotEmpty == true) 'mentionedById': _mentionedById,
        if (_mentionedToId?.isNotEmpty == true) 'mentionedToId': _mentionedToId,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_taskId?.isNotEmpty == true) 'taskId': _taskId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_content?.isNotEmpty == true) 'content': _content,
        'isRead': _isRead,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
    };
    final result = widget.item != null
        ? Mention.fromJson({...widget.item!.toJson(), ...data})
        : Mention.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Mentioned By Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _mentionedById = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mentioned To Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _mentionedToId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Task Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _taskId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _content = v?.isEmpty == true ? null : v,
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Mention'),
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