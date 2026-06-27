import 'package:flutter/material.dart' hide Notification, Route;
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ReservationDetailWidget extends StatelessWidget {
  final Reservation item;
  const ReservationDetailWidget({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'mobile.reservation.details'.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text('${'mobile.reservation.id'.tr()}${item.id}'),
        ],
      ),
    );
  }
}
