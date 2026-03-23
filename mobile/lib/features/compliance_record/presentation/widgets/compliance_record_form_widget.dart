import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ComplianceRecord Form Widget  |  Fields: entityId, entityType, type, status, documentUrl, expiryDate, notes, isVerified, propertyId, agentId, agencyId, reservationId

class ComplianceRecordFormWidget extends StatefulWidget {
  final ComplianceRecord? item;
  final void Function(ComplianceRecord)? onSubmit;
  const ComplianceRecordFormWidget({super.key, this.item, this.onSubmit});
  @override State<ComplianceRecordFormWidget> createState() => _ComplianceRecordFormWidgetState();
}

class _ComplianceRecordFormWidgetState extends State<ComplianceRecordFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _entityId;
  String? _entityType;
  String? _type;
  String? _status;
  String? _documentUrl;
  DateTime? _expiryDate;
  String? _notes;
  bool _isVerified = false;
  String? _propertyId;
  String? _agentId;
  String? _agencyId;
  String? _reservationId;

  @override
  void initState() {
    super.initState();
    _entityId = widget.item?.entityId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _documentUrl = widget.item?.documentUrl?.toString();
    _expiryDate = widget.item?.expiryDate;
    _notes = widget.item?.notes?.toString();
    _isVerified = widget.item?.isVerified ?? false;
    _propertyId = widget.item?.propertyId?.toString();
    _agentId = widget.item?.agentId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
        if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_documentUrl?.isNotEmpty == true) 'documentUrl': _documentUrl,
        if (_expiryDate != null) 'expiryDate': _expiryDate!.toIso8601String(),
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        'isVerified': _isVerified,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
    };
    final result = widget.item != null
        ? ComplianceRecord.fromJson({...widget.item!.toJson(), ...data})
        : ComplianceRecord.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _entityId?.toString() ?? '',
                onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _entityType?.toString() ?? '',
                onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _type?.toString() ?? '',
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _status?.toString() ?? '',
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Document Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _documentUrl?.toString() ?? '',
                onSaved: (v) => _documentUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _expiryDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiryDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Expiry Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_expiryDate != null ? _fmt(_expiryDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _notes?.toString() ?? '',
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Verified'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isVerified,
                  onChanged: (v) { ss(() {}); setState(() => _isVerified = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _propertyId?.toString() ?? '',
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _agentId?.toString() ?? '',
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _agencyId?.toString() ?? '',
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _reservationId?.toString() ?? '',
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Compliance Record'),
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