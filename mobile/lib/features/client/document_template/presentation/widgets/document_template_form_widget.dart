import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class DocumentTemplateFormWidget extends ConsumerStatefulWidget {
  final DocumentTemplate? item;
  final Function(DocumentTemplate) onSubmit;
  const DocumentTemplateFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<DocumentTemplateFormWidget> createState() =>
      _DocumentTemplateFormWidgetState();
}

class _DocumentTemplateFormWidgetState
    extends ConsumerState<DocumentTemplateFormWidget> {
  String? _name;
  String? _type;
  String? _category;
  String? _templateContent;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _type = widget.item?.type;
    _category = widget.item?.category;
    _templateContent = widget.item?.templateContent;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.documenttemplate'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.documenttemplate'.tr()}",
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
              initialValue: _category?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.category'.tr()),
              onChanged: (v) => _category = v,
            ),
            TextFormField(
              initialValue: _templateContent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.templatecontent'.tr()),
              onChanged: (v) => _templateContent = v,
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
                  if (_category != null) 'category': _category,
                  if (_templateContent != null)
                    'templateContent': _templateContent,
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
                  widget.onSubmit(DocumentTemplate.fromJson(json));
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
