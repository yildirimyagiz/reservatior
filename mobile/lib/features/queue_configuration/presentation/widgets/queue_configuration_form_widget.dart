import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── QueueConfiguration Form Widget  |  Fields: queueName, exchangeName, routingKey, messageType, handlerClass, maxConcurrency, retryPolicy, deadLetterQueue, isActive

class QueueConfigurationFormWidget extends StatefulWidget {
  final QueueConfiguration? item;
  final void Function(QueueConfiguration)? onSubmit;
  const QueueConfigurationFormWidget({super.key, this.item, this.onSubmit});
  @override State<QueueConfigurationFormWidget> createState() => _QueueConfigurationFormWidgetState();
}

class _QueueConfigurationFormWidgetState extends State<QueueConfigurationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _queueName;
  String? _exchangeName;
  String? _routingKey;
  String? _messageType;
  String? _handlerClass;
  int? _maxConcurrency;
  String? _retryPolicy;
  String? _deadLetterQueue;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _queueName = widget.item?.queueName?.toString();
    _exchangeName = widget.item?.exchangeName?.toString();
    _routingKey = widget.item?.routingKey?.toString();
    _messageType = widget.item?.messageType?.toString();
    _handlerClass = widget.item?.handlerClass?.toString();
    _maxConcurrency = widget.item?.maxConcurrency;
    _retryPolicy = widget.item?.retryPolicy?.toString();
    _deadLetterQueue = widget.item?.deadLetterQueue?.toString();
    _isActive = widget.item?.isActive ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_queueName?.isNotEmpty == true) 'queueName': _queueName,
        if (_exchangeName?.isNotEmpty == true) 'exchangeName': _exchangeName,
        if (_routingKey?.isNotEmpty == true) 'routingKey': _routingKey,
        if (_messageType?.isNotEmpty == true) 'messageType': _messageType,
        if (_handlerClass?.isNotEmpty == true) 'handlerClass': _handlerClass,
        if (_maxConcurrency != null) 'maxConcurrency': _maxConcurrency,
        if (_retryPolicy?.isNotEmpty == true) 'retryPolicy': _retryPolicy,
        if (_deadLetterQueue?.isNotEmpty == true) 'deadLetterQueue': _deadLetterQueue,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? QueueConfiguration.fromJson({...widget.item!.toJson(), ...data})
        : QueueConfiguration.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Handler Class', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _handlerClass = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Concurrency', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxConcurrency = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Retry Policy', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _retryPolicy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dead Letter Queue', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _deadLetterQueue = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Queue Configuration'),
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