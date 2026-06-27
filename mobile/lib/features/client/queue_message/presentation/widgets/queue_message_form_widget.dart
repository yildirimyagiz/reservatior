import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class QueueMessageFormWidget extends ConsumerStatefulWidget {
  final QueueMessage? item;
  final Function(QueueMessage) onSubmit;
  const QueueMessageFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<QueueMessageFormWidget> createState() =>
      _QueueMessageFormWidgetState();
}

class _QueueMessageFormWidgetState
    extends ConsumerState<QueueMessageFormWidget> {
  String? _messageId;
  String? _queueName;
  String? _exchangeName;
  String? _routingKey;
  String? _messageType;
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
    _messageId = widget.item?.messageId;
    _queueName = widget.item?.queueName;
    _exchangeName = widget.item?.exchangeName;
    _routingKey = widget.item?.routingKey;
    _messageType = widget.item?.messageType;
    _status = widget.item?.status;
    _priority = widget.item?.priority;
    _retryCount = widget.item?.retryCount;
    _maxRetries = widget.item?.maxRetries;
    _nextRetryAt = widget.item?.nextRetryAt;
    _processedAt = widget.item?.processedAt;
    _completedAt = widget.item?.completedAt;
    _failedAt = widget.item?.failedAt;
    _errorMessage = widget.item?.errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.queuemessage'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.queuemessage'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _messageId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.messageid'.tr()),
              onChanged: (v) => _messageId = v,
            ),
            TextFormField(
              initialValue: _queueName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.queuename'.tr()),
              onChanged: (v) => _queueName = v,
            ),
            TextFormField(
              initialValue: _exchangeName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.exchangename'.tr()),
              onChanged: (v) => _exchangeName = v,
            ),
            TextFormField(
              initialValue: _routingKey?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.routingkey'.tr()),
              onChanged: (v) => _routingKey = v,
            ),
            TextFormField(
              initialValue: _messageType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.messagetype'.tr()),
              onChanged: (v) => _messageType = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _priority?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.priority'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _priority = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _retryCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.retrycount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _retryCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxRetries?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxretries'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxRetries = int.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_next_retry_at'.tr()}: ${_nextRetryAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _nextRetryAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _nextRetryAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_processed_at'.tr()}: ${_processedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _processedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _processedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_completed_at'.tr()}: ${_completedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _completedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _completedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_failed_at'.tr()}: ${_failedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _failedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _failedAt = d);
              },
            ),
            TextFormField(
              initialValue: _errorMessage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.errormessage'.tr()),
              onChanged: (v) => _errorMessage = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_messageId != null) 'messageId': _messageId,
                  if (_queueName != null) 'queueName': _queueName,
                  if (_exchangeName != null) 'exchangeName': _exchangeName,
                  if (_routingKey != null) 'routingKey': _routingKey,
                  if (_messageType != null) 'messageType': _messageType,
                  if (_status != null) 'status': _status,
                  if (_priority != null) 'priority': _priority,
                  if (_retryCount != null) 'retryCount': _retryCount,
                  if (_maxRetries != null) 'maxRetries': _maxRetries,
                  if (_nextRetryAt != null)
                    'nextRetryAt': _nextRetryAt!.toIso8601String(),
                  if (_processedAt != null)
                    'processedAt': _processedAt!.toIso8601String(),
                  if (_completedAt != null)
                    'completedAt': _completedAt!.toIso8601String(),
                  if (_failedAt != null)
                    'failedAt': _failedAt!.toIso8601String(),
                  if (_errorMessage != null) 'errorMessage': _errorMessage,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(QueueMessage.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
