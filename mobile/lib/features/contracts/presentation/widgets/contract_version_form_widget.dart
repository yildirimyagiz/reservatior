import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ContractVersion Form Widget  |  Fields: contractId, version, documentUrl, checksum

class ContractVersionFormWidget extends StatefulWidget {
  final ContractVersion? item;
  final void Function(ContractVersion)? onSubmit;
  const ContractVersionFormWidget({super.key, this.item, this.onSubmit});
  @override State<ContractVersionFormWidget> createState() => _ContractVersionFormWidgetState();
}

class _ContractVersionFormWidgetState extends State<ContractVersionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _contractId;
  int? _version;
  String? _documentUrl;
  String? _checksum;

  @override
  void initState() {
    super.initState();
    _contractId = widget.item?.contractId?.toString();
    _version = widget.item?.version;
    _documentUrl = widget.item?.documentUrl?.toString();
    _checksum = widget.item?.checksum?.toString();
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
        if (_version != null) 'version': _version,
        if (_documentUrl?.isNotEmpty == true) 'documentUrl': _documentUrl,
        if (_checksum?.isNotEmpty == true) 'checksum': _checksum,
    };
    final result = widget.item != null
        ? ContractVersion.fromJson({...widget.item!.toJson(), ...data})
        : ContractVersion.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Contract Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contractId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Version', prefixIcon: const Icon(Icons.numbers), border: const OutlineInputBorder()),
                onSaved: (v) => _version = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Document Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _documentUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Checksum', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _checksum = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Contract Version'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}