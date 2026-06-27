import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ListingTagFormWidget extends ConsumerStatefulWidget {
  final ListingTag? item;
  final Function(ListingTag) onSubmit;
  const ListingTagFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ListingTagFormWidget> createState() =>
      _ListingTagFormWidgetState();
}

class _ListingTagFormWidgetState extends ConsumerState<ListingTagFormWidget> {
  String? _listingId;
  String? _tagId;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _tagId = widget.item?.tagId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.listingtag'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.listingtag'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _tagId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tagid'.tr()),
              onChanged: (v) => _tagId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_tagId != null) 'tagId': _tagId,
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
                  widget.onSubmit(ListingTag.fromJson(json));
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
