import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ReviewFormWidget extends ConsumerStatefulWidget {
  final Review? item;
  final Function(Review) onSubmit;
  const ReviewFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ReviewFormWidget> createState() => _ReviewFormWidgetState();
}

class _ReviewFormWidgetState extends ConsumerState<ReviewFormWidget> {
  String? _reviewerId;
  String? _targetId;
  String? _targetType;
  int? _rating;
  String? _title;
  String? _comment;
  bool? _isVerified;
  @override
  void initState() {
    super.initState();
    _reviewerId = widget.item?.reviewerId;
    _targetId = widget.item?.targetId;
    _targetType = widget.item?.targetType;
    _rating = widget.item?.rating;
    _title = widget.item?.title;
    _comment = widget.item?.comment;
    _isVerified = widget.item?.isVerified;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.review'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.review'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _reviewerId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reviewerid'.tr()),
              onChanged: (v) => _reviewerId = v,
            ),
            TextFormField(
              initialValue: _targetId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.targetid'.tr()),
              onChanged: (v) => _targetId = v,
            ),
            TextFormField(
              initialValue: _targetType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.targettype'.tr()),
              onChanged: (v) => _targetType = v,
            ),
            TextFormField(
              initialValue: _rating?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rating'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rating = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _comment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.comment'.tr()),
              onChanged: (v) => _comment = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isverified'.tr()),
              value: _isVerified ?? false,
              onChanged: (v) => setState(() => _isVerified = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_reviewerId != null) 'reviewerId': _reviewerId,
                  if (_targetId != null) 'targetId': _targetId,
                  if (_targetType != null) 'targetType': _targetType,
                  if (_rating != null) 'rating': _rating,
                  if (_title != null) 'title': _title,
                  if (_comment != null) 'comment': _comment,
                  'isVerified': _isVerified,
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
                  widget.onSubmit(Review.fromJson(json));
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
