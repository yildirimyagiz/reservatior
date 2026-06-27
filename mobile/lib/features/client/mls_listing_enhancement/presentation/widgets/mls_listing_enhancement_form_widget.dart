import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MlsListingEnhancementFormWidget extends ConsumerStatefulWidget {
  final MlsListingEnhancement? item;
  final Function(MlsListingEnhancement) onSubmit;
  const MlsListingEnhancementFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<MlsListingEnhancementFormWidget> createState() =>
      _MlsListingEnhancementFormWidgetState();
}

class _MlsListingEnhancementFormWidgetState
    extends ConsumerState<MlsListingEnhancementFormWidget> {
  String? _listingId;
  String? _mlsNumber;
  String? _mlsStatus;
  DateTime? _lastMlsUpdate;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _mlsNumber = widget.item?.mlsNumber;
    _mlsStatus = widget.item?.mlsStatus;
    _lastMlsUpdate = widget.item?.lastMlsUpdate;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mlslistingenhancement'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mlslistingenhancement'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _mlsNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mlsnumber'.tr()),
              onChanged: (v) => _mlsNumber = v,
            ),
            TextFormField(
              initialValue: _mlsStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mlsstatus'.tr()),
              onChanged: (v) => _mlsStatus = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_mls_update'.tr()}: ${_lastMlsUpdate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastMlsUpdate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastMlsUpdate = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_mlsNumber != null) 'mlsNumber': _mlsNumber,
                  if (_mlsStatus != null) 'mlsStatus': _mlsStatus,
                  if (_lastMlsUpdate != null)
                    'lastMlsUpdate': _lastMlsUpdate!.toIso8601String(),
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
                  widget.onSubmit(MlsListingEnhancement.fromJson(json));
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
