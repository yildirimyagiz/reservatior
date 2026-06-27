import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ExchangeRateFormWidget extends ConsumerStatefulWidget {
  final ExchangeRate? item;
  final Function(ExchangeRate) onSubmit;
  const ExchangeRateFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ExchangeRateFormWidget> createState() =>
      _ExchangeRateFormWidgetState();
}

class _ExchangeRateFormWidgetState
    extends ConsumerState<ExchangeRateFormWidget> {
  String? _baseCurrency;
  String? _quoteCurrency;
  double? _rate;
  DateTime? _asOfDate;
  String? _source;
  @override
  void initState() {
    super.initState();
    _baseCurrency = widget.item?.baseCurrency;
    _quoteCurrency = widget.item?.quoteCurrency;
    _rate = widget.item?.rate;
    _asOfDate = widget.item?.asOfDate;
    _source = widget.item?.source;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.exchangerate'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.exchangerate'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _baseCurrency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.basecurrency'.tr()),
              onChanged: (v) => _baseCurrency = v,
            ),
            TextFormField(
              initialValue: _quoteCurrency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.quotecurrency'.tr()),
              onChanged: (v) => _quoteCurrency = v,
            ),
            TextFormField(
              initialValue: _rate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rate = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_as_of_date'.tr()}: ${_asOfDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _asOfDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _asOfDate = d);
              },
            ),
            TextFormField(
              initialValue: _source?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.source'.tr()),
              onChanged: (v) => _source = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_baseCurrency != null) 'baseCurrency': _baseCurrency,
                  if (_quoteCurrency != null) 'quoteCurrency': _quoteCurrency,
                  if (_rate != null) 'rate': _rate,
                  if (_asOfDate != null)
                    'asOfDate': _asOfDate!.toIso8601String(),
                  if (_source != null) 'source': _source,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(ExchangeRate.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
