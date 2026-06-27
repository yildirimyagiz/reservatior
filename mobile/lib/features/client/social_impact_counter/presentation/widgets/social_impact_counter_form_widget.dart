import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SocialImpactCounterFormWidget extends ConsumerStatefulWidget {
  final SocialImpactCounter? item;
  final Function(SocialImpactCounter) onSubmit;
  const SocialImpactCounterFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<SocialImpactCounterFormWidget> createState() =>
      _SocialImpactCounterFormWidgetState();
}

class _SocialImpactCounterFormWidgetState
    extends ConsumerState<SocialImpactCounterFormWidget> {
  String? _currency;
  String? _partnerName;
  String? _partnerUrl;
  String? _partnerOrgId;
  String? _campaignTag;
  bool? _isPublic;
  int? _displayGoal;
  @override
  void initState() {
    super.initState();
    _currency = widget.item?.currency;
    _partnerName = widget.item?.partnerName;
    _partnerUrl = widget.item?.partnerUrl;
    _partnerOrgId = widget.item?.partnerOrgId;
    _campaignTag = widget.item?.campaignTag;
    _isPublic = widget.item?.isPublic;
    _displayGoal = widget.item?.displayGoal;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.socialimpactcounter'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.socialimpactcounter'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _partnerName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.partnername'.tr()),
              onChanged: (v) => _partnerName = v,
            ),
            TextFormField(
              initialValue: _partnerUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.partnerurl'.tr()),
              onChanged: (v) => _partnerUrl = v,
            ),
            TextFormField(
              initialValue: _partnerOrgId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.partnerorgid'.tr()),
              onChanged: (v) => _partnerOrgId = v,
            ),
            TextFormField(
              initialValue: _campaignTag?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.campaigntag'.tr()),
              onChanged: (v) => _campaignTag = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.ispublic'.tr()),
              value: _isPublic ?? false,
              onChanged: (v) => setState(() => _isPublic = v),
            ),
            TextFormField(
              initialValue: _displayGoal?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.displaygoal'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _displayGoal = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_currency != null) 'currency': _currency,
                  if (_partnerName != null) 'partnerName': _partnerName,
                  if (_partnerUrl != null) 'partnerUrl': _partnerUrl,
                  if (_partnerOrgId != null) 'partnerOrgId': _partnerOrgId,
                  if (_campaignTag != null) 'campaignTag': _campaignTag,
                  'isPublic': _isPublic,
                  if (_displayGoal != null) 'displayGoal': _displayGoal,
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
                  widget.onSubmit(SocialImpactCounter.fromJson(json));
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
