import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';

final dashboardSummaryProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final dio = ref.watch(dioClientProvider);
  try {
    final response = await dio.get('/api/v1/dashboard-summary');
    return response.data;
  } catch (e) {
    // Return fallback mock data if API fails or offline
    return {
      'portfolioValue': 14250000,
      'activeLeases': 3,
      'monthlyYield': 85400,
      'aiValuation': 4.2,
      'syncEvents': [
        {'platform': 'Airbnb', 'action': 'mobile.leftovers.pricing_synced'.tr(), 'status': 'success'},
        {'platform': 'Zillow', 'action': 'mobile.leftovers.lease_updated'.tr(), 'status': 'success'},
        {'platform': 'mobile.leftovers.gov_uk'.tr(), 'action': 'mobile.leftovers.right_to_rent_checked'.tr(), 'status': 'success'},
      ]
    };
  }
});
