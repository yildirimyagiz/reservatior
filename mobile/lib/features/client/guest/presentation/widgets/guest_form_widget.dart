import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class GuestFormWidget extends ConsumerStatefulWidget {
  final Guest? item;
  final Function(Guest) onSubmit;
  const GuestFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<GuestFormWidget> createState() => _GuestFormWidgetState();
}

class _GuestFormWidgetState extends ConsumerState<GuestFormWidget> {
  String? _name;
  String? _phone;
  String? _image;
  String? _nationality;
  String? _passportNumber;
  DateTime? _birthDate;
  String? _addres;
  String? _city;
  String? _country;
  String? _zipCode;
  String? _email;
  String? _agencyId;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _phone = widget.item?.phone;
    _image = widget.item?.image;
    _nationality = widget.item?.nationality;
    _passportNumber = widget.item?.passportNumber;
    _birthDate = widget.item?.birthDate;
    _addres = widget.item?.addres;
    _city = widget.item?.city;
    _country = widget.item?.country;
    _zipCode = widget.item?.zipCode;
    _email = widget.item?.email;
    _agencyId = widget.item?.agencyId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.guest'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.guest'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _phone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.phone'.tr()),
              onChanged: (v) => _phone = v,
            ),
            TextFormField(
              initialValue: _image?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.image'.tr()),
              onChanged: (v) => _image = v,
            ),
            TextFormField(
              initialValue: _nationality?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.nationality'.tr()),
              onChanged: (v) => _nationality = v,
            ),
            TextFormField(
              initialValue: _passportNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.passportnumber'.tr()),
              onChanged: (v) => _passportNumber = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_birth_date'.tr()}: ${_birthDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _birthDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _birthDate = d);
              },
            ),
            TextFormField(
              initialValue: _addres?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.addres'.tr()),
              onChanged: (v) => _addres = v,
            ),
            TextFormField(
              initialValue: _city?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.city'.tr()),
              onChanged: (v) => _city = v,
            ),
            TextFormField(
              initialValue: _country?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.country'.tr()),
              onChanged: (v) => _country = v,
            ),
            TextFormField(
              initialValue: _zipCode?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zipcode'.tr()),
              onChanged: (v) => _zipCode = v,
            ),
            TextFormField(
              initialValue: _email?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.email'.tr()),
              onChanged: (v) => _email = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_phone != null) 'phone': _phone,
                  if (_image != null) 'image': _image,
                  if (_nationality != null) 'nationality': _nationality,
                  if (_passportNumber != null)
                    'passportNumber': _passportNumber,
                  if (_birthDate != null)
                    'birthDate': _birthDate!.toIso8601String(),
                  if (_addres != null) 'addres': _addres,
                  if (_city != null) 'city': _city,
                  if (_country != null) 'country': _country,
                  if (_zipCode != null) 'zipCode': _zipCode,
                  if (_email != null) 'email': _email,
                  if (_agencyId != null) 'agencyId': _agencyId,
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
                  widget.onSubmit(Guest.fromJson(json));
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
