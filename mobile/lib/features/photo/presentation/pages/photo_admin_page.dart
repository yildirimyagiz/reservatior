import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/photo_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Photo Admin Page  |  22 fields
// Auto-generated — edit with care
// ================================================================

class PhotoAdminPage extends ConsumerWidget {
  const PhotoAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(photoLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(photoListProvider)),
        ],
      ),
      body: const _PhotoBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PhotoFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Photo'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _PhotoBody extends ConsumerStatefulWidget {
  const _PhotoBody({super.key});
  @override ConsumerState<_PhotoBody> createState() => __PhotoBodyState();
}

class __PhotoBodyState extends ConsumerState<_PhotoBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(photoListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
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
          final list = _q.isEmpty
              ? items
              : items.where((item) => ((item.url?.toString() ?? '') + " " + (item.originalName?.toString() ?? '') + " " + (item.filename?.toString() ?? '') + " " + (item.caption?.toString() ?? '') + " " + (item.alt?.toString() ?? '') + " " + (item.src?.toString() ?? '') + " " + (item.mimeType?.toString() ?? '') + " " + (item.dominantColor?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.agencyId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.agentId?.toString() ?? '') + " " + (item.postId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Photos yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(photoListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.type != null && item.type!.toString().isNotEmpty ? item.type!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.type?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                      IconButton(icon: const Icon(Icons.edit_outlined, size: 20), tooltip: 'Edit',
                          onPressed: () => _showForm(context, ref, item: item)),
                      IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20), tooltip: 'Delete',
                          onPressed: () => _confirmDel(context, ref, item)),
                    ]),
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
          SelectableText('$e', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton.icon(onPressed: () => ref.invalidate(photoListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Photo item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photo Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Url', item.url?.toString() ?? 'N/A', Icons.link),
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
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Agent Id', item.agentId?.toString() ?? 'N/A', Icons.link),
              _row('Post Id', item.postId?.toString() ?? 'N/A', Icons.link),
          ]),
        ),
      ),
    ),
  ));
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value),
    ])),
  ]),
);

// ─── Form Dialog ─────────────────────────────────────────────────

void _showForm(BuildContext context, WidgetRef ref, {Photo? item}) {
  showDialog(context: context, builder: (ctx) => _PhotoForm(item: item, ref: ref));
}

class _PhotoForm extends ConsumerStatefulWidget {
  final Photo? item;
  final WidgetRef ref;
  const _PhotoForm({super.key, this.item, required this.ref});
  @override ConsumerState<_PhotoForm> createState() => __PhotoFormState();
}

class __PhotoFormState extends ConsumerState<_PhotoForm> {
  final _key = GlobalKey<FormState>();

  String? _url;
  String? _originalName;
  String? _filename;
  String? _type;
  String? _caption;
  String? _alt;
  String? _src;
  bool _featured = false;
  int? _width;
  int? _height;
  int? _fileSize;
  String? _mimeType;
  String? _dominantColor;
  String? _mlMetadata;
  String? _userId;
  String? _agencyId;
  String? _propertyId;
  String? _agentId;
  String? _postId;

  @override
  void initState() {
    super.initState();
    _url = widget.item?.url?.toString();
    _originalName = widget.item?.originalName?.toString();
    _filename = widget.item?.filename?.toString();
    _type = widget.item?.type?.toString();
    _caption = widget.item?.caption?.toString();
    _alt = widget.item?.alt?.toString();
    _src = widget.item?.src?.toString();
    _featured = widget.item?.featured ?? false;
    _width = widget.item?.width;
    _height = widget.item?.height;
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType?.toString();
    _dominantColor = widget.item?.dominantColor?.toString();
    _mlMetadata = widget.item?.mlMetadata?.toString();
    _userId = widget.item?.userId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _agentId = widget.item?.agentId?.toString();
    _postId = widget.item?.postId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_url?.isNotEmpty == true) 'url': _url,
      if (_originalName?.isNotEmpty == true) 'originalName': _originalName,
      if (_filename?.isNotEmpty == true) 'filename': _filename,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_caption?.isNotEmpty == true) 'caption': _caption,
      if (_alt?.isNotEmpty == true) 'alt': _alt,
      if (_src?.isNotEmpty == true) 'src': _src,
      'featured': _featured,
      if (_width != null) 'width': _width,
      if (_height != null) 'height': _height,
      if (_fileSize != null) 'fileSize': _fileSize,
      if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
      if (_dominantColor?.isNotEmpty == true) 'dominantColor': _dominantColor,
      if (_mlMetadata?.isNotEmpty == true) 'mlMetadata': _mlMetadata,
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
      if (_postId?.isNotEmpty == true) 'postId': _postId,
    };
    if (widget.item == null) {
      widget.ref.read(photoCreateStateProvider.notifier).state = Photo.fromJson(data);
    } else {
      widget.ref.read(photoUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'photo': Photo.fromJson({...widget.item!.toJson(), ...data}),
      };
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 700),
        child: Scaffold(
          appBar: AppBar(
            title: Text(isEdit ? 'Edit Photo' : 'New Photo'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.url?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _url = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Original Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.originalName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _originalName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Filename', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.filename?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _filename = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Caption', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.caption?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _caption = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Alt', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.alt?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _alt = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Src', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.src?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _src = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Featured'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.featured ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _featured = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Width', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.width?.toString() ?? '',
                    onSaved: (v) => _width = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Height', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.height?.toString() ?? '',
                    onSaved: (v) => _height = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'File Size', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.fileSize?.toString() ?? '',
                    onSaved: (v) => _fileSize = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mime Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.mimeType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _mimeType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Dominant Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.dominantColor?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dominantColor = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Ml Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.mlMetadata?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _mlMetadata = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.agencyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.agentId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Post Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.postId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _postId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Photo'),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Delete Confirm ──────────────────────────────────────────────

void _confirmDel(BuildContext context, WidgetRef ref, Photo item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Photo?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(photoDeleteStateProvider.notifier).state = item.id;
          Navigator.pop(ctx);
        },
        icon: const Icon(Icons.delete), label: const Text('Delete'),
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
      ),
    ],
  ));
}

// ─── Helpers ─────────────────────────────────────────────────────

String _formatDate(DateTime? d) {
  if (d == null) return 'N/A';
  final y = d.year; final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0'); final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '$y-$mo-$day $h:$mi';
}
