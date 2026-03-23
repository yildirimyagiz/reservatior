import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── IncludedService Form Widget  |  Fields: propertyId, name, description, value, isRecurring, frequency, icon, logo, facilityId

class IncludedServiceFormWidget extends StatefulWidget {
  final IncludedService? item;
  final void Function(IncludedService)? onSubmit;
  const IncludedServiceFormWidget({super.key, this.item, this.onSubmit});
  @override State<IncludedServiceFormWidget> createState() => _IncludedServiceFormWidgetState();
}

class _IncludedServiceFormWidgetState extends State<IncludedServiceFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _name;
  String? _description;
  double? _value;
  bool _isRecurring = false;
  String? _frequency;
  String? _icon;
  String? _logo;
  String? _facilityId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _value = widget.item?.value;
    _isRecurring = widget.item?.isRecurring ?? false;
    _frequency = widget.item?.frequency?.toString();
    _icon = widget.item?.icon?.toString();
    _logo = widget.item?.logo?.toString();
    _facilityId = widget.item?.facilityId?.toString();
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
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_value != null) 'value': _value,
        'isRecurring': _isRecurring,
        if (_frequency?.isNotEmpty == true) 'frequency': _frequency,
        if (_icon?.isNotEmpty == true) 'icon': _icon,
        if (_logo?.isNotEmpty == true) 'logo': _logo,
        if (_facilityId?.isNotEmpty == true) 'facilityId': _facilityId,
    };
    final result = widget.item != null
        ? IncludedService.fromJson({...widget.item!.toJson(), ...data})
        : IncludedService.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _value = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Recurring'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isRecurring,
                  onChanged: (v) { ss(() {}); setState(() => _isRecurring = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Frequency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _frequency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Icon', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _icon = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Logo', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _logo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Facility Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _facilityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Included Service'),
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