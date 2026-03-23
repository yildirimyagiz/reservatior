import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/negotiation_offer_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// NegotiationOffer Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class NegotiationOfferAdminPage extends ConsumerWidget {
  const NegotiationOfferAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(negotiationOfferLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Negotiation Offer Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(negotiationOfferListProvider)),
        ],
      ),
      body: const _NegotiationOfferBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'NegotiationOfferFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Negotiation Offer'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _NegotiationOfferBody extends ConsumerStatefulWidget {
  const _NegotiationOfferBody({super.key});
  @override ConsumerState<_NegotiationOfferBody> createState() => __NegotiationOfferBodyState();
}

class __NegotiationOfferBodyState extends ConsumerState<_NegotiationOfferBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(negotiationOfferListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Negotiation Offers…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.negotiationId?.toString() ?? '') + " " + (item.currency?.toString() ?? '') + " " + (item.notes?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Negotiation Offers yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(negotiationOfferListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.currency != null && item.currency!.toString().isNotEmpty ? item.currency!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.currency ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(negotiationOfferListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(NegotiationOffer item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, NegotiationOffer item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Negotiation Offer Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Negotiation Id', item.negotiationId?.toString() ?? 'N/A', Icons.link),
              _row('Offered By', item.offeredBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Installment Count', item.installmentCount?.toString() ?? 'N/A', Icons.numbers),
              _row('First Payment Pct', item.firstPaymentPct?.toString() ?? 'N/A', Icons.numbers),
              _row('Total Amount', item.totalAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Offered At', _formatDate(item.offeredAt), Icons.calendar_today),
              _row('Expires At', _formatDate(item.expiresAt), Icons.calendar_today),
              _row('Responded At', _formatDate(item.respondedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {NegotiationOffer? item}) {
  showDialog(context: context, builder: (ctx) => _NegotiationOfferForm(item: item, ref: ref));
}

class _NegotiationOfferForm extends ConsumerStatefulWidget {
  final NegotiationOffer? item;
  final WidgetRef ref;
  const _NegotiationOfferForm({super.key, this.item, required this.ref});
  @override ConsumerState<_NegotiationOfferForm> createState() => __NegotiationOfferFormState();
}

class __NegotiationOfferFormState extends ConsumerState<_NegotiationOfferForm> {
  final _key = GlobalKey<FormState>();

  String? _negotiationId;
  String? _offeredBy;
  int? _installmentCount;
  double? _firstPaymentPct;
  double? _totalAmount;
  String? _currency;
  String? _notes;
  String? _status;
  DateTime? _offeredAt;
  DateTime? _expiresAt;
  DateTime? _respondedAt;

  @override
  void initState() {
    super.initState();
    _negotiationId = widget.item?.negotiationId?.toString();
    _offeredBy = widget.item?.offeredBy?.toString();
    _installmentCount = widget.item?.installmentCount;
    _firstPaymentPct = widget.item?.firstPaymentPct;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency?.toString();
    _notes = widget.item?.notes?.toString();
    _status = widget.item?.status?.toString();
    _offeredAt = widget.item?.offeredAt;
    _expiresAt = widget.item?.expiresAt;
    _respondedAt = widget.item?.respondedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_negotiationId?.isNotEmpty == true) 'negotiationId': _negotiationId,
      if (_offeredBy?.isNotEmpty == true) 'offeredBy': _offeredBy,
      if (_installmentCount != null) 'installmentCount': _installmentCount,
      if (_firstPaymentPct != null) 'firstPaymentPct': _firstPaymentPct,
      if (_totalAmount != null) 'totalAmount': _totalAmount,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_notes?.isNotEmpty == true) 'notes': _notes,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_offeredAt != null) 'offeredAt': _offeredAt!.toIso8601String(),
      if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
      if (_respondedAt != null) 'respondedAt': _respondedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(negotiationOfferCreateStateProvider.notifier).state = NegotiationOffer.fromJson(data);
    } else {
      widget.ref.read(negotiationOfferUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'negotiationOffer': NegotiationOffer.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Negotiation Offer' : 'New Negotiation Offer'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Negotiation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.negotiationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _negotiationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Offered By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.offeredBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _offeredBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Installment Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.installmentCount?.toString() ?? '',
                    onSaved: (v) => _installmentCount = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'First Payment Pct', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.firstPaymentPct?.toString() ?? '',
                    onSaved: (v) => _firstPaymentPct = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.totalAmount?.toString() ?? '',
                    onSaved: (v) => _totalAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _offeredAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _offeredAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Offered At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_offeredAt != null ? _formatDate(_offeredAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _expiresAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _expiresAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Expires At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_expiresAt != null ? _formatDate(_expiresAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _respondedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _respondedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Responded At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_respondedAt != null ? _formatDate(_respondedAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Negotiation Offer'),
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

void _confirmDel(BuildContext context, WidgetRef ref, NegotiationOffer item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Negotiation Offer?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(negotiationOfferDeleteStateProvider.notifier).state = item.id;
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
