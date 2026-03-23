import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── RecommendationResult Form Widget  |  Fields: profileId, listingId, score, explanation, breakdown

class RecommendationResultFormWidget extends StatefulWidget {
  final RecommendationResult? item;
  final void Function(RecommendationResult)? onSubmit;
  const RecommendationResultFormWidget({super.key, this.item, this.onSubmit});
  @override State<RecommendationResultFormWidget> createState() => _RecommendationResultFormWidgetState();
}

class _RecommendationResultFormWidgetState extends State<RecommendationResultFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _profileId;
  String? _listingId;
  int? _score;
  String? _explanation;
  String? _breakdown;

  @override
  void initState() {
    super.initState();
    _profileId = widget.item?.profileId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _score = widget.item?.score;
    _explanation = widget.item?.explanation?.toString();
    _breakdown = widget.item?.breakdown?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_profileId?.isNotEmpty == true) 'profileId': _profileId,
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_score != null) 'score': _score,
        if (_explanation?.isNotEmpty == true) 'explanation': _explanation,
        if (_breakdown?.isNotEmpty == true) 'breakdown': _breakdown,
    };
    final result = widget.item != null
        ? RecommendationResult.fromJson({...widget.item!.toJson(), ...data})
        : RecommendationResult.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Profile Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _profileId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _score = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Explanation', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _explanation = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Breakdown', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _breakdown = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Recommendation Result'),
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