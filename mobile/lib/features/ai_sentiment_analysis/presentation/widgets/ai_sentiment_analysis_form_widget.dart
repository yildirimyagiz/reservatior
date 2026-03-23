import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AISentimentAnalysis Form Widget  |  Fields: contentType, contentId, contentText, sentiment, sentimentScore, confidence, keyPhrases, emotions, analyzedAt

class AISentimentAnalysisFormWidget extends StatefulWidget {
  final AISentimentAnalysis? item;
  final void Function(AISentimentAnalysis)? onSubmit;
  const AISentimentAnalysisFormWidget({super.key, this.item, this.onSubmit});
  @override State<AISentimentAnalysisFormWidget> createState() => _AISentimentAnalysisFormWidgetState();
}

class _AISentimentAnalysisFormWidgetState extends State<AISentimentAnalysisFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _contentType;
  String? _contentId;
  String? _contentText;
  String? _sentiment;
  double? _sentimentScore;
  double? _confidence;
  String? _keyPhrases;
  String? _emotions;
  DateTime? _analyzedAt;

  @override
  void initState() {
    super.initState();
    _contentType = widget.item?.contentType?.toString();
    _contentId = widget.item?.contentId?.toString();
    _contentText = widget.item?.contentText?.toString();
    _sentiment = widget.item?.sentiment?.toString();
    _sentimentScore = widget.item?.sentimentScore;
    _confidence = widget.item?.confidence;
    _keyPhrases = widget.item?.keyPhrases?.toString();
    _emotions = widget.item?.emotions?.toString();
    _analyzedAt = widget.item?.analyzedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_contentType?.isNotEmpty == true) 'contentType': _contentType,
        if (_contentId?.isNotEmpty == true) 'contentId': _contentId,
        if (_contentText?.isNotEmpty == true) 'contentText': _contentText,
        if (_sentiment?.isNotEmpty == true) 'sentiment': _sentiment,
        if (_sentimentScore != null) 'sentimentScore': _sentimentScore,
        if (_confidence != null) 'confidence': _confidence,
        if (_keyPhrases?.isNotEmpty == true) 'keyPhrases': _keyPhrases,
        if (_emotions?.isNotEmpty == true) 'emotions': _emotions,
        if (_analyzedAt != null) 'analyzedAt': _analyzedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? AISentimentAnalysis.fromJson({...widget.item!.toJson(), ...data})
        : AISentimentAnalysis.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Content Type', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                onSaved: (v) => _contentType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Content Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _contentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Content Text', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                onSaved: (v) => _contentText = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sentiment', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _sentiment = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sentiment Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _sentimentScore = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidence = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Key Phrases', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _keyPhrases = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Emotions', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _emotions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _analyzedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _analyzedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Analyzed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_analyzedAt != null ? _fmt(_analyzedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Sentiment Analysis'),
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