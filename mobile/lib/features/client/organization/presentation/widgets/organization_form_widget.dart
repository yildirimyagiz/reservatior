import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class OrganizationFormWidget extends ConsumerStatefulWidget {
  final Organization? item;
  final Function(Organization) onSubmit;
  const OrganizationFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<OrganizationFormWidget> createState() =>
      _OrganizationFormWidgetState();
}

class _OrganizationFormWidgetState
    extends ConsumerState<OrganizationFormWidget> {
  String? _name;
  String? _defaultCurrency;
  String? _defaultLocale;
  String? _legalName;
  String? _taxId;
  String? _addres;
  String? _contactEmail;
  double? _managementFeeRate;
  double? _managementFeeAmount;
  bool? _taxReportingEnabled;
  bool? _complianceTracking;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _defaultCurrency = widget.item?.defaultCurrency;
    _defaultLocale = widget.item?.defaultLocale;
    _legalName = widget.item?.legalName;
    _taxId = widget.item?.taxId;
    _addres = widget.item?.addres;
    _contactEmail = widget.item?.contactEmail;
    _managementFeeRate = widget.item?.managementFeeRate;
    _managementFeeAmount = widget.item?.managementFeeAmount;
    _taxReportingEnabled = widget.item?.taxReportingEnabled;
    _complianceTracking = widget.item?.complianceTracking;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.organization'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.organization'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _defaultCurrency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.defaultcurrency'.tr()),
              onChanged: (v) => _defaultCurrency = v,
            ),
            TextFormField(
              initialValue: _defaultLocale?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.defaultlocale'.tr()),
              onChanged: (v) => _defaultLocale = v,
            ),
            TextFormField(
              initialValue: _legalName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.legalname'.tr()),
              onChanged: (v) => _legalName = v,
            ),
            TextFormField(
              initialValue: _taxId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taxid'.tr()),
              onChanged: (v) => _taxId = v,
            ),
            TextFormField(
              initialValue: _addres?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.addres'.tr()),
              onChanged: (v) => _addres = v,
            ),
            TextFormField(
              initialValue: _contactEmail?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactemail'.tr()),
              onChanged: (v) => _contactEmail = v,
            ),
            TextFormField(
              initialValue: _managementFeeRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.managementfeerate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _managementFeeRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _managementFeeAmount?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.managementfeeamount'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _managementFeeAmount = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.taxreportingenabled'.tr()),
              value: _taxReportingEnabled ?? false,
              onChanged: (v) => setState(() => _taxReportingEnabled = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.compliancetracking'.tr()),
              value: _complianceTracking ?? false,
              onChanged: (v) => setState(() => _complianceTracking = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_defaultCurrency != null)
                    'defaultCurrency': _defaultCurrency,
                  if (_defaultLocale != null) 'defaultLocale': _defaultLocale,
                  if (_legalName != null) 'legalName': _legalName,
                  if (_taxId != null) 'taxId': _taxId,
                  if (_addres != null) 'addres': _addres,
                  if (_contactEmail != null) 'contactEmail': _contactEmail,
                  if (_managementFeeRate != null)
                    'managementFeeRate': _managementFeeRate,
                  if (_managementFeeAmount != null)
                    'managementFeeAmount': _managementFeeAmount,
                  'taxReportingEnabled': _taxReportingEnabled,
                  'complianceTracking': _complianceTracking,
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
                  widget.onSubmit(Organization.fromJson(json));
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
