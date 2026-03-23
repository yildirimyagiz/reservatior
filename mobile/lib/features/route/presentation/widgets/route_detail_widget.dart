import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Route Detail Widget  |  21 fields

class RouteDetailWidget extends StatelessWidget {
  final Route item;
  const RouteDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Start Location Id', item.startLocationId?.toString() ?? 'N/A', Icons.link),
        _row('End Location Id', item.endLocationId?.toString() ?? 'N/A', Icons.link),
        _row('Waypoints', item.waypoints?.toString() ?? 'N/A', Icons.text_fields),
        _row('Distance', item.distance?.toString() ?? 'N/A', Icons.numbers),
        _row('Duration', item.duration?.toString() ?? 'N/A', Icons.numbers),
        _row('Polyline', item.polyline?.toString() ?? 'N/A', Icons.text_fields),
        _row('Provider', item.provider?.toString() ?? 'N/A', Icons.text_fields),
        _row('Instructions', item.instructions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Traffic Data', item.trafficData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Tolls', item.tolls?.toString() ?? 'N/A', Icons.numbers),
        _row('Is Visible', (item.isVisible == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Color', item.color?.toString() ?? 'N/A', Icons.text_fields),
        _row('Stroke Width', item.strokeWidth?.toString() ?? 'N/A', Icons.numbers),
        _row('Opacity', item.opacity?.toString() ?? 'N/A', Icons.location_on),
        _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
      ],
    );
  }
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value, style: const TextStyle(fontSize: 14)),
    ])),
  ]),
);

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}