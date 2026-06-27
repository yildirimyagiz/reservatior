import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class FacilityBlockFormWidget extends ConsumerStatefulWidget {
  final FacilityBlock? item;
  final Function(FacilityBlock) onSubmit;
  const FacilityBlockFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<FacilityBlockFormWidget> createState() =>
      _FacilityBlockFormWidgetState();
}

class _FacilityBlockFormWidgetState
    extends ConsumerState<FacilityBlockFormWidget> {
  String? _facilityId;
  String? _name;
  int? _floors;
  int? _unitsPerFloor;
  int? _totalUnits;
  int? _yearBuilt;
  String? _architect;
  @override
  void initState() {
    super.initState();
    _facilityId = widget.item?.facilityId;
    _name = widget.item?.name;
    _floors = widget.item?.floors;
    _unitsPerFloor = widget.item?.unitsPerFloor;
    _totalUnits = widget.item?.totalUnits;
    _yearBuilt = widget.item?.yearBuilt;
    _architect = widget.item?.architect;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.facilityblock'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.facilityblock'.tr()}",
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
              initialValue: _floors?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.floors'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _floors = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _unitsPerFloor?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.unitsperfloor'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _unitsPerFloor = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalUnits?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalunits'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalUnits = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _yearBuilt?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.yearbuilt'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _yearBuilt = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _architect?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.architect'.tr()),
              onChanged: (v) => _architect = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_facilityId != null) 'facilityId': _facilityId,
                  if (_name != null) 'name': _name,
                  if (_floors != null) 'floors': _floors,
                  if (_unitsPerFloor != null) 'unitsPerFloor': _unitsPerFloor,
                  if (_totalUnits != null) 'totalUnits': _totalUnits,
                  if (_yearBuilt != null) 'yearBuilt': _yearBuilt,
                  if (_architect != null) 'architect': _architect,
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
                  widget.onSubmit(FacilityBlock.fromJson(json));
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
