import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:logger/logger.dart';

class GeoInitService {
  final DioClient _dioClient;
  final Logger _log = Logger();

  GeoInitService(this._dioClient);

  /// Automatically detects the user's IP region from the backend 
  /// if no region is currently selected.
  Future<void> initializeGeo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existingRegion = prefs.getString('selected_region_code');

      if (existingRegion != null && existingRegion.isNotEmpty) {
        _log.d('🌍 GeoInitService: Region already set to [$existingRegion]. Skipping auto-detect.');
        // Note: Language state update could happen here based on the region.
        return;
      }

      _log.d('mobile.leftovers._geoinitservice_no_region_selected_reque'.tr());
      final geoResponse = await _dioClient.get(ApiEndpoints.geoConfig);
      
      if (geoResponse.data != null && geoResponse.data['success'] == true) {
        final detectedCountry = geoResponse.data['country'] as String;
        
        await prefs.setString('selected_region_code', detectedCountry);
        _log.i('🌍 GeoInitService: Successfully auto-detected and saved region: [$detectedCountry]');
        
        // TODO: In the future, trigger a Provider/Riverpod update to refresh the UI and Locale (i18n).
        // e.g., if detectedCountry == 'TR', set locale to 'tr'.
      } else {
        _log.w('mobile.leftovers._geoinitservice_geo_api_returned_unexpec'.tr());
        await prefs.setString('selected_region_code', 'US');
      }
    } catch (e) {
      _log.e('🌍 GeoInitService: Failed to detect geo location. Defaulting to US. Error: $e');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_region_code', 'US');
    }
  }
}
