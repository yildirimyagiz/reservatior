import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/deal_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Deal Admin Page  |  26 fields
// Auto-generated — edit with care
// ================================================================

class DealAdminPage extends ConsumerWidget {
  const DealAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(dealLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deal Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(dealListProvider)),
        ],
      ),
      body: const _DealBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'DealFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Deal'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _DealBody extends ConsumerStatefulWidget {
  const _DealBody({super.key});
  @override ConsumerState<_DealBody> createState() => __DealBodyState();
}

class __DealBodyState extends ConsumerState<_DealBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(dealListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
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
          final list = _q.isEmpty
              ? items
              : items.where((item) => ((item.listingId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.clientId?.toString() ?? '') + " " + (item.agentId?.toString() ?? '') + " " + (item.locationId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "\$_q"' : 'No Deals yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(dealListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.listingId != null && item.listingId!.toString().isNotEmpty ? item.listingId!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.listingId?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Type: ' + (item.dealType?.toString() ?? 'N/A')),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(dealListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Deal item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Deal Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Agent Id', item.agentId?.toString() ?? 'N/A', Icons.link),
              _row('Appraisal Contingency', (item.appraisalContingency == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Attorney Review', (item.attorneyReview == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Buyer Credits', item.buyerCredits?.toString() ?? 'N/A', Icons.numbers),
              _row('Client Id', item.clientId?.toString() ?? 'N/A', Icons.link),
              _row('Closing Costs', item.closingCosts?.toString() ?? 'N/A', Icons.attach_money),
              _row('Closing Date', _formatDate(item.closingDate), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {Deal? item}) {
  showDialog(context: context, builder: (ctx) => _DealForm(item: item, ref: ref));
}

class _DealForm extends ConsumerStatefulWidget {
  final Deal? item;
  final WidgetRef ref;
  const _DealForm({super.key, this.item, required this.ref});
  @override ConsumerState<_DealForm> createState() => __DealFormState();
}

class __DealFormState extends ConsumerState<_DealForm> {
  final _key = GlobalKey<FormState>();

  String? _agentId;
  bool _appraisalContingency = false;
  bool _attorneyReview = false;
  double? _buyerCredits;
  String? _clientId;
  double? _closingCosts;
  DateTime? _closingDate;
  double? _commissionAmount;
  double? _commissionRate;
  String? _dealType;
  double? _downPayment;
  double? _earnestMoney;
  double? _escrowAmount;
  bool _financingContingency = false;
  String? _financingType;
  int? _inspectionPeriod;
  double? _listPrice;
  String? _listingId;
  double? _loanAmount;
  String? _locationId;
  bool _multipleOffers = false;
  double? _offerPrice;
  String? _propertyId;
  double? _salePrice;
  double? _sellerConcessions;
  bool _titleContingency = false;

  @override
  void initState() {
    super.initState();
    _agentId = widget.item?.agentId?.toString();
    _appraisalContingency = widget.item?.appraisalContingency ?? false;
    _attorneyReview = widget.item?.attorneyReview ?? false;
    _buyerCredits = widget.item?.buyerCredits;
    _clientId = widget.item?.clientId?.toString();
    _closingCosts = widget.item?.closingCosts;
    _closingDate = widget.item?.closingDate;
    _commissionAmount = widget.item?.commissionAmount;
    _commissionRate = widget.item?.commissionRate;
    _dealType = widget.item?.dealType?.toString();
    _downPayment = widget.item?.downPayment;
    _earnestMoney = widget.item?.earnestMoney;
    _escrowAmount = widget.item?.escrowAmount;
    _financingContingency = widget.item?.financingContingency ?? false;
    _financingType = widget.item?.financingType?.toString();
    _inspectionPeriod = widget.item?.inspectionPeriod;
    _listPrice = widget.item?.listPrice;
    _listingId = widget.item?.listingId?.toString();
    _loanAmount = widget.item?.loanAmount;
    _locationId = widget.item?.locationId?.toString();
    _multipleOffers = widget.item?.multipleOffers ?? false;
    _offerPrice = widget.item?.offerPrice;
    _propertyId = widget.item?.propertyId?.toString();
    _salePrice = widget.item?.salePrice;
    _sellerConcessions = widget.item?.sellerConcessions;
    _titleContingency = widget.item?.titleContingency ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
      'appraisalContingency': _appraisalContingency,
      'attorneyReview': _attorneyReview,
      if (_buyerCredits != null) 'buyerCredits': _buyerCredits,
      if (_clientId?.isNotEmpty == true) 'clientId': _clientId,
      if (_closingCosts != null) 'closingCosts': _closingCosts,
      if (_closingDate != null) 'closingDate': _closingDate!.toIso8601String(),
      if (_commissionAmount != null) 'commissionAmount': _commissionAmount,
      if (_commissionRate != null) 'commissionRate': _commissionRate,
      if (_dealType?.isNotEmpty == true) 'dealType': _dealType,
      if (_downPayment != null) 'downPayment': _downPayment,
      if (_earnestMoney != null) 'earnestMoney': _earnestMoney,
      if (_escrowAmount != null) 'escrowAmount': _escrowAmount,
      'financingContingency': _financingContingency,
      if (_financingType?.isNotEmpty == true) 'financingType': _financingType,
      if (_inspectionPeriod != null) 'inspectionPeriod': _inspectionPeriod,
      if (_listPrice != null) 'listPrice': _listPrice,
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_loanAmount != null) 'loanAmount': _loanAmount,
      if (_locationId?.isNotEmpty == true) 'locationId': _locationId,
      'multipleOffers': _multipleOffers,
      if (_offerPrice != null) 'offerPrice': _offerPrice,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_salePrice != null) 'salePrice': _salePrice,
      if (_sellerConcessions != null) 'sellerConcessions': _sellerConcessions,
      'titleContingency': _titleContingency,
    };
    if (widget.item == null) {
      widget.ref.read(dealCreateStateProvider.notifier).state = Deal.fromJson(data);
    } else {
      widget.ref.read(dealUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'deal': Deal.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Deal' : 'New Deal'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.agentId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Appraisal Contingency'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.appraisalContingency ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _appraisalContingency = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Attorney Review'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.attorneyReview ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _attorneyReview = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Buyer Credits', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.buyerCredits?.toString() ?? '',
                    onSaved: (v) => _buyerCredits = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Client Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.clientId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _clientId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Closing Costs', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.closingCosts?.toString() ?? '',
                    onSaved: (v) => _closingCosts = double.tryParse(v ?? ''),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _closingDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _closingDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Closing Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_closingDate != null ? _formatDate(_closingDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Commission Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.commissionAmount?.toString() ?? '',
                    onSaved: (v) => _commissionAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Commission Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.commissionRate?.toString() ?? '',
                    onSaved: (v) => _commissionRate = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deal Type', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.dealType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dealType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Down Payment', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.downPayment?.toString() ?? '',
                    onSaved: (v) => _downPayment = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Earnest Money', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.earnestMoney?.toString() ?? '',
                    onSaved: (v) => _earnestMoney = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Escrow Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.escrowAmount?.toString() ?? '',
                    onSaved: (v) => _escrowAmount = double.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Financing Contingency'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.financingContingency ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _financingContingency = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Financing Type', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.financingType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _financingType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Inspection Period', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.inspectionPeriod?.toString() ?? '',
                    onSaved: (v) => _inspectionPeriod = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'List Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.listPrice?.toString() ?? '',
                    onSaved: (v) => _listPrice = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Loan Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.loanAmount?.toString() ?? '',
                    onSaved: (v) => _loanAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Location Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.locationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _locationId = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Multiple Offers'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.multipleOffers ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _multipleOffers = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Offer Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.offerPrice?.toString() ?? '',
                    onSaved: (v) => _offerPrice = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Sale Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.salePrice?.toString() ?? '',
                    onSaved: (v) => _salePrice = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Seller Concessions', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.sellerConcessions?.toString() ?? '',
                    onSaved: (v) => _sellerConcessions = double.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Title Contingency'),
                      secondary: const Icon(Icons.person),
                      value: widget.item?.titleContingency ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _titleContingency = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Deal'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Deal item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Deal?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(dealDeleteStateProvider.notifier).state = item.id;
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
