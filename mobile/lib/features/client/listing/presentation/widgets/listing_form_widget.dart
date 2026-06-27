import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'category_selector.dart';
import 'package:easy_localization/easy_localization.dart';

class ListingFormWidget extends ConsumerStatefulWidget {
  final Listing? item;
  final Function(Listing) onSubmit;
  const ListingFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ListingFormWidget> createState() => _ListingFormWidgetState();
}

class _ListingFormWidgetState extends ConsumerState<ListingFormWidget> {
  String? _propertyId;
  DateTime? _willBeAvailableAt;
  String? _title;
  String? _description;
  double? _price;
  String? _priceCurrency;
  String? _locationId;
  String? _categoryId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _willBeAvailableAt = widget.item?.willBeAvailableAt;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _price = widget.item?.price;
    _priceCurrency = widget.item?.priceCurrency;
    _locationId = widget.item?.locationId;
    _categoryId = widget.item?.categoryId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.listing'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.listing'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CategorySelector(
              selectedCategoryId: _categoryId,
              onCategorySelected: (id) => setState(() => _categoryId = id),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            ListTile(
              title: Text(
                'willBeAvailableAt: ${_willBeAvailableAt ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _willBeAvailableAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _willBeAvailableAt = d);
              },
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _price?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.price'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _price = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _priceCurrency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pricecurrency'.tr()),
              onChanged: (v) => _priceCurrency = v,
            ),
            TextFormField(
              initialValue: _locationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.locationid'.tr()),
              onChanged: (v) => _locationId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_willBeAvailableAt != null)
                    'willBeAvailableAt': _willBeAvailableAt!.toIso8601String(),
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_price != null) 'price': _price,
                  if (_priceCurrency != null) 'priceCurrency': _priceCurrency,
                  if (_locationId != null) 'locationId': _locationId,
                  if (_categoryId != null) 'categoryId': _categoryId,
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
                  widget.onSubmit(Listing.fromJson(json));
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
