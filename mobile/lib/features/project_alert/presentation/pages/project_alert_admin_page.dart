import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/project_alert_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// ProjectAlert Admin Page  |  11 fields
// Auto-generated — edit with care
// ================================================================

class ProjectAlertAdminPage extends ConsumerWidget {
  const ProjectAlertAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(projectAlertLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Alert Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(projectAlertListProvider)),
        ],
      ),
      body: const _ProjectAlertBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'ProjectAlertFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Project Alert'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _ProjectAlertBody extends ConsumerStatefulWidget {
  const _ProjectAlertBody({super.key});
  @override ConsumerState<_ProjectAlertBody> createState() => __ProjectAlertBodyState();
}

class __ProjectAlertBodyState extends ConsumerState<_ProjectAlertBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(projectAlertListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Project Alerts…',
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
              : items.where((item) => ((item.projectId?.toString() ?? '') + " " + (item.alertType?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.message?.toString() ?? '') + " " + (item.severity?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Project Alerts yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(projectAlertListProvider),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(projectAlertListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, ProjectAlert item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Project Alert Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Project Id', item.projectId?.toString() ?? 'N/A', Icons.link),
              _row('Alert Type', item.alertType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
              _row('Message', item.message?.toString() ?? 'N/A', Icons.text_fields),
              _row('Severity', item.severity?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Read', (item.isRead == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Is Resolved', (item.isResolved == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Resolved At', _formatDate(item.resolvedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {ProjectAlert? item}) {
  showDialog(context: context, builder: (ctx) => _ProjectAlertForm(item: item, ref: ref));
}

class _ProjectAlertForm extends ConsumerStatefulWidget {
  final ProjectAlert? item;
  final WidgetRef ref;
  const _ProjectAlertForm({super.key, this.item, required this.ref});
  @override ConsumerState<_ProjectAlertForm> createState() => __ProjectAlertFormState();
}

class __ProjectAlertFormState extends ConsumerState<_ProjectAlertForm> {
  final _key = GlobalKey<FormState>();

  String? _projectId;
  String? _alertType;
  String? _title;
  String? _message;
  String? _severity;
  bool _isRead = false;
  bool _isResolved = false;
  DateTime? _resolvedAt;

  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId?.toString();
    _alertType = widget.item?.alertType?.toString();
    _title = widget.item?.title?.toString();
    _message = widget.item?.message?.toString();
    _severity = widget.item?.severity?.toString();
    _isRead = widget.item?.isRead ?? false;
    _isResolved = widget.item?.isResolved ?? false;
    _resolvedAt = widget.item?.resolvedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_projectId?.isNotEmpty == true) 'projectId': _projectId,
      if (_alertType?.isNotEmpty == true) 'alertType': _alertType,
      if (_title?.isNotEmpty == true) 'title': _title,
      if (_message?.isNotEmpty == true) 'message': _message,
      if (_severity?.isNotEmpty == true) 'severity': _severity,
      'isRead': _isRead,
      'isResolved': _isResolved,
      if (_resolvedAt != null) 'resolvedAt': _resolvedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(projectAlertCreateStateProvider.notifier).state = ProjectAlert.fromJson(data);
    } else {
      widget.ref.read(projectAlertUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'projectAlert': ProjectAlert.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Project Alert' : 'New Project Alert'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Project Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.projectId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _projectId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Alert Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.alertType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _alertType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.title?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _title = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.message?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _message = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Severity', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.severity?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _severity = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Read'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isRead ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isRead = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Resolved'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isResolved ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isResolved = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _resolvedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _resolvedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Resolved At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_resolvedAt != null ? _formatDate(_resolvedAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Project Alert'),
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

void _confirmDel(BuildContext context, WidgetRef ref, ProjectAlert item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Project Alert?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(projectAlertDeleteStateProvider.notifier).state = item.id;
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
