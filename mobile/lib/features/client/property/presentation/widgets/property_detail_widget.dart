import 'package:flutter/material.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyDetailWidget extends StatelessWidget {
  final Property item;
  const PropertyDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name, style: theme.textTheme.titleLarge),
          SizedBox(height: 1.h),
          Text(
            item.addressLine1 ?? 'mobile.leftovers.no_address'.tr(),
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 2.h),
          Text(
            'Price: \$${item.listingPrice ?? 0}',
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.green),
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('mobile.auto.close'.tr()),
          ),
        ],
      ),
    );
  }
}
