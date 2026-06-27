import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PredictiveModelFormWidget extends ConsumerStatefulWidget {
  final PredictiveModel? item;
  final Function(PredictiveModel) onSubmit;
  const PredictiveModelFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PredictiveModelFormWidget> createState() =>
      _PredictiveModelFormWidgetState();
}

class _PredictiveModelFormWidgetState
    extends ConsumerState<PredictiveModelFormWidget> {
  double? _accuracy;
  DateTime? _lastTrained;
  @override
  void initState() {
    super.initState();
    _accuracy = widget.item?.accuracy;
    _lastTrained = widget.item?.lastTrained;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.predictivemodel'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.predictivemodel'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _accuracy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.accuracy'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _accuracy = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_trained'.tr()}: ${_lastTrained ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastTrained ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastTrained = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_accuracy != null) 'accuracy': _accuracy,
                  if (_lastTrained != null)
                    'lastTrained': _lastTrained!.toIso8601String(),
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
                  widget.onSubmit(PredictiveModel.fromJson(json));
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
