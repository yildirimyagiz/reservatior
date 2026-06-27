import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentNegotiationFormWidget extends ConsumerStatefulWidget {
  final PaymentNegotiation? item;
  final Function(PaymentNegotiation) onSubmit;
  const PaymentNegotiationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PaymentNegotiationFormWidget> createState() =>
      _PaymentNegotiationFormWidgetState();
}

class _PaymentNegotiationFormWidgetState
    extends ConsumerState<PaymentNegotiationFormWidget> {
  String? _reservationId;
  String? _tenantContactId;
  String? _ownerContactId;
  String? _ownerUserId;
  int? _maxInstallments;
  double? _minFirstPaymentPct;
  bool? _platformValidated;
  String? _validationNotes;
  String? _agreedOfferId;
  DateTime? _agreedAt;
  DateTime? _expiresAt;
  DateTime? _reminderSentAt;
  @override
  void initState() {
    super.initState();
    _reservationId = widget.item?.reservationId;
    _tenantContactId = widget.item?.tenantContactId;
    _ownerContactId = widget.item?.ownerContactId;
    _ownerUserId = widget.item?.ownerUserId;
    _maxInstallments = widget.item?.maxInstallments;
    _minFirstPaymentPct = widget.item?.minFirstPaymentPct;
    _platformValidated = widget.item?.platformValidated;
    _validationNotes = widget.item?.validationNotes;
    _agreedOfferId = widget.item?.agreedOfferId;
    _agreedAt = widget.item?.agreedAt;
    _expiresAt = widget.item?.expiresAt;
    _reminderSentAt = widget.item?.reminderSentAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.paymentnegotiation'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.paymentnegotiation'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _tenantContactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tenantcontactid'.tr()),
              onChanged: (v) => _tenantContactId = v,
            ),
            TextFormField(
              initialValue: _ownerContactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ownercontactid'.tr()),
              onChanged: (v) => _ownerContactId = v,
            ),
            TextFormField(
              initialValue: _ownerUserId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.owneruserid'.tr()),
              onChanged: (v) => _ownerUserId = v,
            ),
            TextFormField(
              initialValue: _maxInstallments?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxinstallments'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxInstallments = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _minFirstPaymentPct?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.minfirstpaymentpct'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _minFirstPaymentPct = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.platformvalidated'.tr()),
              value: _platformValidated ?? false,
              onChanged: (v) => setState(() => _platformValidated = v),
            ),
            TextFormField(
              initialValue: _validationNotes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.validationnotes'.tr()),
              onChanged: (v) => _validationNotes = v,
            ),
            TextFormField(
              initialValue: _agreedOfferId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agreedofferid'.tr()),
              onChanged: (v) => _agreedOfferId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_agreed_at'.tr()}: ${_agreedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _agreedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _agreedAt = d);
              },
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
            ListTile(
              title: Text("${'mobile.admin.field_reminder_sent_at'.tr()}: ${_reminderSentAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _reminderSentAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _reminderSentAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_tenantContactId != null)
                    'tenantContactId': _tenantContactId,
                  if (_ownerContactId != null)
                    'ownerContactId': _ownerContactId,
                  if (_ownerUserId != null) 'ownerUserId': _ownerUserId,
                  if (_maxInstallments != null)
                    'maxInstallments': _maxInstallments,
                  if (_minFirstPaymentPct != null)
                    'minFirstPaymentPct': _minFirstPaymentPct,
                  'platformValidated': _platformValidated,
                  if (_validationNotes != null)
                    'validationNotes': _validationNotes,
                  if (_agreedOfferId != null) 'agreedOfferId': _agreedOfferId,
                  if (_agreedAt != null)
                    'agreedAt': _agreedAt!.toIso8601String(),
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
                  if (_reminderSentAt != null)
                    'reminderSentAt': _reminderSentAt!.toIso8601String(),
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
                  widget.onSubmit(PaymentNegotiation.fromJson(json));
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
