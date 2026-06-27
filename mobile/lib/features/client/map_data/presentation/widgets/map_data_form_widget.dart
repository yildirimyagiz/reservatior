import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MapDataFormWidget extends ConsumerStatefulWidget {
  final MapData? item;
  final Function(MapData) onSubmit;
  const MapDataFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MapDataFormWidget> createState() => _MapDataFormWidgetState();
}

class _MapDataFormWidgetState extends ConsumerState<MapDataFormWidget> {
  String? _projectId;
  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mapdata'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mapdata'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _projectId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.projectid'.tr()),
              onChanged: (v) => _projectId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_projectId != null) 'projectId': _projectId,
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
                  widget.onSubmit(MapData.fromJson(json));
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
