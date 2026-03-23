import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SignatureRequest Form Widget  |  Fields: contractId, provider, status, signUrl, signedDocumentUrl, expiresAt

class SignatureRequestFormWidget extends StatefulWidget {
  final SignatureRequest? item;
  final void Function(SignatureRequest)? onSubmit;
  const SignatureRequestFormWidget({super.key, this.item, this.onSubmit});
  @override State<SignatureRequestFormWidget> createState() => _SignatureRequestFormWidgetState();
}

class _SignatureRequestFormWidgetState extends State<SignatureRequestFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _contractId;
  String? _provider;
  String? _status;
  String? _signUrl;
  String? _signedDocumentUrl;
  DateTime? _expiresAt;

  @override
  void initState() {
    super.initState();
    _contractId = widget.item?.contractId?.toString();
    _provider = widget.item?.provider?.toString();
    _status = widget.item?.status?.toString();
    _signUrl = widget.item?.signUrl?.toString();
    _signedDocumentUrl = widget.item?.signedDocumentUrl?.toString();
    _expiresAt = widget.item?.expiresAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_contractId?.isNotEmpty == true) 'contractId': _contractId,
        if (_provider?.isNotEmpty == true) 'provider': _provider,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_signUrl?.isNotEmpty == true) 'signUrl': _signUrl,
        if (_signedDocumentUrl?.isNotEmpty == true) 'signedDocumentUrl': _signedDocumentUrl,
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? SignatureRequest.fromJson({...widget.item!.toJson(), ...data})
        : SignatureRequest.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Contract Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contractId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _provider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sign Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _signUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Signed Document Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _signedDocumentUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _expiresAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiresAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Expires At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_expiresAt != null ? _fmt(_expiresAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Signature Request'),
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