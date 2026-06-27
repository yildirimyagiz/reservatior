import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactFormWidget extends ConsumerStatefulWidget {
  final Contact? item;
  final Function(Contact) onSubmit;
  const ContactFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends ConsumerState<ContactFormWidget> {
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
    _fullName = widget.item?.fullName;
    _email = widget.item?.email;
    _phone = widget.item?.phone;
    _notes = widget.item?.notes;
    _locale = widget.item?.locale;
    _currency = widget.item?.currency;
    _consentGivenAt = widget.item?.consentGivenAt;
    _consentWithdrawnAt = widget.item?.consentWithdrawnAt;
    _dataSubjectId = widget.item?.dataSubjectId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.contact'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.contact'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _fullName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fullname'.tr()),
              onChanged: (v) => _fullName = v,
            ),
            TextFormField(
              initialValue: _email?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.email'.tr()),
              onChanged: (v) => _email = v,
            ),
            TextFormField(
              initialValue: _phone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.phone'.tr()),
              onChanged: (v) => _phone = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            TextFormField(
              initialValue: _locale?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.locale'.tr()),
              onChanged: (v) => _locale = v,
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_consent_given_at'.tr()}: ${_consentGivenAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _consentGivenAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _consentGivenAt = d);
              },
            ),
            ListTile(
              title: Text(
                'consentWithdrawnAt: ${_consentWithdrawnAt ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _consentWithdrawnAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _consentWithdrawnAt = d);
              },
            ),
            TextFormField(
              initialValue: _dataSubjectId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.datasubjectid'.tr()),
              onChanged: (v) => _dataSubjectId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_fullName != null) 'fullName': _fullName,
                  if (_email != null) 'email': _email,
                  if (_phone != null) 'phone': _phone,
                  if (_notes != null) 'notes': _notes,
                  if (_locale != null) 'locale': _locale,
                  if (_currency != null) 'currency': _currency,
                  if (_consentGivenAt != null)
                    'consentGivenAt': _consentGivenAt!.toIso8601String(),
                  if (_consentWithdrawnAt != null)
                    'consentWithdrawnAt': _consentWithdrawnAt!
                        .toIso8601String(),
                  if (_dataSubjectId != null) 'dataSubjectId': _dataSubjectId,
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
                  widget.onSubmit(Contact.fromJson(json));
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
