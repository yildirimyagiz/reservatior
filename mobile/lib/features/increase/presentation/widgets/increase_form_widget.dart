import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Increase Form Widget  |  Fields: propertyId, tenantId, proposedBy, oldRent, newRent, effectiveDate, status, contractId

class IncreaseFormWidget extends StatefulWidget {
  final Increase? item;
  final void Function(Increase)? onSubmit;
  const IncreaseFormWidget({super.key, this.item, this.onSubmit});
  @override State<IncreaseFormWidget> createState() => _IncreaseFormWidgetState();
}

class _IncreaseFormWidgetState extends State<IncreaseFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _tenantId;
  String? _proposedBy;
  double? _oldRent;
  double? _newRent;
  DateTime? _effectiveDate;
  String? _status;
  String? _contractId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _tenantId = widget.item?.tenantId?.toString();
    _proposedBy = widget.item?.proposedBy?.toString();
    _oldRent = widget.item?.oldRent;
    _newRent = widget.item?.newRent;
    _effectiveDate = widget.item?.effectiveDate;
    _status = widget.item?.status?.toString();
    _contractId = widget.item?.contractId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_tenantId?.isNotEmpty == true) 'tenantId': _tenantId,
        if (_proposedBy?.isNotEmpty == true) 'proposedBy': _proposedBy,
        if (_oldRent != null) 'oldRent': _oldRent,
        if (_newRent != null) 'newRent': _newRent,
        if (_effectiveDate != null) 'effectiveDate': _effectiveDate!.toIso8601String(),
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_contractId?.isNotEmpty == true) 'contractId': _contractId,
    };
    final result = widget.item != null
        ? Increase.fromJson({...widget.item!.toJson(), ...data})
        : Increase.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Proposed By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _proposedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Old Rent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _oldRent = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'New Rent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _newRent = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _effectiveDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _effectiveDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Effective Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_effectiveDate != null ? _fmt(_effectiveDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contract Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contractId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Increase'),
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