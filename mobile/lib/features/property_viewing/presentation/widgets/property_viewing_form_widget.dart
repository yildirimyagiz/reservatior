import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyViewing Form Widget  |  Fields: propertyId, listingId, viewingType, scheduledDate, duration, attendeeName, attendeeEmail, attendeePhone, attendeeType, status, assignedAgentId, feedback, interestedLevel, followUpRequired, followUpNotes

class PropertyViewingFormWidget extends StatefulWidget {
  final PropertyViewing? item;
  final void Function(PropertyViewing)? onSubmit;
  const PropertyViewingFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyViewingFormWidget> createState() => _PropertyViewingFormWidgetState();
}

class _PropertyViewingFormWidgetState extends State<PropertyViewingFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _listingId;
  String? _viewingType;
  DateTime? _scheduledDate;
  int? _duration;
  String? _attendeeName;
  String? _attendeeEmail;
  String? _attendeePhone;
  String? _attendeeType;
  String? _status;
  String? _assignedAgentId;
  String? _feedback;
  String? _interestedLevel;
  bool _followUpRequired = false;
  String? _followUpNotes;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _viewingType = widget.item?.viewingType?.toString();
    _scheduledDate = widget.item?.scheduledDate;
    _duration = widget.item?.duration;
    _attendeeName = widget.item?.attendeeName?.toString();
    _attendeeEmail = widget.item?.attendeeEmail?.toString();
    _attendeePhone = widget.item?.attendeePhone?.toString();
    _attendeeType = widget.item?.attendeeType?.toString();
    _status = widget.item?.status?.toString();
    _assignedAgentId = widget.item?.assignedAgentId?.toString();
    _feedback = widget.item?.feedback?.toString();
    _interestedLevel = widget.item?.interestedLevel?.toString();
    _followUpRequired = widget.item?.followUpRequired ?? false;
    _followUpNotes = widget.item?.followUpNotes?.toString();
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
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_viewingType?.isNotEmpty == true) 'viewingType': _viewingType,
        if (_scheduledDate != null) 'scheduledDate': _scheduledDate!.toIso8601String(),
        if (_duration != null) 'duration': _duration,
        if (_attendeeName?.isNotEmpty == true) 'attendeeName': _attendeeName,
        if (_attendeeEmail?.isNotEmpty == true) 'attendeeEmail': _attendeeEmail,
        if (_attendeePhone?.isNotEmpty == true) 'attendeePhone': _attendeePhone,
        if (_attendeeType?.isNotEmpty == true) 'attendeeType': _attendeeType,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_assignedAgentId?.isNotEmpty == true) 'assignedAgentId': _assignedAgentId,
        if (_feedback?.isNotEmpty == true) 'feedback': _feedback,
        if (_interestedLevel?.isNotEmpty == true) 'interestedLevel': _interestedLevel,
        'followUpRequired': _followUpRequired,
        if (_followUpNotes?.isNotEmpty == true) 'followUpNotes': _followUpNotes,
    };
    final result = widget.item != null
        ? PropertyViewing.fromJson({...widget.item!.toJson(), ...data})
        : PropertyViewing.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Viewing Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _viewingType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _scheduledDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _scheduledDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Scheduled Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_scheduledDate != null ? _fmt(_scheduledDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _duration = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Attendee Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _attendeeName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Attendee Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                onSaved: (v) => _attendeeEmail = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Attendee Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                onSaved: (v) => _attendeePhone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Attendee Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _attendeeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _assignedAgentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Feedback', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                onSaved: (v) => _feedback = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Interested Level', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _interestedLevel = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Follow Up Required'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _followUpRequired,
                  onChanged: (v) { ss(() {}); setState(() => _followUpRequired = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Follow Up Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _followUpNotes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Viewing'),
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