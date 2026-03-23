import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/availability_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Availability Admin Page  |  26 fields
// Auto-generated — edit with care
// ================================================================

class AvailabilityAdminPage extends ConsumerWidget {
  const AvailabilityAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(availabilityLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Availability Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(availabilityListProvider)),
        ],
      ),
      body: const _AvailabilityBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AvailabilityFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Availability'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AvailabilityBody extends ConsumerStatefulWidget {
  const _AvailabilityBody({super.key});
  @override ConsumerState<_AvailabilityBody> createState() => __AvailabilityBodyState();
}

class __AvailabilityBodyState extends ConsumerState<_AvailabilityBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(availabilityListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Availabilitys…',
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
              : items.where((item) => ((item.propertyId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.pricingRuleId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Availabilitys yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(availabilityListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.date != null && item.date!.toString().isNotEmpty ? item.date!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.date?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(availabilityListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Availability item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Availability Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Date', _formatDate(item.date), Icons.calendar_today),
              _row('Is Blocked', (item.isBlocked == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Is Booked', (item.isBooked == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
              _row('Pricing Rule Id', item.pricingRuleId?.toString() ?? 'N/A', Icons.link),
              _row('Total Units', item.totalUnits?.toString() ?? 'N/A', Icons.attach_money),
              _row('Available Units', item.availableUnits?.toString() ?? 'N/A', Icons.numbers),
              _row('Booked Units', item.bookedUnits?.toString() ?? 'N/A', Icons.numbers),
              _row('Blocked Units', item.blockedUnits?.toString() ?? 'N/A', Icons.numbers),
              _row('Special Pricing', item.specialPricing?.toString() ?? 'N/A', Icons.text_fields),
              _row('Base Price', item.basePrice?.toString() ?? 'N/A', Icons.attach_money),
              _row('Current Price', item.currentPrice?.toString() ?? 'N/A', Icons.attach_money),
              _row('Price Settings', item.priceSettings?.toString() ?? 'N/A', Icons.attach_money),
              _row('Min Nights', item.minNights?.toString() ?? 'N/A', Icons.numbers),
              _row('Max Nights', item.maxNights?.toString() ?? 'N/A', Icons.numbers),
              _row('Max Guests', item.maxGuests?.toString() ?? 'N/A', Icons.numbers),
              _row('Discount Settings', item.discountSettings?.toString() ?? 'N/A', Icons.text_fields),
              _row('Weekend Rate', item.weekendRate?.toString() ?? 'N/A', Icons.attach_money),
              _row('Weekday Rate', item.weekdayRate?.toString() ?? 'N/A', Icons.attach_money),
              _row('Weekend Multiplier', item.weekendMultiplier?.toString() ?? 'N/A', Icons.numbers),
              _row('Weekday Multiplier', item.weekdayMultiplier?.toString() ?? 'N/A', Icons.numbers),
              _row('Seasonal Multiplier', item.seasonalMultiplier?.toString() ?? 'N/A', Icons.numbers),
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

void _showForm(BuildContext context, WidgetRef ref, {Availability? item}) {
  showDialog(context: context, builder: (ctx) => _AvailabilityForm(item: item, ref: ref));
}

class _AvailabilityForm extends ConsumerStatefulWidget {
  final Availability? item;
  final WidgetRef ref;
  const _AvailabilityForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AvailabilityForm> createState() => __AvailabilityFormState();
}

class __AvailabilityFormState extends ConsumerState<_AvailabilityForm> {
  final _key = GlobalKey<FormState>();

  DateTime? _date;
  bool _isBlocked = false;
  bool _isBooked = false;
  String? _propertyId;
  String? _reservationId;
  String? _pricingRuleId;
  int? _totalUnits;
  int? _availableUnits;
  int? _bookedUnits;
  int? _blockedUnits;
  String? _specialPricing;
  double? _basePrice;
  double? _currentPrice;
  String? _priceSettings;
  int? _minNights;
  int? _maxNights;
  int? _maxGuests;
  String? _discountSettings;
  double? _weekendRate;
  double? _weekdayRate;
  double? _weekendMultiplier;
  double? _weekdayMultiplier;
  double? _seasonalMultiplier;

  @override
  void initState() {
    super.initState();
    _date = widget.item?.date;
    _isBlocked = widget.item?.isBlocked ?? false;
    _isBooked = widget.item?.isBooked ?? false;
    _propertyId = widget.item?.propertyId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _pricingRuleId = widget.item?.pricingRuleId?.toString();
    _totalUnits = widget.item?.totalUnits;
    _availableUnits = widget.item?.availableUnits;
    _bookedUnits = widget.item?.bookedUnits;
    _blockedUnits = widget.item?.blockedUnits;
    _specialPricing = widget.item?.specialPricing?.toString();
    _basePrice = widget.item?.basePrice;
    _currentPrice = widget.item?.currentPrice;
    _priceSettings = widget.item?.priceSettings?.toString();
    _minNights = widget.item?.minNights;
    _maxNights = widget.item?.maxNights;
    _maxGuests = widget.item?.maxGuests;
    _discountSettings = widget.item?.discountSettings?.toString();
    _weekendRate = widget.item?.weekendRate;
    _weekdayRate = widget.item?.weekdayRate;
    _weekendMultiplier = widget.item?.weekendMultiplier;
    _weekdayMultiplier = widget.item?.weekdayMultiplier;
    _seasonalMultiplier = widget.item?.seasonalMultiplier;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_date != null) 'date': _date!.toIso8601String(),
      'isBlocked': _isBlocked,
      'isBooked': _isBooked,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
      if (_pricingRuleId?.isNotEmpty == true) 'pricingRuleId': _pricingRuleId,
      if (_totalUnits != null) 'totalUnits': _totalUnits,
      if (_availableUnits != null) 'availableUnits': _availableUnits,
      if (_bookedUnits != null) 'bookedUnits': _bookedUnits,
      if (_blockedUnits != null) 'blockedUnits': _blockedUnits,
      if (_specialPricing?.isNotEmpty == true) 'specialPricing': _specialPricing,
      if (_basePrice != null) 'basePrice': _basePrice,
      if (_currentPrice != null) 'currentPrice': _currentPrice,
      if (_priceSettings?.isNotEmpty == true) 'priceSettings': _priceSettings,
      if (_minNights != null) 'minNights': _minNights,
      if (_maxNights != null) 'maxNights': _maxNights,
      if (_maxGuests != null) 'maxGuests': _maxGuests,
      if (_discountSettings?.isNotEmpty == true) 'discountSettings': _discountSettings,
      if (_weekendRate != null) 'weekendRate': _weekendRate,
      if (_weekdayRate != null) 'weekdayRate': _weekdayRate,
      if (_weekendMultiplier != null) 'weekendMultiplier': _weekendMultiplier,
      if (_weekdayMultiplier != null) 'weekdayMultiplier': _weekdayMultiplier,
      if (_seasonalMultiplier != null) 'seasonalMultiplier': _seasonalMultiplier,
    };
    if (widget.item == null) {
      widget.ref.read(availabilityCreateStateProvider.notifier).state = Availability.fromJson(data);
    } else {
      widget.ref.read(availabilityUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'availability': Availability.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Availability' : 'New Availability'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _date ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _date = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_date != null ? _formatDate(_date) : 'Tap to select date'),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Blocked'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isBlocked ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isBlocked = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Booked'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isBooked ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isBooked = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.reservationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Pricing Rule Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.pricingRuleId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _pricingRuleId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Units', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.totalUnits?.toString() ?? '',
                    onSaved: (v) => _totalUnits = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Available Units', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.availableUnits?.toString() ?? '',
                    onSaved: (v) => _availableUnits = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Booked Units', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.bookedUnits?.toString() ?? '',
                    onSaved: (v) => _bookedUnits = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Blocked Units', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.blockedUnits?.toString() ?? '',
                    onSaved: (v) => _blockedUnits = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Special Pricing', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.specialPricing?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _specialPricing = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Base Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.basePrice?.toString() ?? '',
                    onSaved: (v) => _basePrice = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Current Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.currentPrice?.toString() ?? '',
                    onSaved: (v) => _currentPrice = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price Settings', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                    initialValue: widget.item?.priceSettings?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _priceSettings = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Min Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.minNights?.toString() ?? '',
                    onSaved: (v) => _minNights = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.maxNights?.toString() ?? '',
                    onSaved: (v) => _maxNights = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Guests', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.maxGuests?.toString() ?? '',
                    onSaved: (v) => _maxGuests = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Discount Settings', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.discountSettings?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _discountSettings = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Weekend Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.weekendRate?.toString() ?? '',
                    onSaved: (v) => _weekendRate = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Weekday Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.weekdayRate?.toString() ?? '',
                    onSaved: (v) => _weekdayRate = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Weekend Multiplier', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.weekendMultiplier?.toString() ?? '',
                    onSaved: (v) => _weekendMultiplier = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Weekday Multiplier', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.weekdayMultiplier?.toString() ?? '',
                    onSaved: (v) => _weekdayMultiplier = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Seasonal Multiplier', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.seasonalMultiplier?.toString() ?? '',
                    onSaved: (v) => _seasonalMultiplier = double.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Availability'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Availability item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Availability?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(availabilityDeleteStateProvider.notifier).state = item.id;
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
