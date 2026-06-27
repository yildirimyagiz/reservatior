import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class VendorProfileFormWidget extends ConsumerStatefulWidget {
  final VendorProfile? item;
  final Function(VendorProfile) onSubmit;
  const VendorProfileFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<VendorProfileFormWidget> createState() =>
      _VendorProfileFormWidgetState();
}

class _VendorProfileFormWidgetState
    extends ConsumerState<VendorProfileFormWidget> {
  String? _legalName;
  String? _serviceAreas;
  int? _defaultCommissionBps;
  @override
  void initState() {
    super.initState();
    _legalName = widget.item?.legalName;
    _serviceAreas = widget.item?.serviceAreas;
    _defaultCommissionBps = widget.item?.defaultCommissionBps;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.vendorprofile'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.vendorprofile'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _legalName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.legalname'.tr()),
              onChanged: (v) => _legalName = v,
            ),
            TextFormField(
              initialValue: _serviceAreas?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.serviceareas'.tr()),
              onChanged: (v) => _serviceAreas = v,
            ),
            TextFormField(
              initialValue: _defaultCommissionBps?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.defaultcommissionbps'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _defaultCommissionBps = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_legalName != null) 'legalName': _legalName,
                  if (_serviceAreas != null) 'serviceAreas': _serviceAreas,
                  if (_defaultCommissionBps != null)
                    'defaultCommissionBps': _defaultCommissionBps,
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
                  widget.onSubmit(VendorProfile.fromJson(json));
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
