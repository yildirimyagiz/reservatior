import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AmbassadorContract Form Widget  |  Fields: ambassadorId, version, equityPercent, upfrontFee, currency, startDate, endDate, signedAt, documentUrl, status, notes

class AmbassadorContractFormWidget extends StatefulWidget {
  final AmbassadorContract? item;
  final void Function(AmbassadorContract)? onSubmit;
  const AmbassadorContractFormWidget({super.key, this.item, this.onSubmit});
  @override State<AmbassadorContractFormWidget> createState() => _AmbassadorContractFormWidgetState();
}

class _AmbassadorContractFormWidgetState extends State<AmbassadorContractFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _ambassadorId;
  int? _version;
  double? _equityPercent;
  double? _upfrontFee;
  String? _currency;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _signedAt;
  String? _documentUrl;
  String? _status;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _ambassadorId = widget.item?.ambassadorId?.toString();
    _version = widget.item?.version;
    _equityPercent = widget.item?.equityPercent;
    _upfrontFee = widget.item?.upfrontFee;
    _currency = widget.item?.currency?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _signedAt = widget.item?.signedAt;
    _documentUrl = widget.item?.documentUrl?.toString();
    _status = widget.item?.status?.toString();
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
        if (_ambassadorId?.isNotEmpty == true) 'ambassadorId': _ambassadorId,
        if (_version != null) 'version': _version,
        if (_equityPercent != null) 'equityPercent': _equityPercent,
        if (_upfrontFee != null) 'upfrontFee': _upfrontFee,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_signedAt != null) 'signedAt': _signedAt!.toIso8601String(),
        if (_documentUrl?.isNotEmpty == true) 'documentUrl': _documentUrl,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? AmbassadorContract.fromJson({...widget.item!.toJson(), ...data})
        : AmbassadorContract.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Ambassador Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _ambassadorId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Version', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _version = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Equity Percent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _equityPercent = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Upfront Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _upfrontFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endDate != null ? _fmt(_endDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _signedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _signedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Signed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_signedAt != null ? _fmt(_signedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Document Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _documentUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ambassador Contract'),
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