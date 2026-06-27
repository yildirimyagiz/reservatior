import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SharedAmenityFormWidget extends ConsumerStatefulWidget {
  final SharedAmenity? item;
  final Function(SharedAmenity) onSubmit;
  const SharedAmenityFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<SharedAmenityFormWidget> createState() =>
      _SharedAmenityFormWidgetState();
}

class _SharedAmenityFormWidgetState
    extends ConsumerState<SharedAmenityFormWidget> {
  String? _facilityId;
  String? _name;
  String? _description;
  String? _location;
  int? _capacity;
  bool? _isAvailable;
  String? _operatingHours;
  double? _price;
  @override
  void initState() {
    super.initState();
    _facilityId = widget.item?.facilityId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _location = widget.item?.location;
    _capacity = widget.item?.capacity;
    _isAvailable = widget.item?.isAvailable;
    _operatingHours = widget.item?.operatingHours;
    _price = widget.item?.price;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.sharedamenity'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.sharedamenity'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _facilityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.facilityid'.tr()),
              onChanged: (v) => _facilityId = v,
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
              initialValue: _location?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.location'.tr()),
              onChanged: (v) => _location = v,
            ),
            TextFormField(
              initialValue: _capacity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.capacity'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _capacity = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isavailable'.tr()),
              value: _isAvailable ?? false,
              onChanged: (v) => setState(() => _isAvailable = v),
            ),
            TextFormField(
              initialValue: _operatingHours?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.operatinghours'.tr()),
              onChanged: (v) => _operatingHours = v,
            ),
            TextFormField(
              initialValue: _price?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.price'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _price = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_facilityId != null) 'facilityId': _facilityId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_location != null) 'location': _location,
                  if (_capacity != null) 'capacity': _capacity,
                  'isAvailable': _isAvailable,
                  if (_operatingHours != null)
                    'operatingHours': _operatingHours,
                  if (_price != null) 'price': _price,
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
                  widget.onSubmit(SharedAmenity.fromJson(json));
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
