import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SocialImpactRecordFormWidget extends ConsumerStatefulWidget {
  final SocialImpactRecord? item;
  final Function(SocialImpactRecord) onSubmit;
  const SocialImpactRecordFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<SocialImpactRecordFormWidget> createState() =>
      _SocialImpactRecordFormWidgetState();
}

class _SocialImpactRecordFormWidgetState
    extends ConsumerState<SocialImpactRecordFormWidget> {
  String? _counterId;
  String? _reservationId;
  int? _quantity;
  double? _amount;
  String? _currency;
  String? _description;
  DateTime? _verifiedAt;
  String? _verifiedBy;
  String? _proofUrl;
  @override
  void initState() {
    super.initState();
    _counterId = widget.item?.counterId;
    _reservationId = widget.item?.reservationId;
    _quantity = widget.item?.quantity;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency;
    _description = widget.item?.description;
    _verifiedAt = widget.item?.verifiedAt;
    _verifiedBy = widget.item?.verifiedBy;
    _proofUrl = widget.item?.proofUrl;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.socialimpactrecord'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.socialimpactrecord'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _counterId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.counterid'.tr()),
              onChanged: (v) => _counterId = v,
            ),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _quantity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.quantity'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _quantity = int.tryParse(v ?? ""),
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
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_verified_at'.tr()}: ${_verifiedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _verifiedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _verifiedAt = d);
              },
            ),
            TextFormField(
              initialValue: _verifiedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.verifiedby'.tr()),
              onChanged: (v) => _verifiedBy = v,
            ),
            TextFormField(
              initialValue: _proofUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.proofurl'.tr()),
              onChanged: (v) => _proofUrl = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_counterId != null) 'counterId': _counterId,
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_quantity != null) 'quantity': _quantity,
                  if (_amount != null) 'amount': _amount,
                  if (_currency != null) 'currency': _currency,
                  if (_description != null) 'description': _description,
                  if (_verifiedAt != null)
                    'verifiedAt': _verifiedAt!.toIso8601String(),
                  if (_verifiedBy != null) 'verifiedBy': _verifiedBy,
                  if (_proofUrl != null) 'proofUrl': _proofUrl,
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
                  widget.onSubmit(SocialImpactRecord.fromJson(json));
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
