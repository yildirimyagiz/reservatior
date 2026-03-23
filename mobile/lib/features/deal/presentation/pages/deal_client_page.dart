import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/deal_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/deal_form_widget.dart';

// ── Deal Client Page

class DealClientPage extends ConsumerStatefulWidget {
  const DealClientPage({super.key});
  @override ConsumerState<DealClientPage> createState() => _DealClientPageState();
}

class _DealClientPageState extends ConsumerState<DealClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(dealListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deals'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(dealListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: 'Search Deals…',
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
                : items.where((item) => ((item.listingId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.clientId?.toString() ?? '') + " " + (item.agentId?.toString() ?? '') + " " + (item.locationId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Deals', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(dealListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(child: Text(item.listingId != null && item.listingId!.toString().isNotEmpty ? item.listingId!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.listingId?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
            ElevatedButton.icon(onPressed: () => ref.invalidate(dealListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'DealClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Deal'),
      ),
    );
  }

  void _showDetail(BuildContext context, Deal item) {
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
              const Text('Deal Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
                  _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
                  _row('Agent Id', item.agentId?.toString() ?? 'N/A', Icons.link),
                  _row('Appraisal Contingency', (item.appraisalContingency == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Attorney Review', (item.attorneyReview == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Buyer Credits', item.buyerCredits?.toString() ?? 'N/A', Icons.numbers),
                  _row('Client Id', item.clientId?.toString() ?? 'N/A', Icons.link),
                  _row('Closing Costs', item.closingCosts?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Closing Date', _fmt(item.closingDate), Icons.calendar_today),
                  _row('Commission Amount', item.commissionAmount?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Commission Rate', item.commissionRate?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Deal Type', item.dealType?.toString() ?? 'N/A', Icons.info_outline),
                  _row('Down Payment', item.downPayment?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Earnest Money', item.earnestMoney?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Escrow Amount', item.escrowAmount?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Financing Contingency', (item.financingContingency == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Financing Type', item.financingType?.toString() ?? 'N/A', Icons.info_outline),
                  _row('Inspection Period', item.inspectionPeriod?.toString() ?? 'N/A', Icons.numbers),
                  _row('List Price', item.listPrice?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
                  _row('Loan Amount', item.loanAmount?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Location Id', item.locationId?.toString() ?? 'N/A', Icons.link),
                  _row('Multiple Offers', (item.multipleOffers == true ? 'Yes' : 'No'), Icons.toggle_on),
                  _row('Offer Price', item.offerPrice?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
                  _row('Sale Price', item.salePrice?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Seller Concessions', item.sellerConcessions?.toString() ?? 'N/A', Icons.numbers),
                  _row('Title Contingency', (item.titleContingency == true ? 'Yes' : 'No'), Icons.person),
                  _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
                  _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
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
              child: Text('New Deal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: DealFormWidget(
                onSubmit: (newItem) {
                  ref.read(dealCreateStateProvider.notifier).state = newItem;
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
