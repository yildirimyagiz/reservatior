import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ContractVersionFormWidget extends ConsumerStatefulWidget {
  final ContractVersion? item;
  final Function(ContractVersion) onSubmit;
  const ContractVersionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ContractVersionFormWidget> createState() =>
      _ContractVersionFormWidgetState();
}

class _ContractVersionFormWidgetState
    extends ConsumerState<ContractVersionFormWidget> {
  String? _contractId;
  int? _version;
  String? _documentUrl;
  String? _checksum;
  @override
  void initState() {
    super.initState();
    _contractId = widget.item?.contractId;
    _version = widget.item?.version;
    _documentUrl = widget.item?.documentUrl;
    _checksum = widget.item?.checksum;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.contractversion'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.contractversion'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _contractId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contractid'.tr()),
              onChanged: (v) => _contractId = v,
            ),
            TextFormField(
              initialValue: _version?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.version'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _version = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _documentUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.documenturl'.tr()),
              onChanged: (v) => _documentUrl = v,
            ),
            TextFormField(
              initialValue: _checksum?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checksum'.tr()),
              onChanged: (v) => _checksum = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_contractId != null) 'contractId': _contractId,
                  if (_version != null) 'version': _version,
                  if (_documentUrl != null) 'documentUrl': _documentUrl,
                  if (_checksum != null) 'checksum': _checksum,
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
                  widget.onSubmit(ContractVersion.fromJson(json));
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
