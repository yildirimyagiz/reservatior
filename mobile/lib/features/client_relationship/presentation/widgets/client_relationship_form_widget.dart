import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ClientRelationship Form Widget  |  Fields: agentId, clientId, status, firstContact, lastContact, contactFrequency, preferredChannel

class ClientRelationshipFormWidget extends StatefulWidget {
  final ClientRelationship? item;
  final void Function(ClientRelationship)? onSubmit;
  const ClientRelationshipFormWidget({super.key, this.item, this.onSubmit});
  @override State<ClientRelationshipFormWidget> createState() => _ClientRelationshipFormWidgetState();
}

class _ClientRelationshipFormWidgetState extends State<ClientRelationshipFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _agentId;
  String? _clientId;
  String? _status;
  DateTime? _firstContact;
  DateTime? _lastContact;
  String? _contactFrequency;
  String? _preferredChannel;

  @override
  void initState() {
    super.initState();
    _agentId = widget.item?.agentId?.toString();
    _clientId = widget.item?.clientId?.toString();
    _status = widget.item?.status?.toString();
    _firstContact = widget.item?.firstContact;
    _lastContact = widget.item?.lastContact;
    _contactFrequency = widget.item?.contactFrequency?.toString();
    _preferredChannel = widget.item?.preferredChannel?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
        if (_clientId?.isNotEmpty == true) 'clientId': _clientId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_firstContact != null) 'firstContact': _firstContact!.toIso8601String(),
        if (_lastContact != null) 'lastContact': _lastContact!.toIso8601String(),
        if (_contactFrequency?.isNotEmpty == true) 'contactFrequency': _contactFrequency,
        if (_preferredChannel?.isNotEmpty == true) 'preferredChannel': _preferredChannel,
    };
    final result = widget.item != null
        ? ClientRelationship.fromJson({...widget.item!.toJson(), ...data})
        : ClientRelationship.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _agentId?.toString() ?? '',
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Client Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _clientId?.toString() ?? '',
                onSaved: (v) => _clientId = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _firstContact ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _firstContact = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'First Contact',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_firstContact != null ? _fmt(_firstContact) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastContact ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastContact = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Contact',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastContact != null ? _fmt(_lastContact) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Frequency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _contactFrequency?.toString() ?? '',
                onSaved: (v) => _contactFrequency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preferred Channel', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _preferredChannel?.toString() ?? '',
                onSaved: (v) => _preferredChannel = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Client Relationship'),
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