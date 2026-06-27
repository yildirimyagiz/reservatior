import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageFormWidget extends ConsumerStatefulWidget {
  final Language? item;
  final Function(Language) onSubmit;
  const LanguageFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<LanguageFormWidget> createState() => _LanguageFormWidgetState();
}

class _LanguageFormWidgetState extends ConsumerState<LanguageFormWidget> {
  String? _code;
  String? _name;
  String? _nativeName;
  bool? _isRTL;
  bool? _isActive;
  String? _agencyId;
  String? _agentId;
  String? _userId;
  @override
  void initState() {
    super.initState();
    _code = widget.item?.code;
    _name = widget.item?.name;
    _nativeName = widget.item?.nativeName;
    _isRTL = widget.item?.isRTL;
    _isActive = widget.item?.isActive;
    _agencyId = widget.item?.agencyId;
    _agentId = widget.item?.agentId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.language'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.language'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _code?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.code'.tr()),
              onChanged: (v) => _code = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _nativeName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.nativename'.tr()),
              onChanged: (v) => _nativeName = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isrtl'.tr()),
              value: _isRTL ?? false,
              onChanged: (v) => setState(() => _isRTL = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
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
                  if (_code != null) 'code': _code,
                  if (_name != null) 'name': _name,
                  if (_nativeName != null) 'nativeName': _nativeName,
                  'isRTL': _isRTL,
                  'isActive': _isActive,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_agentId != null) 'agentId': _agentId,
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
                  widget.onSubmit(Language.fromJson(json));
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
