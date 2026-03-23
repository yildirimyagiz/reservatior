import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Route Form Widget  |  Fields: name, type, startLocationId, endLocationId, waypoints, distance, duration, polyline, provider, instructions, trafficData, tolls, isVisible, color, strokeWidth, opacity

class RouteFormWidget extends StatefulWidget {
  final Route? item;
  final void Function(Route)? onSubmit;
  const RouteFormWidget({super.key, this.item, this.onSubmit});
  @override State<RouteFormWidget> createState() => _RouteFormWidgetState();
}

class _RouteFormWidgetState extends State<RouteFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _type;
  String? _startLocationId;
  String? _endLocationId;
  String? _waypoints;
  double? _distance;
  int? _duration;
  String? _polyline;
  String? _provider;
  String? _instructions;
  String? _trafficData;
  double? _tolls;
  bool _isVisible = false;
  String? _color;
  int? _strokeWidth;
  double? _opacity;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _startLocationId = widget.item?.startLocationId?.toString();
    _endLocationId = widget.item?.endLocationId?.toString();
    _waypoints = widget.item?.waypoints?.toString();
    _distance = widget.item?.distance;
    _duration = widget.item?.duration;
    _polyline = widget.item?.polyline?.toString();
    _provider = widget.item?.provider?.toString();
    _instructions = widget.item?.instructions?.toString();
    _trafficData = widget.item?.trafficData?.toString();
    _tolls = widget.item?.tolls;
    _isVisible = widget.item?.isVisible ?? false;
    _color = widget.item?.color?.toString();
    _strokeWidth = widget.item?.strokeWidth;
    _opacity = widget.item?.opacity;
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
        if (_startLocationId?.isNotEmpty == true) 'startLocationId': _startLocationId,
        if (_endLocationId?.isNotEmpty == true) 'endLocationId': _endLocationId,
        if (_waypoints?.isNotEmpty == true) 'waypoints': _waypoints,
        if (_distance != null) 'distance': _distance,
        if (_duration != null) 'duration': _duration,
        if (_polyline?.isNotEmpty == true) 'polyline': _polyline,
        if (_provider?.isNotEmpty == true) 'provider': _provider,
        if (_instructions?.isNotEmpty == true) 'instructions': _instructions,
        if (_trafficData?.isNotEmpty == true) 'trafficData': _trafficData,
        if (_tolls != null) 'tolls': _tolls,
        'isVisible': _isVisible,
        if (_color?.isNotEmpty == true) 'color': _color,
        if (_strokeWidth != null) 'strokeWidth': _strokeWidth,
        if (_opacity != null) 'opacity': _opacity,
    };
    final result = widget.item != null
        ? Route.fromJson({...widget.item!.toJson(), ...data})
        : Route.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Start Location Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _startLocationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'End Location Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _endLocationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Waypoints', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _waypoints = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Distance', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _distance = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _duration = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Polyline', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _polyline = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _provider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Instructions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _instructions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Traffic Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _trafficData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tolls', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _tolls = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Visible'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isVisible,
                  onChanged: (v) { ss(() {}); setState(() => _isVisible = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _color = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Stroke Width', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _strokeWidth = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Opacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                onSaved: (v) => _opacity = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Route'),
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