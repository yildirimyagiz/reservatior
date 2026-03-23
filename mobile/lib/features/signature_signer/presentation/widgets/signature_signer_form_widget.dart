import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SignatureSigner Form Widget  |  Fields: signatureRequestId, participantType, userId, contactId, fullName, email, status, signedAt

class SignatureSignerFormWidget extends StatefulWidget {
  final SignatureSigner? item;
  final void Function(SignatureSigner)? onSubmit;
  const SignatureSignerFormWidget({super.key, this.item, this.onSubmit});
  @override State<SignatureSignerFormWidget> createState() => _SignatureSignerFormWidgetState();
}

class _SignatureSignerFormWidgetState extends State<SignatureSignerFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _signatureRequestId;
  String? _participantType;
  String? _userId;
  String? _contactId;
  String? _fullName;
  String? _email;
  String? _status;
  DateTime? _signedAt;

  @override
  void initState() {
    super.initState();
    _signatureRequestId = widget.item?.signatureRequestId?.toString();
    _participantType = widget.item?.participantType?.toString();
    _userId = widget.item?.userId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _fullName = widget.item?.fullName?.toString();
    _email = widget.item?.email?.toString();
    _status = widget.item?.status?.toString();
    _signedAt = widget.item?.signedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_signatureRequestId?.isNotEmpty == true) 'signatureRequestId': _signatureRequestId,
        if (_participantType?.isNotEmpty == true) 'participantType': _participantType,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_fullName?.isNotEmpty == true) 'fullName': _fullName,
        if (_email?.isNotEmpty == true) 'email': _email,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_signedAt != null) 'signedAt': _signedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? SignatureSigner.fromJson({...widget.item!.toJson(), ...data})
        : SignatureSigner.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Signature Request Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _signatureRequestId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Participant Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _participantType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _fullName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                onSaved: (v) => _email = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _signedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _signedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Signed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_signedAt != null ? _fmt(_signedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Signature Signer'),
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