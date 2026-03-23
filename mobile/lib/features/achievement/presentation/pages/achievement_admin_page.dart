import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/providers.dart';
import '../../../../gen_models/models_library.dart';

// Achievement Admin Page  |  12 fields
// Auto-generated — edit with care

class AchievementAdminPage extends ConsumerWidget {
  const AchievementAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(achievementLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievement Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(achievementListProvider)),
        ],
      ),
      body: const _AchievementBody(key: Key('body')),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AchievementFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Achievement'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AchievementBody extends ConsumerStatefulWidget {
  const _AchievementBody({required super.key});
  @override ConsumerState<_AchievementBody> createState() => __AchievementBodyState();
}

class __AchievementBodyState extends ConsumerState<_AchievementBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(achievementListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Achievements…',
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
        data: (List<Achievement> items) {
          final list = _q.isEmpty
              ? items
              : items.where((item) {
  final userId = item.userId ?? '';
  final bonusReward = item.bonusReward ?? '';
  final organizationId = item.organizationId ?? '';
  return '$userId $bonusReward $organizationId'.toLowerCase().contains(_q);
}).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Achievements yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(achievementListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.bonusReward != null && item.bonusReward!.toString().isNotEmpty ? item.bonusReward!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.bonusReward ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ${_formatDate(item.createdAt)}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(achievementListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Achievement item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Achievement Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Goal Type', item.goalType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Goal Value', item.goalValue?.toString() ?? 'N/A', Icons.numbers),
              _row('Current Value', item.currentValue?.toString() ?? 'N/A', Icons.numbers),
              _row('Is Completed', (item.isCompleted == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Completed At', _formatDate(item.completedAt), Icons.calendar_today),
              _row('Points Reward', item.pointsReward?.toString() ?? 'N/A', Icons.numbers),
              _row('Bonus Reward', item.bonusReward?.toString() ?? 'N/A', Icons.text_fields),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Organization Id', item.organizationId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {Achievement? item}) {
  showDialog(context: context, builder: (ctx) => _AchievementForm(item: item, ref: ref));
}

class _AchievementForm extends ConsumerStatefulWidget {
  final Achievement? item;
  final WidgetRef ref;
  const _AchievementForm({this.item, required this.ref});
  @override ConsumerState<_AchievementForm> createState() => __AchievementFormState();
}

class __AchievementFormState extends ConsumerState<_AchievementForm> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _goalType;
  int? _goalValue;
  int? _currentValue;
  bool _isCompleted = false;
  DateTime? _completedAt;
  int? _pointsReward;
  String? _bonusReward;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _goalType = widget.item?.goalType?.toString();
    _goalValue = widget.item?.goalValue;
    _currentValue = widget.item?.currentValue;
    _isCompleted = widget.item?.isCompleted ?? false;
    _completedAt = widget.item?.completedAt;
    _pointsReward = widget.item?.pointsReward;
    _bonusReward = widget.item?.bonusReward?.toString();
    _organizationId = widget.item?.organizationId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_goalType?.isNotEmpty == true) 'goalType': _goalType,
      if (_goalValue != null) 'goalValue': _goalValue,
      if (_currentValue != null) 'currentValue': _currentValue,
      'isCompleted': _isCompleted,
      if (_completedAt != null) 'completedAt': _completedAt!.toIso8601String(),
      if (_pointsReward != null) 'pointsReward': _pointsReward,
      if (_bonusReward?.isNotEmpty == true) 'bonusReward': _bonusReward,
      if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
    };
    if (widget.item == null) {
      widget.ref.read(achievementCreateStateProvider.notifier).state = Achievement.fromJson(data);
    } else {
      ref.read(achievementUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'achievement': Achievement.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Achievement' : 'New Achievement'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(icon: const Icon(Icons.close), key: const Key('close-dialog'), onPressed: () => Navigator.pop(context)),
            ],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Goal Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.goalType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _goalType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Goal Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.goalValue?.toString() ?? '',
                    onSaved: (v) => _goalValue = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Current Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.currentValue?.toString() ?? '',
                    onSaved: (v) => _currentValue = int.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: const Text('Is Completed'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isCompleted ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isCompleted = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _completedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _completedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Completed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_completedAt != null ? _formatDate(_completedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Points Reward', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.pointsReward?.toString() ?? '',
                    onSaved: (v) => _pointsReward = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Bonus Reward', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.bonusReward?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _bonusReward = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Organization Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.organizationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Achievement'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Achievement item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Achievement?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(achievementDeleteStateProvider.notifier).state = item.id;
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
