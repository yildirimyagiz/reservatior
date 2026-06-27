import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AgentFormWidget extends ConsumerStatefulWidget {
  final Agent? item;
  final Function(Agent) onSubmit;
  const AgentFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AgentFormWidget> createState() => _AgentFormWidgetState();
}

class _AgentFormWidgetState extends ConsumerState<AgentFormWidget> {
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _bio;
  String? _locationId;
  String? _addres;
  String? _website;
  String? _logoUrl;
  String? _agencyId;
  String? _licenseNumber;
  double? _commissionRate;
  int? _yearsOfExperience;
  String? _education;
  String? _externalId;
  String? _ownerId;
  DateTime? _lastActive;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _email = widget.item?.email;
    _phoneNumber = widget.item?.phoneNumber;
    _bio = widget.item?.bio;
    _locationId = widget.item?.locationId;
    _addres = widget.item?.addres;
    _website = widget.item?.website;
    _logoUrl = widget.item?.logoUrl;
    _agencyId = widget.item?.agencyId;
    _licenseNumber = widget.item?.licenseNumber;
    _commissionRate = widget.item?.commissionRate;
    _yearsOfExperience = widget.item?.yearsOfExperience;
    _education = widget.item?.education;
    _externalId = widget.item?.externalId;
    _ownerId = widget.item?.ownerId;
    _lastActive = widget.item?.lastActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.agent'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.agent'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
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
              initialValue: _bio?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bio'.tr()),
              onChanged: (v) => _bio = v,
            ),
            TextFormField(
              initialValue: _locationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.locationid'.tr()),
              onChanged: (v) => _locationId = v,
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
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
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
              initialValue: _yearsOfExperience?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.yearsofexperience'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _yearsOfExperience = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _education?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.education'.tr()),
              onChanged: (v) => _education = v,
            ),
            TextFormField(
              initialValue: _externalId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalid'.tr()),
              onChanged: (v) => _externalId = v,
            ),
            TextFormField(
              initialValue: _ownerId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ownerid'.tr()),
              onChanged: (v) => _ownerId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_active'.tr()}: ${_lastActive ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastActive ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastActive = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_email != null) 'email': _email,
                  if (_phoneNumber != null) 'phoneNumber': _phoneNumber,
                  if (_bio != null) 'bio': _bio,
                  if (_locationId != null) 'locationId': _locationId,
                  if (_addres != null) 'addres': _addres,
                  if (_website != null) 'website': _website,
                  if (_logoUrl != null) 'logoUrl': _logoUrl,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_licenseNumber != null) 'licenseNumber': _licenseNumber,
                  if (_commissionRate != null)
                    'commissionRate': _commissionRate,
                  if (_yearsOfExperience != null)
                    'yearsOfExperience': _yearsOfExperience,
                  if (_education != null) 'education': _education,
                  if (_externalId != null) 'externalId': _externalId,
                  if (_ownerId != null) 'ownerId': _ownerId,
                  if (_lastActive != null)
                    'lastActive': _lastActive!.toIso8601String(),
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
                  widget.onSubmit(Agent.fromJson(json));
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
