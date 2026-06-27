import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiRecommendationFormWidget extends ConsumerStatefulWidget {
  final AiRecommendation? item;
  final Function(AiRecommendation) onSubmit;
  const AiRecommendationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiRecommendationFormWidget> createState() =>
      _AiRecommendationFormWidgetState();
}

class _AiRecommendationFormWidgetState
    extends ConsumerState<AiRecommendationFormWidget> {
  String? _userType;
  String? _userId;
  String? _sessionId;
  String? _recommendationType;
  DateTime? _generatedAt;
  DateTime? _expiresAt;
  @override
  void initState() {
    super.initState();
    _userType = widget.item?.userType;
    _userId = widget.item?.userId;
    _sessionId = widget.item?.sessionId;
    _recommendationType = widget.item?.recommendationType;
    _generatedAt = widget.item?.generatedAt;
    _expiresAt = widget.item?.expiresAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.airecommendation'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.airecommendation'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.usertype'.tr()),
              onChanged: (v) => _userType = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _sessionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sessionid'.tr()),
              onChanged: (v) => _sessionId = v,
            ),
            TextFormField(
              initialValue: _recommendationType?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.recommendationtype'.tr(),
              ),
              onChanged: (v) => _recommendationType = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_generated_at'.tr()}: ${_generatedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _generatedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _generatedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expires_at'.tr()}: ${_expiresAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiresAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userType != null) 'userType': _userType,
                  if (_userId != null) 'userId': _userId,
                  if (_sessionId != null) 'sessionId': _sessionId,
                  if (_recommendationType != null)
                    'recommendationType': _recommendationType,
                  if (_generatedAt != null)
                    'generatedAt': _generatedAt!.toIso8601String(),
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
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
                  widget.onSubmit(AiRecommendation.fromJson(json));
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
