import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ScrapingJob Form Widget  |  Fields: jobType, status, startTime, endTime, projectsScraped, configuration

class ScrapingJobFormWidget extends StatefulWidget {
  final ScrapingJob? item;
  final void Function(ScrapingJob)? onSubmit;
  const ScrapingJobFormWidget({super.key, this.item, this.onSubmit});
  @override State<ScrapingJobFormWidget> createState() => _ScrapingJobFormWidgetState();
}

class _ScrapingJobFormWidgetState extends State<ScrapingJobFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _jobType;
  String? _status;
  DateTime? _startTime;
  DateTime? _endTime;
  int? _projectsScraped;
  String? _configuration;

  @override
  void initState() {
    super.initState();
    _jobType = widget.item?.jobType?.toString();
    _status = widget.item?.status?.toString();
    _startTime = widget.item?.startTime;
    _endTime = widget.item?.endTime;
    _projectsScraped = widget.item?.projectsScraped;
    _configuration = widget.item?.configuration?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_jobType?.isNotEmpty == true) 'jobType': _jobType,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_startTime != null) 'startTime': _startTime!.toIso8601String(),
        if (_endTime != null) 'endTime': _endTime!.toIso8601String(),
        if (_projectsScraped != null) 'projectsScraped': _projectsScraped,
        if (_configuration?.isNotEmpty == true) 'configuration': _configuration,
    };
    final result = widget.item != null
        ? ScrapingJob.fromJson({...widget.item!.toJson(), ...data})
        : ScrapingJob.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Job Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _jobType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startTime ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startTime = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Time',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startTime != null ? _fmt(_startTime) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endTime ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endTime = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Time',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endTime != null ? _fmt(_endTime) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Projects Scraped', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _projectsScraped = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Configuration', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _configuration = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Scraping Job'),
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