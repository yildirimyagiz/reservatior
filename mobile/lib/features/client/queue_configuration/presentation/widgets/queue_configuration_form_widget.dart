import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class QueueConfigurationFormWidget extends ConsumerStatefulWidget {
  final QueueConfiguration? item;
  final Function(QueueConfiguration) onSubmit;
  const QueueConfigurationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<QueueConfigurationFormWidget> createState() =>
      _QueueConfigurationFormWidgetState();
}

class _QueueConfigurationFormWidgetState
    extends ConsumerState<QueueConfigurationFormWidget> {
  String? _queueName;
  String? _exchangeName;
  String? _routingKey;
  String? _messageType;
  String? _handlerClas;
  int? _maxConcurrency;
  String? _deadLetterQueue;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _queueName = widget.item?.queueName;
    _exchangeName = widget.item?.exchangeName;
    _routingKey = widget.item?.routingKey;
    _messageType = widget.item?.messageType;
    _handlerClas = widget.item?.handlerClas;
    _maxConcurrency = widget.item?.maxConcurrency;
    _deadLetterQueue = widget.item?.deadLetterQueue;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.queueconfiguration'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.queueconfiguration'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
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
              initialValue: _handlerClas?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.handlerclas'.tr()),
              onChanged: (v) => _handlerClas = v,
            ),
            TextFormField(
              initialValue: _maxConcurrency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxconcurrency'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxConcurrency = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _deadLetterQueue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.deadletterqueue'.tr()),
              onChanged: (v) => _deadLetterQueue = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_queueName != null) 'queueName': _queueName,
                  if (_exchangeName != null) 'exchangeName': _exchangeName,
                  if (_routingKey != null) 'routingKey': _routingKey,
                  if (_messageType != null) 'messageType': _messageType,
                  if (_handlerClas != null) 'handlerClas': _handlerClas,
                  if (_maxConcurrency != null)
                    'maxConcurrency': _maxConcurrency,
                  if (_deadLetterQueue != null)
                    'deadLetterQueue': _deadLetterQueue,
                  'isActive': _isActive,
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
                  widget.onSubmit(QueueConfiguration.fromJson(json));
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
