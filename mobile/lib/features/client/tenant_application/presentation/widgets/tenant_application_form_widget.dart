import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class TenantApplicationFormWidget extends ConsumerStatefulWidget {
  final TenantApplication? item;
  final Function(TenantApplication) onSubmit;
  const TenantApplicationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<TenantApplicationFormWidget> createState() =>
      _TenantApplicationFormWidgetState();
}

class _TenantApplicationFormWidgetState
    extends ConsumerState<TenantApplicationFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _applicantId;
  DateTime? _submittedAt;
  DateTime? _reviewedAt;
  String? _reviewedBy;
  int? _creditScore;
  bool? _incomeVerified;
  bool? _backgroundCheck;
  String? _organizationId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _applicantId = widget.item?.applicantId;
    _submittedAt = widget.item?.submittedAt;
    _reviewedAt = widget.item?.reviewedAt;
    _reviewedBy = widget.item?.reviewedBy;
    _creditScore = widget.item?.creditScore;
    _incomeVerified = widget.item?.incomeVerified;
    _backgroundCheck = widget.item?.backgroundCheck;
    _organizationId = widget.item?.organizationId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.tenantapplication'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.tenantapplication'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _applicantId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.applicantid'.tr()),
              onChanged: (v) => _applicantId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_submitted_at'.tr()}: ${_submittedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _submittedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _submittedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_reviewed_at'.tr()}: ${_reviewedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _reviewedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _reviewedAt = d);
              },
            ),
            TextFormField(
              initialValue: _reviewedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reviewedby'.tr()),
              onChanged: (v) => _reviewedBy = v,
            ),
            TextFormField(
              initialValue: _creditScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.creditscore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _creditScore = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.incomeverified'.tr()),
              value: _incomeVerified ?? false,
              onChanged: (v) => setState(() => _incomeVerified = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.backgroundcheck'.tr()),
              value: _backgroundCheck ?? false,
              onChanged: (v) => setState(() => _backgroundCheck = v),
            ),
            TextFormField(
              initialValue: _organizationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.organizationid'.tr()),
              onChanged: (v) => _organizationId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_applicantId != null) 'applicantId': _applicantId,
                  if (_submittedAt != null)
                    'submittedAt': _submittedAt!.toIso8601String(),
                  if (_reviewedAt != null)
                    'reviewedAt': _reviewedAt!.toIso8601String(),
                  if (_reviewedBy != null) 'reviewedBy': _reviewedBy,
                  if (_creditScore != null) 'creditScore': _creditScore,
                  'incomeVerified': _incomeVerified,
                  'backgroundCheck': _backgroundCheck,
                  if (_organizationId != null)
                    'organizationId': _organizationId,
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
                  widget.onSubmit(TenantApplication.fromJson(json));
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
