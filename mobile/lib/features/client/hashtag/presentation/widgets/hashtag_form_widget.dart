import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class HashtagFormWidget extends ConsumerStatefulWidget {
  final Hashtag? item;
  final Function(Hashtag) onSubmit;
  const HashtagFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<HashtagFormWidget> createState() => _HashtagFormWidgetState();
}

class _HashtagFormWidgetState extends ConsumerState<HashtagFormWidget> {
  String? _name;
  String? _description;
  int? _usageCount;
  String? _createdById;
  String? _agencyId;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _description = widget.item?.description;
    _usageCount = widget.item?.usageCount;
    _createdById = widget.item?.createdById;
    _agencyId = widget.item?.agencyId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.hashtag'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.hashtag'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _usageCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.usagecount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _usageCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _createdById?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.createdbyid'.tr()),
              onChanged: (v) => _createdById = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_usageCount != null) 'usageCount': _usageCount,
                  if (_createdById != null) 'createdById': _createdById,
                  if (_agencyId != null) 'agencyId': _agencyId,
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
                  widget.onSubmit(Hashtag.fromJson(json));
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
