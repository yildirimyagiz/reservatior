import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class Tax1099FormFormWidget extends ConsumerStatefulWidget {
  final Tax1099Form? item;
  final Function(Tax1099Form) onSubmit;
  const Tax1099FormFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<Tax1099FormFormWidget> createState() =>
      _Tax1099FormFormWidgetState();
}

class _Tax1099FormFormWidgetState extends ConsumerState<Tax1099FormFormWidget> {
  String? _recipientId;
  int? _taxYear;
  double? _amount;
  String? _description;
  DateTime? _issuedAt;
  DateTime? _mailedAt;
  @override
  void initState() {
    super.initState();
    _recipientId = widget.item?.recipientId;
    _taxYear = widget.item?.taxYear;
    _amount = widget.item?.amount;
    _description = widget.item?.description;
    _issuedAt = widget.item?.issuedAt;
    _mailedAt = widget.item?.mailedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.tax1099form'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.tax1099form'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _recipientId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.recipientid'.tr()),
              onChanged: (v) => _recipientId = v,
            ),
            TextFormField(
              initialValue: _taxYear?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taxyear'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _taxYear = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_issued_at'.tr()}: ${_issuedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _issuedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _issuedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_mailed_at'.tr()}: ${_mailedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _mailedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _mailedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_recipientId != null) 'recipientId': _recipientId,
                  if (_taxYear != null) 'taxYear': _taxYear,
                  if (_amount != null) 'amount': _amount,
                  if (_description != null) 'description': _description,
                  if (_issuedAt != null)
                    'issuedAt': _issuedAt!.toIso8601String(),
                  if (_mailedAt != null)
                    'mailedAt': _mailedAt!.toIso8601String(),
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
                  widget.onSubmit(Tax1099Form.fromJson(json));
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
