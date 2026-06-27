import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Notification, Route;
import 'package:reservatior/shared/models/models.dart';

class AgentAssignmentDetailWidget extends StatelessWidget {
  final AgentAssignment item;
  const AgentAssignmentDetailWidget({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('mobile.auto.agentassignment_details'.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text("${'mobile.admin.id_label'.tr()}: ${item.id}"),
        ],
      ),
    );
  }
}
