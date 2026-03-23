import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SharedAmenity Form Widget  |  Fields: facilityId, name, type, description, location, capacity, isAvailable, operatingHours, accessType, price

class SharedAmenityFormWidget extends StatefulWidget {
  final SharedAmenity? item;
  final void Function(SharedAmenity)? onSubmit;
  const SharedAmenityFormWidget({super.key, this.item, this.onSubmit});
  @override State<SharedAmenityFormWidget> createState() => _SharedAmenityFormWidgetState();
}

class _SharedAmenityFormWidgetState extends State<SharedAmenityFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _facilityId;
  String? _name;
  String? _type;
  String? _description;
  String? _location;
  int? _capacity;
  bool _isAvailable = false;
  String? _operatingHours;
  String? _accessType;
  double? _price;

  @override
  void initState() {
    super.initState();
    _facilityId = widget.item?.facilityId?.toString();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _description = widget.item?.description?.toString();
    _location = widget.item?.location?.toString();
    _capacity = widget.item?.capacity;
    _isAvailable = widget.item?.isAvailable ?? false;
    _operatingHours = widget.item?.operatingHours?.toString();
    _accessType = widget.item?.accessType?.toString();
    _price = widget.item?.price;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_facilityId?.isNotEmpty == true) 'facilityId': _facilityId,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_location?.isNotEmpty == true) 'location': _location,
        if (_capacity != null) 'capacity': _capacity,
        'isAvailable': _isAvailable,
        if (_operatingHours?.isNotEmpty == true) 'operatingHours': _operatingHours,
        if (_accessType?.isNotEmpty == true) 'accessType': _accessType,
        if (_price != null) 'price': _price,
    };
    final result = widget.item != null
        ? SharedAmenity.fromJson({...widget.item!.toJson(), ...data})
        : SharedAmenity.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Facility Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _facilityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
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
                decoration: InputDecoration(labelText: 'Location', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _location = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Capacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                onSaved: (v) => _capacity = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Available'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isAvailable,
                  onChanged: (v) { ss(() {}); setState(() => _isAvailable = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Operating Hours', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _operatingHours = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Access Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _accessType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _price = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Shared Amenity'),
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