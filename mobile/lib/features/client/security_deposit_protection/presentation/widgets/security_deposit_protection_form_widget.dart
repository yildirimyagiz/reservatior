import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SecurityDepositProtectionFormWidget extends ConsumerStatefulWidget {
  final SecurityDepositProtection? item;
  final Function(SecurityDepositProtection) onSubmit;
  const SecurityDepositProtectionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<SecurityDepositProtectionFormWidget> createState() =>
      _SecurityDepositProtectionFormWidgetState();
}

class _SecurityDepositProtectionFormWidgetState
    extends ConsumerState<SecurityDepositProtectionFormWidget> {
  String? _leaseId;
  String? _schemeProvider;
  String? _schemeReference;
  double? _depositAmount;
  String? _currency;
  String? _protectionStatus;
  DateTime? _protectedDate;
  DateTime? _releasedDate;
  String? _disputeStatus;
  String? _disputeReason;
  String? _disputeResolution;
  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId;
    _schemeProvider = widget.item?.schemeProvider;
    _schemeReference = widget.item?.schemeReference;
    _depositAmount = widget.item?.depositAmount;
    _currency = widget.item?.currency;
    _protectionStatus = widget.item?.protectionStatus;
    _protectedDate = widget.item?.protectedDate;
    _releasedDate = widget.item?.releasedDate;
    _disputeStatus = widget.item?.disputeStatus;
    _disputeReason = widget.item?.disputeReason;
    _disputeResolution = widget.item?.disputeResolution;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.securitydepositprotection'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.securitydepositprotection'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _schemeProvider?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.schemeprovider'.tr()),
              onChanged: (v) => _schemeProvider = v,
            ),
            TextFormField(
              initialValue: _schemeReference?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.schemereference'.tr()),
              onChanged: (v) => _schemeReference = v,
            ),
            TextFormField(
              initialValue: _depositAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.depositamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _depositAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _protectionStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.protectionstatus'.tr()),
              onChanged: (v) => _protectionStatus = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_protected_date'.tr()}: ${_protectedDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _protectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _protectedDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_released_date'.tr()}: ${_releasedDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _releasedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _releasedDate = d);
              },
            ),
            TextFormField(
              initialValue: _disputeStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.disputestatus'.tr()),
              onChanged: (v) => _disputeStatus = v,
            ),
            TextFormField(
              initialValue: _disputeReason?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.disputereason'.tr()),
              onChanged: (v) => _disputeReason = v,
            ),
            TextFormField(
              initialValue: _disputeResolution?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.disputeresolution'.tr()),
              onChanged: (v) => _disputeResolution = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_schemeProvider != null)
                    'schemeProvider': _schemeProvider,
                  if (_schemeReference != null)
                    'schemeReference': _schemeReference,
                  if (_depositAmount != null) 'depositAmount': _depositAmount,
                  if (_currency != null) 'currency': _currency,
                  if (_protectionStatus != null)
                    'protectionStatus': _protectionStatus,
                  if (_protectedDate != null)
                    'protectedDate': _protectedDate!.toIso8601String(),
                  if (_releasedDate != null)
                    'releasedDate': _releasedDate!.toIso8601String(),
                  if (_disputeStatus != null) 'disputeStatus': _disputeStatus,
                  if (_disputeReason != null) 'disputeReason': _disputeReason,
                  if (_disputeResolution != null)
                    'disputeResolution': _disputeResolution,
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
                  widget.onSubmit(SecurityDepositProtection.fromJson(json));
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
