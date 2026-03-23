import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIRecommendation Form Widget  |  Fields: userType, userId, sessionId, recommendedProperties, recommendationType, userPreferences, reasoning, generatedAt, expiresAt

class AIRecommendationFormWidget extends StatefulWidget {
  final AIRecommendation? item;
  final void Function(AIRecommendation)? onSubmit;
  const AIRecommendationFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIRecommendationFormWidget> createState() => _AIRecommendationFormWidgetState();
}

class _AIRecommendationFormWidgetState extends State<AIRecommendationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userType;
  String? _userId;
  String? _sessionId;
  String? _recommendedProperties;
  String? _recommendationType;
  String? _userPreferences;
  String? _reasoning;
  DateTime? _generatedAt;
  DateTime? _expiresAt;

  @override
  void initState() {
    super.initState();
    _userType = widget.item?.userType?.toString();
    _userId = widget.item?.userId?.toString();
    _sessionId = widget.item?.sessionId?.toString();
    _recommendedProperties = widget.item?.recommendedProperties?.toString();
    _recommendationType = widget.item?.recommendationType?.toString();
    _userPreferences = widget.item?.userPreferences?.toString();
    _reasoning = widget.item?.reasoning?.toString();
    _generatedAt = widget.item?.generatedAt;
    _expiresAt = widget.item?.expiresAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userType?.isNotEmpty == true) 'userType': _userType,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_sessionId?.isNotEmpty == true) 'sessionId': _sessionId,
        if (_recommendedProperties?.isNotEmpty == true) 'recommendedProperties': _recommendedProperties,
        if (_recommendationType?.isNotEmpty == true) 'recommendationType': _recommendationType,
        if (_userPreferences?.isNotEmpty == true) 'userPreferences': _userPreferences,
        if (_reasoning?.isNotEmpty == true) 'reasoning': _reasoning,
        if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? AIRecommendation.fromJson({...widget.item!.toJson(), ...data})
        : AIRecommendation.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'User Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _userType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Session Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _sessionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recommended Properties', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _recommendedProperties = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recommendation Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _recommendationType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'User Preferences', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _userPreferences = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reasoning', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _reasoning = v?.isEmpty == true ? null : v,
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
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _expiresAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiresAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Expires At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_expiresAt != null ? _fmt(_expiresAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Recommendation'),
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