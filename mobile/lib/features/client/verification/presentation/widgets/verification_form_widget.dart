import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class VerificationFormWidget extends ConsumerStatefulWidget {
  final Verification? item;
  final Function(Verification) onSubmit;
  const VerificationFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<VerificationFormWidget> createState() =>
      _VerificationFormWidgetState();
}

class _VerificationFormWidgetState
    extends ConsumerState<VerificationFormWidget> {
  String? _identifier;
  String? _value;
  DateTime? _expiresAt;
  @override
  void initState() {
    super.initState();
    _identifier = widget.item?.identifier;
    _value = widget.item?.value;
    _expiresAt = widget.item?.expiresAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.verification'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.verification'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _identifier?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.identifier'.tr()),
              onChanged: (v) => _identifier = v,
            ),
            TextFormField(
              initialValue: _value?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.value'.tr()),
              onChanged: (v) => _value = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expires_at'.tr()}: ${_expiresAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiresAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_identifier != null) 'identifier': _identifier,
                  if (_value != null) 'value': _value,
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
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
                  widget.onSubmit(Verification.fromJson(json));
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
