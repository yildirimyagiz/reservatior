import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PostFormWidget extends ConsumerStatefulWidget {
  final Post? item;
  final Function(Post) onSubmit;
  const PostFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PostFormWidget> createState() => _PostFormWidgetState();
}

class _PostFormWidgetState extends ConsumerState<PostFormWidget> {
  String? _title;
  String? _content;
  String? _slug;
  String? _userId;
  String? _agencyId;
  String? _hashtagId;
  String? _agentId;
  @override
  void initState() {
    super.initState();
    _title = widget.item?.title;
    _content = widget.item?.content;
    _slug = widget.item?.slug;
    _userId = widget.item?.userId;
    _agencyId = widget.item?.agencyId;
    _hashtagId = widget.item?.hashtagId;
    _agentId = widget.item?.agentId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.post'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.post'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _content?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.content'.tr()),
              onChanged: (v) => _content = v,
            ),
            TextFormField(
              initialValue: _slug?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.slug'.tr()),
              onChanged: (v) => _slug = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _hashtagId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.hashtagid'.tr()),
              onChanged: (v) => _hashtagId = v,
            ),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_title != null) 'title': _title,
                  if (_content != null) 'content': _content,
                  if (_slug != null) 'slug': _slug,
                  if (_userId != null) 'userId': _userId,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_hashtagId != null) 'hashtagId': _hashtagId,
                  if (_agentId != null) 'agentId': _agentId,
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
                  widget.onSubmit(Post.fromJson(json));
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
