import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/mortgage_pre_approval_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/mortgage_pre_approval_form_widget.dart';

// ── MortgagePreApproval Client Page

class MortgagePreApprovalClientPage extends ConsumerStatefulWidget {
  const MortgagePreApprovalClientPage({super.key});
  @override ConsumerState<MortgagePreApprovalClientPage> createState() => _MortgagePreApprovalClientPageState();
}

class _MortgagePreApprovalClientPageState extends ConsumerState<MortgagePreApprovalClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mortgagePreApprovalListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Mortgage Pre Approvals'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(mortgagePreApprovalListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: 'Search Mortgage Pre Approvals…',
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
                : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.dealId?.toString() ?? '') + " " + (item.contactId?.toString() ?? '') + " " + (item.lenderName?.toString() ?? '') + " " + (item.mortgageType?.toString() ?? '') + " " + (item.offerStatus?.toString() ?? '') + " " + (item.solicitorName?.toString() ?? '') + " " + (item.solicitorEmail?.toString() ?? '')).toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Mortgage Pre Approvals', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(mortgagePreApprovalListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(backgroundColor: _stColor(item.offerStatus), foregroundColor: Colors.white, child: Text(item.lenderName != null && item.lenderName!.toString().isNotEmpty ? item.lenderName!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.lenderName ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
            ElevatedButton.icon(onPressed: () => ref.invalidate(mortgagePreApprovalListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MortgagePreApprovalClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Mortgage Pre Approval'),
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

  void _showDetail(BuildContext context, MortgagePreApproval item) {
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
              const Text('Mortgage Pre Approval Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
                  _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
                  _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
                  _row('Deal Id', item.dealId?.toString() ?? 'N/A', Icons.link),
                  _row('Contact Id', item.contactId?.toString() ?? 'N/A', Icons.link),
                  _row('Lender Name', item.lenderName?.toString() ?? 'N/A', Icons.person),
                  _row('Mortgage Type', item.mortgageType?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Mortgage Term', item.mortgageTerm?.toString() ?? 'N/A', Icons.numbers),
                  _row('Interest Rate', item.interestRate?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Arrangement Fee', item.arrangementFee?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Valuation Fee', item.valuationFee?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Loan Amount', item.loanAmount?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Deposit Amount', item.depositAmount?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Loan To Value', item.loanToValue?.toString() ?? 'N/A', Icons.numbers),
                  _row('Monthly Payment', item.monthlyPayment?.toString() ?? 'N/A', Icons.numbers),
                  _row('Total Payable', item.totalPayable?.toString() ?? 'N/A', Icons.attach_money),
                  _row('Offer Status', item.offerStatus?.toString() ?? 'N/A', Icons.info_outline),
                  _row('Offer Date', _fmt(item.offerDate), Icons.calendar_today),
                  _row('Expiry Date', _fmt(item.expiryDate), Icons.calendar_today),
                  _row('Accepted Date', _fmt(item.acceptedDate), Icons.calendar_today),
                  _row('Solicitor Name', item.solicitorName?.toString() ?? 'N/A', Icons.person),
                  _row('Solicitor Email', item.solicitorEmail?.toString() ?? 'N/A', Icons.email),
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
              child: Text('New Mortgage Pre Approval', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: MortgagePreApprovalFormWidget(
                onSubmit: (newItem) {
                  ref.read(mortgagePreApprovalCreateStateProvider.notifier).state = newItem;
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