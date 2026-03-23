import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── RightToRentCheck Form Widget  |  Fields: leaseId, contactId, checkType, reference, status, checkedAt, expiresAt, result

class RightToRentCheckFormWidget extends StatefulWidget {
  final RightToRentCheck? item;
  final void Function(RightToRentCheck)? onSubmit;
  const RightToRentCheckFormWidget({super.key, this.item, this.onSubmit});
  @override State<RightToRentCheckFormWidget> createState() => _RightToRentCheckFormWidgetState();
}

class _RightToRentCheckFormWidgetState extends State<RightToRentCheckFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _leaseId;
  String? _contactId;
  String? _checkType;
  String? _reference;
  String? _status;
  DateTime? _checkedAt;
  DateTime? _expiresAt;
  String? _result;

  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _checkType = widget.item?.checkType?.toString();
    _reference = widget.item?.reference?.toString();
    _status = widget.item?.status?.toString();
    _checkedAt = widget.item?.checkedAt;
    _expiresAt = widget.item?.expiresAt;
    _result = widget.item?.result?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_checkType?.isNotEmpty == true) 'checkType': _checkType,
        if (_reference?.isNotEmpty == true) 'reference': _reference,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_checkedAt != null) 'checkedAt': _checkedAt!.toIso8601String(),
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
        if (_result?.isNotEmpty == true) 'result': _result,
    };
    final result = widget.item != null
        ? RightToRentCheck.fromJson({...widget.item!.toJson(), ...data})
        : RightToRentCheck.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Check Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _checkType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _reference = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _checkedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _checkedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Checked At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_checkedAt != null ? _fmt(_checkedAt) : 'Tap to select date'),
                ),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Result', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _result = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Right To Rent Check'),
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