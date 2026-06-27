import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class RentArrearsFormWidget extends ConsumerStatefulWidget {
  final RentArrears? item;
  final Function(RentArrears) onSubmit;
  const RentArrearsFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<RentArrearsFormWidget> createState() =>
      _RentArrearsFormWidgetState();
}

class _RentArrearsFormWidgetState extends ConsumerState<RentArrearsFormWidget> {
  String? _leaseId;
  String? _tenantId;
  DateTime? _periodStart;
  DateTime? _periodEnd;
  double? _rentDue;
  double? _rentPaid;
  double? _arrearsAmount;
  String? _status;
  DateTime? _lastPaymentDate;
  bool? _noticeSent;
  DateTime? _noticeDate;
  String? _noticeType;
  bool? _legalAction;
  String? _legalReference;
  DateTime? _courtDate;
  double? _recoveryAmount;
  double? _writeOffAmount;
  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId;
    _tenantId = widget.item?.tenantId;
    _periodStart = widget.item?.periodStart;
    _periodEnd = widget.item?.periodEnd;
    _rentDue = widget.item?.rentDue;
    _rentPaid = widget.item?.rentPaid;
    _arrearsAmount = widget.item?.arrearsAmount;
    _status = widget.item?.status;
    _lastPaymentDate = widget.item?.lastPaymentDate;
    _noticeSent = widget.item?.noticeSent;
    _noticeDate = widget.item?.noticeDate;
    _noticeType = widget.item?.noticeType;
    _legalAction = widget.item?.legalAction;
    _legalReference = widget.item?.legalReference;
    _courtDate = widget.item?.courtDate;
    _recoveryAmount = widget.item?.recoveryAmount;
    _writeOffAmount = widget.item?.writeOffAmount;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.rentarrears'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.rentarrears'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _tenantId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tenantid'.tr()),
              onChanged: (v) => _tenantId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_period_start'.tr()}: ${_periodStart ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _periodStart ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _periodStart = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_period_end'.tr()}: ${_periodEnd ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _periodEnd ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _periodEnd = d);
              },
            ),
            TextFormField(
              initialValue: _rentDue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rentdue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rentDue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _rentPaid?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rentpaid'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rentPaid = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _arrearsAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.arrearsamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _arrearsAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_payment_date'.tr()}: ${_lastPaymentDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastPaymentDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastPaymentDate = d);
              },
            ),
            SwitchListTile(
              title: Text('mobile.auto.noticesent'.tr()),
              value: _noticeSent ?? false,
              onChanged: (v) => setState(() => _noticeSent = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_notice_date'.tr()}: ${_noticeDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _noticeDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _noticeDate = d);
              },
            ),
            TextFormField(
              initialValue: _noticeType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.noticetype'.tr()),
              onChanged: (v) => _noticeType = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.legalaction'.tr()),
              value: _legalAction ?? false,
              onChanged: (v) => setState(() => _legalAction = v),
            ),
            TextFormField(
              initialValue: _legalReference?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.legalreference'.tr()),
              onChanged: (v) => _legalReference = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_court_date'.tr()}: ${_courtDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _courtDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _courtDate = d);
              },
            ),
            TextFormField(
              initialValue: _recoveryAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.recoveryamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _recoveryAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _writeOffAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.writeoffamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _writeOffAmount = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_tenantId != null) 'tenantId': _tenantId,
                  if (_periodStart != null)
                    'periodStart': _periodStart!.toIso8601String(),
                  if (_periodEnd != null)
                    'periodEnd': _periodEnd!.toIso8601String(),
                  if (_rentDue != null) 'rentDue': _rentDue,
                  if (_rentPaid != null) 'rentPaid': _rentPaid,
                  if (_arrearsAmount != null) 'arrearsAmount': _arrearsAmount,
                  if (_status != null) 'status': _status,
                  if (_lastPaymentDate != null)
                    'lastPaymentDate': _lastPaymentDate!.toIso8601String(),
                  'noticeSent': _noticeSent,
                  if (_noticeDate != null)
                    'noticeDate': _noticeDate!.toIso8601String(),
                  if (_noticeType != null) 'noticeType': _noticeType,
                  'legalAction': _legalAction,
                  if (_legalReference != null)
                    'legalReference': _legalReference,
                  if (_courtDate != null)
                    'courtDate': _courtDate!.toIso8601String(),
                  if (_recoveryAmount != null)
                    'recoveryAmount': _recoveryAmount,
                  if (_writeOffAmount != null)
                    'writeOffAmount': _writeOffAmount,
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
                  widget.onSubmit(RentArrears.fromJson(json));
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
