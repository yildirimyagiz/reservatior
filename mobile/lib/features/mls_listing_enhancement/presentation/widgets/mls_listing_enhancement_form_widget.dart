import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MlsListingEnhancement Form Widget  |  Fields: listingId, mlsNumber, mlsStatus, mlsPhotos, mlsDocuments, mlsHistory, lastMlsUpdate

class MlsListingEnhancementFormWidget extends StatefulWidget {
  final MlsListingEnhancement? item;
  final void Function(MlsListingEnhancement)? onSubmit;
  const MlsListingEnhancementFormWidget({super.key, this.item, this.onSubmit});
  @override State<MlsListingEnhancementFormWidget> createState() => _MlsListingEnhancementFormWidgetState();
}

class _MlsListingEnhancementFormWidgetState extends State<MlsListingEnhancementFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _mlsNumber;
  String? _mlsStatus;
  String? _mlsPhotos;
  String? _mlsDocuments;
  String? _mlsHistory;
  DateTime? _lastMlsUpdate;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _mlsNumber = widget.item?.mlsNumber?.toString();
    _mlsStatus = widget.item?.mlsStatus?.toString();
    _mlsPhotos = widget.item?.mlsPhotos?.toString();
    _mlsDocuments = widget.item?.mlsDocuments?.toString();
    _mlsHistory = widget.item?.mlsHistory?.toString();
    _lastMlsUpdate = widget.item?.lastMlsUpdate;
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
        if (_mlsNumber?.isNotEmpty == true) 'mlsNumber': _mlsNumber,
        if (_mlsStatus?.isNotEmpty == true) 'mlsStatus': _mlsStatus,
        if (_mlsPhotos?.isNotEmpty == true) 'mlsPhotos': _mlsPhotos,
        if (_mlsDocuments?.isNotEmpty == true) 'mlsDocuments': _mlsDocuments,
        if (_mlsHistory?.isNotEmpty == true) 'mlsHistory': _mlsHistory,
        if (_lastMlsUpdate != null) 'lastMlsUpdate': _lastMlsUpdate!.toIso8601String(),
    };
    final result = widget.item != null
        ? MlsListingEnhancement.fromJson({...widget.item!.toJson(), ...data})
        : MlsListingEnhancement.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Mls Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mlsNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mls Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _mlsStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mls Photos', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mlsPhotos = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mls Documents', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mlsDocuments = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mls History', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mlsHistory = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastMlsUpdate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastMlsUpdate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Mls Update',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastMlsUpdate != null ? _fmt(_lastMlsUpdate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Mls Listing Enhancement'),
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