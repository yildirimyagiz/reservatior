import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIChatHandoff Form Widget  |  Fields: sessionId, handoffReason, handoffTo, handoffAt, resolvedAt, resolvedBy, notes

class AIChatHandoffFormWidget extends StatefulWidget {
  final AIChatHandoff? item;
  final void Function(AIChatHandoff)? onSubmit;
  const AIChatHandoffFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIChatHandoffFormWidget> createState() => _AIChatHandoffFormWidgetState();
}

class _AIChatHandoffFormWidgetState extends State<AIChatHandoffFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _sessionId;
  String? _handoffReason;
  String? _handoffTo;
  DateTime? _handoffAt;
  DateTime? _resolvedAt;
  String? _resolvedBy;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _sessionId = widget.item?.sessionId?.toString();
    _handoffReason = widget.item?.handoffReason?.toString();
    _handoffTo = widget.item?.handoffTo?.toString();
    _handoffAt = widget.item?.handoffAt;
    _resolvedAt = widget.item?.resolvedAt;
    _resolvedBy = widget.item?.resolvedBy?.toString();
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
        if (_sessionId?.isNotEmpty == true) 'sessionId': _sessionId,
        if (_handoffReason?.isNotEmpty == true) 'handoffReason': _handoffReason,
        if (_handoffTo?.isNotEmpty == true) 'handoffTo': _handoffTo,
        if (_handoffAt != null) 'handoffAt': _handoffAt!.toIso8601String(),
        if (_resolvedAt != null) 'resolvedAt': _resolvedAt!.toIso8601String(),
        if (_resolvedBy?.isNotEmpty == true) 'resolvedBy': _resolvedBy,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? AIChatHandoff.fromJson({...widget.item!.toJson(), ...data})
        : AIChatHandoff.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Session Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _sessionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Handoff Reason', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _handoffReason = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Handoff To', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _handoffTo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _handoffAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _handoffAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Handoff At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_handoffAt != null ? _fmt(_handoffAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _resolvedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _resolvedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Resolved At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_resolvedAt != null ? _fmt(_resolvedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Resolved By', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _resolvedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Chat Handoff'),
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