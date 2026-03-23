import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── VacationRentalPlatform Form Widget  |  Fields: rentalId, platform, externalId, externalUrl, status, lastSyncedAt, syncEnabled

class VacationRentalPlatformFormWidget extends StatefulWidget {
  final VacationRentalPlatform? item;
  final void Function(VacationRentalPlatform)? onSubmit;
  const VacationRentalPlatformFormWidget({super.key, this.item, this.onSubmit});
  @override State<VacationRentalPlatformFormWidget> createState() => _VacationRentalPlatformFormWidgetState();
}

class _VacationRentalPlatformFormWidgetState extends State<VacationRentalPlatformFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _rentalId;
  String? _platform;
  String? _externalId;
  String? _externalUrl;
  String? _status;
  DateTime? _lastSyncedAt;
  bool _syncEnabled = false;

  @override
  void initState() {
    super.initState();
    _rentalId = widget.item?.rentalId?.toString();
    _platform = widget.item?.platform?.toString();
    _externalId = widget.item?.externalId?.toString();
    _externalUrl = widget.item?.externalUrl?.toString();
    _status = widget.item?.status?.toString();
    _lastSyncedAt = widget.item?.lastSyncedAt;
    _syncEnabled = widget.item?.syncEnabled ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_rentalId?.isNotEmpty == true) 'rentalId': _rentalId,
        if (_platform?.isNotEmpty == true) 'platform': _platform,
        if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
        if (_externalUrl?.isNotEmpty == true) 'externalUrl': _externalUrl,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_lastSyncedAt != null) 'lastSyncedAt': _lastSyncedAt!.toIso8601String(),
        'syncEnabled': _syncEnabled,
    };
    final result = widget.item != null
        ? VacationRentalPlatform.fromJson({...widget.item!.toJson(), ...data})
        : VacationRentalPlatform.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Rental Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _rentalId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Platform', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _platform = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'External Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'External Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _externalUrl = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _lastSyncedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastSyncedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Synced At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastSyncedAt != null ? _fmt(_lastSyncedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Sync Enabled'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _syncEnabled,
                  onChanged: (v) { ss(() {}); setState(() => _syncEnabled = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Vacation Rental Platform'),
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