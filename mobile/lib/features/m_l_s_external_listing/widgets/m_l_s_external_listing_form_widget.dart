import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MLSExternalListing Form Widget  |  Fields: connectionId, externalId, externalUrl, raw, mappedListingId, status, lastSeenAt

class MLSExternalListingFormWidget extends StatefulWidget {
  final MLSExternalListing? item;
  final void Function(MLSExternalListing)? onSubmit;
  const MLSExternalListingFormWidget({super.key, this.item, this.onSubmit});
  @override State<MLSExternalListingFormWidget> createState() => _MLSExternalListingFormWidgetState();
}

class _MLSExternalListingFormWidgetState extends State<MLSExternalListingFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _connectionId;
  String? _externalId;
  String? _externalUrl;
  String? _raw;
  String? _mappedListingId;
  String? _status;
  DateTime? _lastSeenAt;

  @override
  void initState() {
    super.initState();
    _connectionId = widget.item?.connectionId?.toString();
    _externalId = widget.item?.externalId?.toString();
    _externalUrl = widget.item?.externalUrl?.toString();
    _raw = widget.item?.raw?.toString();
    _mappedListingId = widget.item?.mappedListingId?.toString();
    _status = widget.item?.status?.toString();
    _lastSeenAt = widget.item?.lastSeenAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_connectionId?.isNotEmpty == true) 'connectionId': _connectionId,
        if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
        if (_externalUrl?.isNotEmpty == true) 'externalUrl': _externalUrl,
        if (_raw?.isNotEmpty == true) 'raw': _raw,
        if (_mappedListingId?.isNotEmpty == true) 'mappedListingId': _mappedListingId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_lastSeenAt != null) 'lastSeenAt': _lastSeenAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? MLSExternalListing.fromJson({...widget.item!.toJson(), ...data})
        : MLSExternalListing.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Connection Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _connectionId = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Raw', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _raw = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mapped Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _mappedListingId = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _lastSeenAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastSeenAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Seen At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastSeenAt != null ? _fmt(_lastSeenAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create M L S External Listing'),
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