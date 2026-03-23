import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Ticket Form Widget  |  Fields: cuid, subject, description, status, closedAt, userId, agentId

class TicketFormWidget extends StatefulWidget {
  final Ticket? item;
  final void Function(Ticket)? onSubmit;
  const TicketFormWidget({super.key, this.item, this.onSubmit});
  @override State<TicketFormWidget> createState() => _TicketFormWidgetState();
}

class _TicketFormWidgetState extends State<TicketFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _cuid;
  String? _subject;
  String? _description;
  String? _status;
  DateTime? _closedAt;
  String? _userId;
  String? _agentId;

  @override
  void initState() {
    super.initState();
    _cuid = widget.item?.cuid?.toString();
    _subject = widget.item?.subject?.toString();
    _description = widget.item?.description?.toString();
    _status = widget.item?.status?.toString();
    _closedAt = widget.item?.closedAt;
    _userId = widget.item?.userId?.toString();
    _agentId = widget.item?.agentId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_cuid?.isNotEmpty == true) 'cuid': _cuid,
        if (_subject?.isNotEmpty == true) 'subject': _subject,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_closedAt != null) 'closedAt': _closedAt!.toIso8601String(),
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
    };
    final result = widget.item != null
        ? Ticket.fromJson({...widget.item!.toJson(), ...data})
        : Ticket.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Cuid', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _cuid = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _subject = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _closedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _closedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Closed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_closedAt != null ? _fmt(_closedAt) : 'Tap to select date'),
                ),
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
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ticket'),
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