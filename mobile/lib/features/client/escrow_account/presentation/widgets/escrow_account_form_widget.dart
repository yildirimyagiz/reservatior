import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class EscrowAccountFormWidget extends ConsumerStatefulWidget {
  final EscrowAccount? item;
  final Function(EscrowAccount) onSubmit;
  const EscrowAccountFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<EscrowAccountFormWidget> createState() =>
      _EscrowAccountFormWidgetState();
}

class _EscrowAccountFormWidgetState
    extends ConsumerState<EscrowAccountFormWidget> {
  String? _reservationId;
  double? _totalAmount;
  double? _depositAmount;
  String? _currency;
  DateTime? _heldAt;
  DateTime? _releasedAt;
  @override
  void initState() {
    super.initState();
    _reservationId = widget.item?.reservationId;
    _totalAmount = widget.item?.totalAmount;
    _depositAmount = widget.item?.depositAmount;
    _currency = widget.item?.currency;
    _heldAt = widget.item?.heldAt;
    _releasedAt = widget.item?.releasedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.escrowaccount'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.escrowaccount'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _totalAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalAmount = double.tryParse(v ?? ""),
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
            ListTile(
              title: Text("${'mobile.admin.field_held_at'.tr()}: ${_heldAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _heldAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _heldAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_released_at'.tr()}: ${_releasedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _releasedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _releasedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_totalAmount != null) 'totalAmount': _totalAmount,
                  if (_depositAmount != null) 'depositAmount': _depositAmount,
                  if (_currency != null) 'currency': _currency,
                  if (_heldAt != null) 'heldAt': _heldAt!.toIso8601String(),
                  if (_releasedAt != null)
                    'releasedAt': _releasedAt!.toIso8601String(),
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
                  widget.onSubmit(EscrowAccount.fromJson(json));
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
