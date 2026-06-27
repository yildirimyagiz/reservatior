import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class FacilityFormWidget extends ConsumerStatefulWidget {
  final Facility? item;
  final Function(Facility) onSubmit;
  const FacilityFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<FacilityFormWidget> createState() => _FacilityFormWidgetState();
}

class _FacilityFormWidgetState extends ConsumerState<FacilityFormWidget> {
  String? _propertyId;
  String? _name;
  double? _feeAmount;
  String? _feeCurrency;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _name = widget.item?.name;
    _feeAmount = widget.item?.feeAmount;
    _feeCurrency = widget.item?.feeCurrency;
    _notes = widget.item?.notes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.facility'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.facility'.tr()}",
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
              initialValue: _feeAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.feeamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _feeAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _feeCurrency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.feecurrency'.tr()),
              onChanged: (v) => _feeCurrency = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_name != null) 'name': _name,
                  if (_feeAmount != null) 'feeAmount': _feeAmount,
                  if (_feeCurrency != null) 'feeCurrency': _feeCurrency,
                  if (_notes != null) 'notes': _notes,
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
                  widget.onSubmit(Facility.fromJson(json));
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
