import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SignatureRequestFormWidget extends ConsumerStatefulWidget {
  final SignatureRequest? item;
  final Function(SignatureRequest) onSubmit;
  const SignatureRequestFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<SignatureRequestFormWidget> createState() =>
      _SignatureRequestFormWidgetState();
}

class _SignatureRequestFormWidgetState
    extends ConsumerState<SignatureRequestFormWidget> {
  String? _contractId;
  String? _provider;
  String? _signUrl;
  String? _signedDocumentUrl;
  DateTime? _expiresAt;
  @override
  void initState() {
    super.initState();
    _contractId = widget.item?.contractId;
    _provider = widget.item?.provider;
    _signUrl = widget.item?.signUrl;
    _signedDocumentUrl = widget.item?.signedDocumentUrl;
    _expiresAt = widget.item?.expiresAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.signaturerequest'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.signaturerequest'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _contractId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contractid'.tr()),
              onChanged: (v) => _contractId = v,
            ),
            TextFormField(
              initialValue: _provider?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.provider'.tr()),
              onChanged: (v) => _provider = v,
            ),
            TextFormField(
              initialValue: _signUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.signurl'.tr()),
              onChanged: (v) => _signUrl = v,
            ),
            TextFormField(
              initialValue: _signedDocumentUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.signeddocumenturl'.tr()),
              onChanged: (v) => _signedDocumentUrl = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expires_at'.tr()}: ${_expiresAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiresAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_contractId != null) 'contractId': _contractId,
                  if (_provider != null) 'provider': _provider,
                  if (_signUrl != null) 'signUrl': _signUrl,
                  if (_signedDocumentUrl != null)
                    'signedDocumentUrl': _signedDocumentUrl,
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
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
                  widget.onSubmit(SignatureRequest.fromJson(json));
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
