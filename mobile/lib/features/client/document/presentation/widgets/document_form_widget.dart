import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class DocumentFormWidget extends ConsumerStatefulWidget {
  final Document? item;
  final Function(Document) onSubmit;
  const DocumentFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<DocumentFormWidget> createState() => _DocumentFormWidgetState();
}

class _DocumentFormWidgetState extends ConsumerState<DocumentFormWidget> {
  String? _dealId;
  String? _propertyId;
  String? _contractId;
  String? _userId;
  String? _listingId;
  String? _title;
  String? _description;
  String? _fileUrl;
  String? _fileName;
  int? _fileSize;
  String? _mimeType;
  String? _checksum;
  int? _version;
  bool? _isRequired;
  bool? _isSigned;
  bool? _signatureRequired;
  bool? _notarizationRequired;
  bool? _recordingRequired;
  DateTime? _expiryDate;
  String? _jurisdiction;
  String? _templateId;
  String? _analysisStatus;
  DateTime? _lastAnalyzedAt;
  String? _analysisJobId;
  String? _searchVector;
  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId;
    _propertyId = widget.item?.propertyId;
    _contractId = widget.item?.contractId;
    _userId = widget.item?.userId;
    _listingId = widget.item?.listingId;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _fileUrl = widget.item?.fileUrl;
    _fileName = widget.item?.fileName;
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType;
    _checksum = widget.item?.checksum;
    _version = widget.item?.version;
    _isRequired = widget.item?.isRequired;
    _isSigned = widget.item?.isSigned;
    _signatureRequired = widget.item?.signatureRequired;
    _notarizationRequired = widget.item?.notarizationRequired;
    _recordingRequired = widget.item?.recordingRequired;
    _expiryDate = widget.item?.expiryDate;
    _jurisdiction = widget.item?.jurisdiction;
    _templateId = widget.item?.templateId;
    _analysisStatus = widget.item?.analysisStatus;
    _lastAnalyzedAt = widget.item?.lastAnalyzedAt;
    _analysisJobId = widget.item?.analysisJobId;
    _searchVector = widget.item?.searchVector;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.document'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.document'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _dealId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dealid'.tr()),
              onChanged: (v) => _dealId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _contractId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contractid'.tr()),
              onChanged: (v) => _contractId = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
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
              title: Text('mobile.auto.isrequired'.tr()),
              value: _isRequired ?? false,
              onChanged: (v) => setState(() => _isRequired = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.issigned'.tr()),
              value: _isSigned ?? false,
              onChanged: (v) => setState(() => _isSigned = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.signaturerequired'.tr()),
              value: _signatureRequired ?? false,
              onChanged: (v) => setState(() => _signatureRequired = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.notarizationrequired'.tr()),
              value: _notarizationRequired ?? false,
              onChanged: (v) => setState(() => _notarizationRequired = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.recordingrequired'.tr()),
              value: _recordingRequired ?? false,
              onChanged: (v) => setState(() => _recordingRequired = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expiry_date'.tr()}: ${_expiryDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiryDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiryDate = d);
              },
            ),
            TextFormField(
              initialValue: _jurisdiction?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.jurisdiction'.tr()),
              onChanged: (v) => _jurisdiction = v,
            ),
            TextFormField(
              initialValue: _templateId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.templateid'.tr()),
              onChanged: (v) => _templateId = v,
            ),
            TextFormField(
              initialValue: _analysisStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.analysisstatus'.tr()),
              onChanged: (v) => _analysisStatus = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_analyzed_at'.tr()}: ${_lastAnalyzedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastAnalyzedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastAnalyzedAt = d);
              },
            ),
            TextFormField(
              initialValue: _analysisJobId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.analysisjobid'.tr()),
              onChanged: (v) => _analysisJobId = v,
            ),
            TextFormField(
              initialValue: _searchVector?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.searchvector'.tr()),
              onChanged: (v) => _searchVector = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_dealId != null) 'dealId': _dealId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_contractId != null) 'contractId': _contractId,
                  if (_userId != null) 'userId': _userId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_fileUrl != null) 'fileUrl': _fileUrl,
                  if (_fileName != null) 'fileName': _fileName,
                  if (_fileSize != null) 'fileSize': _fileSize,
                  if (_mimeType != null) 'mimeType': _mimeType,
                  if (_checksum != null) 'checksum': _checksum,
                  if (_version != null) 'version': _version,
                  'isRequired': _isRequired,
                  'isSigned': _isSigned,
                  'signatureRequired': _signatureRequired,
                  'notarizationRequired': _notarizationRequired,
                  'recordingRequired': _recordingRequired,
                  if (_expiryDate != null)
                    'expiryDate': _expiryDate!.toIso8601String(),
                  if (_jurisdiction != null) 'jurisdiction': _jurisdiction,
                  if (_templateId != null) 'templateId': _templateId,
                  if (_analysisStatus != null)
                    'analysisStatus': _analysisStatus,
                  if (_lastAnalyzedAt != null)
                    'lastAnalyzedAt': _lastAnalyzedAt!.toIso8601String(),
                  if (_analysisJobId != null) 'analysisJobId': _analysisJobId,
                  if (_searchVector != null) 'searchVector': _searchVector,
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
                  widget.onSubmit(Document.fromJson(json));
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
