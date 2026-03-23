import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Post Form Widget  |  Fields: title, content, slug, userId, agencyId, hashtagId, agentId

class PostFormWidget extends StatefulWidget {
  final Post? item;
  final void Function(Post)? onSubmit;
  const PostFormWidget({super.key, this.item, this.onSubmit});
  @override State<PostFormWidget> createState() => _PostFormWidgetState();
}

class _PostFormWidgetState extends State<PostFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _title;
  String? _content;
  String? _slug;
  String? _userId;
  String? _agencyId;
  String? _hashtagId;
  String? _agentId;

  @override
  void initState() {
    super.initState();
    _title = widget.item?.title?.toString();
    _content = widget.item?.content?.toString();
    _slug = widget.item?.slug?.toString();
    _userId = widget.item?.userId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _hashtagId = widget.item?.hashtagId?.toString();
    _agentId = widget.item?.agentId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_content?.isNotEmpty == true) 'content': _content,
        if (_slug?.isNotEmpty == true) 'slug': _slug,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_hashtagId?.isNotEmpty == true) 'hashtagId': _hashtagId,
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
    };
    final result = widget.item != null
        ? Post.fromJson({...widget.item!.toJson(), ...data})
        : Post.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _content = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Slug', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _slug = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hashtag Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _hashtagId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Post'),
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