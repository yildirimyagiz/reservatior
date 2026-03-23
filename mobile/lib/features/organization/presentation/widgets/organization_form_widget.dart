import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Organization Form Widget  |  Fields: name, type, region, defaultCurrency, defaultLocale, legalName, taxId, address, contactEmail, managementFeeType, managementFeeRate, managementFeeAmount, managementFeeScope, taxReportingEnabled, complianceTracking

class OrganizationFormWidget extends StatefulWidget {
  final Organization? item;
  final void Function(Organization)? onSubmit;
  const OrganizationFormWidget({super.key, this.item, this.onSubmit});
  @override State<OrganizationFormWidget> createState() => _OrganizationFormWidgetState();
}

class _OrganizationFormWidgetState extends State<OrganizationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _type;
  String? _region;
  String? _defaultCurrency;
  String? _defaultLocale;
  String? _legalName;
  String? _taxId;
  String? _address;
  String? _contactEmail;
  String? _managementFeeType;
  double? _managementFeeRate;
  double? _managementFeeAmount;
  String? _managementFeeScope;
  bool _taxReportingEnabled = false;
  bool _complianceTracking = false;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _region = widget.item?.region?.toString();
    _defaultCurrency = widget.item?.defaultCurrency?.toString();
    _defaultLocale = widget.item?.defaultLocale?.toString();
    _legalName = widget.item?.legalName?.toString();
    _taxId = widget.item?.taxId?.toString();
    _address = widget.item?.address?.toString();
    _contactEmail = widget.item?.contactEmail?.toString();
    _managementFeeType = widget.item?.managementFeeType?.toString();
    _managementFeeRate = widget.item?.managementFeeRate;
    _managementFeeAmount = widget.item?.managementFeeAmount;
    _managementFeeScope = widget.item?.managementFeeScope?.toString();
    _taxReportingEnabled = widget.item?.taxReportingEnabled ?? false;
    _complianceTracking = widget.item?.complianceTracking ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_region?.isNotEmpty == true) 'region': _region,
        if (_defaultCurrency?.isNotEmpty == true) 'defaultCurrency': _defaultCurrency,
        if (_defaultLocale?.isNotEmpty == true) 'defaultLocale': _defaultLocale,
        if (_legalName?.isNotEmpty == true) 'legalName': _legalName,
        if (_taxId?.isNotEmpty == true) 'taxId': _taxId,
        if (_address?.isNotEmpty == true) 'address': _address,
        if (_contactEmail?.isNotEmpty == true) 'contactEmail': _contactEmail,
        if (_managementFeeType?.isNotEmpty == true) 'managementFeeType': _managementFeeType,
        if (_managementFeeRate != null) 'managementFeeRate': _managementFeeRate,
        if (_managementFeeAmount != null) 'managementFeeAmount': _managementFeeAmount,
        if (_managementFeeScope?.isNotEmpty == true) 'managementFeeScope': _managementFeeScope,
        'taxReportingEnabled': _taxReportingEnabled,
        'complianceTracking': _complianceTracking,
    };
    final result = widget.item != null
        ? Organization.fromJson({...widget.item!.toJson(), ...data})
        : Organization.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Region', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _region = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Default Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _defaultCurrency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Default Locale', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _defaultLocale = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Legal Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _legalName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tax Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _taxId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _address = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                onSaved: (v) => _contactEmail = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Management Fee Type', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                onSaved: (v) => _managementFeeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Management Fee Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _managementFeeRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Management Fee Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _managementFeeAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Management Fee Scope', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                onSaved: (v) => _managementFeeScope = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Tax Reporting Enabled'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _taxReportingEnabled,
                  onChanged: (v) { ss(() {}); setState(() => _taxReportingEnabled = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Compliance Tracking'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _complianceTracking,
                  onChanged: (v) { ss(() {}); setState(() => _complianceTracking = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Organization'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}