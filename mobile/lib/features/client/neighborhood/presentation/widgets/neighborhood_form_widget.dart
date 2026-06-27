import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class NeighborhoodFormWidget extends ConsumerStatefulWidget {
  final Neighborhood? item;
  final Function(Neighborhood) onSubmit;
  const NeighborhoodFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<NeighborhoodFormWidget> createState() =>
      _NeighborhoodFormWidgetState();
}

class _NeighborhoodFormWidgetState
    extends ConsumerState<NeighborhoodFormWidget> {
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
    _name = widget.item?.name;
    _city = widget.item?.city;
    _state = widget.item?.state;
    _zip = widget.item?.zip;
    _lat = widget.item?.lat;
    _lng = widget.item?.lng;
    _avgPrice = widget.item?.avgPrice;
    _medianPrice = widget.item?.medianPrice;
    _propertyCount = widget.item?.propertyCount;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.neighborhood'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.neighborhood'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _city?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.city'.tr()),
              onChanged: (v) => _city = v,
            ),
            TextFormField(
              initialValue: _state?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.state'.tr()),
              onChanged: (v) => _state = v,
            ),
            TextFormField(
              initialValue: _zip?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zip'.tr()),
              onChanged: (v) => _zip = v,
            ),
            TextFormField(
              initialValue: _lat?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lat'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lat = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lng?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lng'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lng = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _avgPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.avgprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _avgPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _medianPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.medianprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _medianPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _propertyCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertycount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _propertyCount = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_city != null) 'city': _city,
                  if (_state != null) 'state': _state,
                  if (_zip != null) 'zip': _zip,
                  if (_lat != null) 'lat': _lat,
                  if (_lng != null) 'lng': _lng,
                  if (_avgPrice != null) 'avgPrice': _avgPrice,
                  if (_medianPrice != null) 'medianPrice': _medianPrice,
                  if (_propertyCount != null) 'propertyCount': _propertyCount,
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
                  widget.onSubmit(Neighborhood.fromJson(json));
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
