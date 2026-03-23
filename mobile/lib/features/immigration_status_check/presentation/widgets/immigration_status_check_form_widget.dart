import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ImmigrationStatusCheck Form Widget  |  Fields: leaseId, tenantId, checkStatus, checkDate, validUntil, immigrationStatus, visaType, visaExpiry, documentType, documentNumber, documentVerified, shareCode, checkReference, notes

class ImmigrationStatusCheckFormWidget extends StatefulWidget {
  final ImmigrationStatusCheck? item;
  final void Function(ImmigrationStatusCheck)? onSubmit;
  const ImmigrationStatusCheckFormWidget({super.key, this.item, this.onSubmit});
  @override State<ImmigrationStatusCheckFormWidget> createState() => _ImmigrationStatusCheckFormWidgetState();
}

class _ImmigrationStatusCheckFormWidgetState extends State<ImmigrationStatusCheckFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _leaseId;
  String? _tenantId;
  String? _checkStatus;
  DateTime? _checkDate;
  DateTime? _validUntil;
  String? _immigrationStatus;
  String? _visaType;
  DateTime? _visaExpiry;
  String? _documentType;
  String? _documentNumber;
  bool _documentVerified = false;
  String? _shareCode;
  String? _checkReference;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId?.toString();
    _tenantId = widget.item?.tenantId?.toString();
    _checkStatus = widget.item?.checkStatus?.toString();
    _checkDate = widget.item?.checkDate;
    _validUntil = widget.item?.validUntil;
    _immigrationStatus = widget.item?.immigrationStatus?.toString();
    _visaType = widget.item?.visaType?.toString();
    _visaExpiry = widget.item?.visaExpiry;
    _documentType = widget.item?.documentType?.toString();
    _documentNumber = widget.item?.documentNumber?.toString();
    _documentVerified = widget.item?.documentVerified ?? false;
    _shareCode = widget.item?.shareCode?.toString();
    _checkReference = widget.item?.checkReference?.toString();
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
        if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
        if (_tenantId?.isNotEmpty == true) 'tenantId': _tenantId,
        if (_checkStatus?.isNotEmpty == true) 'checkStatus': _checkStatus,
        if (_checkDate != null) 'checkDate': _checkDate!.toIso8601String(),
        if (_validUntil != null) 'validUntil': _validUntil!.toIso8601String(),
        if (_immigrationStatus?.isNotEmpty == true) 'immigrationStatus': _immigrationStatus,
        if (_visaType?.isNotEmpty == true) 'visaType': _visaType,
        if (_visaExpiry != null) 'visaExpiry': _visaExpiry!.toIso8601String(),
        if (_documentType?.isNotEmpty == true) 'documentType': _documentType,
        if (_documentNumber?.isNotEmpty == true) 'documentNumber': _documentNumber,
        'documentVerified': _documentVerified,
        if (_shareCode?.isNotEmpty == true) 'shareCode': _shareCode,
        if (_checkReference?.isNotEmpty == true) 'checkReference': _checkReference,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? ImmigrationStatusCheck.fromJson({...widget.item!.toJson(), ...data})
        : ImmigrationStatusCheck.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Check Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _checkStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _checkDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _checkDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Check Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_checkDate != null ? _fmt(_checkDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _validUntil ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _validUntil = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Valid Until',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_validUntil != null ? _fmt(_validUntil) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Immigration Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _immigrationStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Visa Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _visaType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _visaExpiry ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _visaExpiry = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Visa Expiry',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_visaExpiry != null ? _fmt(_visaExpiry) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Document Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _documentType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Document Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _documentNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Document Verified'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _documentVerified,
                  onChanged: (v) { ss(() {}); setState(() => _documentVerified = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Share Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _shareCode = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Check Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _checkReference = v?.isEmpty == true ? null : v,
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Immigration Status Check'),
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