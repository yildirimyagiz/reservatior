import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyPhoto Form Widget  |  Fields: propertyId, url, caption, isPrimary, sortOrder

class PropertyPhotoFormWidget extends StatefulWidget {
  final PropertyPhoto? item;
  final void Function(PropertyPhoto)? onSubmit;
  const PropertyPhotoFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyPhotoFormWidget> createState() => _PropertyPhotoFormWidgetState();
}

class _PropertyPhotoFormWidgetState extends State<PropertyPhotoFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _url;
  String? _caption;
  bool _isPrimary = false;
  int? _sortOrder;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _url = widget.item?.url?.toString();
    _caption = widget.item?.caption?.toString();
    _isPrimary = widget.item?.isPrimary ?? false;
    _sortOrder = widget.item?.sortOrder;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_url?.isNotEmpty == true) 'url': _url,
        if (_caption?.isNotEmpty == true) 'caption': _caption,
        'isPrimary': _isPrimary,
        if (_sortOrder != null) 'sortOrder': _sortOrder,
    };
    final result = widget.item != null
        ? PropertyPhoto.fromJson({...widget.item!.toJson(), ...data})
        : PropertyPhoto.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _url = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Caption', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _caption = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Primary'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isPrimary,
                  onChanged: (v) { ss(() {}); setState(() => _isPrimary = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sort Order', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _sortOrder = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Photo'),
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