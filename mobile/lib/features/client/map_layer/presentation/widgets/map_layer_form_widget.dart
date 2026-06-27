import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MapLayerFormWidget extends ConsumerStatefulWidget {
  final MapLayer? item;
  final Function(MapLayer) onSubmit;
  const MapLayerFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MapLayerFormWidget> createState() => _MapLayerFormWidgetState();
}

class _MapLayerFormWidgetState extends ConsumerState<MapLayerFormWidget> {
  String? _name;
  String? _type;
  String? _url;
  bool? _isVisible;
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
    _name = widget.item?.name;
    _type = widget.item?.type;
    _url = widget.item?.url;
    _isVisible = widget.item?.isVisible;
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
    _fillColor = widget.item?.fillColor;
    _strokeColor = widget.item?.strokeColor;
    _strokeWidth = widget.item?.strokeWidth;
    _fillOpacity = widget.item?.fillOpacity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.maplayer'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.maplayer'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _type?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.type'.tr()),
              onChanged: (v) => _type = v,
            ),
            TextFormField(
              initialValue: _url?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.url'.tr()),
              onChanged: (v) => _url = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isvisible'.tr()),
              value: _isVisible ?? false,
              onChanged: (v) => setState(() => _isVisible = v),
            ),
            TextFormField(
              initialValue: _opacity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.opacity'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _opacity = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _zIndex?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zindex'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _zIndex = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _northEastLat?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.northeastlat'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _northEastLat = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _northEastLng?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.northeastlng'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _northEastLng = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _southWestLat?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.southwestlat'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _southWestLat = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _southWestLng?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.southwestlng'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _southWestLng = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _centerLat?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.centerlat'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _centerLat = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _centerLng?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.centerlng'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _centerLng = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _zoomLevel?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zoomlevel'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _zoomLevel = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _minZoom?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.minzoom'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _minZoom = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxZoom?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxzoom'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxZoom = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _fillColor?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fillcolor'.tr()),
              onChanged: (v) => _fillColor = v,
            ),
            TextFormField(
              initialValue: _strokeColor?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.strokecolor'.tr()),
              onChanged: (v) => _strokeColor = v,
            ),
            TextFormField(
              initialValue: _strokeWidth?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.strokewidth'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _strokeWidth = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _fillOpacity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fillopacity'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _fillOpacity = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_type != null) 'type': _type,
                  if (_url != null) 'url': _url,
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
                  if (_fillColor != null) 'fillColor': _fillColor,
                  if (_strokeColor != null) 'strokeColor': _strokeColor,
                  if (_strokeWidth != null) 'strokeWidth': _strokeWidth,
                  if (_fillOpacity != null) 'fillOpacity': _fillOpacity,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(MapLayer.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
