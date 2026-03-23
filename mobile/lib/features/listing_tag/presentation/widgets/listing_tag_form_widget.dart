import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ListingTag Form Widget  |  Fields: listingId, tagId

class ListingTagFormWidget extends StatefulWidget {
  final ListingTag? item;
  final void Function(ListingTag)? onSubmit;
  const ListingTagFormWidget({super.key, this.item, this.onSubmit});
  @override State<ListingTagFormWidget> createState() => _ListingTagFormWidgetState();
}

class _ListingTagFormWidgetState extends State<ListingTagFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _tagId;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _tagId = widget.item?.tagId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_tagId?.isNotEmpty == true) 'tagId': _tagId,
    };
    final result = widget.item != null
        ? ListingTag.fromJson({...widget.item!.toJson(), ...data})
        : ListingTag.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tag Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _tagId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Listing Tag'),
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