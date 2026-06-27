import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class FloorPlanFormWidget extends ConsumerStatefulWidget {
  final FloorPlan? item;
  final Function(FloorPlan) onSubmit;
  const FloorPlanFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<FloorPlanFormWidget> createState() =>
      _FloorPlanFormWidgetState();
}

class _FloorPlanFormWidgetState extends ConsumerState<FloorPlanFormWidget> {
  String? _propertyId;
  String? _name;
  String? _description;
  int? _floorLevel;
  String? _imageUrl;
  int? _imageWidth;
  int? _imageHeight;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _floorLevel = widget.item?.floorLevel;
    _imageUrl = widget.item?.imageUrl;
    _imageWidth = widget.item?.imageWidth;
    _imageHeight = widget.item?.imageHeight;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.floorplan'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.floorplan'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _floorLevel?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.floorlevel'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _floorLevel = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _imageUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.imageurl'.tr()),
              onChanged: (v) => _imageUrl = v,
            ),
            TextFormField(
              initialValue: _imageWidth?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.imagewidth'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _imageWidth = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _imageHeight?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.imageheight'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _imageHeight = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_floorLevel != null) 'floorLevel': _floorLevel,
                  if (_imageUrl != null) 'imageUrl': _imageUrl,
                  if (_imageWidth != null) 'imageWidth': _imageWidth,
                  if (_imageHeight != null) 'imageHeight': _imageHeight,
                  'isActive': _isActive,
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
                  widget.onSubmit(FloorPlan.fromJson(json));
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
