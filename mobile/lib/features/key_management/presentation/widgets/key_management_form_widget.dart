import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── KeyManagement Form Widget  |  Fields: propertyId, keyType, keyNumber, keyLocation, keySafeCode, keyStatus, cutDate, cutBy, replacementCost, notes

class KeyManagementFormWidget extends StatefulWidget {
  final KeyManagement? item;
  final void Function(KeyManagement)? onSubmit;
  const KeyManagementFormWidget({super.key, this.item, this.onSubmit});
  @override State<KeyManagementFormWidget> createState() => _KeyManagementFormWidgetState();
}

class _KeyManagementFormWidgetState extends State<KeyManagementFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _keyType;
  String? _keyNumber;
  String? _keyLocation;
  String? _keySafeCode;
  String? _keyStatus;
  DateTime? _cutDate;
  String? _cutBy;
  double? _replacementCost;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _keyType = widget.item?.keyType?.toString();
    _keyNumber = widget.item?.keyNumber?.toString();
    _keyLocation = widget.item?.keyLocation?.toString();
    _keySafeCode = widget.item?.keySafeCode?.toString();
    _keyStatus = widget.item?.keyStatus?.toString();
    _cutDate = widget.item?.cutDate;
    _cutBy = widget.item?.cutBy?.toString();
    _replacementCost = widget.item?.replacementCost;
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
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_keyType?.isNotEmpty == true) 'keyType': _keyType,
        if (_keyNumber?.isNotEmpty == true) 'keyNumber': _keyNumber,
        if (_keyLocation?.isNotEmpty == true) 'keyLocation': _keyLocation,
        if (_keySafeCode?.isNotEmpty == true) 'keySafeCode': _keySafeCode,
        if (_keyStatus?.isNotEmpty == true) 'keyStatus': _keyStatus,
        if (_cutDate != null) 'cutDate': _cutDate!.toIso8601String(),
        if (_cutBy?.isNotEmpty == true) 'cutBy': _cutBy,
        if (_replacementCost != null) 'replacementCost': _replacementCost,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? KeyManagement.fromJson({...widget.item!.toJson(), ...data})
        : KeyManagement.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Key Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _keyType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Key Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _keyNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Key Location', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _keyLocation = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Key Safe Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _keySafeCode = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Key Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _keyStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _cutDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _cutDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Cut Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_cutDate != null ? _fmt(_cutDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cut By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _cutBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Replacement Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _replacementCost = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Key Management'),
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