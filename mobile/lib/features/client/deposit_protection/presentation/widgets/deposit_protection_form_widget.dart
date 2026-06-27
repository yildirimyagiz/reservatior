import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class DepositProtectionFormWidget extends ConsumerStatefulWidget {
  final DepositProtection? item;
  final Function(DepositProtection) onSubmit;
  const DepositProtectionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<DepositProtectionFormWidget> createState() =>
      _DepositProtectionFormWidgetState();
}

class _DepositProtectionFormWidgetState
    extends ConsumerState<DepositProtectionFormWidget> {
  String? _leaseId;
  String? _provider;
  String? _scheme;
  String? _reference;
  double? _amount;
  String? _currency;
  String? _status;
  DateTime? _protectedAt;
  DateTime? _claimedAt;
  DateTime? _returnedAt;
  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId;
    _provider = widget.item?.provider;
    _scheme = widget.item?.scheme;
    _reference = widget.item?.reference;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency;
    _status = widget.item?.status;
    _protectedAt = widget.item?.protectedAt;
    _claimedAt = widget.item?.claimedAt;
    _returnedAt = widget.item?.returnedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.depositprotection'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.depositprotection'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _provider?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.provider'.tr()),
              onChanged: (v) => _provider = v,
            ),
            TextFormField(
              initialValue: _scheme?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.scheme'.tr()),
              onChanged: (v) => _scheme = v,
            ),
            TextFormField(
              initialValue: _reference?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reference'.tr()),
              onChanged: (v) => _reference = v,
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_protected_at'.tr()}: ${_protectedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _protectedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _protectedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_claimed_at'.tr()}: ${_claimedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _claimedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _claimedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_returned_at'.tr()}: ${_returnedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _returnedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _returnedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_provider != null) 'provider': _provider,
                  if (_scheme != null) 'scheme': _scheme,
                  if (_reference != null) 'reference': _reference,
                  if (_amount != null) 'amount': _amount,
                  if (_currency != null) 'currency': _currency,
                  if (_status != null) 'status': _status,
                  if (_protectedAt != null)
                    'protectedAt': _protectedAt!.toIso8601String(),
                  if (_claimedAt != null)
                    'claimedAt': _claimedAt!.toIso8601String(),
                  if (_returnedAt != null)
                    'returnedAt': _returnedAt!.toIso8601String(),
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
                  widget.onSubmit(DepositProtection.fromJson(json));
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
