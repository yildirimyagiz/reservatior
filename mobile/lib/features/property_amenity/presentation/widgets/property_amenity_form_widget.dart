import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyAmenity Form Widget  |  Fields: propertyId, amenityId

class PropertyAmenityFormWidget extends StatefulWidget {
  final PropertyAmenity? item;
  final void Function(PropertyAmenity)? onSubmit;
  const PropertyAmenityFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyAmenityFormWidget> createState() => _PropertyAmenityFormWidgetState();
}

class _PropertyAmenityFormWidgetState extends State<PropertyAmenityFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _amenityId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _amenityId = widget.item?.amenityId?.toString();
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
        if (_amenityId?.isNotEmpty == true) 'amenityId': _amenityId,
    };
    final result = widget.item != null
        ? PropertyAmenity.fromJson({...widget.item!.toJson(), ...data})
        : PropertyAmenity.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Amenity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _amenityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Amenity'),
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