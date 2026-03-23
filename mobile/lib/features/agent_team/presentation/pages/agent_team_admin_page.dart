import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/agent_team_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AgentTeam Admin Page  |  4 fields
// Auto-generated — edit with care
// ================================================================

class AgentTeamAdminPage extends ConsumerWidget {
  const AgentTeamAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(agentTeamLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Team Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(agentTeamListProvider)),
        ],
      ),
      body: const _AgentTeamBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AgentTeamFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Agent Team'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AgentTeamBody extends ConsumerStatefulWidget {
  const _AgentTeamBody();
  @override ConsumerState<_AgentTeamBody> createState() => __AgentTeamBodyState();
}

class __AgentTeamBodyState extends ConsumerState<_AgentTeamBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(agentTeamListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Agent Teams…',
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
              : items.where((item) {
  if (item == null) return false;
  final orgId = item.orgId?.toString() ?? '';
  final name = item.name?.toString() ?? '';
  final leaderId = item.leaderId?.toString() ?? '';
  return '$orgId $name $leaderId'.toLowerCase().contains(_q);
}).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Agent Teams yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(agentTeamListProvider),
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
                    subtitle: Text('Leader Id: ${item.leaderId?.toString() ?? 'N/A'}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(agentTeamListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AgentTeam item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agent Team Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Leader Id', item.leaderId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {AgentTeam? item}) {
  showDialog(context: context, builder: (ctx) => _AgentTeamForm(item: item, ref: ref));
}

class _AgentTeamForm extends ConsumerStatefulWidget {
  final AgentTeam? item;
  final WidgetRef ref;
  const _AgentTeamForm({this.item, required this.ref});
  @override ConsumerState<_AgentTeamForm> createState() => __AgentTeamFormState();
}

class __AgentTeamFormState extends ConsumerState<_AgentTeamForm> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _leaderId;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _leaderId = widget.item?.leaderId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_leaderId?.isNotEmpty == true) 'leaderId': _leaderId,
    };
    if (widget.item == null) {
      widget.ref.read(agentTeamCreateStateProvider.notifier).state = AgentTeam.fromJson(data);
    } else {
      widget.ref.read(agentTeamUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'agentTeam': AgentTeam.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Agent Team' : 'New Agent Team'),
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
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    initialValue: widget.item?.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Leader Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.leaderId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _leaderId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Agent Team'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AgentTeam item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Agent Team?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(agentTeamDeleteStateProvider.notifier).state = item.id;
          Navigator.pop(ctx);
        },
        icon: const Icon(Icons.delete), label: const Text('Delete'),
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
      ),
    ],
  ));
}

