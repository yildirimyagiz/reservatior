import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class LeaseRenewalFormWidget extends ConsumerStatefulWidget {
  final LeaseRenewal? item;
  final Function(LeaseRenewal) onSubmit;
  const LeaseRenewalFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<LeaseRenewalFormWidget> createState() =>
      _LeaseRenewalFormWidgetState();
}

class _LeaseRenewalFormWidgetState
    extends ConsumerState<LeaseRenewalFormWidget> {
  String? _leaseId;
  double? _proposedRent;
  DateTime? _renewalDate;
  DateTime? _responseDeadline;
  String? _organizationId;
  String? _listingId;
  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId;
    _proposedRent = widget.item?.proposedRent;
    _renewalDate = widget.item?.renewalDate;
    _responseDeadline = widget.item?.responseDeadline;
    _organizationId = widget.item?.organizationId;
    _listingId = widget.item?.listingId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.leaserenewal'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.leaserenewal'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _proposedRent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.proposedrent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _proposedRent = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_renewal_date'.tr()}: ${_renewalDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _renewalDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _renewalDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_response_deadline'.tr()}: ${_responseDeadline ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _responseDeadline ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _responseDeadline = d);
              },
            ),
            TextFormField(
              initialValue: _organizationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.organizationid'.tr()),
              onChanged: (v) => _organizationId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_proposedRent != null) 'proposedRent': _proposedRent,
                  if (_renewalDate != null)
                    'renewalDate': _renewalDate!.toIso8601String(),
                  if (_responseDeadline != null)
                    'responseDeadline': _responseDeadline!.toIso8601String(),
                  if (_organizationId != null)
                    'organizationId': _organizationId,
                  if (_listingId != null) 'listingId': _listingId,
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
                  widget.onSubmit(LeaseRenewal.fromJson(json));
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
