import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/pricing_rule_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/pricing_rule_form_widget.dart';

// ── PricingRule Client Page

class PricingRuleClientPage extends ConsumerStatefulWidget {
  const PricingRuleClientPage({super.key});
  @override ConsumerState<PricingRuleClientPage> createState() => _PricingRuleClientPageState();
}

class _PricingRuleClientPageState extends ConsumerState<PricingRuleClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(pricingRuleListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pricing Rules'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(pricingRuleListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: 'Search Pricing Rules…',
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
                : items.where((item) => ((item.listingId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.ruleType?.toString() ?? '') + " " + (item.strategy?.toString() ?? '') + " " + (item.currencyId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Pricing Rules', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(pricingRuleListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Start Date: ' + _fmt(item.startDate)),
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
            ElevatedButton.icon(onPressed: () => ref.invalidate(pricingRuleListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PricingRuleClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Pricing Rule'),
      ),
    );
  }

  void _showDetail(BuildContext context, PricingRule item) {
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
              const Text('Pricing Rule Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
                  _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
                  _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
                  _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
                  _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
                  _row('Rule Type', item.ruleType?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Conditions', item.conditions?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Actions', item.actions?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Priority', item.priority?.toString() ?? 'N/A', Icons.numbers),
                  _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
                  _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
                  _row('Base Price', item.basePrice?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Strategy', item.strategy?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Start Date', _fmt(item.startDate), Icons.calendar_today),
                  _row('End Date', _fmt(item.endDate), Icons.calendar_today),
                  _row('Min Nights', item.minNights?.toString() ?? 'N/A', Icons.numbers),
                  _row('Max Nights', item.maxNights?.toString() ?? 'N/A', Icons.numbers),
                  _row('Weekday Prices', item.weekdayPrices?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Tax Rules', item.taxRules?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Discount Rules', item.discountRules?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Currency Id', item.currencyId?.toString() ?? 'N/A', Icons.link),
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
              child: Text('New Pricing Rule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: PricingRuleFormWidget(
                onSubmit: (newItem) {
                  ref.read(pricingRuleCreateStateProvider.notifier).state = newItem;
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