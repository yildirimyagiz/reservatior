import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class VirtualTourFormWidget extends ConsumerStatefulWidget {
  final VirtualTour? item;
  final Function(VirtualTour) onSubmit;
  const VirtualTourFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<VirtualTourFormWidget> createState() =>
      _VirtualTourFormWidgetState();
}

class _VirtualTourFormWidgetState extends ConsumerState<VirtualTourFormWidget> {
  String? _propertyId;
  String? _name;
  String? _description;
  String? _tourType;
  String? _videoUrl;
  String? _embedCode;
  String? _thumbnailUrl;
  int? _duration;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _tourType = widget.item?.tourType;
    _videoUrl = widget.item?.videoUrl;
    _embedCode = widget.item?.embedCode;
    _thumbnailUrl = widget.item?.thumbnailUrl;
    _duration = widget.item?.duration;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.virtualtour'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.virtualtour'.tr()}",
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
              initialValue: _tourType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tourtype'.tr()),
              onChanged: (v) => _tourType = v,
            ),
            TextFormField(
              initialValue: _videoUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.videourl'.tr()),
              onChanged: (v) => _videoUrl = v,
            ),
            TextFormField(
              initialValue: _embedCode?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.embedcode'.tr()),
              onChanged: (v) => _embedCode = v,
            ),
            TextFormField(
              initialValue: _thumbnailUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.thumbnailurl'.tr()),
              onChanged: (v) => _thumbnailUrl = v,
            ),
            TextFormField(
              initialValue: _duration?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.duration'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _duration = int.tryParse(v ?? ""),
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
                  if (_tourType != null) 'tourType': _tourType,
                  if (_videoUrl != null) 'videoUrl': _videoUrl,
                  if (_embedCode != null) 'embedCode': _embedCode,
                  if (_thumbnailUrl != null) 'thumbnailUrl': _thumbnailUrl,
                  if (_duration != null) 'duration': _duration,
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
                  widget.onSubmit(VirtualTour.fromJson(json));
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
