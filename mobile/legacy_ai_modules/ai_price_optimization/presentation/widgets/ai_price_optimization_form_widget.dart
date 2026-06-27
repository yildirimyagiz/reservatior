import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiPriceOptimizationFormWidget extends ConsumerStatefulWidget {
  final AiPriceOptimization? item;
  final Function(AiPriceOptimization) onSubmit;
  const AiPriceOptimizationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiPriceOptimizationFormWidget> createState() =>
      _AiPriceOptimizationFormWidgetState();
}

class _AiPriceOptimizationFormWidgetState
    extends ConsumerState<AiPriceOptimizationFormWidget> {
  String? _listingId;
  double? _currentPrice;
  double? _recommendedPrice;
  double? _confidence;
  DateTime? _generatedAt;
  bool? _isApplied;
  DateTime? _appliedAt;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _currentPrice = widget.item?.currentPrice;
    _recommendedPrice = widget.item?.recommendedPrice;
    _confidence = widget.item?.confidence;
    _generatedAt = widget.item?.generatedAt;
    _isApplied = widget.item?.isApplied;
    _appliedAt = widget.item?.appliedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aipriceoptimization'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aipriceoptimization'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _currentPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currentprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _currentPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _recommendedPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.recommendedprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _recommendedPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _confidence?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidence'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidence = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_generated_at'.tr()}: ${_generatedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _generatedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _generatedAt = d);
              },
            ),
            SwitchListTile(
              title: Text('mobile.auto.isapplied'.tr()),
              value: _isApplied ?? false,
              onChanged: (v) => setState(() => _isApplied = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_applied_at'.tr()}: ${_appliedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _appliedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _appliedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_currentPrice != null) 'currentPrice': _currentPrice,
                  if (_recommendedPrice != null)
                    'recommendedPrice': _recommendedPrice,
                  if (_confidence != null) 'confidence': _confidence,
                  if (_generatedAt != null)
                    'generatedAt': _generatedAt!.toIso8601String(),
                  'isApplied': _isApplied,
                  if (_appliedAt != null)
                    'appliedAt': _appliedAt!.toIso8601String(),
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
                  widget.onSubmit(AiPriceOptimization.fromJson(json));
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
