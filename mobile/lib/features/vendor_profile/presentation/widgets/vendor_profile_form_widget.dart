import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── VendorProfile Form Widget  |  Fields: legalName, serviceAreas, defaultCommissionBps

class VendorProfileFormWidget extends StatefulWidget {
  final VendorProfile? item;
  final void Function(VendorProfile)? onSubmit;
  const VendorProfileFormWidget({super.key, this.item, this.onSubmit});
  @override State<VendorProfileFormWidget> createState() => _VendorProfileFormWidgetState();
}

class _VendorProfileFormWidgetState extends State<VendorProfileFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _legalName;
  String? _serviceAreas;
  int? _defaultCommissionBps;

  @override
  void initState() {
    super.initState();
    _legalName = widget.item?.legalName?.toString();
    _serviceAreas = widget.item?.serviceAreas?.toString();
    _defaultCommissionBps = widget.item?.defaultCommissionBps;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_legalName?.isNotEmpty == true) 'legalName': _legalName,
        if (_serviceAreas?.isNotEmpty == true) 'serviceAreas': _serviceAreas,
        if (_defaultCommissionBps != null) 'defaultCommissionBps': _defaultCommissionBps,
    };
    final result = widget.item != null
        ? VendorProfile.fromJson({...widget.item!.toJson(), ...data})
        : VendorProfile.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Legal Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _legalName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Service Areas', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _serviceAreas = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Default Commission Bps', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _defaultCommissionBps = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Vendor Profile'),
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