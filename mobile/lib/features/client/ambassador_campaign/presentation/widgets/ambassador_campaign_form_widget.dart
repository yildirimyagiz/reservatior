import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AmbassadorCampaignFormWidget extends ConsumerStatefulWidget {
  final AmbassadorCampaign? item;
  final Function(AmbassadorCampaign) onSubmit;
  const AmbassadorCampaignFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AmbassadorCampaignFormWidget> createState() =>
      _AmbassadorCampaignFormWidgetState();
}

class _AmbassadorCampaignFormWidgetState
    extends ConsumerState<AmbassadorCampaignFormWidget> {
  String? _ambassadorId;
  String? _name;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _budget;
  double? _actualSpend;
  String? _currency;
  int? _targetReach;
  int? _actualReach;
  int? _impressions;
  int? _clicks;
  int? _conversions;
  double? _conversionValue;
  double? _roi;
  @override
  void initState() {
    super.initState();
    _ambassadorId = widget.item?.ambassadorId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _budget = widget.item?.budget;
    _actualSpend = widget.item?.actualSpend;
    _currency = widget.item?.currency;
    _targetReach = widget.item?.targetReach;
    _actualReach = widget.item?.actualReach;
    _impressions = widget.item?.impressions;
    _clicks = widget.item?.clicks;
    _conversions = widget.item?.conversions;
    _conversionValue = widget.item?.conversionValue;
    _roi = widget.item?.roi;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.ambassadorcampaign'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.ambassadorcampaign'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _ambassadorId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ambassadorid'.tr()),
              onChanged: (v) => _ambassadorId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
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
            TextFormField(
              initialValue: _budget?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.budget'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _budget = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _actualSpend?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.actualspend'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _actualSpend = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _targetReach?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.targetreach'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _targetReach = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _actualReach?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.actualreach'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _actualReach = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _impressions?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.impressions'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _impressions = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _clicks?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.clicks'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _clicks = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _conversions?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.conversions'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _conversions = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _conversionValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.conversionvalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _conversionValue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _roi?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.roi'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _roi = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_ambassadorId != null) 'ambassadorId': _ambassadorId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_budget != null) 'budget': _budget,
                  if (_actualSpend != null) 'actualSpend': _actualSpend,
                  if (_currency != null) 'currency': _currency,
                  if (_targetReach != null) 'targetReach': _targetReach,
                  if (_actualReach != null) 'actualReach': _actualReach,
                  if (_impressions != null) 'impressions': _impressions,
                  if (_clicks != null) 'clicks': _clicks,
                  if (_conversions != null) 'conversions': _conversions,
                  if (_conversionValue != null)
                    'conversionValue': _conversionValue,
                  if (_roi != null) 'roi': _roi,
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
                  widget.onSubmit(AmbassadorCampaign.fromJson(json));
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
