import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Analytics Form Widget  |  Fields: entityId, entityType, type, data, timestamp, propertyId, userId, agentId, agencyId, reservationId, taskId, taxRecordId

class AnalyticsFormWidget extends StatefulWidget {
  final Analytics? item;
  final void Function(Analytics)? onSubmit;
  const AnalyticsFormWidget({super.key, this.item, this.onSubmit});
  @override State<AnalyticsFormWidget> createState() => _AnalyticsFormWidgetState();
}

class _AnalyticsFormWidgetState extends State<AnalyticsFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _entityId;
  String? _entityType;
  String? _type;
  String? _data;
  DateTime? _timestamp;
  String? _propertyId;
  String? _userId;
  String? _agentId;
  String? _agencyId;
  String? _reservationId;
  String? _taskId;
  String? _taxRecordId;

  @override
  void initState() {
    super.initState();
    _entityId = widget.item?.entityId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _type = widget.item?.type?.toString();
    _data = widget.item?.data?.toString();
    _timestamp = widget.item?.timestamp;
    _propertyId = widget.item?.propertyId?.toString();
    _userId = widget.item?.userId?.toString();
    _agentId = widget.item?.agentId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _taskId = widget.item?.taskId?.toString();
    _taxRecordId = widget.item?.taxRecordId?.toString();
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
        if (_data?.isNotEmpty == true) 'data': _data,
        if (_timestamp != null) 'timestamp': _timestamp!.toIso8601String(),
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
        if (_taskId?.isNotEmpty == true) 'taskId': _taskId,
        if (_taxRecordId?.isNotEmpty == true) 'taxRecordId': _taxRecordId,
    };
    final result = widget.item != null
        ? Analytics.fromJson({...widget.item!.toJson(), ...data})
        : Analytics.fromJson(data);
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
                onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _data = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _timestamp ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _timestamp = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Timestamp',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_timestamp != null ? _fmt(_timestamp) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Task Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _taskId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tax Record Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _taxRecordId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Analytics'),
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