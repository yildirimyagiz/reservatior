import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class RouteFormWidget extends ConsumerStatefulWidget {
  final Route? item;
  final Function(Route) onSubmit;
  const RouteFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<RouteFormWidget> createState() => _RouteFormWidgetState();
}

class _RouteFormWidgetState extends ConsumerState<RouteFormWidget> {
  String? _name;
  String? _type;
  String? _startLocationId;
  String? _endLocationId;
  double? _distance;
  int? _duration;
  String? _polyline;
  double? _tolls;
  bool? _isVisible;
  String? _color;
  int? _strokeWidth;
  double? _opacity;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _type = widget.item?.type;
    _startLocationId = widget.item?.startLocationId;
    _endLocationId = widget.item?.endLocationId;
    _distance = widget.item?.distance;
    _duration = widget.item?.duration;
    _polyline = widget.item?.polyline;
    _tolls = widget.item?.tolls;
    _isVisible = widget.item?.isVisible;
    _color = widget.item?.color;
    _strokeWidth = widget.item?.strokeWidth;
    _opacity = widget.item?.opacity;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.route'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.route'.tr()}",
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
              initialValue: _startLocationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.startlocationid'.tr()),
              onChanged: (v) => _startLocationId = v,
            ),
            TextFormField(
              initialValue: _endLocationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.endlocationid'.tr()),
              onChanged: (v) => _endLocationId = v,
            ),
            TextFormField(
              initialValue: _distance?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.distance'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _distance = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _duration?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.duration'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _duration = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _polyline?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.polyline'.tr()),
              onChanged: (v) => _polyline = v,
            ),
            TextFormField(
              initialValue: _tolls?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tolls'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _tolls = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isvisible'.tr()),
              value: _isVisible ?? false,
              onChanged: (v) => setState(() => _isVisible = v),
            ),
            TextFormField(
              initialValue: _color?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.color'.tr()),
              onChanged: (v) => _color = v,
            ),
            TextFormField(
              initialValue: _strokeWidth?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.strokewidth'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _strokeWidth = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _opacity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.opacity'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _opacity = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_type != null) 'type': _type,
                  if (_startLocationId != null)
                    'startLocationId': _startLocationId,
                  if (_endLocationId != null) 'endLocationId': _endLocationId,
                  if (_distance != null) 'distance': _distance,
                  if (_duration != null) 'duration': _duration,
                  if (_polyline != null) 'polyline': _polyline,
                  if (_tolls != null) 'tolls': _tolls,
                  'isVisible': _isVisible,
                  if (_color != null) 'color': _color,
                  if (_strokeWidth != null) 'strokeWidth': _strokeWidth,
                  if (_opacity != null) 'opacity': _opacity,
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
                  widget.onSubmit(Route.fromJson(json));
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
