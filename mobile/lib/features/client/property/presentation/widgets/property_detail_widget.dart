import 'package:flutter/material.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/services/ml_api_service.dart';

class PropertyDetailWidget extends StatefulWidget {
  final Property item;
  const PropertyDetailWidget({super.key, required this.item});

  @override
  State<PropertyDetailWidget> createState() => _PropertyDetailWidgetState();
}

class _PropertyDetailWidgetState extends State<PropertyDetailWidget> {
  bool _isGenerating = false;

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
          Text(widget.item.name, style: theme.textTheme.titleLarge),
          SizedBox(height: 1.h),
          Text(
            widget.item.addressLine1 ?? 'mobile.leftovers.no_address'.tr(),
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 2.h),
          Text(
            'Price: \$${widget.item.listingPrice ?? 0}',
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.green),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              ElevatedButton.icon(
                icon: _isGenerating 
                  ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Icon(Icons.document_scanner),
                label: Text('Generate AI Contract'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade700, foregroundColor: Colors.white),
                onPressed: _isGenerating ? null : () async {
                  setState(() => _isGenerating = true);
                  try {
                    final res = await mlApiService.generateContract({
                      "country_code": "TR",
                      "contract_type": "SALES",
                      "property": {
                        "id": widget.item.id,
                        "address": widget.item.addressLine1 ?? "Unknown",
                        "city": widget.item.city ?? "Unknown",
                        "country": widget.item.country ?? "TR",
                        "price": widget.item.listingPrice ?? 0,
                        "currency": widget.item.currency ?? "USD",
                        "property_type": "Property"
                      },
                      "owner": { "full_name": "System Owner", "identification_number": "000", "address": "N/A", "phone": "000", "email": "admin@res.com" },
                      "buyer_or_tenant": { "full_name": "New Client", "identification_number": "111", "address": "N/A", "phone": "111", "email": "client@res.com" }
                    });
                    
                    if (!mounted) return;
                    showDialog(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: Text('AI Contract Ready'),
                        content: SingleChildScrollView(child: Text(res['content_markdown'] ?? 'No content')),
                        actions: [TextButton(onPressed: () => Navigator.pop(c), child: Text('Close'))],
                      )
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  } finally {
                    if (mounted) setState(() => _isGenerating = false);
                  }
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('mobile.auto.close'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
