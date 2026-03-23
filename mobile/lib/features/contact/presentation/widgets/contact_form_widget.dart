import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Contact Form Widget  |  Fields: type, fullName, email, phone, notes, locale, currency, consentGivenAt, consentWithdrawnAt, dataSubjectId

class ContactFormWidget extends StatefulWidget {
  final Contact? item;
  final void Function(Contact)? onSubmit;
  const ContactFormWidget({super.key, this.item, this.onSubmit});
  @override State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _type;
  String? _fullName;
  String? _email;
  String? _phone;
  String? _notes;
  String? _locale;
  String? _currency;
  DateTime? _consentGivenAt;
  DateTime? _consentWithdrawnAt;
  String? _dataSubjectId;

  @override
  void initState() {
    super.initState();
    _type = widget.item?.type?.toString();
    _fullName = widget.item?.fullName?.toString();
    _email = widget.item?.email?.toString();
    _phone = widget.item?.phone?.toString();
    _notes = widget.item?.notes?.toString();
    _locale = widget.item?.locale?.toString();
    _currency = widget.item?.currency?.toString();
    _consentGivenAt = widget.item?.consentGivenAt;
    _consentWithdrawnAt = widget.item?.consentWithdrawnAt;
    _dataSubjectId = widget.item?.dataSubjectId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_fullName?.isNotEmpty == true) 'fullName': _fullName,
        if (_email?.isNotEmpty == true) 'email': _email,
        if (_phone?.isNotEmpty == true) 'phone': _phone,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        if (_locale?.isNotEmpty == true) 'locale': _locale,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_consentGivenAt != null) 'consentGivenAt': _consentGivenAt!.toIso8601String(),
        if (_consentWithdrawnAt != null) 'consentWithdrawnAt': _consentWithdrawnAt!.toIso8601String(),
        if (_dataSubjectId?.isNotEmpty == true) 'dataSubjectId': _dataSubjectId,
    };
    final result = widget.item != null
        ? Contact.fromJson({...widget.item!.toJson(), ...data})
        : Contact.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _type?.toString() ?? '',
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _fullName?.toString() ?? '',
                onSaved: (v) => _fullName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                initialValue: _email?.toString() ?? '',
                onSaved: (v) => _email = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                initialValue: _phone?.toString() ?? '',
                onSaved: (v) => _phone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _notes?.toString() ?? '',
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Locale', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _locale?.toString() ?? '',
                onSaved: (v) => _locale = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _currency?.toString() ?? '',
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _consentGivenAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _consentGivenAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Consent Given At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_consentGivenAt != null ? _fmt(_consentGivenAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _consentWithdrawnAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _consentWithdrawnAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Consent Withdrawn At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_consentWithdrawnAt != null ? _fmt(_consentWithdrawnAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data Subject Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _dataSubjectId?.toString() ?? '',
                onSaved: (v) => _dataSubjectId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Contact'),
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