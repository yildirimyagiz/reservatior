import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Notification, Route;
import 'package:reservatior/shared/models/models.dart';

class RouteDetailWidget extends StatelessWidget {
  final Route item;
  const RouteDetailWidget({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('mobile.auto.route_details'.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text("${'mobile.admin.id_label'.tr()}: ${item.id}"),
        ],
      ),
    );
  }
}
