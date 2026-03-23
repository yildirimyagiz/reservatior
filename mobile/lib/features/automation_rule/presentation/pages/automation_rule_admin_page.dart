import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/automation_rule_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AutomationRule Admin Page  |  14 fields
// Auto-generated — edit with care
// ================================================================

class AutomationRuleAdminPage extends ConsumerWidget {
  const AutomationRuleAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(automationRuleLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automation Rule Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(automationRuleListProvider)),
        ],
      ),
      body: const _AutomationRuleBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AutomationRuleFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Automation Rule'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AutomationRuleBody extends ConsumerStatefulWidget {
  const _AutomationRuleBody({super.key});
  @override ConsumerState<_AutomationRuleBody> createState() => __AutomationRuleBodyState();
}

class __AutomationRuleBodyState extends ConsumerState<_AutomationRuleBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(automationRuleListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Automation Rules…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.ruleName?.toString() ?? '') + " " + (item.ruleType?.toString() ?? '') + " " + (item.triggerType?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Automation Rules yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(automationRuleListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.ruleName != null && item.ruleName!.toString().isNotEmpty ? item.ruleName!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.ruleName ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(automationRuleListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AutomationRule item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Automation Rule Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Rule Name', item.ruleName?.toString() ?? 'N/A', Icons.person),
              _row('Rule Type', item.ruleType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Trigger Type', item.triggerType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Trigger Config', item.triggerConfig?.toString() ?? 'N/A', Icons.text_fields),
              _row('Conditions', item.conditions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Actions', item.actions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Last Executed At', _formatDate(item.lastExecutedAt), Icons.calendar_today),
              _row('Execution Count', item.executionCount?.toString() ?? 'N/A', Icons.numbers),
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

void _showForm(BuildContext context, WidgetRef ref, {AutomationRule? item}) {
  showDialog(context: context, builder: (ctx) => _AutomationRuleForm(item: item, ref: ref));
}

class _AutomationRuleForm extends ConsumerStatefulWidget {
  final AutomationRule? item;
  final WidgetRef ref;
  const _AutomationRuleForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AutomationRuleForm> createState() => __AutomationRuleFormState();
}

class __AutomationRuleFormState extends ConsumerState<_AutomationRuleForm> {
  final _key = GlobalKey<FormState>();

  String? _ruleName;
  String? _ruleType;
  String? _triggerType;
  String? _triggerConfig;
  String? _conditions;
  String? _actions;
  bool _isActive = false;
  DateTime? _lastExecutedAt;
  int? _executionCount;

  @override
  void initState() {
    super.initState();
    _ruleName = widget.item?.ruleName?.toString();
    _ruleType = widget.item?.ruleType?.toString();
    _triggerType = widget.item?.triggerType?.toString();
    _triggerConfig = widget.item?.triggerConfig?.toString();
    _conditions = widget.item?.conditions?.toString();
    _actions = widget.item?.actions?.toString();
    _isActive = widget.item?.isActive ?? false;
    _lastExecutedAt = widget.item?.lastExecutedAt;
    _executionCount = widget.item?.executionCount;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_ruleName?.isNotEmpty == true) 'ruleName': _ruleName,
      if (_ruleType?.isNotEmpty == true) 'ruleType': _ruleType,
      if (_triggerType?.isNotEmpty == true) 'triggerType': _triggerType,
      if (_triggerConfig?.isNotEmpty == true) 'triggerConfig': _triggerConfig,
      if (_conditions?.isNotEmpty == true) 'conditions': _conditions,
      if (_actions?.isNotEmpty == true) 'actions': _actions,
      'isActive': _isActive,
      if (_lastExecutedAt != null) 'lastExecutedAt': _lastExecutedAt!.toIso8601String(),
      if (_executionCount != null) 'executionCount': _executionCount,
    };
    if (widget.item == null) {
      widget.ref.read(automationRuleCreateStateProvider.notifier).state = AutomationRule.fromJson(data);
    } else {
      widget.ref.read(automationRuleUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'automationRule': AutomationRule.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Automation Rule' : 'New Automation Rule'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Rule Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.ruleName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ruleName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Rule Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.ruleType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ruleType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Trigger Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.triggerType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _triggerType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Trigger Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.triggerConfig?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _triggerConfig = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Conditions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.conditions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _conditions = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Actions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.actions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _actions = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastExecutedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastExecutedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Executed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastExecutedAt != null ? _formatDate(_lastExecutedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Execution Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.executionCount?.toString() ?? '',
                    onSaved: (v) => _executionCount = int.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Automation Rule'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AutomationRule item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Automation Rule?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(automationRuleDeleteStateProvider.notifier).state = item.id;
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
