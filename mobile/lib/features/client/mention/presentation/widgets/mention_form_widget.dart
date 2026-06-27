import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MentionFormWidget extends ConsumerStatefulWidget {
  final Mention? item;
  final Function(Mention) onSubmit;
  const MentionFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MentionFormWidget> createState() => _MentionFormWidgetState();
}

class _MentionFormWidgetState extends ConsumerState<MentionFormWidget> {
  String? _mentionedById;
  String? _mentionedToId;
  String? _taskId;
  String? _propertyId;
  String? _content;
  bool? _isRead;
  String? _agencyId;
  String? _userId;
  @override
  void initState() {
    super.initState();
    _mentionedById = widget.item?.mentionedById;
    _mentionedToId = widget.item?.mentionedToId;
    _taskId = widget.item?.taskId;
    _propertyId = widget.item?.propertyId;
    _content = widget.item?.content;
    _isRead = widget.item?.isRead;
    _agencyId = widget.item?.agencyId;
    _userId = widget.item?.userId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mention'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mention'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _mentionedById?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mentionedbyid'.tr()),
              onChanged: (v) => _mentionedById = v,
            ),
            TextFormField(
              initialValue: _mentionedToId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mentionedtoid'.tr()),
              onChanged: (v) => _mentionedToId = v,
            ),
            TextFormField(
              initialValue: _taskId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taskid'.tr()),
              onChanged: (v) => _taskId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _content?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.content'.tr()),
              onChanged: (v) => _content = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isread'.tr()),
              value: _isRead ?? false,
              onChanged: (v) => setState(() => _isRead = v),
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_mentionedById != null) 'mentionedById': _mentionedById,
                  if (_mentionedToId != null) 'mentionedToId': _mentionedToId,
                  if (_taskId != null) 'taskId': _taskId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_content != null) 'content': _content,
                  'isRead': _isRead,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_userId != null) 'userId': _userId,
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
                  widget.onSubmit(Mention.fromJson(json));
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
