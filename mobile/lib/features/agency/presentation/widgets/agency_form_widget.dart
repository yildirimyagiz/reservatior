import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Agency Form Widget  |  Fields: organizationId, name, description, email, phoneNumber, address, website, logoUrl, status, facilityId, includedServiceId, extraChargeId, isActive, ownerId, settings, theme, externalId, integration, totalProperties, totalAgents, establishedYear, licenseNumber, commissionRate, taxIdentificationNumber, taxJurisdiction, metrics, taxConfiguration

class AgencyFormWidget extends StatefulWidget {
  final Agency? item;
  final void Function(Agency)? onSubmit;
  const AgencyFormWidget({super.key, this.item, this.onSubmit});
  @override State<AgencyFormWidget> createState() => _AgencyFormWidgetState();
}

class _AgencyFormWidgetState extends State<AgencyFormWidget> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _cOrganizationId;
  late final TextEditingController _cName;
  late final TextEditingController _cDescription;
  late final TextEditingController _cEmail;
  late final TextEditingController _cPhoneNumber;
  late final TextEditingController _cAddress;
  late final TextEditingController _cWebsite;
  late final TextEditingController _cLogoUrl;
  late final TextEditingController _cStatus;
  late final TextEditingController _cFacilityId;
  late final TextEditingController _cIncludedServiceId;
  late final TextEditingController _cExtraChargeId;
  late final TextEditingController _cOwnerId;
  late final TextEditingController _cSettings;
  late final TextEditingController _cTheme;
  late final TextEditingController _cExternalId;
  late final TextEditingController _cIntegration;
  late final TextEditingController _cTotalProperties;
  late final TextEditingController _cTotalAgents;
  late final TextEditingController _cEstablishedYear;
  late final TextEditingController _cLicenseNumber;
  late final TextEditingController _cCommissionRate;
  late final TextEditingController _cTaxIdentificationNumber;
  late final TextEditingController _cTaxJurisdiction;
  late final TextEditingController _cMetrics;
  late final TextEditingController _cTaxConfiguration;
  String? _organizationId;
  String? _name;
  String? _description;
  String? _email;
  String? _phoneNumber;
  String? _address;
  String? _website;
  String? _logoUrl;
  String? _status;
  String? _facilityId;
  String? _includedServiceId;
  String? _extraChargeId;
  bool _isActive = false;
  String? _ownerId;
  String? _settings;
  String? _theme;
  String? _externalId;
  String? _integration;
  int? _totalProperties;
  int? _totalAgents;
  int? _establishedYear;
  String? _licenseNumber;
  double? _commissionRate;
  String? _taxIdentificationNumber;
  String? _taxJurisdiction;
  String? _metrics;
  String? _taxConfiguration;

  @override
  void initState() {
    super.initState();
    _cOrganizationId.text = widget.item?.organizationId?.toString() ?? "";
    _cName.text = widget.item?.name?.toString() ?? "";
    _cDescription.text = widget.item?.description?.toString() ?? "";
    _cEmail.text = widget.item?.email?.toString() ?? "";
    _cPhoneNumber.text = widget.item?.phoneNumber?.toString() ?? "";
    _cAddress.text = widget.item?.address?.toString() ?? "";
    _cWebsite.text = widget.item?.website?.toString() ?? "";
    _cLogoUrl.text = widget.item?.logoUrl?.toString() ?? "";
    _cStatus.text = widget.item?.status?.toString() ?? "";
    _cFacilityId.text = widget.item?.facilityId?.toString() ?? "";
    _cIncludedServiceId.text = widget.item?.includedServiceId?.toString() ?? "";
    _cExtraChargeId.text = widget.item?.extraChargeId?.toString() ?? "";
    _cOwnerId.text = widget.item?.ownerId?.toString() ?? "";
    _cSettings.text = widget.item?.settings?.toString() ?? "";
    _cTheme.text = widget.item?.theme?.toString() ?? "";
    _cExternalId.text = widget.item?.externalId?.toString() ?? "";
    _cIntegration.text = widget.item?.integration?.toString() ?? "";
    _cTotalProperties.text = widget.item?.totalProperties?.toString() ?? "";
    _cTotalAgents.text = widget.item?.totalAgents?.toString() ?? "";
    _cEstablishedYear.text = widget.item?.establishedYear?.toString() ?? "";
    _cLicenseNumber.text = widget.item?.licenseNumber?.toString() ?? "";
    _cCommissionRate.text = widget.item?.commissionRate?.toString() ?? "";
    _cTaxIdentificationNumber = TextEditingController(text: widget.item?.taxIdentificationNumber?.toString() ?? '');
    _cTaxJurisdiction = TextEditingController(text: widget.item?.taxJurisdiction?.toString() ?? '');
    _cMetrics = TextEditingController(text: widget.item?.metrics?.toString() ?? '');
    _cTaxConfiguration = TextEditingController(text: widget.item?.taxConfiguration?.toString() ?? '');
    _cOrganizationId.text = widget.item?.organizationId?.toString() ?? "";
    _cName.text = widget.item?.name?.toString() ?? "";
    _cDescription.text = widget.item?.description?.toString() ?? "";
    _cEmail.text = widget.item?.email?.toString() ?? "";
    _cPhoneNumber.text = widget.item?.phoneNumber?.toString() ?? "";
    _cAddress.text = widget.item?.address?.toString() ?? "";
    _cWebsite.text = widget.item?.website?.toString() ?? "";
    _cLogoUrl.text = widget.item?.logoUrl?.toString() ?? "";
    _cStatus.text = widget.item?.status?.toString() ?? "";
    _cFacilityId.text = widget.item?.facilityId?.toString() ?? "";
    _cIncludedServiceId.text = widget.item?.includedServiceId?.toString() ?? "";
    _cExtraChargeId.text = widget.item?.extraChargeId?.toString() ?? "";
    _isActive = widget.item?.isActive ?? false;
    _cOwnerId.text = widget.item?.ownerId?.toString() ?? "";
    _cSettings.text = widget.item?.settings?.toString() ?? "";
    _cTheme.text = widget.item?.theme?.toString() ?? "";
    _cExternalId.text = widget.item?.externalId?.toString() ?? "";
    _cIntegration.text = widget.item?.integration?.toString() ?? "";
    _cTotalProperties.text = widget.item?.totalProperties?.toString() ?? "";
    _cTotalAgents.text = widget.item?.totalAgents?.toString() ?? "";
    _cEstablishedYear.text = widget.item?.establishedYear?.toString() ?? "";
    _cLicenseNumber.text = widget.item?.licenseNumber?.toString() ?? "";
    _cCommissionRate.text = widget.item?.commissionRate?.toString() ?? "";
    _cTaxIdentificationNumber = TextEditingController(text: widget.item?.taxIdentificationNumber?.toString() ?? '');
    _cTaxJurisdiction = TextEditingController(text: widget.item?.taxJurisdiction?.toString() ?? '');
    _cMetrics = TextEditingController(text: widget.item?.metrics?.toString() ?? '');
    _cTaxConfiguration = TextEditingController(text: widget.item?.taxConfiguration?.toString() ?? '');
  }

  @override
  void dispose() {
    _cOrganizationId.dispose();
    _cName.dispose();
    _cDescription.dispose();
    _cEmail.dispose();
    _cPhoneNumber.dispose();
    _cAddress.dispose();
    _cWebsite.dispose();
    _cLogoUrl.dispose();
    _cStatus.dispose();
    _cFacilityId.dispose();
    _cIncludedServiceId.dispose();
    _cExtraChargeId.dispose();
    _cOwnerId.dispose();
    _cSettings.dispose();
    _cTheme.dispose();
    _cExternalId.dispose();
    _cIntegration.dispose();
    _cTotalProperties.dispose();
    _cTotalAgents.dispose();
    _cEstablishedYear.dispose();
    _cLicenseNumber.dispose();
    _cCommissionRate.dispose();
    _cTaxIdentificationNumber.dispose();
    _cTaxJurisdiction.dispose();
    _cMetrics.dispose();
    _cTaxConfiguration.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_email?.isNotEmpty == true) 'email': _email,
        if (_phoneNumber?.isNotEmpty == true) 'phoneNumber': _phoneNumber,
        if (_address?.isNotEmpty == true) 'address': _address,
        if (_website?.isNotEmpty == true) 'website': _website,
        if (_logoUrl?.isNotEmpty == true) 'logoUrl': _logoUrl,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_facilityId?.isNotEmpty == true) 'facilityId': _facilityId,
        if (_includedServiceId?.isNotEmpty == true) 'includedServiceId': _includedServiceId,
        if (_extraChargeId?.isNotEmpty == true) 'extraChargeId': _extraChargeId,
        'isActive': _isActive,
        if (_ownerId?.isNotEmpty == true) 'ownerId': _ownerId,
        if (_settings?.isNotEmpty == true) 'settings': _settings,
        if (_theme?.isNotEmpty == true) 'theme': _theme,
        if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
        if (_integration?.isNotEmpty == true) 'integration': _integration,
        if (_totalProperties != null) 'totalProperties': _totalProperties,
        if (_totalAgents != null) 'totalAgents': _totalAgents,
        if (_establishedYear != null) 'establishedYear': _establishedYear,
        if (_licenseNumber?.isNotEmpty == true) 'licenseNumber': _licenseNumber,
        if (_commissionRate != null) 'commissionRate': _commissionRate,
        if (_taxIdentificationNumber?.isNotEmpty == true) 'taxIdentificationNumber': _taxIdentificationNumber,
        if (_taxJurisdiction?.isNotEmpty == true) 'taxJurisdiction': _taxJurisdiction,
        if (_metrics?.isNotEmpty == true) 'metrics': _metrics,
        if (_taxConfiguration?.isNotEmpty == true) 'taxConfiguration': _taxConfiguration,
    };
    final result = widget.item != null
        ? Agency.fromJson({...widget.item!.toJson(), ...data})
        : Agency.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Organization Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                controller: _cName, maxLines: 1,
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                controller: _cDescription, maxLines: 3,
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
                controller: _cEmail, maxLines: 1,
                onSaved: (v) => _email = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder()),
                controller: _cPhoneNumber, maxLines: 1,
                onSaved: (v) => _phoneNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                controller: _cAddress, maxLines: 1,
                onSaved: (v) => _address = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Website', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cWebsite, maxLines: 1,
                onSaved: (v) => _website = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Logo Url', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cLogoUrl, maxLines: 1,
                onSaved: (v) => _logoUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                controller: _cStatus, maxLines: 1,
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Facility Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cFacilityId, maxLines: 1,
                onSaved: (v) => _facilityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Included Service Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cIncludedServiceId, maxLines: 1,
                onSaved: (v) => _includedServiceId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Extra Charge Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cExtraChargeId, maxLines: 1,
                onSaved: (v) => _extraChargeId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: const Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Owner Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cOwnerId, maxLines: 1,
                onSaved: (v) => _ownerId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Settings', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cSettings, maxLines: 1,
                onSaved: (v) => _settings = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Theme', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cTheme, maxLines: 1,
                onSaved: (v) => _theme = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'External Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cExternalId, maxLines: 1,
                onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Integration', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cIntegration, maxLines: 1,
                onSaved: (v) => _integration = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Properties', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalProperties = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Agents', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalAgents = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Established Year', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _establishedYear = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'License Number', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cLicenseNumber, maxLines: 1,
                onSaved: (v) => _licenseNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true), controller: _cCommissionRate,
                onSaved: (v) => _commissionRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tax Identification Number', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cTaxIdentificationNumber, maxLines: 1,
                onSaved: (v) => _taxIdentificationNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tax Jurisdiction', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cTaxJurisdiction, maxLines: 1,
                onSaved: (v) => _taxJurisdiction = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cMetrics, maxLines: 1,
                onSaved: (v) => _metrics = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tax Configuration', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cTaxConfiguration, maxLines: 1,
                onSaved: (v) => _taxConfiguration = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Agency'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}