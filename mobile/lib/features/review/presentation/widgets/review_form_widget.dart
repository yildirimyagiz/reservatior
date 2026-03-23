import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Review Form Widget  |  Fields: reviewerId, targetId, targetType, rating, title, comment, isVerified, responses

class ReviewFormWidget extends StatefulWidget {
  final Review? item;
  final void Function(Review)? onSubmit;
  const ReviewFormWidget({super.key, this.item, this.onSubmit});
  @override State<ReviewFormWidget> createState() => _ReviewFormWidgetState();
}

class _ReviewFormWidgetState extends State<ReviewFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _reviewerId;
  String? _targetId;
  String? _targetType;
  int? _rating;
  String? _title;
  String? _comment;
  bool _isVerified = false;
  String? _responses;

  @override
  void initState() {
    super.initState();
    _reviewerId = widget.item?.reviewerId?.toString();
    _targetId = widget.item?.targetId?.toString();
    _targetType = widget.item?.targetType?.toString();
    _rating = widget.item?.rating;
    _title = widget.item?.title?.toString();
    _comment = widget.item?.comment?.toString();
    _isVerified = widget.item?.isVerified ?? false;
    _responses = widget.item?.responses?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_reviewerId?.isNotEmpty == true) 'reviewerId': _reviewerId,
        if (_targetId?.isNotEmpty == true) 'targetId': _targetId,
        if (_targetType?.isNotEmpty == true) 'targetType': _targetType,
        if (_rating != null) 'rating': _rating,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_comment?.isNotEmpty == true) 'comment': _comment,
        'isVerified': _isVerified,
        if (_responses?.isNotEmpty == true) 'responses': _responses,
    };
    final result = widget.item != null
        ? Review.fromJson({...widget.item!.toJson(), ...data})
        : Review.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Reviewer Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reviewerId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Target Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _targetId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Target Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _targetType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rating', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _rating = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Comment', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _comment = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Verified'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isVerified,
                  onChanged: (v) { ss(() {}); setState(() => _isVerified = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Responses', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _responses = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Review'),
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