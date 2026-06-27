import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/marketing_campaign.dart';

final adminMarketingCampaignsProvider = FutureProvider<List<MarketingCampaign>>(
  (ref) async {
    final dioClient = DioClient();
    try {
      final response = await dioClient.get('/api/v1/marketing-campaign');
      final data = response.data['data'] ?? response.data;
      if (data is List) {
        return data.map((e) => MarketingCampaign.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  },
);
