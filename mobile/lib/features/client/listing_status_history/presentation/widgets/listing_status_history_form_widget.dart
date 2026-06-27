import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ListingStatusHistoryFormWidget extends ConsumerStatefulWidget {
  final ListingStatusHistory? item;
  final Function(ListingStatusHistory) onSubmit;
  const ListingStatusHistoryFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ListingStatusHistoryFormWidget> createState() =>
      _ListingStatusHistoryFormWidgetState();
}

class _ListingStatusHistoryFormWidgetState
    extends ConsumerState<ListingStatusHistoryFormWidget> {
  String? _listingId;
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _reason;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _fromDate = widget.item?.fromDate;
    _toDate = widget.item?.toDate;
    _reason = widget.item?.reason;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.listingstatushistory'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.listingstatushistory'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_from_date'.tr()}: ${_fromDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _fromDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _fromDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_to_date'.tr()}: ${_toDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _toDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _toDate = d);
              },
            ),
            TextFormField(
              initialValue: _reason?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reason'.tr()),
              onChanged: (v) => _reason = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_fromDate != null)
                    'fromDate': _fromDate!.toIso8601String(),
                  if (_toDate != null) 'toDate': _toDate!.toIso8601String(),
                  if (_reason != null) 'reason': _reason,
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
                  widget.onSubmit(ListingStatusHistory.fromJson(json));
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
