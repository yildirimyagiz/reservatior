import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/automation_task_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AutomationTask Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class AutomationTaskAdminPage extends ConsumerWidget {
  const AutomationTaskAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(automationTaskLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automation Task Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(automationTaskListProvider)),
        ],
      ),
      body: const _AutomationTaskBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AutomationTaskFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Automation Task'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AutomationTaskBody extends ConsumerStatefulWidget {
  const _AutomationTaskBody({super.key});
  @override ConsumerState<_AutomationTaskBody> createState() => __AutomationTaskBodyState();
}

class __AutomationTaskBodyState extends ConsumerState<_AutomationTaskBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(automationTaskListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Automation Tasks…',
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
              : items.where((item) => ((item.taskType?.toString() ?? '') + " " + (item.persona?.toString() ?? '') + " " + (item.command?.toString() ?? '') + " " + (item.status?.toString() ?? '') + " " + (item.schedule?.toString() ?? '') + " " + (item.error?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Automation Tasks yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(automationTaskListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.taskType != null && item.taskType!.toString().isNotEmpty ? item.taskType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.taskType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ' + item.status?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.status != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.status!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
                  ),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(automationTaskListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(AutomationTask item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AutomationTask item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Automation Task Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Task Type', item.taskType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Persona', item.persona?.toString() ?? 'N/A', Icons.text_fields),
              _row('Command', item.command?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Schedule', item.schedule?.toString() ?? 'N/A', Icons.text_fields),
              _row('Last Run', _formatDate(item.lastRun), Icons.calendar_today),
              _row('Next Run', _formatDate(item.nextRun), Icons.calendar_today),
              _row('Configuration', item.configuration?.toString() ?? 'N/A', Icons.text_fields),
              _row('Result', item.result?.toString() ?? 'N/A', Icons.text_fields),
              _row('Error', item.error?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {AutomationTask? item}) {
  showDialog(context: context, builder: (ctx) => _AutomationTaskForm(item: item, ref: ref));
}

class _AutomationTaskForm extends ConsumerStatefulWidget {
  final AutomationTask? item;
  final WidgetRef ref;
  const _AutomationTaskForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AutomationTaskForm> createState() => __AutomationTaskFormState();
}

class __AutomationTaskFormState extends ConsumerState<_AutomationTaskForm> {
  final _key = GlobalKey<FormState>();

  String? _taskType;
  String? _persona;
  String? _command;
  String? _status;
  String? _schedule;
  DateTime? _lastRun;
  DateTime? _nextRun;
  String? _configuration;
  String? _result;
  String? _error;

  @override
  void initState() {
    super.initState();
    _taskType = widget.item?.taskType?.toString();
    _persona = widget.item?.persona?.toString();
    _command = widget.item?.command?.toString();
    _status = widget.item?.status?.toString();
    _schedule = widget.item?.schedule?.toString();
    _lastRun = widget.item?.lastRun;
    _nextRun = widget.item?.nextRun;
    _configuration = widget.item?.configuration?.toString();
    _result = widget.item?.result?.toString();
    _error = widget.item?.error?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_taskType?.isNotEmpty == true) 'taskType': _taskType,
      if (_persona?.isNotEmpty == true) 'persona': _persona,
      if (_command?.isNotEmpty == true) 'command': _command,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_schedule?.isNotEmpty == true) 'schedule': _schedule,
      if (_lastRun != null) 'lastRun': _lastRun!.toIso8601String(),
      if (_nextRun != null) 'nextRun': _nextRun!.toIso8601String(),
      if (_configuration?.isNotEmpty == true) 'configuration': _configuration,
      if (_result?.isNotEmpty == true) 'result': _result,
      if (_error?.isNotEmpty == true) 'error': _error,
    };
    if (widget.item == null) {
      widget.ref.read(automationTaskCreateStateProvider.notifier).state = AutomationTask.fromJson(data);
    } else {
      widget.ref.read(automationTaskUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'automationTask': AutomationTask.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Automation Task' : 'New Automation Task'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Task Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.taskType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taskType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Persona', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.persona?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _persona = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Command', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.command?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _command = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Schedule', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.schedule?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _schedule = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastRun ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastRun = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Run',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastRun != null ? _formatDate(_lastRun) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _nextRun ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _nextRun = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Next Run',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_nextRun != null ? _formatDate(_nextRun) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Configuration', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.configuration?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _configuration = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Result', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.result?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _result = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.error?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _error = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Automation Task'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AutomationTask item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Automation Task?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(automationTaskDeleteStateProvider.notifier).state = item.id;
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
