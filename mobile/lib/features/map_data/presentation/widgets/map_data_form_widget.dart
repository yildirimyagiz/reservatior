import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MapData Form Widget  |  Fields: projectId, coordinates, address, placeId, amenities, geocodingData

class MapDataFormWidget extends StatefulWidget {
  final MapData? item;
  final void Function(MapData)? onSubmit;
  const MapDataFormWidget({super.key, this.item, this.onSubmit});
  @override State<MapDataFormWidget> createState() => _MapDataFormWidgetState();
}

class _MapDataFormWidgetState extends State<MapDataFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _projectId;
  String? _coordinates;
  String? _address;
  String? _placeId;
  String? _amenities;
  String? _geocodingData;

  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId?.toString();
    _coordinates = widget.item?.coordinates?.toString();
    _address = widget.item?.address?.toString();
    _placeId = widget.item?.placeId?.toString();
    _amenities = widget.item?.amenities?.toString();
    _geocodingData = widget.item?.geocodingData?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_projectId?.isNotEmpty == true) 'projectId': _projectId,
        if (_coordinates?.isNotEmpty == true) 'coordinates': _coordinates,
        if (_address?.isNotEmpty == true) 'address': _address,
        if (_placeId?.isNotEmpty == true) 'placeId': _placeId,
        if (_amenities?.isNotEmpty == true) 'amenities': _amenities,
        if (_geocodingData?.isNotEmpty == true) 'geocodingData': _geocodingData,
    };
    final result = widget.item != null
        ? MapData.fromJson({...widget.item!.toJson(), ...data})
        : MapData.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Project Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _projectId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Coordinates', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _coordinates = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _address = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Place Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _placeId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amenities', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _amenities = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Geocoding Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _geocodingData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Map Data'),
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