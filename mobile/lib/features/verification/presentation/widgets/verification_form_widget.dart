import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Verification Form Widget  |  Fields: identifier, value, expiresAt

class VerificationFormWidget extends StatefulWidget {
  final Verification? item;
  final void Function(Verification)? onSubmit;
  const VerificationFormWidget({super.key, this.item, this.onSubmit});
  @override State<VerificationFormWidget> createState() => _VerificationFormWidgetState();
}

class _VerificationFormWidgetState extends State<VerificationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _identifier;
  String? _value;
  DateTime? _expiresAt;

  @override
  void initState() {
    super.initState();
    _identifier = widget.item?.identifier?.toString();
    _value = widget.item?.value?.toString();
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
        if (_identifier?.isNotEmpty == true) 'identifier': _identifier,
        if (_value?.isNotEmpty == true) 'value': _value,
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? Verification.fromJson({...widget.item!.toJson(), ...data})
        : Verification.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Identifier', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _identifier = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Value', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _value = v?.isEmpty == true ? null : v,
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Verification'),
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