import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIChatbotSession Form Widget  |  Fields: userId, contactId, sessionId, conversationHistory, intent, confidence, status, transferredTo, startedAt, lastActivityAt, endedAt, satisfaction

class AIChatbotSessionFormWidget extends StatefulWidget {
  final AIChatbotSession? item;
  final void Function(AIChatbotSession)? onSubmit;
  const AIChatbotSessionFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIChatbotSessionFormWidget> createState() => _AIChatbotSessionFormWidgetState();
}

class _AIChatbotSessionFormWidgetState extends State<AIChatbotSessionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _contactId;
  String? _sessionId;
  String? _conversationHistory;
  String? _intent;
  double? _confidence;
  String? _status;
  String? _transferredTo;
  DateTime? _startedAt;
  DateTime? _lastActivityAt;
  DateTime? _endedAt;
  int? _satisfaction;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _sessionId = widget.item?.sessionId?.toString();
    _conversationHistory = widget.item?.conversationHistory?.toString();
    _intent = widget.item?.intent?.toString();
    _confidence = widget.item?.confidence;
    _status = widget.item?.status?.toString();
    _transferredTo = widget.item?.transferredTo?.toString();
    _startedAt = widget.item?.startedAt;
    _lastActivityAt = widget.item?.lastActivityAt;
    _endedAt = widget.item?.endedAt;
    _satisfaction = widget.item?.satisfaction;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_sessionId?.isNotEmpty == true) 'sessionId': _sessionId,
        if (_conversationHistory?.isNotEmpty == true) 'conversationHistory': _conversationHistory,
        if (_intent?.isNotEmpty == true) 'intent': _intent,
        if (_confidence != null) 'confidence': _confidence,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_transferredTo?.isNotEmpty == true) 'transferredTo': _transferredTo,
        if (_startedAt != null) 'startedAt': _startedAt!.toIso8601String(),
        if (_lastActivityAt != null) 'lastActivityAt': _lastActivityAt!.toIso8601String(),
        if (_endedAt != null) 'endedAt': _endedAt!.toIso8601String(),
        if (_satisfaction != null) 'satisfaction': _satisfaction,
    };
    final result = widget.item != null
        ? AIChatbotSession.fromJson({...widget.item!.toJson(), ...data})
        : AIChatbotSession.fromJson(data);
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
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Session Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _sessionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Conversation History', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _conversationHistory = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Intent', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _intent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidence = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Transferred To', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _transferredTo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Started At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startedAt != null ? _fmt(_startedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastActivityAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastActivityAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Activity At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastActivityAt != null ? _fmt(_lastActivityAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Ended At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endedAt != null ? _fmt(_endedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Satisfaction', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _satisfaction = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Chatbot Session'),
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