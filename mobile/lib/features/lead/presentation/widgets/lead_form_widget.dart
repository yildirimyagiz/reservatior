import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Lead Form Widget  |  Fields: campaignId, sourceId, firstName, lastName, email, phone, budget, timeline, notes, status, sourceDetail, assignedToUserId, assignedToContactId, interestedPropertyId, interestedListingId, agentTeamId

class LeadFormWidget extends StatefulWidget {
  final Lead? item;
  final void Function(Lead)? onSubmit;
  const LeadFormWidget({super.key, this.item, this.onSubmit});
  @override State<LeadFormWidget> createState() => _LeadFormWidgetState();
}

class _LeadFormWidgetState extends State<LeadFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _campaignId;
  String? _sourceId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  double? _budget;
  String? _timeline;
  String? _notes;
  String? _status;
  String? _sourceDetail;
  String? _assignedToUserId;
  String? _assignedToContactId;
  String? _interestedPropertyId;
  String? _interestedListingId;
  String? _agentTeamId;

  @override
  void initState() {
    super.initState();
    _campaignId = widget.item?.campaignId?.toString();
    _sourceId = widget.item?.sourceId?.toString();
    _firstName = widget.item?.firstName?.toString();
    _lastName = widget.item?.lastName?.toString();
    _email = widget.item?.email?.toString();
    _phone = widget.item?.phone?.toString();
    _budget = widget.item?.budget;
    _timeline = widget.item?.timeline?.toString();
    _notes = widget.item?.notes?.toString();
    _status = widget.item?.status?.toString();
    _sourceDetail = widget.item?.sourceDetail?.toString();
    _assignedToUserId = widget.item?.assignedToUserId?.toString();
    _assignedToContactId = widget.item?.assignedToContactId?.toString();
    _interestedPropertyId = widget.item?.interestedPropertyId?.toString();
    _interestedListingId = widget.item?.interestedListingId?.toString();
    _agentTeamId = widget.item?.agentTeamId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_campaignId?.isNotEmpty == true) 'campaignId': _campaignId,
        if (_sourceId?.isNotEmpty == true) 'sourceId': _sourceId,
        if (_firstName?.isNotEmpty == true) 'firstName': _firstName,
        if (_lastName?.isNotEmpty == true) 'lastName': _lastName,
        if (_email?.isNotEmpty == true) 'email': _email,
        if (_phone?.isNotEmpty == true) 'phone': _phone,
        if (_budget != null) 'budget': _budget,
        if (_timeline?.isNotEmpty == true) 'timeline': _timeline,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_sourceDetail?.isNotEmpty == true) 'sourceDetail': _sourceDetail,
        if (_assignedToUserId?.isNotEmpty == true) 'assignedToUserId': _assignedToUserId,
        if (_assignedToContactId?.isNotEmpty == true) 'assignedToContactId': _assignedToContactId,
        if (_interestedPropertyId?.isNotEmpty == true) 'interestedPropertyId': _interestedPropertyId,
        if (_interestedListingId?.isNotEmpty == true) 'interestedListingId': _interestedListingId,
        if (_agentTeamId?.isNotEmpty == true) 'agentTeamId': _agentTeamId,
    };
    final result = widget.item != null
        ? Lead.fromJson({...widget.item!.toJson(), ...data})
        : Lead.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Campaign Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _campaignId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Source Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _sourceId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _firstName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _lastName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                onSaved: (v) => _email = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                onSaved: (v) => _phone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Budget', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _budget = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Timeline', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _timeline = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Source Detail', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _sourceDetail = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned To User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _assignedToUserId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned To Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _assignedToContactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Interested Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _interestedPropertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Interested Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _interestedListingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Team Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agentTeamId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Lead'),
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