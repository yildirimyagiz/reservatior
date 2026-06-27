import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class NegotiationOfferFormWidget extends ConsumerStatefulWidget {
  final NegotiationOffer? item;
  final Function(NegotiationOffer) onSubmit;
  const NegotiationOfferFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<NegotiationOfferFormWidget> createState() =>
      _NegotiationOfferFormWidgetState();
}

class _NegotiationOfferFormWidgetState
    extends ConsumerState<NegotiationOfferFormWidget> {
  String? _negotiationId;
  int? _installmentCount;
  double? _firstPaymentPct;
  double? _totalAmount;
  String? _currency;
  String? _notes;
  DateTime? _offeredAt;
  DateTime? _expiresAt;
  DateTime? _respondedAt;
  @override
  void initState() {
    super.initState();
    _negotiationId = widget.item?.negotiationId;
    _installmentCount = widget.item?.installmentCount;
    _firstPaymentPct = widget.item?.firstPaymentPct;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency;
    _notes = widget.item?.notes;
    _offeredAt = widget.item?.offeredAt;
    _expiresAt = widget.item?.expiresAt;
    _respondedAt = widget.item?.respondedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.negotiationoffer'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.negotiationoffer'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _negotiationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.negotiationid'.tr()),
              onChanged: (v) => _negotiationId = v,
            ),
            TextFormField(
              initialValue: _installmentCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.installmentcount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _installmentCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _firstPaymentPct?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.firstpaymentpct'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _firstPaymentPct = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_offered_at'.tr()}: ${_offeredAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _offeredAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _offeredAt = d);
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
              title: Text("${'mobile.admin.field_responded_at'.tr()}: ${_respondedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _respondedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _respondedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_negotiationId != null) 'negotiationId': _negotiationId,
                  if (_installmentCount != null)
                    'installmentCount': _installmentCount,
                  if (_firstPaymentPct != null)
                    'firstPaymentPct': _firstPaymentPct,
                  if (_totalAmount != null) 'totalAmount': _totalAmount,
                  if (_currency != null) 'currency': _currency,
                  if (_notes != null) 'notes': _notes,
                  if (_offeredAt != null)
                    'offeredAt': _offeredAt!.toIso8601String(),
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
                  if (_respondedAt != null)
                    'respondedAt': _respondedAt!.toIso8601String(),
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
                  widget.onSubmit(NegotiationOffer.fromJson(json));
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
