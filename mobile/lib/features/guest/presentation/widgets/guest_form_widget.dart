import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Guest Form Widget  |  Fields: name, phone, image, nationality, passportNumber, gender, birthDate, address, city, country, zipCode, email, agencyId

class GuestFormWidget extends StatefulWidget {
  final Guest? item;
  final void Function(Guest)? onSubmit;
  const GuestFormWidget({super.key, this.item, this.onSubmit});
  @override State<GuestFormWidget> createState() => _GuestFormWidgetState();
}

class _GuestFormWidgetState extends State<GuestFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _phone;
  String? _image;
  String? _nationality;
  String? _passportNumber;
  String? _gender;
  DateTime? _birthDate;
  String? _address;
  String? _city;
  String? _country;
  String? _zipCode;
  String? _email;
  String? _agencyId;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _phone = widget.item?.phone?.toString();
    _image = widget.item?.image?.toString();
    _nationality = widget.item?.nationality?.toString();
    _passportNumber = widget.item?.passportNumber?.toString();
    _gender = widget.item?.gender?.toString();
    _birthDate = widget.item?.birthDate;
    _address = widget.item?.address?.toString();
    _city = widget.item?.city?.toString();
    _country = widget.item?.country?.toString();
    _zipCode = widget.item?.zipCode?.toString();
    _email = widget.item?.email?.toString();
    _agencyId = widget.item?.agencyId?.toString();
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
        if (_phone?.isNotEmpty == true) 'phone': _phone,
        if (_image?.isNotEmpty == true) 'image': _image,
        if (_nationality?.isNotEmpty == true) 'nationality': _nationality,
        if (_passportNumber?.isNotEmpty == true) 'passportNumber': _passportNumber,
        if (_gender?.isNotEmpty == true) 'gender': _gender,
        if (_birthDate != null) 'birthDate': _birthDate!.toIso8601String(),
        if (_address?.isNotEmpty == true) 'address': _address,
        if (_city?.isNotEmpty == true) 'city': _city,
        if (_country?.isNotEmpty == true) 'country': _country,
        if (_zipCode?.isNotEmpty == true) 'zipCode': _zipCode,
        if (_email?.isNotEmpty == true) 'email': _email,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
    };
    final result = widget.item != null
        ? Guest.fromJson({...widget.item!.toJson(), ...data})
        : Guest.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                onSaved: (v) => _phone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _image = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nationality', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _nationality = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Passport Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _passportNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _gender = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _birthDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _birthDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Birth Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_birthDate != null ? _fmt(_birthDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _address = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'City', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _city = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Country', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _country = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Zip Code', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _zipCode = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                onSaved: (v) => _email = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Guest'),
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