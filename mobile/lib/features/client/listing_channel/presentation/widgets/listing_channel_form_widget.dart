import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ListingChannelFormWidget extends ConsumerStatefulWidget {
  final ListingChannel? item;
  final Function(ListingChannel) onSubmit;
  const ListingChannelFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ListingChannelFormWidget> createState() =>
      _ListingChannelFormWidgetState();
}

class _ListingChannelFormWidgetState
    extends ConsumerState<ListingChannelFormWidget> {
  String? _listingId;
  String? _channelId;
  String? _status;
  DateTime? _lastSync;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _channelId = widget.item?.channelId;
    _status = widget.item?.status;
    _lastSync = widget.item?.lastSync;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.listingchannel'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.listingchannel'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _channelId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.channelid'.tr()),
              onChanged: (v) => _channelId = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_sync'.tr()}: ${_lastSync ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastSync ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastSync = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_channelId != null) 'channelId': _channelId,
                  if (_status != null) 'status': _status,
                  if (_lastSync != null)
                    'lastSync': _lastSync!.toIso8601String(),
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
                  widget.onSubmit(ListingChannel.fromJson(json));
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
