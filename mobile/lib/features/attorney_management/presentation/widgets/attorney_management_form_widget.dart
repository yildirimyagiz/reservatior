import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AttorneyManagement Form Widget  |  Fields: dealId, contactId, solicitorFirm, solicitorName, solicitorEmail, solicitorPhone, appointmentType, appointmentDate, appointmentNotes, status, searchDate, draftContractDate, finalContractDate, completionDate, completionNotes, fees

class AttorneyManagementFormWidget extends StatefulWidget {
  final AttorneyManagement? item;
  final void Function(AttorneyManagement)? onSubmit;
  const AttorneyManagementFormWidget({super.key, this.item, this.onSubmit});
  @override State<AttorneyManagementFormWidget> createState() => _AttorneyManagementFormWidgetState();
}

class _AttorneyManagementFormWidgetState extends State<AttorneyManagementFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _dealId;
  String? _contactId;
  String? _solicitorFirm;
  String? _solicitorName;
  String? _solicitorEmail;
  String? _solicitorPhone;
  String? _appointmentType;
  DateTime? _appointmentDate;
  String? _appointmentNotes;
  String? _status;
  DateTime? _searchDate;
  DateTime? _draftContractDate;
  DateTime? _finalContractDate;
  DateTime? _completionDate;
  String? _completionNotes;
  String? _fees;

  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _solicitorFirm = widget.item?.solicitorFirm?.toString();
    _solicitorName = widget.item?.solicitorName?.toString();
    _solicitorEmail = widget.item?.solicitorEmail?.toString();
    _solicitorPhone = widget.item?.solicitorPhone?.toString();
    _appointmentType = widget.item?.appointmentType?.toString();
    _appointmentDate = widget.item?.appointmentDate;
    _appointmentNotes = widget.item?.appointmentNotes?.toString();
    _status = widget.item?.status?.toString();
    _searchDate = widget.item?.searchDate;
    _draftContractDate = widget.item?.draftContractDate;
    _finalContractDate = widget.item?.finalContractDate;
    _completionDate = widget.item?.completionDate;
    _completionNotes = widget.item?.completionNotes?.toString();
    _fees = widget.item?.fees?.toString();
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
        if (_solicitorFirm?.isNotEmpty == true) 'solicitorFirm': _solicitorFirm,
        if (_solicitorName?.isNotEmpty == true) 'solicitorName': _solicitorName,
        if (_solicitorEmail?.isNotEmpty == true) 'solicitorEmail': _solicitorEmail,
        if (_solicitorPhone?.isNotEmpty == true) 'solicitorPhone': _solicitorPhone,
        if (_appointmentType?.isNotEmpty == true) 'appointmentType': _appointmentType,
        if (_appointmentDate != null) 'appointmentDate': _appointmentDate!.toIso8601String(),
        if (_appointmentNotes?.isNotEmpty == true) 'appointmentNotes': _appointmentNotes,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_searchDate != null) 'searchDate': _searchDate!.toIso8601String(),
        if (_draftContractDate != null) 'draftContractDate': _draftContractDate!.toIso8601String(),
        if (_finalContractDate != null) 'finalContractDate': _finalContractDate!.toIso8601String(),
        if (_completionDate != null) 'completionDate': _completionDate!.toIso8601String(),
        if (_completionNotes?.isNotEmpty == true) 'completionNotes': _completionNotes,
        if (_fees?.isNotEmpty == true) 'fees': _fees,
    };
    final result = widget.item != null
        ? AttorneyManagement.fromJson({...widget.item!.toJson(), ...data})
        : AttorneyManagement.fromJson(data);
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
                initialValue: _dealId?.toString() ?? '',
                onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _contactId?.toString() ?? '',
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Solicitor Firm', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _solicitorFirm?.toString() ?? '',
                onSaved: (v) => _solicitorFirm = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Solicitor Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _solicitorName?.toString() ?? '',
                onSaved: (v) => _solicitorName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Solicitor Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                initialValue: _solicitorEmail?.toString() ?? '',
                onSaved: (v) => _solicitorEmail = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Solicitor Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                initialValue: _solicitorPhone?.toString() ?? '',
                onSaved: (v) => _solicitorPhone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Appointment Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _appointmentType?.toString() ?? '',
                onSaved: (v) => _appointmentType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _appointmentDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _appointmentDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Appointment Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_appointmentDate != null ? _fmt(_appointmentDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Appointment Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _appointmentNotes?.toString() ?? '',
                onSaved: (v) => _appointmentNotes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _status?.toString() ?? '',
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _searchDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _searchDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Search Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_searchDate != null ? _fmt(_searchDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _draftContractDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _draftContractDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Draft Contract Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_draftContractDate != null ? _fmt(_draftContractDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _finalContractDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _finalContractDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Final Contract Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_finalContractDate != null ? _fmt(_finalContractDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _completionDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _completionDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Completion Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_completionDate != null ? _fmt(_completionDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Completion Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _completionNotes?.toString() ?? '',
                onSaved: (v) => _completionNotes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fees', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                initialValue: _fees?.toString() ?? '',
                onSaved: (v) => _fees = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Attorney Management'),
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