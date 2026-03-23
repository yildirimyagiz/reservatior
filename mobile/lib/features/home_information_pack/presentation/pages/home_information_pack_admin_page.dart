import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/home_information_pack_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// HomeInformationPack Admin Page  |  15 fields
// Auto-generated — edit with care
// ================================================================

class HomeInformationPackAdminPage extends ConsumerWidget {
  const HomeInformationPackAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(homeInformationPackLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Information Pack Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(homeInformationPackListProvider)),
        ],
      ),
      body: const _HomeInformationPackBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'HomeInformationPackFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Home Information Pack'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _HomeInformationPackBody extends ConsumerStatefulWidget {
  const _HomeInformationPackBody({super.key});
  @override ConsumerState<_HomeInformationPackBody> createState() => __HomeInformationPackBodyState();
}

class __HomeInformationPackBodyState extends ConsumerState<_HomeInformationPackBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(homeInformationPackListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Home Information Packs…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.fileUrl?.toString() ?? '') + " " + (item.fileName?.toString() ?? '') + " " + (item.mimeType?.toString() ?? '') + " " + (item.checksum?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Home Information Packs yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(homeInformationPackListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.title != null && item.title!.toString().isNotEmpty ? item.title!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.title ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(homeInformationPackListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, HomeInformationPack item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Information Pack Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('File Url', item.fileUrl?.toString() ?? 'N/A', Icons.link),
              _row('File Name', item.fileName?.toString() ?? 'N/A', Icons.person),
              _row('File Size', item.fileSize?.toString() ?? 'N/A', Icons.numbers),
              _row('Mime Type', item.mimeType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Checksum', item.checksum?.toString() ?? 'N/A', Icons.text_fields),
              _row('Version', item.version?.toString() ?? 'N/A', Icons.numbers),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {HomeInformationPack? item}) {
  showDialog(context: context, builder: (ctx) => _HomeInformationPackForm(item: item, ref: ref));
}

class _HomeInformationPackForm extends ConsumerStatefulWidget {
  final HomeInformationPack? item;
  final WidgetRef ref;
  const _HomeInformationPackForm({super.key, this.item, required this.ref});
  @override ConsumerState<_HomeInformationPackForm> createState() => __HomeInformationPackFormState();
}

class __HomeInformationPackFormState extends ConsumerState<_HomeInformationPackForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _title;
  String? _description;
  String? _fileUrl;
  String? _fileName;
  int? _fileSize;
  String? _mimeType;
  String? _checksum;
  int? _version;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _fileUrl = widget.item?.fileUrl?.toString();
    _fileName = widget.item?.fileName?.toString();
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType?.toString();
    _checksum = widget.item?.checksum?.toString();
    _version = widget.item?.version;
    _isActive = widget.item?.isActive ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_title?.isNotEmpty == true) 'title': _title,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_fileUrl?.isNotEmpty == true) 'fileUrl': _fileUrl,
      if (_fileName?.isNotEmpty == true) 'fileName': _fileName,
      if (_fileSize != null) 'fileSize': _fileSize,
      if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
      if (_checksum?.isNotEmpty == true) 'checksum': _checksum,
      if (_version != null) 'version': _version,
      'isActive': _isActive,
    };
    if (widget.item == null) {
      widget.ref.read(homeInformationPackCreateStateProvider.notifier).state = HomeInformationPack.fromJson(data);
    } else {
      widget.ref.read(homeInformationPackUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'homeInformationPack': HomeInformationPack.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Home Information Pack' : 'New Home Information Pack'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.title?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _title = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'File Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.fileUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fileUrl = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'File Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.fileName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fileName = v?.isEmpty == true ? null : v,
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
                    decoration: InputDecoration(labelText: 'Checksum', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.checksum?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _checksum = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Version', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.version?.toString() ?? '',
                    onSaved: (v) => _version = int.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Home Information Pack'),
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

void _confirmDel(BuildContext context, WidgetRef ref, HomeInformationPack item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Home Information Pack?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(homeInformationPackDeleteStateProvider.notifier).state = item.id;
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
