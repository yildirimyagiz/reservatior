import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SignatureSignerFormWidget extends ConsumerStatefulWidget {
  final SignatureSigner? item;
  final Function(SignatureSigner) onSubmit;
  const SignatureSignerFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<SignatureSignerFormWidget> createState() =>
      _SignatureSignerFormWidgetState();
}

class _SignatureSignerFormWidgetState
    extends ConsumerState<SignatureSignerFormWidget> {
  String? _signatureRequestId;
  String? _userId;
  String? _contactId;
  String? _fullName;
  String? _email;
  DateTime? _signedAt;
  @override
  void initState() {
    super.initState();
    _signatureRequestId = widget.item?.signatureRequestId;
    _userId = widget.item?.userId;
    _contactId = widget.item?.contactId;
    _fullName = widget.item?.fullName;
    _email = widget.item?.email;
    _signedAt = widget.item?.signedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.signaturesigner'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.signaturesigner'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _signatureRequestId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.signaturerequestid'.tr(),
              ),
              onChanged: (v) => _signatureRequestId = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
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
            ListTile(
              title: Text("${'mobile.admin.field_signed_at'.tr()}: ${_signedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _signedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _signedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_signatureRequestId != null)
                    'signatureRequestId': _signatureRequestId,
                  if (_userId != null) 'userId': _userId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_fullName != null) 'fullName': _fullName,
                  if (_email != null) 'email': _email,
                  if (_signedAt != null)
                    'signedAt': _signedAt!.toIso8601String(),
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
                  widget.onSubmit(SignatureSigner.fromJson(json));
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
