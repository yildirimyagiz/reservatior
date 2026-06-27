import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class CurrencyFormWidget extends ConsumerStatefulWidget {
  final Currency? item;
  final Function(Currency) onSubmit;
  const CurrencyFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<CurrencyFormWidget> createState() => _CurrencyFormWidgetState();
}

class _CurrencyFormWidgetState extends ConsumerState<CurrencyFormWidget> {
  String? _code;
  String? _name;
  String? _symbol;
  double? _exchangeRate;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _code = widget.item?.code;
    _name = widget.item?.name;
    _symbol = widget.item?.symbol;
    _exchangeRate = widget.item?.exchangeRate;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.currency'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.currency'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _code?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.code'.tr()),
              onChanged: (v) => _code = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _symbol?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.symbol'.tr()),
              onChanged: (v) => _symbol = v,
            ),
            TextFormField(
              initialValue: _exchangeRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.exchangerate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _exchangeRate = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_code != null) 'code': _code,
                  if (_name != null) 'name': _name,
                  if (_symbol != null) 'symbol': _symbol,
                  if (_exchangeRate != null) 'exchangeRate': _exchangeRate,
                  'isActive': _isActive,
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
                  widget.onSubmit(Currency.fromJson(json));
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
