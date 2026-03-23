import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/mortgage_pre_approval_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// MortgagePreApproval Admin Page  |  23 fields
// Auto-generated — edit with care
// ================================================================

class MortgagePreApprovalAdminPage extends ConsumerWidget {
  const MortgagePreApprovalAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(mortgagePreApprovalLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortgage Pre Approval Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(mortgagePreApprovalListProvider)),
        ],
      ),
      body: const _MortgagePreApprovalBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MortgagePreApprovalFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Mortgage Pre Approval'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _MortgagePreApprovalBody extends ConsumerStatefulWidget {
  const _MortgagePreApprovalBody({super.key});
  @override ConsumerState<_MortgagePreApprovalBody> createState() => __MortgagePreApprovalBodyState();
}

class __MortgagePreApprovalBodyState extends ConsumerState<_MortgagePreApprovalBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mortgagePreApprovalListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
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
          final list = _q.isEmpty
              ? items
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.dealId?.toString() ?? '') + " " + (item.contactId?.toString() ?? '') + " " + (item.lenderName?.toString() ?? '') + " " + (item.mortgageType?.toString() ?? '') + " " + (item.offerStatus?.toString() ?? '') + " " + (item.solicitorName?.toString() ?? '') + " " + (item.solicitorEmail?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Mortgage Pre Approvals yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mortgagePreApprovalListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.lenderName != null && item.lenderName!.toString().isNotEmpty ? item.lenderName!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.lenderName ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.offerStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.offerStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(mortgagePreApprovalListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(MortgagePreApproval item) {
    final s = item.offerStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, MortgagePreApproval item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mortgage Pre Approval Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              _row('Offer Date', _formatDate(item.offerDate), Icons.calendar_today),
              _row('Expiry Date', _formatDate(item.expiryDate), Icons.calendar_today),
              _row('Accepted Date', _formatDate(item.acceptedDate), Icons.calendar_today),
              _row('Solicitor Name', item.solicitorName?.toString() ?? 'N/A', Icons.person),
              _row('Solicitor Email', item.solicitorEmail?.toString() ?? 'N/A', Icons.email),
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

void _showForm(BuildContext context, WidgetRef ref, {MortgagePreApproval? item}) {
  showDialog(context: context, builder: (ctx) => _MortgagePreApprovalForm(item: item, ref: ref));
}

class _MortgagePreApprovalForm extends ConsumerStatefulWidget {
  final MortgagePreApproval? item;
  final WidgetRef ref;
  const _MortgagePreApprovalForm({super.key, this.item, required this.ref});
  @override ConsumerState<_MortgagePreApprovalForm> createState() => __MortgagePreApprovalFormState();
}

class __MortgagePreApprovalFormState extends ConsumerState<_MortgagePreApprovalForm> {
  final _key = GlobalKey<FormState>();

  String? _dealId;
  String? _contactId;
  String? _lenderName;
  String? _mortgageType;
  int? _mortgageTerm;
  double? _interestRate;
  double? _arrangementFee;
  double? _valuationFee;
  double? _loanAmount;
  double? _depositAmount;
  double? _loanToValue;
  double? _monthlyPayment;
  double? _totalPayable;
  String? _offerStatus;
  DateTime? _offerDate;
  DateTime? _expiryDate;
  DateTime? _acceptedDate;
  String? _solicitorName;
  String? _solicitorEmail;

  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _lenderName = widget.item?.lenderName?.toString();
    _mortgageType = widget.item?.mortgageType?.toString();
    _mortgageTerm = widget.item?.mortgageTerm;
    _interestRate = widget.item?.interestRate;
    _arrangementFee = widget.item?.arrangementFee;
    _valuationFee = widget.item?.valuationFee;
    _loanAmount = widget.item?.loanAmount;
    _depositAmount = widget.item?.depositAmount;
    _loanToValue = widget.item?.loanToValue;
    _monthlyPayment = widget.item?.monthlyPayment;
    _totalPayable = widget.item?.totalPayable;
    _offerStatus = widget.item?.offerStatus?.toString();
    _offerDate = widget.item?.offerDate;
    _expiryDate = widget.item?.expiryDate;
    _acceptedDate = widget.item?.acceptedDate;
    _solicitorName = widget.item?.solicitorName?.toString();
    _solicitorEmail = widget.item?.solicitorEmail?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_dealId?.isNotEmpty == true) 'dealId': _dealId,
      if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
      if (_lenderName?.isNotEmpty == true) 'lenderName': _lenderName,
      if (_mortgageType?.isNotEmpty == true) 'mortgageType': _mortgageType,
      if (_mortgageTerm != null) 'mortgageTerm': _mortgageTerm,
      if (_interestRate != null) 'interestRate': _interestRate,
      if (_arrangementFee != null) 'arrangementFee': _arrangementFee,
      if (_valuationFee != null) 'valuationFee': _valuationFee,
      if (_loanAmount != null) 'loanAmount': _loanAmount,
      if (_depositAmount != null) 'depositAmount': _depositAmount,
      if (_loanToValue != null) 'loanToValue': _loanToValue,
      if (_monthlyPayment != null) 'monthlyPayment': _monthlyPayment,
      if (_totalPayable != null) 'totalPayable': _totalPayable,
      if (_offerStatus?.isNotEmpty == true) 'offerStatus': _offerStatus,
      if (_offerDate != null) 'offerDate': _offerDate!.toIso8601String(),
      if (_expiryDate != null) 'expiryDate': _expiryDate!.toIso8601String(),
      if (_acceptedDate != null) 'acceptedDate': _acceptedDate!.toIso8601String(),
      if (_solicitorName?.isNotEmpty == true) 'solicitorName': _solicitorName,
      if (_solicitorEmail?.isNotEmpty == true) 'solicitorEmail': _solicitorEmail,
    };
    if (widget.item == null) {
      widget.ref.read(mortgagePreApprovalCreateStateProvider.notifier).state = MortgagePreApproval.fromJson(data);
    } else {
      widget.ref.read(mortgagePreApprovalUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'mortgagePreApproval': MortgagePreApproval.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Mortgage Pre Approval' : 'New Mortgage Pre Approval'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.dealId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.contactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Lender Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.lenderName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _lenderName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mortgage Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.mortgageType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _mortgageType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mortgage Term', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.mortgageTerm?.toString() ?? '',
                    onSaved: (v) => _mortgageTerm = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Interest Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.interestRate?.toString() ?? '',
                    onSaved: (v) => _interestRate = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Arrangement Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.arrangementFee?.toString() ?? '',
                    onSaved: (v) => _arrangementFee = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Valuation Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.valuationFee?.toString() ?? '',
                    onSaved: (v) => _valuationFee = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Loan Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.loanAmount?.toString() ?? '',
                    onSaved: (v) => _loanAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Deposit Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.depositAmount?.toString() ?? '',
                    onSaved: (v) => _depositAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Loan To Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.loanToValue?.toString() ?? '',
                    onSaved: (v) => _loanToValue = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Monthly Payment', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.monthlyPayment?.toString() ?? '',
                    onSaved: (v) => _monthlyPayment = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Payable', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.totalPayable?.toString() ?? '',
                    onSaved: (v) => _totalPayable = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Offer Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.offerStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _offerStatus = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _offerDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _offerDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Offer Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_offerDate != null ? _formatDate(_offerDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _expiryDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _expiryDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_expiryDate != null ? _formatDate(_expiryDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _acceptedDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _acceptedDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Accepted Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_acceptedDate != null ? _formatDate(_acceptedDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Solicitor Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.solicitorName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _solicitorName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Solicitor Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                    initialValue: widget.item.solicitorEmail?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _solicitorEmail = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Mortgage Pre Approval'),
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

void _confirmDel(BuildContext context, WidgetRef ref, MortgagePreApproval item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Mortgage Pre Approval?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(mortgagePreApprovalDeleteStateProvider.notifier).state = item.id;
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
