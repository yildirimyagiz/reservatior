import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MlsExternalListingFormWidget extends ConsumerStatefulWidget {
  final MlsExternalListing? item;
  final Function(MlsExternalListing) onSubmit;
  const MlsExternalListingFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<MlsExternalListingFormWidget> createState() =>
      _MlsExternalListingFormWidgetState();
}

class _MlsExternalListingFormWidgetState
    extends ConsumerState<MlsExternalListingFormWidget> {
  String? _connectionId;
  String? _externalId;
  String? _externalUrl;
  String? _mappedListingId;
  String? _status;
  DateTime? _lastSeenAt;
  @override
  void initState() {
    super.initState();
    _connectionId = widget.item?.connectionId;
    _externalId = widget.item?.externalId;
    _externalUrl = widget.item?.externalUrl;
    _mappedListingId = widget.item?.mappedListingId;
    _status = widget.item?.status;
    _lastSeenAt = widget.item?.lastSeenAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mlsexternallisting'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mlsexternallisting'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _connectionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.connectionid'.tr()),
              onChanged: (v) => _connectionId = v,
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
            TextFormField(
              initialValue: _mappedListingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mappedlistingid'.tr()),
              onChanged: (v) => _mappedListingId = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_seen_at'.tr()}: ${_lastSeenAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastSeenAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastSeenAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_connectionId != null) 'connectionId': _connectionId,
                  if (_externalId != null) 'externalId': _externalId,
                  if (_externalUrl != null) 'externalUrl': _externalUrl,
                  if (_mappedListingId != null)
                    'mappedListingId': _mappedListingId,
                  if (_status != null) 'status': _status,
                  if (_lastSeenAt != null)
                    'lastSeenAt': _lastSeenAt!.toIso8601String(),
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
                  widget.onSubmit(MlsExternalListing.fromJson(json));
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
