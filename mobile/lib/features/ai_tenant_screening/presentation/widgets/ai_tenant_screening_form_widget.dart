import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AITenantScreening Form Widget  |  Fields: applicationId, overallScore, riskAssessment, creditScore, incomeStability, rentalHistory, backgroundCheck, riskFactors, recommendations, screenedAt, reviewedBy, finalDecision

class AITenantScreeningFormWidget extends StatefulWidget {
  final AITenantScreening? item;
  final void Function(AITenantScreening)? onSubmit;
  const AITenantScreeningFormWidget({super.key, this.item, this.onSubmit});
  @override State<AITenantScreeningFormWidget> createState() => _AITenantScreeningFormWidgetState();
}

class _AITenantScreeningFormWidgetState extends State<AITenantScreeningFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _applicationId;
  double? _overallScore;
  String? _riskAssessment;
  double? _creditScore;
  double? _incomeStability;
  double? _rentalHistory;
  double? _backgroundCheck;
  String? _riskFactors;
  String? _recommendations;
  DateTime? _screenedAt;
  String? _reviewedBy;
  String? _finalDecision;

  @override
  void initState() {
    super.initState();
    _applicationId = widget.item?.applicationId?.toString();
    _overallScore = widget.item?.overallScore;
    _riskAssessment = widget.item?.riskAssessment?.toString();
    _creditScore = widget.item?.creditScore;
    _incomeStability = widget.item?.incomeStability;
    _rentalHistory = widget.item?.rentalHistory;
    _backgroundCheck = widget.item?.backgroundCheck;
    _riskFactors = widget.item?.riskFactors?.toString();
    _recommendations = widget.item?.recommendations?.toString();
    _screenedAt = widget.item?.screenedAt;
    _reviewedBy = widget.item?.reviewedBy?.toString();
    _finalDecision = widget.item?.finalDecision?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_applicationId?.isNotEmpty == true) 'applicationId': _applicationId,
        if (_overallScore != null) 'overallScore': _overallScore,
        if (_riskAssessment?.isNotEmpty == true) 'riskAssessment': _riskAssessment,
        if (_creditScore != null) 'creditScore': _creditScore,
        if (_incomeStability != null) 'incomeStability': _incomeStability,
        if (_rentalHistory != null) 'rentalHistory': _rentalHistory,
        if (_backgroundCheck != null) 'backgroundCheck': _backgroundCheck,
        if (_riskFactors?.isNotEmpty == true) 'riskFactors': _riskFactors,
        if (_recommendations?.isNotEmpty == true) 'recommendations': _recommendations,
        if (_screenedAt != null) 'screenedAt': _screenedAt!.toIso8601String(),
        if (_reviewedBy?.isNotEmpty == true) 'reviewedBy': _reviewedBy,
        if (_finalDecision?.isNotEmpty == true) 'finalDecision': _finalDecision,
    };
    final result = widget.item != null
        ? AITenantScreening.fromJson({...widget.item!.toJson(), ...data})
        : AITenantScreening.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Application Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _applicationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Overall Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _overallScore = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Risk Assessment', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _riskAssessment = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Credit Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _creditScore = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Income Stability', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _incomeStability = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rental History', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _rentalHistory = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Background Check', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _backgroundCheck = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Risk Factors', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _riskFactors = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recommendations', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _recommendations = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _screenedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _screenedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Screened At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_screenedAt != null ? _fmt(_screenedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reviewed By', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _reviewedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Final Decision', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _finalDecision = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Tenant Screening'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}