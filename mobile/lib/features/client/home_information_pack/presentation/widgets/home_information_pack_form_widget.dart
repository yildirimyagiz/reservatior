import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeInformationPackFormWidget extends ConsumerStatefulWidget {
  final HomeInformationPack? item;
  final Function(HomeInformationPack) onSubmit;
  const HomeInformationPackFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<HomeInformationPackFormWidget> createState() =>
      _HomeInformationPackFormWidgetState();
}

class _HomeInformationPackFormWidgetState
    extends ConsumerState<HomeInformationPackFormWidget> {
  String? _propertyId;
  String? _title;
  String? _description;
  String? _fileUrl;
  String? _fileName;
  int? _fileSize;
  String? _mimeType;
  String? _checksum;
  int? _version;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _fileUrl = widget.item?.fileUrl;
    _fileName = widget.item?.fileName;
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType;
    _checksum = widget.item?.checksum;
    _version = widget.item?.version;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.homeinformationpack'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.homeinformationpack'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _fileUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fileurl'.tr()),
              onChanged: (v) => _fileUrl = v,
            ),
            TextFormField(
              initialValue: _fileName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.filename'.tr()),
              onChanged: (v) => _fileName = v,
            ),
            TextFormField(
              initialValue: _fileSize?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.filesize'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _fileSize = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _mimeType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mimetype'.tr()),
              onChanged: (v) => _mimeType = v,
            ),
            TextFormField(
              initialValue: _checksum?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checksum'.tr()),
              onChanged: (v) => _checksum = v,
            ),
            TextFormField(
              initialValue: _version?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.version'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _version = int.tryParse(v ?? ""),
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
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_fileUrl != null) 'fileUrl': _fileUrl,
                  if (_fileName != null) 'fileName': _fileName,
                  if (_fileSize != null) 'fileSize': _fileSize,
                  if (_mimeType != null) 'mimeType': _mimeType,
                  if (_checksum != null) 'checksum': _checksum,
                  if (_version != null) 'version': _version,
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
                  widget.onSubmit(HomeInformationPack.fromJson(json));
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
