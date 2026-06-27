import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ExportFileFormWidget extends ConsumerStatefulWidget {
  final ExportFile? item;
  final Function(ExportFile) onSubmit;
  const ExportFileFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ExportFileFormWidget> createState() =>
      _ExportFileFormWidgetState();
}

class _ExportFileFormWidgetState extends ConsumerState<ExportFileFormWidget> {
  String? _exportJobId;
  String? _fileName;
  String? _storageKey;
  String? _mimeType;
  int? _sizeBytes;
  @override
  void initState() {
    super.initState();
    _exportJobId = widget.item?.exportJobId;
    _fileName = widget.item?.fileName;
    _storageKey = widget.item?.storageKey;
    _mimeType = widget.item?.mimeType;
    _sizeBytes = widget.item?.sizeBytes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.exportfile'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.exportfile'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _exportJobId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.exportjobid'.tr()),
              onChanged: (v) => _exportJobId = v,
            ),
            TextFormField(
              initialValue: _fileName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.filename'.tr()),
              onChanged: (v) => _fileName = v,
            ),
            TextFormField(
              initialValue: _storageKey?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.storagekey'.tr()),
              onChanged: (v) => _storageKey = v,
            ),
            TextFormField(
              initialValue: _mimeType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mimetype'.tr()),
              onChanged: (v) => _mimeType = v,
            ),
            TextFormField(
              initialValue: _sizeBytes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sizebytes'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _sizeBytes = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_exportJobId != null) 'exportJobId': _exportJobId,
                  if (_fileName != null) 'fileName': _fileName,
                  if (_storageKey != null) 'storageKey': _storageKey,
                  if (_mimeType != null) 'mimeType': _mimeType,
                  if (_sizeBytes != null) 'sizeBytes': _sizeBytes,
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
                  widget.onSubmit(ExportFile.fromJson(json));
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
