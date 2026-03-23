import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/agent_team_member_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AgentTeamMember Admin Page  |  4 fields
// Auto-generated — edit with care
// ================================================================

class AgentTeamMemberAdminPage extends ConsumerWidget {
  const AgentTeamMemberAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(agentTeamMemberLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Team Member Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(agentTeamMemberListProvider)),
        ],
      ),
      body: const _AgentTeamMemberBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AgentTeamMemberFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Agent Team Member'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AgentTeamMemberBody extends ConsumerStatefulWidget {
  const _AgentTeamMemberBody({super.key});
  @override ConsumerState<_AgentTeamMemberBody> createState() => __AgentTeamMemberBodyState();
}

class __AgentTeamMemberBodyState extends ConsumerState<_AgentTeamMemberBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(agentTeamMemberListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Agent Team Members…',
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
              : items.where((item) => '${item.teamId ?? ''} ${item.userId ?? ''} ${item.role ?? ''}'.toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Agent Team Members yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(agentTeamMemberListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.role != null && item.role!.toString().isNotEmpty ? item.role!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.role ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Team Id: ${item.teamId ?? 'N/A'}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(agentTeamMemberListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AgentTeamMember item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agent Team Member Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Team Id', item.teamId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Role', item.role?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {AgentTeamMember? item}) {
  showDialog(context: context, builder: (ctx) => _AgentTeamMemberForm(item: item, ref: ref));
}

class _AgentTeamMemberForm extends ConsumerStatefulWidget {
  final AgentTeamMember? item;
  final WidgetRef ref;
  const _AgentTeamMemberForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AgentTeamMemberForm> createState() => __AgentTeamMemberFormState();
}

class __AgentTeamMemberFormState extends ConsumerState<_AgentTeamMemberForm> {
  final _key = GlobalKey<FormState>();

  String? _teamId;
  String? _userId;
  String? _role;

  @override
  void initState() {
    super.initState();
    _teamId = widget.item?.teamId?.toString();
    _userId = widget.item?.userId?.toString();
    _role = widget.item?.role?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_teamId?.isNotEmpty == true) 'teamId': _teamId,
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_role?.isNotEmpty == true) 'role': _role,
    };
    if (widget.item == null) {
      widget.ref.read(agentTeamMemberCreateStateProvider.notifier).state = AgentTeamMember.fromJson(data);
    } else {
      widget.ref.read(agentTeamMemberUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'agentTeamMember': AgentTeamMember.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Agent Team Member' : 'New Agent Team Member'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Team Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.teamId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _teamId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Role', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.role?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _role = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Agent Team Member'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AgentTeamMember item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Agent Team Member?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(agentTeamMemberDeleteStateProvider.notifier).state = item.id;
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
