import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AgencyFormWidget extends ConsumerStatefulWidget {
  final Agency? item;
  final Function(Agency) onSubmit;
  const AgencyFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AgencyFormWidget> createState() => _AgencyFormWidgetState();
}

class _AgencyFormWidgetState extends ConsumerState<AgencyFormWidget> {
  String? _organizationId;
  String? _name;
  String? _description;
  String? _email;
  String? _phoneNumber;
  String? _addres;
  String? _website;
  String? _logoUrl;
  String? _facilityId;
  String? _includedServiceId;
  String? _extraChargeId;
  bool? _isActive;
  String? _ownerId;
  String? _theme;
  String? _externalId;
  int? _totalProperties;
  int? _totalAgents;
  int? _establishedYear;
  String? _licenseNumber;
  double? _commissionRate;
  String? _taxIdentificationNumber;
  String? _taxJurisdiction;
  @override
  void initState() {
    super.initState();
    _organizationId = widget.item?.organizationId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _email = widget.item?.email;
    _phoneNumber = widget.item?.phoneNumber;
    _addres = widget.item?.addres;
    _website = widget.item?.website;
    _logoUrl = widget.item?.logoUrl;
    _facilityId = widget.item?.facilityId;
    _includedServiceId = widget.item?.includedServiceId;
    _extraChargeId = widget.item?.extraChargeId;
    _isActive = widget.item?.isActive;
    _ownerId = widget.item?.ownerId;
    _theme = widget.item?.theme;
    _externalId = widget.item?.externalId;
    _totalProperties = widget.item?.totalProperties;
    _totalAgents = widget.item?.totalAgents;
    _establishedYear = widget.item?.establishedYear;
    _licenseNumber = widget.item?.licenseNumber;
    _commissionRate = widget.item?.commissionRate;
    _taxIdentificationNumber = widget.item?.taxIdentificationNumber;
    _taxJurisdiction = widget.item?.taxJurisdiction;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.agency'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.agency'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _organizationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.organizationid'.tr()),
              onChanged: (v) => _organizationId = v,
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
              initialValue: _email?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.email'.tr()),
              onChanged: (v) => _email = v,
            ),
            TextFormField(
              initialValue: _phoneNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.phonenumber'.tr()),
              onChanged: (v) => _phoneNumber = v,
            ),
            TextFormField(
              initialValue: _addres?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.addres'.tr()),
              onChanged: (v) => _addres = v,
            ),
            TextFormField(
              initialValue: _website?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.website'.tr()),
              onChanged: (v) => _website = v,
            ),
            TextFormField(
              initialValue: _logoUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.logourl'.tr()),
              onChanged: (v) => _logoUrl = v,
            ),
            TextFormField(
              initialValue: _facilityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.facilityid'.tr()),
              onChanged: (v) => _facilityId = v,
            ),
            TextFormField(
              initialValue: _includedServiceId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.includedserviceid'.tr()),
              onChanged: (v) => _includedServiceId = v,
            ),
            TextFormField(
              initialValue: _extraChargeId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.extrachargeid'.tr()),
              onChanged: (v) => _extraChargeId = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            TextFormField(
              initialValue: _ownerId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ownerid'.tr()),
              onChanged: (v) => _ownerId = v,
            ),
            TextFormField(
              initialValue: _theme?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.theme'.tr()),
              onChanged: (v) => _theme = v,
            ),
            TextFormField(
              initialValue: _externalId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalid'.tr()),
              onChanged: (v) => _externalId = v,
            ),
            TextFormField(
              initialValue: _totalProperties?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalproperties'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalProperties = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalAgents?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalagents'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalAgents = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _establishedYear?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.establishedyear'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _establishedYear = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _licenseNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.licensenumber'.tr()),
              onChanged: (v) => _licenseNumber = v,
            ),
            TextFormField(
              initialValue: _commissionRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _taxIdentificationNumber?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.taxidentificationnumber'.tr(),
              ),
              onChanged: (v) => _taxIdentificationNumber = v,
            ),
            TextFormField(
              initialValue: _taxJurisdiction?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taxjurisdiction'.tr()),
              onChanged: (v) => _taxJurisdiction = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_organizationId != null)
                    'organizationId': _organizationId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_email != null) 'email': _email,
                  if (_phoneNumber != null) 'phoneNumber': _phoneNumber,
                  if (_addres != null) 'addres': _addres,
                  if (_website != null) 'website': _website,
                  if (_logoUrl != null) 'logoUrl': _logoUrl,
                  if (_facilityId != null) 'facilityId': _facilityId,
                  if (_includedServiceId != null)
                    'includedServiceId': _includedServiceId,
                  if (_extraChargeId != null) 'extraChargeId': _extraChargeId,
                  'isActive': _isActive,
                  if (_ownerId != null) 'ownerId': _ownerId,
                  if (_theme != null) 'theme': _theme,
                  if (_externalId != null) 'externalId': _externalId,
                  if (_totalProperties != null)
                    'totalProperties': _totalProperties,
                  if (_totalAgents != null) 'totalAgents': _totalAgents,
                  if (_establishedYear != null)
                    'establishedYear': _establishedYear,
                  if (_licenseNumber != null) 'licenseNumber': _licenseNumber,
                  if (_commissionRate != null)
                    'commissionRate': _commissionRate,
                  if (_taxIdentificationNumber != null)
                    'taxIdentificationNumber': _taxIdentificationNumber,
                  if (_taxJurisdiction != null)
                    'taxJurisdiction': _taxJurisdiction,
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
                  widget.onSubmit(Agency.fromJson(json));
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
