import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class CommunicationTemplateFormWidget extends ConsumerStatefulWidget {
  final CommunicationTemplate? item;
  final Function(CommunicationTemplate) onSubmit;
  const CommunicationTemplateFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<CommunicationTemplateFormWidget> createState() =>
      _CommunicationTemplateFormWidgetState();
}

class _CommunicationTemplateFormWidgetState
    extends ConsumerState<CommunicationTemplateFormWidget> {
  String? _name;
  String? _type;
  String? _templateType;
  String? _subject;
  String? _htmlContent;
  String? _textContent;
  String? _title;
  String? _message;
  String? _category;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _type = widget.item?.type;
    _templateType = widget.item?.templateType;
    _subject = widget.item?.subject;
    _htmlContent = widget.item?.htmlContent;
    _textContent = widget.item?.textContent;
    _title = widget.item?.title;
    _message = widget.item?.message;
    _category = widget.item?.category;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.communicationtemplate'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.communicationtemplate'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _type?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.type'.tr()),
              onChanged: (v) => _type = v,
            ),
            TextFormField(
              initialValue: _templateType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.templatetype'.tr()),
              onChanged: (v) => _templateType = v,
            ),
            TextFormField(
              initialValue: _subject?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.subject'.tr()),
              onChanged: (v) => _subject = v,
            ),
            TextFormField(
              initialValue: _htmlContent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.htmlcontent'.tr()),
              onChanged: (v) => _htmlContent = v,
            ),
            TextFormField(
              initialValue: _textContent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.textcontent'.tr()),
              onChanged: (v) => _textContent = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _message?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.message'.tr()),
              onChanged: (v) => _message = v,
            ),
            TextFormField(
              initialValue: _category?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.category'.tr()),
              onChanged: (v) => _category = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_type != null) 'type': _type,
                  if (_templateType != null) 'templateType': _templateType,
                  if (_subject != null) 'subject': _subject,
                  if (_htmlContent != null) 'htmlContent': _htmlContent,
                  if (_textContent != null) 'textContent': _textContent,
                  if (_title != null) 'title': _title,
                  if (_message != null) 'message': _message,
                  if (_category != null) 'category': _category,
                  'isActive': _isActive,
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
                  widget.onSubmit(CommunicationTemplate.fromJson(json));
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
