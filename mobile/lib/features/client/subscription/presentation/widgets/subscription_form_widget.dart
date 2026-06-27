import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SubscriptionFormWidget extends ConsumerStatefulWidget {
  final Subscription? item;
  final Function(Subscription) onSubmit;
  const SubscriptionFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<SubscriptionFormWidget> createState() =>
      _SubscriptionFormWidgetState();
}

class _SubscriptionFormWidgetState
    extends ConsumerState<SubscriptionFormWidget> {
  String? _userId;
  String? _name;
  double? _price;
  String? _currency;
  String? _billingCycle;
  int? _maxProperties;
  int? _maxListings;
  int? _featuredListings;
  bool? _prioritySupport;
  bool? _apiAcces;
  double? _commissionDiscount;
  double? _loyaltyMultiplier;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _name = widget.item?.name;
    _price = widget.item?.price;
    _currency = widget.item?.currency;
    _billingCycle = widget.item?.billingCycle;
    _maxProperties = widget.item?.maxProperties;
    _maxListings = widget.item?.maxListings;
    _featuredListings = widget.item?.featuredListings;
    _prioritySupport = widget.item?.prioritySupport;
    _apiAcces = widget.item?.apiAcces;
    _commissionDiscount = widget.item?.commissionDiscount;
    _loyaltyMultiplier = widget.item?.loyaltyMultiplier;
    _isActive = widget.item?.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.subscription'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.subscription'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _price?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.price'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _price = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _billingCycle?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.billingcycle'.tr()),
              onChanged: (v) => _billingCycle = v,
            ),
            TextFormField(
              initialValue: _maxProperties?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxproperties'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxProperties = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxListings?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxlistings'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxListings = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _featuredListings?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.featuredlistings'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _featuredListings = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.prioritysupport'.tr()),
              value: _prioritySupport ?? false,
              onChanged: (v) => setState(() => _prioritySupport = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.apiacces'.tr()),
              value: _apiAcces ?? false,
              onChanged: (v) => setState(() => _apiAcces = v),
            ),
            TextFormField(
              initialValue: _commissionDiscount?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.commissiondiscount'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionDiscount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _loyaltyMultiplier?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.loyaltymultiplier'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _loyaltyMultiplier = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_name != null) 'name': _name,
                  if (_price != null) 'price': _price,
                  if (_currency != null) 'currency': _currency,
                  if (_billingCycle != null) 'billingCycle': _billingCycle,
                  if (_maxProperties != null) 'maxProperties': _maxProperties,
                  if (_maxListings != null) 'maxListings': _maxListings,
                  if (_featuredListings != null)
                    'featuredListings': _featuredListings,
                  'prioritySupport': _prioritySupport,
                  'apiAcces': _apiAcces,
                  if (_commissionDiscount != null)
                    'commissionDiscount': _commissionDiscount,
                  if (_loyaltyMultiplier != null)
                    'loyaltyMultiplier': _loyaltyMultiplier,
                  'isActive': _isActive,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(Subscription.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
