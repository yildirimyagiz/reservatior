import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Neighborhood Form Widget  |  Fields: name, city, state, zip, lat, lng, avgPrice, medianPrice, propertyCount

class NeighborhoodFormWidget extends StatefulWidget {
  final Neighborhood? item;
  final void Function(Neighborhood)? onSubmit;
  const NeighborhoodFormWidget({super.key, this.item, this.onSubmit});
  @override State<NeighborhoodFormWidget> createState() => _NeighborhoodFormWidgetState();
}

class _NeighborhoodFormWidgetState extends State<NeighborhoodFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _city;
  String? _state;
  String? _zip;
  double? _lat;
  double? _lng;
  double? _avgPrice;
  double? _medianPrice;
  int? _propertyCount;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _city = widget.item?.city?.toString();
    _state = widget.item?.state?.toString();
    _zip = widget.item?.zip?.toString();
    _lat = widget.item?.lat;
    _lng = widget.item?.lng;
    _avgPrice = widget.item?.avgPrice;
    _medianPrice = widget.item?.medianPrice;
    _propertyCount = widget.item?.propertyCount;
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
        if (_city?.isNotEmpty == true) 'city': _city,
        if (_state?.isNotEmpty == true) 'state': _state,
        if (_zip?.isNotEmpty == true) 'zip': _zip,
        if (_lat != null) 'lat': _lat,
        if (_lng != null) 'lng': _lng,
        if (_avgPrice != null) 'avgPrice': _avgPrice,
        if (_medianPrice != null) 'medianPrice': _medianPrice,
        if (_propertyCount != null) 'propertyCount': _propertyCount,
    };
    final result = widget.item != null
        ? Neighborhood.fromJson({...widget.item!.toJson(), ...data})
        : Neighborhood.fromJson(data);
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
                decoration: InputDecoration(labelText: 'City', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _city = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'State', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _state = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Zip', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _zip = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lat', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _lat = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lng', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _lng = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Avg Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _avgPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Median Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _medianPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Property Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _propertyCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Neighborhood'),
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