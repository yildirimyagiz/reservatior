import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiValuationModelFormWidget extends ConsumerStatefulWidget {
  final AiValuationModel? item;
  final Function(AiValuationModel) onSubmit;
  const AiValuationModelFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiValuationModelFormWidget> createState() =>
      _AiValuationModelFormWidgetState();
}

class _AiValuationModelFormWidgetState
    extends ConsumerState<AiValuationModelFormWidget> {
  String? _modelName;
  String? _modelVersion;
  double? _accuracy;
  DateTime? _lastTrainedAt;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _modelName = widget.item?.modelName;
    _modelVersion = widget.item?.modelVersion;
    _accuracy = widget.item?.accuracy;
    _lastTrainedAt = widget.item?.lastTrainedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aivaluationmodel'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aivaluationmodel'.tr()}",
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
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_modelName != null) 'modelName': _modelName,
                  if (_modelVersion != null) 'modelVersion': _modelVersion,
                  if (_accuracy != null) 'accuracy': _accuracy,
                  if (_lastTrainedAt != null)
                    'lastTrainedAt': _lastTrainedAt!.toIso8601String(),
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
                  widget.onSubmit(AiValuationModel.fromJson(json));
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
