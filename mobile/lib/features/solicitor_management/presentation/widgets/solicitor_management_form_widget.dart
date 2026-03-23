import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SolicitorManagement Form Widget  |  Fields: dealId, contactId, solicitorType, status, engagedAt, completedAt, fee, currency, notes

class SolicitorManagementFormWidget extends StatefulWidget {
  final SolicitorManagement? item;
  final void Function(SolicitorManagement)? onSubmit;
  const SolicitorManagementFormWidget({super.key, this.item, this.onSubmit});
  @override State<SolicitorManagementFormWidget> createState() => _SolicitorManagementFormWidgetState();
}

class _SolicitorManagementFormWidgetState extends State<SolicitorManagementFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _dealId;
  String? _contactId;
  String? _solicitorType;
  String? _status;
  DateTime? _engagedAt;
  DateTime? _completedAt;
  double? _fee;
  String? _currency;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _solicitorType = widget.item?.solicitorType?.toString();
    _status = widget.item?.status?.toString();
    _engagedAt = widget.item?.engagedAt;
    _completedAt = widget.item?.completedAt;
    _fee = widget.item?.fee;
    _currency = widget.item?.currency?.toString();
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
        if (_dealId?.isNotEmpty == true) 'dealId': _dealId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_solicitorType?.isNotEmpty == true) 'solicitorType': _solicitorType,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_engagedAt != null) 'engagedAt': _engagedAt!.toIso8601String(),
        if (_completedAt != null) 'completedAt': _completedAt!.toIso8601String(),
        if (_fee != null) 'fee': _fee,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? SolicitorManagement.fromJson({...widget.item!.toJson(), ...data})
        : SolicitorManagement.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Solicitor Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _solicitorType = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _engagedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _engagedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Engaged At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_engagedAt != null ? _fmt(_engagedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _completedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _completedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Completed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_completedAt != null ? _fmt(_completedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _fee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Solicitor Management'),
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