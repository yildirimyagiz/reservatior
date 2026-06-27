import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiModelFormWidget extends ConsumerStatefulWidget {
  final AiModel? item;
  final Function(AiModel) onSubmit;
  const AiModelFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AiModelFormWidget> createState() => _AiModelFormWidgetState();
}

class _AiModelFormWidgetState extends ConsumerState<AiModelFormWidget> {
  String? _modelName;
  String? _modelVersion;
  String? _modelType;
  String? _provider;
  String? _endpointUrl;
  String? _apiKey;
  String? _status;
  double? _accuracy;
  DateTime? _lastTrainedAt;
  @override
  void initState() {
    super.initState();
    _modelName = widget.item?.modelName;
    _modelVersion = widget.item?.modelVersion;
    _modelType = widget.item?.modelType;
    _provider = widget.item?.provider;
    _endpointUrl = widget.item?.endpointUrl;
    _apiKey = widget.item?.apiKey;
    _status = widget.item?.status;
    _accuracy = widget.item?.accuracy;
    _lastTrainedAt = widget.item?.lastTrainedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aimodel'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aimodel'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _modelName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modelname'.tr()),
              onChanged: (v) => _modelName = v,
            ),
            TextFormField(
              initialValue: _modelVersion?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modelversion'.tr()),
              onChanged: (v) => _modelVersion = v,
            ),
            TextFormField(
              initialValue: _modelType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modeltype'.tr()),
              onChanged: (v) => _modelType = v,
            ),
            TextFormField(
              initialValue: _provider?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.provider'.tr()),
              onChanged: (v) => _provider = v,
            ),
            TextFormField(
              initialValue: _endpointUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.endpointurl'.tr()),
              onChanged: (v) => _endpointUrl = v,
            ),
            TextFormField(
              initialValue: _apiKey?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.apikey'.tr()),
              onChanged: (v) => _apiKey = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _accuracy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.accuracy'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _accuracy = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_trained_at'.tr()}: ${_lastTrainedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastTrainedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastTrainedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_modelName != null) 'modelName': _modelName,
                  if (_modelVersion != null) 'modelVersion': _modelVersion,
                  if (_modelType != null) 'modelType': _modelType,
                  if (_provider != null) 'provider': _provider,
                  if (_endpointUrl != null) 'endpointUrl': _endpointUrl,
                  if (_apiKey != null) 'apiKey': _apiKey,
                  if (_status != null) 'status': _status,
                  if (_accuracy != null) 'accuracy': _accuracy,
                  if (_lastTrainedAt != null)
                    'lastTrainedAt': _lastTrainedAt!.toIso8601String(),
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
                  widget.onSubmit(AiModel.fromJson(json));
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
