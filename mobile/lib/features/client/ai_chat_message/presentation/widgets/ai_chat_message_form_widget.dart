import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiChatMessageFormWidget extends ConsumerStatefulWidget {
  final AiChatMessage? item;
  final Function(AiChatMessage) onSubmit;
  const AiChatMessageFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AiChatMessageFormWidget> createState() =>
      _AiChatMessageFormWidgetState();
}

class _AiChatMessageFormWidgetState
    extends ConsumerState<AiChatMessageFormWidget> {
  String? _sessionId;
  String? _listingId;
  String? _reservationId;
  String? _content;
  String? _contentHash;
  String? _redactedContent;
  bool? _piiDetected;
  String? _language;
  bool? _isAI;
  String? _escalationTag;
  String? _escalationTopic;
  bool? _paymentAgreed;
  bool? _securityFlag;
  String? _securityReason;
  int? _tokenCount;
  int? _processingMs;
  @override
  void initState() {
    super.initState();
    _sessionId = widget.item?.sessionId;
    _listingId = widget.item?.listingId;
    _reservationId = widget.item?.reservationId;
    _content = widget.item?.content;
    _contentHash = widget.item?.contentHash;
    _redactedContent = widget.item?.redactedContent;
    _piiDetected = widget.item?.piiDetected;
    _language = widget.item?.language;
    _isAI = widget.item?.isAI;
    _escalationTag = widget.item?.escalationTag;
    _escalationTopic = widget.item?.escalationTopic;
    _paymentAgreed = widget.item?.paymentAgreed;
    _securityFlag = widget.item?.securityFlag;
    _securityReason = widget.item?.securityReason;
    _tokenCount = widget.item?.tokenCount;
    _processingMs = widget.item?.processingMs;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aichatmessage'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aichatmessage'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _sessionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sessionid'.tr()),
              onChanged: (v) => _sessionId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _content?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.content'.tr()),
              onChanged: (v) => _content = v,
            ),
            TextFormField(
              initialValue: _contentHash?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contenthash'.tr()),
              onChanged: (v) => _contentHash = v,
            ),
            TextFormField(
              initialValue: _redactedContent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.redactedcontent'.tr()),
              onChanged: (v) => _redactedContent = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.piidetected'.tr()),
              value: _piiDetected ?? false,
              onChanged: (v) => setState(() => _piiDetected = v),
            ),
            TextFormField(
              initialValue: _language?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.language'.tr()),
              onChanged: (v) => _language = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isai'.tr()),
              value: _isAI ?? false,
              onChanged: (v) => setState(() => _isAI = v),
            ),
            TextFormField(
              initialValue: _escalationTag?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.escalationtag'.tr()),
              onChanged: (v) => _escalationTag = v,
            ),
            TextFormField(
              initialValue: _escalationTopic?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.escalationtopic'.tr()),
              onChanged: (v) => _escalationTopic = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.paymentagreed'.tr()),
              value: _paymentAgreed ?? false,
              onChanged: (v) => setState(() => _paymentAgreed = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.securityflag'.tr()),
              value: _securityFlag ?? false,
              onChanged: (v) => setState(() => _securityFlag = v),
            ),
            TextFormField(
              initialValue: _securityReason?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.securityreason'.tr()),
              onChanged: (v) => _securityReason = v,
            ),
            TextFormField(
              initialValue: _tokenCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tokencount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _tokenCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _processingMs?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.processingms'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _processingMs = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_sessionId != null) 'sessionId': _sessionId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_content != null) 'content': _content,
                  if (_contentHash != null) 'contentHash': _contentHash,
                  if (_redactedContent != null)
                    'redactedContent': _redactedContent,
                  'piiDetected': _piiDetected,
                  if (_language != null) 'language': _language,
                  'isAI': _isAI,
                  if (_escalationTag != null) 'escalationTag': _escalationTag,
                  if (_escalationTopic != null)
                    'escalationTopic': _escalationTopic,
                  'paymentAgreed': _paymentAgreed,
                  'securityFlag': _securityFlag,
                  if (_securityReason != null)
                    'securityReason': _securityReason,
                  if (_tokenCount != null) 'tokenCount': _tokenCount,
                  if (_processingMs != null) 'processingMs': _processingMs,
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
                  widget.onSubmit(AiChatMessage.fromJson(json));
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
