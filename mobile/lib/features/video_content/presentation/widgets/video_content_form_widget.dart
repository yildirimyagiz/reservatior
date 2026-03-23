import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── VideoContent Form Widget  |  Fields: propertyId, listingId, ambassadorId, ambassadorCampaignId, title, primaryLoraStyle, secondaryLoraStyle, primaryLoraScale, secondaryLoraScale, pipeline, prompt, negativePrompt, strategy, durationSeconds, platform, status, renderingJobId, storageKey, url, thumbnailUrl, fileSize, mimeType, publishedAt, engagementData, campaignType, abTestGroup, campaignId

class VideoContentFormWidget extends StatefulWidget {
  final VideoContent? item;
  final void Function(VideoContent)? onSubmit;
  const VideoContentFormWidget({super.key, this.item, this.onSubmit});
  @override State<VideoContentFormWidget> createState() => _VideoContentFormWidgetState();
}

class _VideoContentFormWidgetState extends State<VideoContentFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _listingId;
  String? _ambassadorId;
  String? _ambassadorCampaignId;
  String? _title;
  String? _primaryLoraStyle;
  String? _secondaryLoraStyle;
  double? _primaryLoraScale;
  double? _secondaryLoraScale;
  String? _pipeline;
  String? _prompt;
  String? _negativePrompt;
  String? _strategy;
  int? _durationSeconds;
  String? _platform;
  String? _status;
  String? _renderingJobId;
  String? _storageKey;
  String? _url;
  String? _thumbnailUrl;
  int? _fileSize;
  String? _mimeType;
  DateTime? _publishedAt;
  String? _engagementData;
  String? _campaignType;
  String? _abTestGroup;
  String? _campaignId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _ambassadorId = widget.item?.ambassadorId?.toString();
    _ambassadorCampaignId = widget.item?.ambassadorCampaignId?.toString();
    _title = widget.item?.title?.toString();
    _primaryLoraStyle = widget.item?.primaryLoraStyle?.toString();
    _secondaryLoraStyle = widget.item?.secondaryLoraStyle?.toString();
    _primaryLoraScale = widget.item?.primaryLoraScale;
    _secondaryLoraScale = widget.item?.secondaryLoraScale;
    _pipeline = widget.item?.pipeline?.toString();
    _prompt = widget.item?.prompt?.toString();
    _negativePrompt = widget.item?.negativePrompt?.toString();
    _strategy = widget.item?.strategy?.toString();
    _durationSeconds = widget.item?.durationSeconds;
    _platform = widget.item?.platform?.toString();
    _status = widget.item?.status?.toString();
    _renderingJobId = widget.item?.renderingJobId?.toString();
    _storageKey = widget.item?.storageKey?.toString();
    _url = widget.item?.url?.toString();
    _thumbnailUrl = widget.item?.thumbnailUrl?.toString();
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType?.toString();
    _publishedAt = widget.item?.publishedAt;
    _engagementData = widget.item?.engagementData?.toString();
    _campaignType = widget.item?.campaignType?.toString();
    _abTestGroup = widget.item?.abTestGroup?.toString();
    _campaignId = widget.item?.campaignId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_ambassadorId?.isNotEmpty == true) 'ambassadorId': _ambassadorId,
        if (_ambassadorCampaignId?.isNotEmpty == true) 'ambassadorCampaignId': _ambassadorCampaignId,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_primaryLoraStyle?.isNotEmpty == true) 'primaryLoraStyle': _primaryLoraStyle,
        if (_secondaryLoraStyle?.isNotEmpty == true) 'secondaryLoraStyle': _secondaryLoraStyle,
        if (_primaryLoraScale != null) 'primaryLoraScale': _primaryLoraScale,
        if (_secondaryLoraScale != null) 'secondaryLoraScale': _secondaryLoraScale,
        if (_pipeline?.isNotEmpty == true) 'pipeline': _pipeline,
        if (_prompt?.isNotEmpty == true) 'prompt': _prompt,
        if (_negativePrompt?.isNotEmpty == true) 'negativePrompt': _negativePrompt,
        if (_strategy?.isNotEmpty == true) 'strategy': _strategy,
        if (_durationSeconds != null) 'durationSeconds': _durationSeconds,
        if (_platform?.isNotEmpty == true) 'platform': _platform,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_renderingJobId?.isNotEmpty == true) 'renderingJobId': _renderingJobId,
        if (_storageKey?.isNotEmpty == true) 'storageKey': _storageKey,
        if (_url?.isNotEmpty == true) 'url': _url,
        if (_thumbnailUrl?.isNotEmpty == true) 'thumbnailUrl': _thumbnailUrl,
        if (_fileSize != null) 'fileSize': _fileSize,
        if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
        if (_publishedAt != null) 'publishedAt': _publishedAt!.toIso8601String(),
        if (_engagementData?.isNotEmpty == true) 'engagementData': _engagementData,
        if (_campaignType?.isNotEmpty == true) 'campaignType': _campaignType,
        if (_abTestGroup?.isNotEmpty == true) 'abTestGroup': _abTestGroup,
        if (_campaignId?.isNotEmpty == true) 'campaignId': _campaignId,
    };
    final result = widget.item != null
        ? VideoContent.fromJson({...widget.item!.toJson(), ...data})
        : VideoContent.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ambassador Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _ambassadorId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ambassador Campaign Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _ambassadorCampaignId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Primary Lora Style', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _primaryLoraStyle = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Secondary Lora Style', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _secondaryLoraStyle = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Primary Lora Scale', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _primaryLoraScale = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Secondary Lora Scale', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _secondaryLoraScale = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pipeline', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _pipeline = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prompt', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _prompt = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Negative Prompt', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _negativePrompt = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Strategy', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                onSaved: (v) => _strategy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration Seconds', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _durationSeconds = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Platform', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _platform = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rendering Job Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _renderingJobId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Storage Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _storageKey = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _url = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Thumbnail Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _thumbnailUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'File Size', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _fileSize = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mime Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mimeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _publishedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _publishedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Published At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_publishedAt != null ? _fmt(_publishedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Engagement Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _engagementData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Campaign Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _campaignType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ab Test Group', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _abTestGroup = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Campaign Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _campaignId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Video Content'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}