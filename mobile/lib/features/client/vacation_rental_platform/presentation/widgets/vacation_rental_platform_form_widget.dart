import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class VacationRentalPlatformFormWidget extends ConsumerStatefulWidget {
  final VacationRentalPlatform? item;
  final Function(VacationRentalPlatform) onSubmit;
  const VacationRentalPlatformFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<VacationRentalPlatformFormWidget> createState() =>
      _VacationRentalPlatformFormWidgetState();
}

class _VacationRentalPlatformFormWidgetState
    extends ConsumerState<VacationRentalPlatformFormWidget> {
  String? _rentalId;
  String? _externalId;
  String? _externalUrl;
  DateTime? _lastSyncedAt;
  bool? _syncEnabled;
  @override
  void initState() {
    super.initState();
    _rentalId = widget.item?.rentalId;
    _externalId = widget.item?.externalId;
    _externalUrl = widget.item?.externalUrl;
    _lastSyncedAt = widget.item?.lastSyncedAt;
    _syncEnabled = widget.item?.syncEnabled;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.vacationrentalplatform'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.vacationrentalplatform'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _rentalId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rentalid'.tr()),
              onChanged: (v) => _rentalId = v,
            ),
            TextFormField(
              initialValue: _externalId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalid'.tr()),
              onChanged: (v) => _externalId = v,
            ),
            TextFormField(
              initialValue: _externalUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalurl'.tr()),
              onChanged: (v) => _externalUrl = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_synced_at'.tr()}: ${_lastSyncedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastSyncedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastSyncedAt = d);
              },
            ),
            SwitchListTile(
              title: Text('mobile.auto.syncenabled'.tr()),
              value: _syncEnabled ?? false,
              onChanged: (v) => setState(() => _syncEnabled = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_rentalId != null) 'rentalId': _rentalId,
                  if (_externalId != null) 'externalId': _externalId,
                  if (_externalUrl != null) 'externalUrl': _externalUrl,
                  if (_lastSyncedAt != null)
                    'lastSyncedAt': _lastSyncedAt!.toIso8601String(),
                  'syncEnabled': _syncEnabled,
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
                  widget.onSubmit(VacationRentalPlatform.fromJson(json));
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
