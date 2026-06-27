import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiTenantScreeningFormWidget extends ConsumerStatefulWidget {
  final AiTenantScreening? item;
  final Function(AiTenantScreening) onSubmit;
  const AiTenantScreeningFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiTenantScreeningFormWidget> createState() =>
      _AiTenantScreeningFormWidgetState();
}

class _AiTenantScreeningFormWidgetState
    extends ConsumerState<AiTenantScreeningFormWidget> {
  String? _applicationId;
  double? _overallScore;
  String? _riskAssessment;
  double? _creditScore;
  double? _incomeStability;
  double? _rentalHistory;
  double? _backgroundCheck;
  DateTime? _screenedAt;
  String? _reviewedBy;
  String? _finalDecision;
  @override
  void initState() {
    super.initState();
    _applicationId = widget.item?.applicationId;
    _overallScore = widget.item?.overallScore;
    _riskAssessment = widget.item?.riskAssessment;
    _creditScore = widget.item?.creditScore;
    _incomeStability = widget.item?.incomeStability;
    _rentalHistory = widget.item?.rentalHistory;
    _backgroundCheck = widget.item?.backgroundCheck;
    _screenedAt = widget.item?.screenedAt;
    _reviewedBy = widget.item?.reviewedBy;
    _finalDecision = widget.item?.finalDecision;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aitenantscreening'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aitenantscreening'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _applicationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.applicationid'.tr()),
              onChanged: (v) => _applicationId = v,
            ),
            TextFormField(
              initialValue: _overallScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.overallscore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _overallScore = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _riskAssessment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.riskassessment'.tr()),
              onChanged: (v) => _riskAssessment = v,
            ),
            TextFormField(
              initialValue: _creditScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.creditscore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _creditScore = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _incomeStability?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.incomestability'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _incomeStability = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _rentalHistory?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rentalhistory'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rentalHistory = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _backgroundCheck?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.backgroundcheck'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _backgroundCheck = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_screened_at'.tr()}: ${_screenedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _screenedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _screenedAt = d);
              },
            ),
            TextFormField(
              initialValue: _reviewedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reviewedby'.tr()),
              onChanged: (v) => _reviewedBy = v,
            ),
            TextFormField(
              initialValue: _finalDecision?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.finaldecision'.tr()),
              onChanged: (v) => _finalDecision = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_applicationId != null) 'applicationId': _applicationId,
                  if (_overallScore != null) 'overallScore': _overallScore,
                  if (_riskAssessment != null)
                    'riskAssessment': _riskAssessment,
                  if (_creditScore != null) 'creditScore': _creditScore,
                  if (_incomeStability != null)
                    'incomeStability': _incomeStability,
                  if (_rentalHistory != null) 'rentalHistory': _rentalHistory,
                  if (_backgroundCheck != null)
                    'backgroundCheck': _backgroundCheck,
                  if (_screenedAt != null)
                    'screenedAt': _screenedAt!.toIso8601String(),
                  if (_reviewedBy != null) 'reviewedBy': _reviewedBy,
                  if (_finalDecision != null) 'finalDecision': _finalDecision,
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
                  widget.onSubmit(AiTenantScreening.fromJson(json));
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
