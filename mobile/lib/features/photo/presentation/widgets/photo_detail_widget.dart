import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Photo Detail Widget  |  22 fields

class PhotoDetailWidget extends StatelessWidget {
  final Photo item;
  const PhotoDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Url', item.url?.toString() ?? 'N/A', Icons.text_fields),
        _row('Original Name', item.originalName?.toString() ?? 'N/A', Icons.person),
        _row('Filename', item.filename?.toString() ?? 'N/A', Icons.person),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Caption', item.caption?.toString() ?? 'N/A', Icons.text_fields),
        _row('Alt', item.alt?.toString() ?? 'N/A', Icons.text_fields),
        _row('Src', item.src?.toString() ?? 'N/A', Icons.text_fields),
        _row('Featured', (item.featured == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Width', item.width?.toString() ?? 'N/A', Icons.numbers),
        _row('Height', item.height?.toString() ?? 'N/A', Icons.numbers),
        _row('File Size', item.fileSize?.toString() ?? 'N/A', Icons.numbers),
        _row('Mime Type', item.mimeType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Dominant Color', item.dominantColor?.toString() ?? 'N/A', Icons.text_fields),
        _row('Ml Metadata', item.mlMetadata?.toString() ?? 'N/A', Icons.text_fields),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
        _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
        _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Agent Id', item.agentId?.toString() ?? 'N/A', Icons.link),
        _row('Post Id', item.postId?.toString() ?? 'N/A', Icons.link),
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