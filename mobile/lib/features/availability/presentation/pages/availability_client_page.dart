import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/availability_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/availability_form_widget.dart';

// ── Availability Client Page

class AvailabilityClientPage extends ConsumerStatefulWidget {
  const AvailabilityClientPage({super.key});
  @override ConsumerState<AvailabilityClientPage> createState() => _AvailabilityClientPageState();
}

class _AvailabilityClientPageState extends ConsumerState<AvailabilityClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(availabilityListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Availabilitys'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(availabilityListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
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
            final list = _q.isEmpty ? items
                : items.where((item) => ((item.propertyId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.pricingRuleId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Availabilitys', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(availabilityListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(child: Text(item.date != null && item.date!.toString().isNotEmpty ? item.date!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.date?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
            ElevatedButton.icon(onPressed: () => ref.invalidate(availabilityListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AvailabilityClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Availability'),
      ),
    );
  }

  void _showDetail(BuildContext context, Availability item) {
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
              const Text('Availability Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
                  _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
                  _row('Date', _fmt(item.date), Icons.calendar_today),
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
              child: Text('New Availability', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AvailabilityFormWidget(
                onSubmit: (newItem) {
                  ref.read(availabilityCreateStateProvider.notifier).state = newItem;
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