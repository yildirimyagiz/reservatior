import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Agent Form Widget ──
// Fields: name, email, phoneNumber, bio, locationId, address, website, logoUrl, status, agencyId, licenseNumber, commissionRate, yearsOfExperience, education, performanceMetrics, taxConfiguration, availability, socialMedia, settings, externalId, integration, ownerId, lastActive

class AgentFormWidget extends StatefulWidget {
  final Agent? item;
  final void Function(Agent)? onSubmit;
  const AgentFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<AgentFormWidget> createState() => _AgentFormWidgetState();
}

class _AgentFormWidgetState extends State<AgentFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _bio;
  String? _locationId;
  String? _address;
  String? _website;
  String? _logoUrl;
  String? _status;
  String? _agencyId;
  String? _licenseNumber;
  double? _commissionRate;
  int? _yearsOfExperience;
  String? _education;
  String? _performanceMetrics;
  String? _taxConfiguration;
  String? _availability;
  String? _socialMedia;
  String? _settings;
  String? _externalId;
  String? _integration;
  String? _ownerId;
  DateTime? _lastActive;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _email = widget.item?.email?.toString();
    _phoneNumber = widget.item?.phoneNumber?.toString();
    _bio = widget.item?.bio?.toString();
    _locationId = widget.item?.locationId?.toString();
    _address = widget.item?.address?.toString();
    _website = widget.item?.website?.toString();
    _logoUrl = widget.item?.logoUrl?.toString();
    _status = widget.item?.status?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _licenseNumber = widget.item?.licenseNumber?.toString();
    _commissionRate = widget.item?.commissionRate;
    _yearsOfExperience = widget.item?.yearsOfExperience;
    _education = widget.item?.education?.toString();
    _performanceMetrics = widget.item?.performanceMetrics?.toString();
    _taxConfiguration = widget.item?.taxConfiguration?.toString();
    _availability = widget.item?.availability?.toString();
    _socialMedia = widget.item?.socialMedia?.toString();
    _settings = widget.item?.settings?.toString();
    _externalId = widget.item?.externalId?.toString();
    _integration = widget.item?.integration?.toString();
    _ownerId = widget.item?.ownerId?.toString();
    _lastActive = widget.item?.lastActive;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_name != null) 'name': _name,
        if (_email != null) 'email': _email,
        if (_phoneNumber != null) 'phoneNumber': _phoneNumber,
        if (_bio != null) 'bio': _bio,
        if (_locationId != null) 'locationId': _locationId,
        if (_address != null) 'address': _address,
        if (_website != null) 'website': _website,
        if (_logoUrl != null) 'logoUrl': _logoUrl,
        if (_status != null) 'status': _status,
        if (_agencyId != null) 'agencyId': _agencyId,
        if (_licenseNumber != null) 'licenseNumber': _licenseNumber,
        if (_commissionRate != null) 'commissionRate': _commissionRate,
        if (_yearsOfExperience != null) 'yearsOfExperience': _yearsOfExperience,
        if (_education != null) 'education': _education,
        if (_performanceMetrics != null) 'performanceMetrics': _performanceMetrics,
        if (_taxConfiguration != null) 'taxConfiguration': _taxConfiguration,
        if (_availability != null) 'availability': _availability,
        if (_socialMedia != null) 'socialMedia': _socialMedia,
        if (_settings != null) 'settings': _settings,
        if (_externalId != null) 'externalId': _externalId,
        if (_integration != null) 'integration': _integration,
        if (_ownerId != null) 'ownerId': _ownerId,
        if (_lastActive != null) 'lastActive': _lastActive!.toIso8601String(),
    };
    final result = widget.item != null
        ? Agent.fromJson({...widget.item!.toJson(), ...data})
        : Agent.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _email = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _phoneNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bio', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _bio = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _locationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _address = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Website', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _website = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Logo Url', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _logoUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Agency Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'License Number', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _licenseNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _commissionRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Years Of Experience', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _yearsOfExperience = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Education', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _education = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Performance Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _performanceMetrics = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tax Configuration', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _taxConfiguration = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Availability', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _availability = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Social Media', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _socialMedia = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Settings', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _settings = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'External Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Integration', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _integration = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Org Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _ownerId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _lastActive ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastActive = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Last Active',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_lastActive != null ? _fmt(_lastActive) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Agent'),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
