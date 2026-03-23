import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/map_layer_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// MapLayer Admin Page  |  26 fields
// Auto-generated — edit with care
// ================================================================

class MapLayerAdminPage extends ConsumerWidget {
  const MapLayerAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(mapLayerLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Layer Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(mapLayerListProvider)),
        ],
      ),
      body: const _MapLayerBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MapLayerFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Map Layer'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _MapLayerBody extends ConsumerStatefulWidget {
  const _MapLayerBody({super.key});
  @override ConsumerState<_MapLayerBody> createState() => __MapLayerBodyState();
}

class __MapLayerBodyState extends ConsumerState<_MapLayerBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mapLayerListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Map Layers…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.type?.toString() ?? '') + " " + (item.url?.toString() ?? '') + " " + (item.fillColor?.toString() ?? '') + " " + (item.strokeColor?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Map Layers yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mapLayerListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Type: ' + item.type?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(mapLayerListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, MapLayer item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Map Layer Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Provider', item.provider?.toString() ?? 'N/A', Icons.text_fields),
              _row('Url', item.url?.toString() ?? 'N/A', Icons.link),
              _row('Config', item.config?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Visible', (item.isVisible == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Opacity', item.opacity?.toString() ?? 'N/A', Icons.location_on),
              _row('Z Index', item.zIndex?.toString() ?? 'N/A', Icons.numbers),
              _row('North East Lat', item.northEastLat?.toString() ?? 'N/A', Icons.numbers),
              _row('North East Lng', item.northEastLng?.toString() ?? 'N/A', Icons.numbers),
              _row('South West Lat', item.southWestLat?.toString() ?? 'N/A', Icons.numbers),
              _row('South West Lng', item.southWestLng?.toString() ?? 'N/A', Icons.numbers),
              _row('Center Lat', item.centerLat?.toString() ?? 'N/A', Icons.numbers),
              _row('Center Lng', item.centerLng?.toString() ?? 'N/A', Icons.numbers),
              _row('Zoom Level', item.zoomLevel?.toString() ?? 'N/A', Icons.numbers),
              _row('Min Zoom', item.minZoom?.toString() ?? 'N/A', Icons.numbers),
              _row('Max Zoom', item.maxZoom?.toString() ?? 'N/A', Icons.numbers),
              _row('Fill Color', item.fillColor?.toString() ?? 'N/A', Icons.text_fields),
              _row('Stroke Color', item.strokeColor?.toString() ?? 'N/A', Icons.text_fields),
              _row('Stroke Width', item.strokeWidth?.toString() ?? 'N/A', Icons.numbers),
              _row('Fill Opacity', item.fillOpacity?.toString() ?? 'N/A', Icons.location_on),
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

void _showForm(BuildContext context, WidgetRef ref, {MapLayer? item}) {
  showDialog(context: context, builder: (ctx) => _MapLayerForm(item: item, ref: ref));
}

class _MapLayerForm extends ConsumerStatefulWidget {
  final MapLayer? item;
  final WidgetRef ref;
  const _MapLayerForm({super.key, this.item, required this.ref});
  @override ConsumerState<_MapLayerForm> createState() => __MapLayerFormState();
}

class __MapLayerFormState extends ConsumerState<_MapLayerForm> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _type;
  String? _provider;
  String? _url;
  String? _config;
  bool _isVisible = false;
  double? _opacity;
  int? _zIndex;
  double? _northEastLat;
  double? _northEastLng;
  double? _southWestLat;
  double? _southWestLng;
  double? _centerLat;
  double? _centerLng;
  int? _zoomLevel;
  int? _minZoom;
  int? _maxZoom;
  String? _fillColor;
  String? _strokeColor;
  double? _strokeWidth;
  double? _fillOpacity;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _provider = widget.item?.provider?.toString();
    _url = widget.item?.url?.toString();
    _config = widget.item?.config?.toString();
    _isVisible = widget.item?.isVisible ?? false;
    _opacity = widget.item?.opacity;
    _zIndex = widget.item?.zIndex;
    _northEastLat = widget.item?.northEastLat;
    _northEastLng = widget.item?.northEastLng;
    _southWestLat = widget.item?.southWestLat;
    _southWestLng = widget.item?.southWestLng;
    _centerLat = widget.item?.centerLat;
    _centerLng = widget.item?.centerLng;
    _zoomLevel = widget.item?.zoomLevel;
    _minZoom = widget.item?.minZoom;
    _maxZoom = widget.item?.maxZoom;
    _fillColor = widget.item?.fillColor?.toString();
    _strokeColor = widget.item?.strokeColor?.toString();
    _strokeWidth = widget.item?.strokeWidth;
    _fillOpacity = widget.item?.fillOpacity;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_provider?.isNotEmpty == true) 'provider': _provider,
      if (_url?.isNotEmpty == true) 'url': _url,
      if (_config?.isNotEmpty == true) 'config': _config,
      'isVisible': _isVisible,
      if (_opacity != null) 'opacity': _opacity,
      if (_zIndex != null) 'zIndex': _zIndex,
      if (_northEastLat != null) 'northEastLat': _northEastLat,
      if (_northEastLng != null) 'northEastLng': _northEastLng,
      if (_southWestLat != null) 'southWestLat': _southWestLat,
      if (_southWestLng != null) 'southWestLng': _southWestLng,
      if (_centerLat != null) 'centerLat': _centerLat,
      if (_centerLng != null) 'centerLng': _centerLng,
      if (_zoomLevel != null) 'zoomLevel': _zoomLevel,
      if (_minZoom != null) 'minZoom': _minZoom,
      if (_maxZoom != null) 'maxZoom': _maxZoom,
      if (_fillColor?.isNotEmpty == true) 'fillColor': _fillColor,
      if (_strokeColor?.isNotEmpty == true) 'strokeColor': _strokeColor,
      if (_strokeWidth != null) 'strokeWidth': _strokeWidth,
      if (_fillOpacity != null) 'fillOpacity': _fillOpacity,
    };
    if (widget.item == null) {
      widget.ref.read(mapLayerCreateStateProvider.notifier).state = MapLayer.fromJson(data);
    } else {
      widget.ref.read(mapLayerUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'mapLayer': MapLayer.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Map Layer' : 'New Map Layer'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.provider?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _provider = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.url?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _url = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.config?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _config = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Visible'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isVisible ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isVisible = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Opacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.opacity?.toString() ?? '',
                    onSaved: (v) => _opacity = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Z Index', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.zIndex?.toString() ?? '',
                    onSaved: (v) => _zIndex = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'North East Lat', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.northEastLat?.toString() ?? '',
                    onSaved: (v) => _northEastLat = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'North East Lng', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.northEastLng?.toString() ?? '',
                    onSaved: (v) => _northEastLng = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'South West Lat', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.southWestLat?.toString() ?? '',
                    onSaved: (v) => _southWestLat = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'South West Lng', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.southWestLng?.toString() ?? '',
                    onSaved: (v) => _southWestLng = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Center Lat', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.centerLat?.toString() ?? '',
                    onSaved: (v) => _centerLat = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Center Lng', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.centerLng?.toString() ?? '',
                    onSaved: (v) => _centerLng = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Zoom Level', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.zoomLevel?.toString() ?? '',
                    onSaved: (v) => _zoomLevel = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Min Zoom', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.minZoom?.toString() ?? '',
                    onSaved: (v) => _minZoom = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Zoom', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.maxZoom?.toString() ?? '',
                    onSaved: (v) => _maxZoom = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Fill Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.fillColor?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fillColor = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Stroke Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.strokeColor?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _strokeColor = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Stroke Width', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.strokeWidth?.toString() ?? '',
                    onSaved: (v) => _strokeWidth = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Fill Opacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.fillOpacity?.toString() ?? '',
                    onSaved: (v) => _fillOpacity = double.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Map Layer'),
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

void _confirmDel(BuildContext context, WidgetRef ref, MapLayer item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Map Layer?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(mapLayerDeleteStateProvider.notifier).state = item.id;
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
