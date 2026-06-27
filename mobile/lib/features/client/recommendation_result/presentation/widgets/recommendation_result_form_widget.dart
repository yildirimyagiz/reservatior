import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class RecommendationResultFormWidget extends ConsumerStatefulWidget {
  final RecommendationResult? item;
  final Function(RecommendationResult) onSubmit;
  const RecommendationResultFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<RecommendationResultFormWidget> createState() =>
      _RecommendationResultFormWidgetState();
}

class _RecommendationResultFormWidgetState
    extends ConsumerState<RecommendationResultFormWidget> {
  String? _profileId;
  String? _listingId;
  int? _score;
  String? _explanation;
  @override
  void initState() {
    super.initState();
    _profileId = widget.item?.profileId;
    _listingId = widget.item?.listingId;
    _score = widget.item?.score;
    _explanation = widget.item?.explanation;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.recommendationresult'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.recommendationresult'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _profileId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.profileid'.tr()),
              onChanged: (v) => _profileId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _score?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.score'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _score = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _explanation?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.explanation'.tr()),
              onChanged: (v) => _explanation = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_profileId != null) 'profileId': _profileId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_score != null) 'score': _score,
                  if (_explanation != null) 'explanation': _explanation,
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
                  widget.onSubmit(RecommendationResult.fromJson(json));
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
