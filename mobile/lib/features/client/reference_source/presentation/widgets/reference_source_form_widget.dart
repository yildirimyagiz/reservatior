import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ReferenceSourceFormWidget extends ConsumerStatefulWidget {
  final ReferenceSource? item;
  final Function(ReferenceSource) onSubmit;
  const ReferenceSourceFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ReferenceSourceFormWidget> createState() =>
      _ReferenceSourceFormWidgetState();
}

class _ReferenceSourceFormWidgetState
    extends ConsumerState<ReferenceSourceFormWidget> {
  String? _name;
  String? _logo;
  String? _apiKey;
  String? _apiSecret;
  String? _baseUrl;
  bool? _isActive;
  double? _commission;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _logo = widget.item?.logo;
    _apiKey = widget.item?.apiKey;
    _apiSecret = widget.item?.apiSecret;
    _baseUrl = widget.item?.baseUrl;
    _isActive = widget.item?.isActive;
    _commission = widget.item?.commission;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.referencesource'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.referencesource'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _logo?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.logo'.tr()),
              onChanged: (v) => _logo = v,
            ),
            TextFormField(
              initialValue: _apiKey?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.apikey'.tr()),
              onChanged: (v) => _apiKey = v,
            ),
            TextFormField(
              initialValue: _apiSecret?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.apisecret'.tr()),
              onChanged: (v) => _apiSecret = v,
            ),
            TextFormField(
              initialValue: _baseUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.baseurl'.tr()),
              onChanged: (v) => _baseUrl = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            TextFormField(
              initialValue: _commission?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commission'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commission = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_logo != null) 'logo': _logo,
                  if (_apiKey != null) 'apiKey': _apiKey,
                  if (_apiSecret != null) 'apiSecret': _apiSecret,
                  if (_baseUrl != null) 'baseUrl': _baseUrl,
                  'isActive': _isActive,
                  if (_commission != null) 'commission': _commission,
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
                  widget.onSubmit(ReferenceSource.fromJson(json));
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
