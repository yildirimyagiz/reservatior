import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AmbassadorContractFormWidget extends ConsumerStatefulWidget {
  final AmbassadorContract? item;
  final Function(AmbassadorContract) onSubmit;
  const AmbassadorContractFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AmbassadorContractFormWidget> createState() =>
      _AmbassadorContractFormWidgetState();
}

class _AmbassadorContractFormWidgetState
    extends ConsumerState<AmbassadorContractFormWidget> {
  String? _ambassadorId;
  int? _version;
  double? _equityPercent;
  double? _upfrontFee;
  String? _currency;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _signedAt;
  String? _documentUrl;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _ambassadorId = widget.item?.ambassadorId;
    _version = widget.item?.version;
    _equityPercent = widget.item?.equityPercent;
    _upfrontFee = widget.item?.upfrontFee;
    _currency = widget.item?.currency;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _signedAt = widget.item?.signedAt;
    _documentUrl = widget.item?.documentUrl;
    _notes = widget.item?.notes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.ambassadorcontract'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.ambassadorcontract'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _ambassadorId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ambassadorid'.tr()),
              onChanged: (v) => _ambassadorId = v,
            ),
            TextFormField(
              initialValue: _version?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.version'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _version = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _equityPercent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.equitypercent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _equityPercent = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _upfrontFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.upfrontfee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _upfrontFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_start_date'.tr()}: ${_startDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_end_date'.tr()}: ${_endDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_signed_at'.tr()}: ${_signedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _signedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _signedAt = d);
              },
            ),
            TextFormField(
              initialValue: _documentUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.documenturl'.tr()),
              onChanged: (v) => _documentUrl = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_ambassadorId != null) 'ambassadorId': _ambassadorId,
                  if (_version != null) 'version': _version,
                  if (_equityPercent != null) 'equityPercent': _equityPercent,
                  if (_upfrontFee != null) 'upfrontFee': _upfrontFee,
                  if (_currency != null) 'currency': _currency,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_signedAt != null)
                    'signedAt': _signedAt!.toIso8601String(),
                  if (_documentUrl != null) 'documentUrl': _documentUrl,
                  if (_notes != null) 'notes': _notes,
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
                  widget.onSubmit(AmbassadorContract.fromJson(json));
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
