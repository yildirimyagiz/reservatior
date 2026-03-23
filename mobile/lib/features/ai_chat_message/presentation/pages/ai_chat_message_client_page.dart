import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_chat_message_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/a_i_chat_message_form_widget.dart';
// ── AIChatMessage Client Page

class AIChatMessageClientPage extends ConsumerStatefulWidget {
  const AIChatMessageClientPage({super.key});
  @override ConsumerState<AIChatMessageClientPage> createState() => _AIChatMessageClientPageState();
}

class _AIChatMessageClientPageState extends ConsumerState<AIChatMessageClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiChatMessageListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ai Chat Messages'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(aiChatMessageListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: 'Search Ai Chat Messages…',
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
                : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.sessionId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.content?.toString() ?? '') + " " + (item.contentHash?.toString() ?? '') + " " + (item.redactedContent?.toString() ?? '') + " " + (item.language?.toString() ?? '') + " " + (item.escalationTag?.toString() ?? '') + " " + (item.escalationTopic?.toString() ?? '') + " " + (item.securityReason?.toString() ?? '')).toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Ai Chat Messages', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(aiChatMessageListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(child: Text(item.content != null && item.content!.toString().isNotEmpty ? item.content!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.content ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Created At: ' + _fmt(item.createdAt)),
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
            ElevatedButton.icon(onPressed: () => ref.invalidate(aiChatMessageListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIChatMessageClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Ai Chat Message'),
      ),
    );
  }

  void _showDetail(BuildContext context, AIChatMessage item) {
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
              const Text('Ai Chat Message Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
                  _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
                  _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
                  _row('Session Id', item.sessionId?.toString() ?? 'N/A', Icons.link),
                  _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
                  _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
                  _row('Role', item.role?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Content', item.content?.toString() ?? 'N/A', Icons.notes),
                  _row('Content Hash', item.contentHash?.toString() ?? 'N/A', Icons.notes),
                  _row('Redacted Content', item.redactedContent?.toString() ?? 'N/A', Icons.notes),
                  _row('Pii Detected', (item.piiDetected == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Language', item.language?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Is A I', (item.isAI == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Escalation Tag', item.escalationTag?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Escalation Topic', item.escalationTopic?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Payment Agreed', (item.paymentAgreed == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Payment Plan', item.paymentPlan?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Security Flag', (item.securityFlag == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Security Reason', item.securityReason?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Module Type', item.moduleType?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Token Count', item.tokenCount?.toString() ?? 'N/A', Icons.numbers),
                  _row('Processing Ms', item.processingMs?.toString() ?? 'N/A', Icons.numbers),
                  _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
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
              child: Text('New Ai Chat Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AIChatMessageFormWidget(
                onSubmit: (newItem) {
                  ref.read(aiChatMessageCreateStateProvider.notifier).state = newItem;
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