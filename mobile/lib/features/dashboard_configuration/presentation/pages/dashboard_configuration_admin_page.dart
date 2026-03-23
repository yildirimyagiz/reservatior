import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/dashboard_configuration_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// DashboardConfiguration Admin Page  |  8 fields
// Auto-generated — edit with care
// ================================================================

class DashboardConfigurationAdminPage extends ConsumerWidget {
  const DashboardConfigurationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(dashboard_configurationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard_configuration Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(dashboard_configurationListProvider)),
        ],
      ),
      body: const _DashboardConfigurationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'DashboardConfigurationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Dashboard_configuration'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _DashboardConfigurationBody extends ConsumerStatefulWidget {
  const _DashboardConfigurationBody({super.key});
  @override ConsumerState<_DashboardConfigurationBody> createState() => __DashboardConfigurationBodyState();
}

class __DashboardConfigurationBodyState extends ConsumerState<_DashboardConfigurationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(dashboard_configurationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Dashboard_configurations…',
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
              : items.where((item) => ((item.userId?.toString() ?? '') + " " + (item.dashboardName?.toString() ?? '') + " " + (item.layout?.toString() ?? '') + " " + (item.widgets?.toString() ?? '') + " " + (item.filters?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "\$_q"' : 'No Dashboard_configurations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(dashboard_configurationListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.dashboardName != null && item.dashboardName!.toString().isNotEmpty ? item.dashboardName!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.dashboardName?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(dashboard_configurationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, DashboardConfiguration item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard_configuration Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Dashboard Name', item.dashboardName?.toString() ?? 'N/A', Icons.person),
              _row('Filters', item.filters?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Default', (item.isDefault == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Is Public', (item.isPublic == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Layout', item.layout?.toString() ?? 'N/A', Icons.text_fields),
              _row('Time Range', item.timeRange?.toString() ?? 'N/A', Icons.text_fields),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Widgets', item.widgets?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {DashboardConfiguration? item}) {
  showDialog(context: context, builder: (ctx) => _DashboardConfigurationForm(item: item, ref: ref));
}

class _DashboardConfigurationForm extends ConsumerStatefulWidget {
  final DashboardConfiguration? item;
  final WidgetRef ref;
  const _DashboardConfigurationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_DashboardConfigurationForm> createState() => __DashboardConfigurationFormState();
}

class __DashboardConfigurationFormState extends ConsumerState<_DashboardConfigurationForm> {
  final _key = GlobalKey<FormState>();

  String? _dashboardName;
  String? _filters;
  bool _isDefault = false;
  bool _isPublic = false;
  String? _layout;
  String? _timeRange;
  String? _userId;
  String? _widgets;

  @override
  void initState() {
    super.initState();
    _dashboardName = widget.item?.dashboardName?.toString();
    _filters = widget.item?.filters?.toString();
    _isDefault = widget.item?.isDefault ?? false;
    _isPublic = widget.item?.isPublic ?? false;
    _layout = widget.item?.layout?.toString();
    _timeRange = widget.item?.timeRange?.toString();
    _userId = widget.item?.userId?.toString();
    _widgets = widget.item?.widgets?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_dashboardName?.isNotEmpty == true) 'dashboardName': _dashboardName,
      if (_filters?.isNotEmpty == true) 'filters': _filters,
      'isDefault': _isDefault,
      'isPublic': _isPublic,
      if (_layout?.isNotEmpty == true) 'layout': _layout,
      if (_timeRange?.isNotEmpty == true) 'timeRange': _timeRange,
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_widgets?.isNotEmpty == true) 'widgets': _widgets,
    };
    if (widget.item == null) {
      widget.ref.read(dashboard_configurationCreateStateProvider.notifier).state = DashboardConfiguration.fromJson(data);
    } else {
      widget.ref.read(dashboard_configurationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'dashboard_configuration': DashboardConfiguration.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Dashboard_configuration' : 'New Dashboard_configuration'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Dashboard Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.dashboardName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dashboardName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Filters', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.filters?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _filters = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Default'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isDefault ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isDefault = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Public'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isPublic ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isPublic = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Layout', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.layout?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _layout = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Time Range', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.timeRange?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _timeRange = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Widgets', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.widgets?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _widgets = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Dashboard_configuration'),
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

void _confirmDel(BuildContext context, WidgetRef ref, DashboardConfiguration item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Dashboard_configuration?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(dashboard_configurationDeleteStateProvider.notifier).state = item.id;
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
