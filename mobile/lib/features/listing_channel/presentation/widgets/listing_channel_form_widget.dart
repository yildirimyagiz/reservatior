import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ListingChannel Form Widget  |  Fields: listingId, channel, channelId, status, lastSync

class ListingChannelFormWidget extends StatefulWidget {
  final ListingChannel? item;
  final void Function(ListingChannel)? onSubmit;
  const ListingChannelFormWidget({super.key, this.item, this.onSubmit});
  @override State<ListingChannelFormWidget> createState() => _ListingChannelFormWidgetState();
}

class _ListingChannelFormWidgetState extends State<ListingChannelFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _channel;
  String? _channelId;
  String? _status;
  DateTime? _lastSync;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _channel = widget.item?.channel?.toString();
    _channelId = widget.item?.channelId?.toString();
    _status = widget.item?.status?.toString();
    _lastSync = widget.item?.lastSync;
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
        if (_channel?.isNotEmpty == true) 'channel': _channel,
        if (_channelId?.isNotEmpty == true) 'channelId': _channelId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_lastSync != null) 'lastSync': _lastSync!.toIso8601String(),
    };
    final result = widget.item != null
        ? ListingChannel.fromJson({...widget.item!.toJson(), ...data})
        : ListingChannel.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Channel', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _channel = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Channel Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _channelId = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _lastSync ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastSync = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Sync',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastSync != null ? _fmt(_lastSync) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Listing Channel'),
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