import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/config/region_config.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

final regionProvider = StateNotifierProvider<RegionNotifier, RegionalConfig?>((ref) {
  return RegionNotifier();
});

class RegionNotifier extends StateNotifier<RegionalConfig?> {
  RegionNotifier() : super(null);

  Future<void> fetchRegion(String countryCode) async {
    try {
      final dio = DioClient();
      final response = await dio.get('${ApiEndpoints.baseUrl}/config/regions/$countryCode');
      state = RegionalConfig.fromJson(response.data['region']);
    } catch (e) {
      print('Error fetching regional config: $e');
    }
  }

  Future<void> setRegion(RegionalConfig config) async {
    state = config;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_region_code', config.toString());
    } catch (e) {
      print('Failed to save region code: $e');
    }
  }
}
