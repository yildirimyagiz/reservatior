import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MlsDataMappingFormWidget extends ConsumerStatefulWidget {
  final MlsDataMapping? item;
  final Function(MlsDataMapping) onSubmit;
  const MlsDataMappingFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<MlsDataMappingFormWidget> createState() =>
      _MlsDataMappingFormWidgetState();
}

class _MlsDataMappingFormWidgetState
    extends ConsumerState<MlsDataMappingFormWidget> {
  String? _fieldName;
  String? _standardField;
  String? _dataType;
  bool? _isRequired;
  @override
  void initState() {
    super.initState();
    _fieldName = widget.item?.fieldName;
    _standardField = widget.item?.standardField;
    _dataType = widget.item?.dataType;
    _isRequired = widget.item?.isRequired;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mlsdatamapping'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mlsdatamapping'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _fieldName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fieldname'.tr()),
              onChanged: (v) => _fieldName = v,
            ),
            TextFormField(
              initialValue: _standardField?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.standardfield'.tr()),
              onChanged: (v) => _standardField = v,
            ),
            TextFormField(
              initialValue: _dataType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.datatype'.tr()),
              onChanged: (v) => _dataType = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isrequired'.tr()),
              value: _isRequired ?? false,
              onChanged: (v) => setState(() => _isRequired = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_fieldName != null) 'fieldName': _fieldName,
                  if (_standardField != null) 'standardField': _standardField,
                  if (_dataType != null) 'dataType': _dataType,
                  'isRequired': _isRequired,
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
                  widget.onSubmit(MlsDataMapping.fromJson(json));
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
