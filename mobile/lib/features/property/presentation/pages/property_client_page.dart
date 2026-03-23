import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/property_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/property_form_widget.dart';
import '../widgets/property_detail_widget.dart';

// ── Property Client Page

class PropertyClientPage extends ConsumerStatefulWidget {
  const PropertyClientPage({super.key});
  @override ConsumerState<PropertyClientPage> createState() => _PropertyClientPageState();
}

class _PropertyClientPageState extends ConsumerState<PropertyClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(propertyListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Propertys'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(propertyListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: 'Search Propertys…',
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
                : items.where((item) => (((item.orgId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.currency?.toString() ?? '') + " " + (item.addressLine1?.toString() ?? '') + " " + (item.addressLine2?.toString() ?? '') + " " + (item.city?.toString() ?? '') + " " + (item.state?.toString() ?? '') + " " + (item.zip?.toString() ?? '') + " " + (item.country?.toString() ?? '') + " " + (item.neighborhoodId?.toString() ?? '') + " " + (item.notes?.toString() ?? '') + " " + (item.locationId?.toString() ?? '') + " " + (item.schoolDistrict?.toString() ?? '') + " " + (item.hoaFeeFrequency?.toString() ?? '') + " " + (item.floodZone?.toString() ?? '') + " " + (item.zoningCode?.toString() ?? '') + " " + (item.basementType?.toString() ?? '') + " " + (item.garageType?.toString() ?? '') + " " + (item.parkingType?.toString() ?? '') + " " + (item.poolType?.toString() ?? '') + " " + (item.heatingType?.toString() ?? '') + " " + (item.coolingType?.toString() ?? '') + " " + (item.fireplaceType?.toString() ?? '') + " " + (item.viewType?.toString() ?? '') + " " + (item.waterfrontType?.toString() ?? '') + " " + (item.constructionType?.toString() ?? '') + " " + (item.roofType?.toString() ?? '') + " " + (item.sidingType?.toString() ?? '') + " " + (item.zipPlus4?.toString() ?? '') + " " + (item.countyFIPS?.toString() ?? '') + " " + (item.censusTract?.toString() ?? '') + " " + (item.mlsArea?.toString() ?? '') + " " + (item.propertyClass?.toString() ?? '') + " " + (item.buildingClass?.toString() ?? '') + " " + (item.electricityProvider?.toString() ?? '') + " " + (item.gasProvider?.toString() ?? '') + " " + (item.waterProvider?.toString() ?? '') + " " + (item.internetProvider?.toString() ?? '') + " " + (item.trashService?.toString() ?? '') + " " + (item.mlsNumber?.toString() ?? '') + " " + (item.mlsStatus?.toString() ?? '') + " " + (item.energyRating?.toString() ?? '') + " " + (item.zoningDescription?.toString() ?? '') + " " + (item.landUse?.toString() ?? '') + " " + (item.buildingRestrictions?.toString() ?? '') + " " + (item.futureDevelopment?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q))).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Propertys', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(propertyListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  final _title = item.name?.toString() ?? 'Unknown';
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(
                        child: Text(_title.isNotEmpty ? _title[0].toUpperCase() : '?'),
                      ),
                      title: Text(_title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Type: ' + item.type?.toString()),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(icon: const Icon(Icons.edit_outlined, size: 20), tooltip: 'Edit',
                            onPressed: () => _showForm(context, item: item)),
                        const Icon(Icons.chevron_right),
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
            Text('$e', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton.icon(onPressed: () => ref.invalidate(propertyListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PropertyClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Property'),
      ),
    );
  }

  void _showDetail(BuildContext context, Property item) {
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
              const Text('Property Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.edit_outlined), tooltip: 'Edit',
                onPressed: () { Navigator.pop(ctx); _showForm(context, item: item); }),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: SingleChildScrollView(
            controller: sc,
            padding: const EdgeInsets.all(16),
            child: PropertyDetailWidget(item: item),
          )),
        ]),
      ),
    );
  }

  void _showForm(BuildContext context, {Property? item}) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(alignment: Alignment.centerLeft,
              child: Text(item != null ? 'Edit Property' : 'New Property',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: PropertyFormWidget(
                item: item,
                onSubmit: (result) {
                  if (item == null) {
                    ref.read(propertyCreateStateProvider.notifier).state = result;
                  } else {
                    ref.read(propertyUpdateStateProvider.notifier).state = {
                      'id': item.id,
                      'property': result,
                    };
                  }
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

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}
