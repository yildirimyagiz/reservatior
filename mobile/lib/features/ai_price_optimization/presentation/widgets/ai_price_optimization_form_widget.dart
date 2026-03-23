import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIPriceOptimization Form Widget  |  Fields: listingId, currentPrice, recommendedPrice, priceRange, factors, comparableData, marketTrends, confidence, generatedAt, isApplied, appliedAt

class AIPriceOptimizationFormWidget extends StatefulWidget {
  final AIPriceOptimization? item;
  final void Function(AIPriceOptimization)? onSubmit;
  const AIPriceOptimizationFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIPriceOptimizationFormWidget> createState() => _AIPriceOptimizationFormWidgetState();
}

class _AIPriceOptimizationFormWidgetState extends State<AIPriceOptimizationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  double? _currentPrice;
  double? _recommendedPrice;
  String? _priceRange;
  String? _factors;
  String? _comparableData;
  String? _marketTrends;
  double? _confidence;
  DateTime? _generatedAt;
  bool _isApplied = false;
  DateTime? _appliedAt;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _currentPrice = widget.item?.currentPrice;
    _recommendedPrice = widget.item?.recommendedPrice;
    _priceRange = widget.item?.priceRange?.toString();
    _factors = widget.item?.factors?.toString();
    _comparableData = widget.item?.comparableData?.toString();
    _marketTrends = widget.item?.marketTrends?.toString();
    _confidence = widget.item?.confidence;
    _generatedAt = widget.item?.generatedAt;
    _isApplied = widget.item?.isApplied ?? false;
    _appliedAt = widget.item?.appliedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_currentPrice != null) 'currentPrice': _currentPrice,
        if (_recommendedPrice != null) 'recommendedPrice': _recommendedPrice,
        if (_priceRange?.isNotEmpty == true) 'priceRange': _priceRange,
        if (_factors?.isNotEmpty == true) 'factors': _factors,
        if (_comparableData?.isNotEmpty == true) 'comparableData': _comparableData,
        if (_marketTrends?.isNotEmpty == true) 'marketTrends': _marketTrends,
        if (_confidence != null) 'confidence': _confidence,
        if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
        'isApplied': _isApplied,
        if (_appliedAt != null) 'appliedAt': _appliedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? AIPriceOptimization.fromJson({...widget.item!.toJson(), ...data})
        : AIPriceOptimization.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Current Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _currentPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recommended Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _recommendedPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price Range', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _priceRange = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Factors', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _factors = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Comparable Data', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _comparableData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Market Trends', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _marketTrends = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidence = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _generatedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _generatedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Generated At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_generatedAt != null ? _fmt(_generatedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Applied'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isApplied,
                  onChanged: (v) { ss(() {}); setState(() => _isApplied = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _appliedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _appliedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Applied At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_appliedAt != null ? _fmt(_appliedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Price Optimization'),
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