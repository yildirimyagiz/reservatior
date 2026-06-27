import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AttachmentFormWidget extends ConsumerStatefulWidget {
  final Attachment? item;
  final Function(Attachment) onSubmit;
  const AttachmentFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AttachmentFormWidget> createState() =>
      _AttachmentFormWidgetState();
}

class _AttachmentFormWidgetState extends ConsumerState<AttachmentFormWidget> {
  String? _propertyId;
  String? _entityType;
  String? _entityId;
  String? _fileName;
  String? _mimeType;
  int? _sizeBytes;
  String? _storageKey;
  String? _url;
  String? _checksum;
  String? _transactionId;
  String? _taskId;
  String? _messageId;
  String? _propertyComplianceId;
  String? _reviewId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _entityType = widget.item?.entityType;
    _entityId = widget.item?.entityId;
    _fileName = widget.item?.fileName;
    _mimeType = widget.item?.mimeType;
    _sizeBytes = widget.item?.sizeBytes;
    _storageKey = widget.item?.storageKey;
    _url = widget.item?.url;
    _checksum = widget.item?.checksum;
    _transactionId = widget.item?.transactionId;
    _taskId = widget.item?.taskId;
    _messageId = widget.item?.messageId;
    _propertyComplianceId = widget.item?.propertyComplianceId;
    _reviewId = widget.item?.reviewId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.attachment'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.attachment'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _entityType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entitytype'.tr()),
              onChanged: (v) => _entityType = v,
            ),
            TextFormField(
              initialValue: _entityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entityid'.tr()),
              onChanged: (v) => _entityId = v,
            ),
            TextFormField(
              initialValue: _fileName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.filename'.tr()),
              onChanged: (v) => _fileName = v,
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
            TextFormField(
              initialValue: _storageKey?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.storagekey'.tr()),
              onChanged: (v) => _storageKey = v,
            ),
            TextFormField(
              initialValue: _url?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.url'.tr()),
              onChanged: (v) => _url = v,
            ),
            TextFormField(
              initialValue: _checksum?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checksum'.tr()),
              onChanged: (v) => _checksum = v,
            ),
            TextFormField(
              initialValue: _transactionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.transactionid'.tr()),
              onChanged: (v) => _transactionId = v,
            ),
            TextFormField(
              initialValue: _taskId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taskid'.tr()),
              onChanged: (v) => _taskId = v,
            ),
            TextFormField(
              initialValue: _messageId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.messageid'.tr()),
              onChanged: (v) => _messageId = v,
            ),
            TextFormField(
              initialValue: _propertyComplianceId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.propertycomplianceid'.tr(),
              ),
              onChanged: (v) => _propertyComplianceId = v,
            ),
            TextFormField(
              initialValue: _reviewId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reviewid'.tr()),
              onChanged: (v) => _reviewId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_entityType != null) 'entityType': _entityType,
                  if (_entityId != null) 'entityId': _entityId,
                  if (_fileName != null) 'fileName': _fileName,
                  if (_mimeType != null) 'mimeType': _mimeType,
                  if (_sizeBytes != null) 'sizeBytes': _sizeBytes,
                  if (_storageKey != null) 'storageKey': _storageKey,
                  if (_url != null) 'url': _url,
                  if (_checksum != null) 'checksum': _checksum,
                  if (_transactionId != null) 'transactionId': _transactionId,
                  if (_taskId != null) 'taskId': _taskId,
                  if (_messageId != null) 'messageId': _messageId,
                  if (_propertyComplianceId != null)
                    'propertyComplianceId': _propertyComplianceId,
                  if (_reviewId != null) 'reviewId': _reviewId,
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
                  widget.onSubmit(Attachment.fromJson(json));
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
