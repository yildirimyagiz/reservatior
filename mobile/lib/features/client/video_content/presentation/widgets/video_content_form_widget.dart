import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class VideoContentFormWidget extends ConsumerStatefulWidget {
  final VideoContent? item;
  final Function(VideoContent) onSubmit;
  const VideoContentFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<VideoContentFormWidget> createState() =>
      _VideoContentFormWidgetState();
}

class _VideoContentFormWidgetState
    extends ConsumerState<VideoContentFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _ambassadorId;
  String? _ambassadorCampaignId;
  String? _title;
  double? _primaryLoraScale;
  double? _secondaryLoraScale;
  String? _prompt;
  String? _negativePrompt;
  int? _durationSeconds;
  String? _renderingJobId;
  String? _storageKey;
  String? _url;
  String? _thumbnailUrl;
  int? _fileSize;
  String? _mimeType;
  DateTime? _publishedAt;
  String? _abTestGroup;
  String? _campaignId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _ambassadorId = widget.item?.ambassadorId;
    _ambassadorCampaignId = widget.item?.ambassadorCampaignId;
    _title = widget.item?.title;
    _primaryLoraScale = widget.item?.primaryLoraScale;
    _secondaryLoraScale = widget.item?.secondaryLoraScale;
    _prompt = widget.item?.prompt;
    _negativePrompt = widget.item?.negativePrompt;
    _durationSeconds = widget.item?.durationSeconds;
    _renderingJobId = widget.item?.renderingJobId;
    _storageKey = widget.item?.storageKey;
    _url = widget.item?.url;
    _thumbnailUrl = widget.item?.thumbnailUrl;
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType;
    _publishedAt = widget.item?.publishedAt;
    _abTestGroup = widget.item?.abTestGroup;
    _campaignId = widget.item?.campaignId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.videocontent'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.videocontent'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _ambassadorId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ambassadorid'.tr()),
              onChanged: (v) => _ambassadorId = v,
            ),
            TextFormField(
              initialValue: _ambassadorCampaignId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.ambassadorcampaignid'.tr(),
              ),
              onChanged: (v) => _ambassadorCampaignId = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _primaryLoraScale?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.primarylorascale'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _primaryLoraScale = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _secondaryLoraScale?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.secondarylorascale'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _secondaryLoraScale = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _prompt?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.prompt'.tr()),
              onChanged: (v) => _prompt = v,
            ),
            TextFormField(
              initialValue: _negativePrompt?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.negativeprompt'.tr()),
              onChanged: (v) => _negativePrompt = v,
            ),
            TextFormField(
              initialValue: _durationSeconds?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.durationseconds'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _durationSeconds = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _renderingJobId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.renderingjobid'.tr()),
              onChanged: (v) => _renderingJobId = v,
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
              initialValue: _thumbnailUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.thumbnailurl'.tr()),
              onChanged: (v) => _thumbnailUrl = v,
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
            ListTile(
              title: Text("${'mobile.admin.field_published_at'.tr()}: ${_publishedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _publishedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _publishedAt = d);
              },
            ),
            TextFormField(
              initialValue: _abTestGroup?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.abtestgroup'.tr()),
              onChanged: (v) => _abTestGroup = v,
            ),
            TextFormField(
              initialValue: _campaignId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.campaignid'.tr()),
              onChanged: (v) => _campaignId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_ambassadorId != null) 'ambassadorId': _ambassadorId,
                  if (_ambassadorCampaignId != null)
                    'ambassadorCampaignId': _ambassadorCampaignId,
                  if (_title != null) 'title': _title,
                  if (_primaryLoraScale != null)
                    'primaryLoraScale': _primaryLoraScale,
                  if (_secondaryLoraScale != null)
                    'secondaryLoraScale': _secondaryLoraScale,
                  if (_prompt != null) 'prompt': _prompt,
                  if (_negativePrompt != null)
                    'negativePrompt': _negativePrompt,
                  if (_durationSeconds != null)
                    'durationSeconds': _durationSeconds,
                  if (_renderingJobId != null)
                    'renderingJobId': _renderingJobId,
                  if (_storageKey != null) 'storageKey': _storageKey,
                  if (_url != null) 'url': _url,
                  if (_thumbnailUrl != null) 'thumbnailUrl': _thumbnailUrl,
                  if (_fileSize != null) 'fileSize': _fileSize,
                  if (_mimeType != null) 'mimeType': _mimeType,
                  if (_publishedAt != null)
                    'publishedAt': _publishedAt!.toIso8601String(),
                  if (_abTestGroup != null) 'abTestGroup': _abTestGroup,
                  if (_campaignId != null) 'campaignId': _campaignId,
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
                  widget.onSubmit(VideoContent.fromJson(json));
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
