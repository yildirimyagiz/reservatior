import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ReferenceSource Form Widget  |  Fields: name, logo, apiKey, apiSecret, baseUrl, isActive, commission, source

class ReferenceSourceFormWidget extends StatefulWidget {
  final ReferenceSource? item;
  final void Function(ReferenceSource)? onSubmit;
  const ReferenceSourceFormWidget({super.key, this.item, this.onSubmit});
  @override State<ReferenceSourceFormWidget> createState() => _ReferenceSourceFormWidgetState();
}

class _ReferenceSourceFormWidgetState extends State<ReferenceSourceFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _logo;
  String? _apiKey;
  String? _apiSecret;
  String? _baseUrl;
  bool _isActive = false;
  double? _commission;
  String? _source;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _logo = widget.item?.logo?.toString();
    _apiKey = widget.item?.apiKey?.toString();
    _apiSecret = widget.item?.apiSecret?.toString();
    _baseUrl = widget.item?.baseUrl?.toString();
    _isActive = widget.item?.isActive ?? false;
    _commission = widget.item?.commission;
    _source = widget.item?.source?.toString();
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
        if (_logo?.isNotEmpty == true) 'logo': _logo,
        if (_apiKey?.isNotEmpty == true) 'apiKey': _apiKey,
        if (_apiSecret?.isNotEmpty == true) 'apiSecret': _apiSecret,
        if (_baseUrl?.isNotEmpty == true) 'baseUrl': _baseUrl,
        'isActive': _isActive,
        if (_commission != null) 'commission': _commission,
        if (_source?.isNotEmpty == true) 'source': _source,
    };
    final result = widget.item != null
        ? ReferenceSource.fromJson({...widget.item!.toJson(), ...data})
        : ReferenceSource.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Logo', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _logo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Api Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _apiKey = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Api Secret', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _apiSecret = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Base Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _baseUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _commission = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Source', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _source = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Reference Source'),
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