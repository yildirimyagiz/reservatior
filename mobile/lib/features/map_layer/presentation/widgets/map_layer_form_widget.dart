import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MapLayer Form Widget  |  Fields: name, type, provider, url, config, isVisible, opacity, zIndex, northEastLat, northEastLng, southWestLat, southWestLng, centerLat, centerLng, zoomLevel, minZoom, maxZoom, fillColor, strokeColor, strokeWidth, fillOpacity

class MapLayerFormWidget extends StatefulWidget {
  final MapLayer? item;
  final void Function(MapLayer)? onSubmit;
  const MapLayerFormWidget({super.key, this.item, this.onSubmit});
  @override State<MapLayerFormWidget> createState() => _MapLayerFormWidgetState();
}

class _MapLayerFormWidgetState extends State<MapLayerFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _type;
  String? _provider;
  String? _url;
  String? _config;
  bool _isVisible = false;
  double? _opacity;
  int? _zIndex;
  double? _northEastLat;
  double? _northEastLng;
  double? _southWestLat;
  double? _southWestLng;
  double? _centerLat;
  double? _centerLng;
  int? _zoomLevel;
  int? _minZoom;
  int? _maxZoom;
  String? _fillColor;
  String? _strokeColor;
  double? _strokeWidth;
  double? _fillOpacity;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _provider = widget.item?.provider?.toString();
    _url = widget.item?.url?.toString();
    _config = widget.item?.config?.toString();
    _isVisible = widget.item?.isVisible ?? false;
    _opacity = widget.item?.opacity;
    _zIndex = widget.item?.zIndex;
    _northEastLat = widget.item?.northEastLat;
    _northEastLng = widget.item?.northEastLng;
    _southWestLat = widget.item?.southWestLat;
    _southWestLng = widget.item?.southWestLng;
    _centerLat = widget.item?.centerLat;
    _centerLng = widget.item?.centerLng;
    _zoomLevel = widget.item?.zoomLevel;
    _minZoom = widget.item?.minZoom;
    _maxZoom = widget.item?.maxZoom;
    _fillColor = widget.item?.fillColor?.toString();
    _strokeColor = widget.item?.strokeColor?.toString();
    _strokeWidth = widget.item?.strokeWidth;
    _fillOpacity = widget.item?.fillOpacity;
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
        if (_provider?.isNotEmpty == true) 'provider': _provider,
        if (_url?.isNotEmpty == true) 'url': _url,
        if (_config?.isNotEmpty == true) 'config': _config,
        'isVisible': _isVisible,
        if (_opacity != null) 'opacity': _opacity,
        if (_zIndex != null) 'zIndex': _zIndex,
        if (_northEastLat != null) 'northEastLat': _northEastLat,
        if (_northEastLng != null) 'northEastLng': _northEastLng,
        if (_southWestLat != null) 'southWestLat': _southWestLat,
        if (_southWestLng != null) 'southWestLng': _southWestLng,
        if (_centerLat != null) 'centerLat': _centerLat,
        if (_centerLng != null) 'centerLng': _centerLng,
        if (_zoomLevel != null) 'zoomLevel': _zoomLevel,
        if (_minZoom != null) 'minZoom': _minZoom,
        if (_maxZoom != null) 'maxZoom': _maxZoom,
        if (_fillColor?.isNotEmpty == true) 'fillColor': _fillColor,
        if (_strokeColor?.isNotEmpty == true) 'strokeColor': _strokeColor,
        if (_strokeWidth != null) 'strokeWidth': _strokeWidth,
        if (_fillOpacity != null) 'fillOpacity': _fillOpacity,
    };
    final result = widget.item != null
        ? MapLayer.fromJson({...widget.item!.toJson(), ...data})
        : MapLayer.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _provider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _url = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _config = v?.isEmpty == true ? null : v,
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
                decoration: const InputDecoration(labelText: 'Opacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                onSaved: (v) => _opacity = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Z Index', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _zIndex = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'North East Lat', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _northEastLat = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'North East Lng', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _northEastLng = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'South West Lat', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _southWestLat = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'South West Lng', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _southWestLng = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Center Lat', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _centerLat = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Center Lng', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _centerLng = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Zoom Level', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _zoomLevel = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Min Zoom', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _minZoom = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Zoom', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxZoom = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fill Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _fillColor = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stroke Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _strokeColor = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Stroke Width', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _strokeWidth = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fill Opacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                onSaved: (v) => _fillOpacity = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Map Layer'),
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