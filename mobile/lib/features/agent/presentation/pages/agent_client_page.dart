import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/agent_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/agent_form_widget.dart';

// ── Agent Client Page

class AgentClientPage extends ConsumerStatefulWidget {
  const AgentClientPage({super.key});
  @override ConsumerState<AgentClientPage> createState() => _AgentClientPageState();
}

class _AgentClientPageState extends ConsumerState<AgentClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(agentListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Agents'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(agentListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: 'Search Agents…',
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
            final list = _q.isEmpty ? items
                : items.where((item) => '${item.name ?? ''} ${item.email ?? ''} ${item.phoneNumber ?? ''} ${item.bio ?? ''} ${item.locationId ?? ''} ${item.address ?? ''} ${item.website ?? ''} ${item.logoUrl ?? ''} ${item.agencyId ?? ''} ${item.licenseNumber ?? ''} ${item.education ?? ''}'.toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Agents', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(agentListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(backgroundColor: _stColor(item.status), foregroundColor: Colors.white, child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Status: ${item.status?.toString() ?? 'N/A'}'),
                      trailing: const Icon(Icons.chevron_right),
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
            Text('$e', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton.icon(onPressed: () => ref.invalidate(agentListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AgentClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Agent'),
      ),
    );
  }

Color _stColor(dynamic status) {
  final s = status?.toString().toLowerCase() ?? '';
  if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
  if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
  if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
  return Colors.blueGrey;
}

  void _showDetail(BuildContext context, Agent item) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6, minChildSize: 0.3, maxChildSize: 0.92, expand: false,
        builder: (ctx2, sc) => Column(children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              const Text('Agent Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
                  _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
                  _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
                  _row('Email', item.email?.toString() ?? 'N/A', Icons.email),
                  _row('Phone Number', item.phoneNumber?.toString() ?? 'N/A', Icons.phone),
                  _row('Bio', item.bio?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Location Id', item.locationId?.toString() ?? 'N/A', Icons.link),
                  _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
                  _row('Website', item.website?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Logo Url', item.logoUrl?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
                  _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
                  _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
                  _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
                  _row('License Number', item.licenseNumber?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Commission Rate', item.commissionRate?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Years Of Experience', item.yearsOfExperience?.toString() ?? 'N/A', Icons.numbers),
                  _row('Education', item.education?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Performance Metrics', item.performanceMetrics?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Tax Configuration', item.taxConfiguration?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Availability', item.availability?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Social Media', item.socialMedia?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Settings', item.settings?.toString() ?? 'N/A', Icons.text_fields),
                  _row('External Id', item.externalId?.toString() ?? 'N/A', Icons.link),
                  _row('Integration', item.integration?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Owner Id', item.ownerId?.toString() ?? 'N/A', Icons.link),
                  _row('Last Active', _fmt(item.lastActive), Icons.calendar_today),
          ])),
        ]),
      ),
    );
  }

  void _showForm(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(alignment: Alignment.centerLeft,
              child: Text('New Agent', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AgentFormWidget(
                onSubmit: (newItem) {
                  ref.read(agentCreateStateProvider.notifier).state = newItem;
                  Navigator.pop(ctx);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value, style: const TextStyle(fontSize: 14)),
    ])),
  ]),
);

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}