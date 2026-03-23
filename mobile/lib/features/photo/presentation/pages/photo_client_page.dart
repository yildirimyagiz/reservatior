import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/photo_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/photo_form_widget.dart';

// ── Photo Client Page

class PhotoClientPage extends ConsumerStatefulWidget {
  const PhotoClientPage({super.key});
  @override ConsumerState<PhotoClientPage> createState() => _PhotoClientPageState();
}

class _PhotoClientPageState extends ConsumerState<PhotoClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(photoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Photos'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(photoListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: 'Search Photos…',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _q.isNotEmpty
                  ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _ctrl.clear(); setState(() => _q = ''); })
                  : null,
              border: const OutlineInputBorder(), isDense: true,
            ),
            onChanged: (v) => setState(() => _q = v.toLowerCase()),
          ),
        ),
        Expanded(child: async.when(
          data: (items) {
            final list = _q.isEmpty ? items
                : items.where((item) => ((item.url?.toString() ?? '') + " " + (item.originalName?.toString() ?? '') + " " + (item.filename?.toString() ?? '') + " " + (item.caption?.toString() ?? '') + " " + (item.alt?.toString() ?? '') + " " + (item.src?.toString() ?? '') + " " + (item.mimeType?.toString() ?? '') + " " + (item.dominantColor?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.agencyId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.agentId?.toString() ?? '') + " " + (item.postId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Photos', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(photoListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(child: Text(item.type != null && item.type!.toString().isNotEmpty ? item.type!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.type?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Created At: ' + _fmt(item.createdAt)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showDetail(context, item),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text('$e', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton.icon(onPressed: () => ref.invalidate(photoListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PhotoClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Photo'),
      ),
    );
  }

  void _showDetail(BuildContext context, Photo item) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6, minChildSize: 0.3, maxChildSize: 0.92, expand: false,
        builder: (ctx2, sc) => Column(children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              const Text('Photo Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
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
          ])),
        ]),
      ),
    );
  }

  void _showForm(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(alignment: Alignment.centerLeft,
              child: Text('New Photo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: PhotoFormWidget(
                onSubmit: (newItem) {
                  ref.read(photoCreateStateProvider.notifier).state = newItem;
                  Navigator.pop(ctx);
                },
              ),
            ),
          ),
        ]),
      ),
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