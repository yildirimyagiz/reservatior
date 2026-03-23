import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Hashtag Form Widget  |  Fields: name, type, description, usageCount, createdById, agencyId

class HashtagFormWidget extends StatefulWidget {
  final Hashtag? item;
  final void Function(Hashtag)? onSubmit;
  const HashtagFormWidget({super.key, this.item, this.onSubmit});
  @override State<HashtagFormWidget> createState() => _HashtagFormWidgetState();
}

class _HashtagFormWidgetState extends State<HashtagFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _type;
  String? _description;
  int? _usageCount;
  String? _createdById;
  String? _agencyId;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _description = widget.item?.description?.toString();
    _usageCount = widget.item?.usageCount;
    _createdById = widget.item?.createdById?.toString();
    _agencyId = widget.item?.agencyId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_usageCount != null) 'usageCount': _usageCount,
        if (_createdById?.isNotEmpty == true) 'createdById': _createdById,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
    };
    final result = widget.item != null
        ? Hashtag.fromJson({...widget.item!.toJson(), ...data})
        : Hashtag.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Usage Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _usageCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Created By Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _createdById = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Hashtag'),
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