import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Facility Form Widget ──
// Fields: propertyId, name, feeAmount, feeCurrency, notes

class FacilityFormWidget extends StatefulWidget {
  final Facility? item;
  final void Function(Facility)? onSubmit;
  const FacilityFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<FacilityFormWidget> createState() => _FacilityFormWidgetState();
}

class _FacilityFormWidgetState extends State<FacilityFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _name;
  double? _feeAmount;
  String? _feeCurrency;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _name = widget.item?.name?.toString();
    _feeAmount = widget.item?.feeAmount;
    _feeCurrency = widget.item?.feeCurrency?.toString();
    _notes = widget.item?.notes?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId != null) 'propertyId': _propertyId,
        if (_name != null) 'name': _name,
        if (_feeAmount != null) 'feeAmount': _feeAmount,
        if (_feeCurrency != null) 'feeCurrency': _feeCurrency,
        if (_notes != null) 'notes': _notes,
    };
    final result = widget.item != null
        ? Facility.fromJson({...widget.item!.toJson(), ...data})
        : Facility.fromJson(data);
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
                maxLines: 1,
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fee Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _feeAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fee Currency', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _feeCurrency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Facility'),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
