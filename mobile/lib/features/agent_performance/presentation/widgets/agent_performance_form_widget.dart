import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AgentPerformance Form Widget  |  Fields: userId, period, startDate, endDate, leadsGenerated, showingsCompleted, offersSubmitted, dealsClosed, commissionEarned

class AgentPerformanceFormWidget extends StatefulWidget {
  final AgentPerformance? item;
  final void Function(AgentPerformance)? onSubmit;
  const AgentPerformanceFormWidget({super.key, this.item, this.onSubmit});
  @override State<AgentPerformanceFormWidget> createState() => _AgentPerformanceFormWidgetState();
}

class _AgentPerformanceFormWidgetState extends State<AgentPerformanceFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _period;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _leadsGenerated;
  int? _showingsCompleted;
  int? _offersSubmitted;
  int? _dealsClosed;
  double? _commissionEarned;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _period = widget.item?.period?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _leadsGenerated = widget.item?.leadsGenerated;
    _showingsCompleted = widget.item?.showingsCompleted;
    _offersSubmitted = widget.item?.offersSubmitted;
    _dealsClosed = widget.item?.dealsClosed;
    _commissionEarned = widget.item?.commissionEarned;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_period?.isNotEmpty == true) 'period': _period,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_leadsGenerated != null) 'leadsGenerated': _leadsGenerated,
        if (_showingsCompleted != null) 'showingsCompleted': _showingsCompleted,
        if (_offersSubmitted != null) 'offersSubmitted': _offersSubmitted,
        if (_dealsClosed != null) 'dealsClosed': _dealsClosed,
        if (_commissionEarned != null) 'commissionEarned': _commissionEarned,
    };
    final result = widget.item != null
        ? AgentPerformance.fromJson({...widget.item!.toJson(), ...data})
        : AgentPerformance.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Period', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _period = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endDate != null ? _fmt(_endDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Leads Generated', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _leadsGenerated = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Showings Completed', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _showingsCompleted = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Offers Submitted', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _offersSubmitted = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Deals Closed', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _dealsClosed = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Earned', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _commissionEarned = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Agent Performance'),
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