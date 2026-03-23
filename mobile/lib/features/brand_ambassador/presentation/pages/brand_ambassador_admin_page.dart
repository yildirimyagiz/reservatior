import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/brand_ambassador_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// BrandAmbassador Admin Page  |  27 fields
// Auto-generated — edit with care
// ================================================================

class BrandAmbassadorAdminPage extends ConsumerWidget {
  const BrandAmbassadorAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(brandAmbassadorLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brand Ambassador Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(brandAmbassadorListProvider)),
        ],
      ),
      body: const _BrandAmbassadorBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'BrandAmbassadorFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Brand Ambassador'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _BrandAmbassadorBody extends ConsumerStatefulWidget {
  const _BrandAmbassadorBody({super.key});
  @override ConsumerState<_BrandAmbassadorBody> createState() => __BrandAmbassadorBodyState();
}

class __BrandAmbassadorBodyState extends ConsumerState<_BrandAmbassadorBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(brandAmbassadorListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Brand Ambassadors…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.fullName?.toString() ?? '') + " " + (item.emailCiphertext?.toString() ?? '') + " " + (item.phoneCiphertext?.toString() ?? '') + " " + (item.currency?.toString() ?? '') + " " + (item.tier?.toString() ?? '') + " " + (item.agencyName?.toString() ?? '') + " " + (item.agencyContact?.toString() ?? '') + " " + (item.notes?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Brand Ambassadors yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(brandAmbassadorListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.fullName != null && item.fullName!.toString().isNotEmpty ? item.fullName!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.fullName ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(brandAmbassadorListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(BrandAmbassador item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, BrandAmbassador item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Brand Ambassador Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Full Name', item.fullName?.toString() ?? 'N/A', Icons.person),
              _row('Email Ciphertext', item.emailCiphertext?.toString() ?? 'N/A', Icons.email),
              _row('Phone Ciphertext', item.phoneCiphertext?.toString() ?? 'N/A', Icons.phone),
              _row('Category', item.category?.toString() ?? 'N/A', Icons.text_fields),
              _row('Follower Count', item.followerCount?.toString() ?? 'N/A', Icons.numbers),
              _row('Engagement Rate', item.engagementRate?.toString() ?? 'N/A', Icons.attach_money),
              _row('Contract Start', _formatDate(item.contractStart), Icons.calendar_today),
              _row('Contract End', _formatDate(item.contractEnd), Icons.calendar_today),
              _row('Equity Percent', item.equityPercent?.toString() ?? 'N/A', Icons.numbers),
              _row('Upfront Fee', item.upfrontFee?.toString() ?? 'N/A', Icons.attach_money),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Tier', item.tier?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Agency Name', item.agencyName?.toString() ?? 'N/A', Icons.person),
              _row('Agency Contact', item.agencyContact?.toString() ?? 'N/A', Icons.text_fields),
              _row('Nda Signed', (item.ndaSigned == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Nda Signed At', _formatDate(item.ndaSignedAt), Icons.calendar_today),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
              _row('Pitch Sent At', _formatDate(item.pitchSentAt), Icons.calendar_today),
              _row('Responded At', _formatDate(item.respondedAt), Icons.calendar_today),
              _row('Signed At', _formatDate(item.signedAt), Icons.calendar_today),
              _row('Actual Reach', item.actualReach?.toString() ?? 'N/A', Icons.numbers),
              _row('Total Roi', item.totalRoi?.toString() ?? 'N/A', Icons.attach_money),
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

void _showForm(BuildContext context, WidgetRef ref, {BrandAmbassador? item}) {
  showDialog(context: context, builder: (ctx) => _BrandAmbassadorForm(item: item, ref: ref));
}

class _BrandAmbassadorForm extends ConsumerStatefulWidget {
  final BrandAmbassador? item;
  final WidgetRef ref;
  const _BrandAmbassadorForm({super.key, this.item, required this.ref});
  @override ConsumerState<_BrandAmbassadorForm> createState() => __BrandAmbassadorFormState();
}

class __BrandAmbassadorFormState extends ConsumerState<_BrandAmbassadorForm> {
  final _key = GlobalKey<FormState>();

  String? _fullName;
  String? _emailCiphertext;
  String? _phoneCiphertext;
  String? _category;
  int? _followerCount;
  double? _engagementRate;
  DateTime? _contractStart;
  DateTime? _contractEnd;
  double? _equityPercent;
  double? _upfrontFee;
  String? _currency;
  String? _tier;
  String? _status;
  String? _agencyName;
  String? _agencyContact;
  bool _ndaSigned = false;
  DateTime? _ndaSignedAt;
  String? _notes;
  DateTime? _pitchSentAt;
  DateTime? _respondedAt;
  DateTime? _signedAt;
  int? _actualReach;
  double? _totalRoi;

  @override
  void initState() {
    super.initState();
    _fullName = widget.item?.fullName?.toString();
    _emailCiphertext = widget.item?.emailCiphertext?.toString();
    _phoneCiphertext = widget.item?.phoneCiphertext?.toString();
    _category = widget.item?.category?.toString();
    _followerCount = widget.item?.followerCount;
    _engagementRate = widget.item?.engagementRate;
    _contractStart = widget.item?.contractStart;
    _contractEnd = widget.item?.contractEnd;
    _equityPercent = widget.item?.equityPercent;
    _upfrontFee = widget.item?.upfrontFee;
    _currency = widget.item?.currency?.toString();
    _tier = widget.item?.tier?.toString();
    _status = widget.item?.status?.toString();
    _agencyName = widget.item?.agencyName?.toString();
    _agencyContact = widget.item?.agencyContact?.toString();
    _ndaSigned = widget.item?.ndaSigned ?? false;
    _ndaSignedAt = widget.item?.ndaSignedAt;
    _notes = widget.item?.notes?.toString();
    _pitchSentAt = widget.item?.pitchSentAt;
    _respondedAt = widget.item?.respondedAt;
    _signedAt = widget.item?.signedAt;
    _actualReach = widget.item?.actualReach;
    _totalRoi = widget.item?.totalRoi;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_fullName?.isNotEmpty == true) 'fullName': _fullName,
      if (_emailCiphertext?.isNotEmpty == true) 'emailCiphertext': _emailCiphertext,
      if (_phoneCiphertext?.isNotEmpty == true) 'phoneCiphertext': _phoneCiphertext,
      if (_category?.isNotEmpty == true) 'category': _category,
      if (_followerCount != null) 'followerCount': _followerCount,
      if (_engagementRate != null) 'engagementRate': _engagementRate,
      if (_contractStart != null) 'contractStart': _contractStart!.toIso8601String(),
      if (_contractEnd != null) 'contractEnd': _contractEnd!.toIso8601String(),
      if (_equityPercent != null) 'equityPercent': _equityPercent,
      if (_upfrontFee != null) 'upfrontFee': _upfrontFee,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_tier?.isNotEmpty == true) 'tier': _tier,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_agencyName?.isNotEmpty == true) 'agencyName': _agencyName,
      if (_agencyContact?.isNotEmpty == true) 'agencyContact': _agencyContact,
      'ndaSigned': _ndaSigned,
      if (_ndaSignedAt != null) 'ndaSignedAt': _ndaSignedAt!.toIso8601String(),
      if (_notes?.isNotEmpty == true) 'notes': _notes,
      if (_pitchSentAt != null) 'pitchSentAt': _pitchSentAt!.toIso8601String(),
      if (_respondedAt != null) 'respondedAt': _respondedAt!.toIso8601String(),
      if (_signedAt != null) 'signedAt': _signedAt!.toIso8601String(),
      if (_actualReach != null) 'actualReach': _actualReach,
      if (_totalRoi != null) 'totalRoi': _totalRoi,
    };
    if (widget.item == null) {
      widget.ref.read(brandAmbassadorCreateStateProvider.notifier).state = BrandAmbassador.fromJson(data);
    } else {
      widget.ref.read(brandAmbassadorUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'brandAmbassador': BrandAmbassador.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Brand Ambassador' : 'New Brand Ambassador'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Full Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.fullName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fullName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email Ciphertext', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                    initialValue: widget.item?.emailCiphertext?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _emailCiphertext = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone Ciphertext', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                    initialValue: widget.item?.phoneCiphertext?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _phoneCiphertext = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.category?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _category = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Follower Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.followerCount?.toString() ?? '',
                    onSaved: (v) => _followerCount = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Engagement Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.engagementRate?.toString() ?? '',
                    onSaved: (v) => _engagementRate = double.tryParse(v ?? ''),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _contractStart ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _contractStart = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Contract Start',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_contractStart != null ? _formatDate(_contractStart) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _contractEnd ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _contractEnd = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Contract End',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_contractEnd != null ? _formatDate(_contractEnd) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Equity Percent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.equityPercent?.toString() ?? '',
                    onSaved: (v) => _equityPercent = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Upfront Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.upfrontFee?.toString() ?? '',
                    onSaved: (v) => _upfrontFee = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tier', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.tier?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tier = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agency Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.agencyName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agencyName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agency Contact', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.agencyContact?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agencyContact = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Nda Signed'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.ndaSigned ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _ndaSigned = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _ndaSignedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _ndaSignedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Nda Signed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_ndaSignedAt != null ? _formatDate(_ndaSignedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _pitchSentAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _pitchSentAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Pitch Sent At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_pitchSentAt != null ? _formatDate(_pitchSentAt) : 'Tap to select date'),
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
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _signedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _signedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Signed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_signedAt != null ? _formatDate(_signedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Actual Reach', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.actualReach?.toString() ?? '',
                    onSaved: (v) => _actualReach = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Roi', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.totalRoi?.toString() ?? '',
                    onSaved: (v) => _totalRoi = double.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Brand Ambassador'),
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

void _confirmDel(BuildContext context, WidgetRef ref, BrandAmbassador item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Brand Ambassador?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(brandAmbassadorDeleteStateProvider.notifier).state = item.id;
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
