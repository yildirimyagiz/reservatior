import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class GiftCardFormWidget extends ConsumerStatefulWidget {
  final GiftCard? item;
  final Function(GiftCard) onSubmit;
  const GiftCardFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<GiftCardFormWidget> createState() => _GiftCardFormWidgetState();
}

class _GiftCardFormWidgetState extends ConsumerState<GiftCardFormWidget> {
  String? _code;
  double? _amount;
  double? _balance;
  String? _currency;
  DateTime? _expiresAt;
  bool? _isActive;
  String? _issuedTo;
  String? _issuedBy;
  String? _issuedFor;
  @override
  void initState() {
    super.initState();
    _code = widget.item?.code;
    _amount = widget.item?.amount;
    _balance = widget.item?.balance;
    _currency = widget.item?.currency;
    _expiresAt = widget.item?.expiresAt;
    _isActive = widget.item?.isActive;
    _issuedTo = widget.item?.issuedTo;
    _issuedBy = widget.item?.issuedBy;
    _issuedFor = widget.item?.issuedFor;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.giftcard'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.giftcard'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _code?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.code'.tr()),
              onChanged: (v) => _code = v,
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _balance?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.balance'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _balance = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
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
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            TextFormField(
              initialValue: _issuedTo?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.issuedto'.tr()),
              onChanged: (v) => _issuedTo = v,
            ),
            TextFormField(
              initialValue: _issuedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.issuedby'.tr()),
              onChanged: (v) => _issuedBy = v,
            ),
            TextFormField(
              initialValue: _issuedFor?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.issuedfor'.tr()),
              onChanged: (v) => _issuedFor = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_code != null) 'code': _code,
                  if (_amount != null) 'amount': _amount,
                  if (_balance != null) 'balance': _balance,
                  if (_currency != null) 'currency': _currency,
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
                  'isActive': _isActive,
                  if (_issuedTo != null) 'issuedTo': _issuedTo,
                  if (_issuedBy != null) 'issuedBy': _issuedBy,
                  if (_issuedFor != null) 'issuedFor': _issuedFor,
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
                  widget.onSubmit(GiftCard.fromJson(json));
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
