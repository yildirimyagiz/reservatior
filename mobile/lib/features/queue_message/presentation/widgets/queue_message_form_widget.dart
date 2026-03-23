import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── QueueMessage Form Widget  |  Fields: messageId, queueName, exchangeName, routingKey, messageType, payload, status, priority, retryCount, maxRetries, nextRetryAt, processedAt, completedAt, failedAt, errorMessage

class QueueMessageFormWidget extends StatefulWidget {
  final QueueMessage? item;
  final void Function(QueueMessage)? onSubmit;
  const QueueMessageFormWidget({super.key, this.item, this.onSubmit});
  @override State<QueueMessageFormWidget> createState() => _QueueMessageFormWidgetState();
}

class _QueueMessageFormWidgetState extends State<QueueMessageFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _messageId;
  String? _queueName;
  String? _exchangeName;
  String? _routingKey;
  String? _messageType;
  String? _payload;
  String? _status;
  int? _priority;
  int? _retryCount;
  int? _maxRetries;
  DateTime? _nextRetryAt;
  DateTime? _processedAt;
  DateTime? _completedAt;
  DateTime? _failedAt;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _messageId = widget.item?.messageId?.toString();
    _queueName = widget.item?.queueName?.toString();
    _exchangeName = widget.item?.exchangeName?.toString();
    _routingKey = widget.item?.routingKey?.toString();
    _messageType = widget.item?.messageType?.toString();
    _payload = widget.item?.payload?.toString();
    _status = widget.item?.status?.toString();
    _priority = widget.item?.priority;
    _retryCount = widget.item?.retryCount;
    _maxRetries = widget.item?.maxRetries;
    _nextRetryAt = widget.item?.nextRetryAt;
    _processedAt = widget.item?.processedAt;
    _completedAt = widget.item?.completedAt;
    _failedAt = widget.item?.failedAt;
    _errorMessage = widget.item?.errorMessage?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_messageId?.isNotEmpty == true) 'messageId': _messageId,
        if (_queueName?.isNotEmpty == true) 'queueName': _queueName,
        if (_exchangeName?.isNotEmpty == true) 'exchangeName': _exchangeName,
        if (_routingKey?.isNotEmpty == true) 'routingKey': _routingKey,
        if (_messageType?.isNotEmpty == true) 'messageType': _messageType,
        if (_payload?.isNotEmpty == true) 'payload': _payload,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_priority != null) 'priority': _priority,
        if (_retryCount != null) 'retryCount': _retryCount,
        if (_maxRetries != null) 'maxRetries': _maxRetries,
        if (_nextRetryAt != null) 'nextRetryAt': _nextRetryAt!.toIso8601String(),
        if (_processedAt != null) 'processedAt': _processedAt!.toIso8601String(),
        if (_completedAt != null) 'completedAt': _completedAt!.toIso8601String(),
        if (_failedAt != null) 'failedAt': _failedAt!.toIso8601String(),
        if (_errorMessage?.isNotEmpty == true) 'errorMessage': _errorMessage,
    };
    final result = widget.item != null
        ? QueueMessage.fromJson({...widget.item!.toJson(), ...data})
        : QueueMessage.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Message Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _messageId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Queue Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _queueName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Exchange Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _exchangeName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Routing Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _routingKey = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _messageType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payload', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _payload = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Priority', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _priority = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Retry Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _retryCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Retries', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxRetries = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _nextRetryAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _nextRetryAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Next Retry At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_nextRetryAt != null ? _fmt(_nextRetryAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _processedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _processedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Processed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_processedAt != null ? _fmt(_processedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _completedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _completedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Completed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_completedAt != null ? _fmt(_completedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _failedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _failedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Failed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_failedAt != null ? _fmt(_failedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Error Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _errorMessage = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Queue Message'),
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