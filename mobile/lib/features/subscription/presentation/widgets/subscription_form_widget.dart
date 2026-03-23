import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Subscription Form Widget  |  Fields: userId, name, type, price, currency, billingCycle, maxProperties, maxListings, featuredListings, prioritySupport, apiAccess, commissionDiscount, loyaltyMultiplier, isActive, userSubscriptions

class SubscriptionFormWidget extends StatefulWidget {
  final Subscription? item;
  final void Function(Subscription)? onSubmit;
  const SubscriptionFormWidget({super.key, this.item, this.onSubmit});
  @override State<SubscriptionFormWidget> createState() => _SubscriptionFormWidgetState();
}

class _SubscriptionFormWidgetState extends State<SubscriptionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _name;
  String? _type;
  double? _price;
  String? _currency;
  String? _billingCycle;
  int? _maxProperties;
  int? _maxListings;
  int? _featuredListings;
  bool _prioritySupport = false;
  bool _apiAccess = false;
  double? _commissionDiscount;
  double? _loyaltyMultiplier;
  bool _isActive = false;
  String? _userSubscriptions;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _price = widget.item?.price;
    _currency = widget.item?.currency?.toString();
    _billingCycle = widget.item?.billingCycle?.toString();
    _maxProperties = widget.item?.maxProperties;
    _maxListings = widget.item?.maxListings;
    _featuredListings = widget.item?.featuredListings;
    _prioritySupport = widget.item?.prioritySupport ?? false;
    _apiAccess = widget.item?.apiAccess ?? false;
    _commissionDiscount = widget.item?.commissionDiscount;
    _loyaltyMultiplier = widget.item?.loyaltyMultiplier;
    _isActive = widget.item?.isActive ?? false;
    _userSubscriptions = widget.item?.userSubscriptions?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_price != null) 'price': _price,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_billingCycle?.isNotEmpty == true) 'billingCycle': _billingCycle,
        if (_maxProperties != null) 'maxProperties': _maxProperties,
        if (_maxListings != null) 'maxListings': _maxListings,
        if (_featuredListings != null) 'featuredListings': _featuredListings,
        'prioritySupport': _prioritySupport,
        'apiAccess': _apiAccess,
        if (_commissionDiscount != null) 'commissionDiscount': _commissionDiscount,
        if (_loyaltyMultiplier != null) 'loyaltyMultiplier': _loyaltyMultiplier,
        'isActive': _isActive,
        if (_userSubscriptions?.isNotEmpty == true) 'userSubscriptions': _userSubscriptions,
    };
    final result = widget.item != null
        ? Subscription.fromJson({...widget.item!.toJson(), ...data})
        : Subscription.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _price = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Billing Cycle', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _billingCycle = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Properties', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxProperties = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Listings', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxListings = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Featured Listings', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _featuredListings = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Priority Support'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _prioritySupport,
                  onChanged: (v) { ss(() {}); setState(() => _prioritySupport = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Api Access'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _apiAccess,
                  onChanged: (v) { ss(() {}); setState(() => _apiAccess = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Discount', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _commissionDiscount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Loyalty Multiplier', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _loyaltyMultiplier = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Subscriptions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _userSubscriptions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Subscription'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
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