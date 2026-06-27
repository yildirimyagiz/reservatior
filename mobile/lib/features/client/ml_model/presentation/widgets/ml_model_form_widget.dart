import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MlModelFormWidget extends ConsumerStatefulWidget {
  final MlModel? item;
  final Function(MlModel) onSubmit;
  const MlModelFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MlModelFormWidget> createState() => _MlModelFormWidgetState();
}

class _MlModelFormWidgetState extends ConsumerState<MlModelFormWidget> {
  String? _modelName;
  String? _modelType;
  String? _version;
  double? _accuracy;
  String? _modelPath;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _modelName = widget.item?.modelName;
    _modelType = widget.item?.modelType;
    _version = widget.item?.version;
    _accuracy = widget.item?.accuracy;
    _modelPath = widget.item?.modelPath;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mlmodel'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mlmodel'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _modelName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modelname'.tr()),
              onChanged: (v) => _modelName = v,
            ),
            TextFormField(
              initialValue: _modelType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modeltype'.tr()),
              onChanged: (v) => _modelType = v,
            ),
            TextFormField(
              initialValue: _version?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.version'.tr()),
              onChanged: (v) => _version = v,
            ),
            TextFormField(
              initialValue: _accuracy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.accuracy'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _accuracy = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _modelPath?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modelpath'.tr()),
              onChanged: (v) => _modelPath = v,
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
                  if (_modelType != null) 'modelType': _modelType,
                  if (_version != null) 'version': _version,
                  if (_accuracy != null) 'accuracy': _accuracy,
                  if (_modelPath != null) 'modelPath': _modelPath,
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
                  widget.onSubmit(MlModel.fromJson(json));
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
