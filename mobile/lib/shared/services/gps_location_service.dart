import 'package:geolocator/geolocator.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';

class GpsLocationService {
  final Logger _logger = Logger();

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _logger.e('mobile.leftovers.location_services_are_disabled'.tr());
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _logger.e('mobile.leftovers.location_permissions_are_denied'.tr());
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      _logger.e('mobile.leftovers.location_permissions_are_permanently_den'.tr());
      return null;
    } 

    return await Geolocator.getCurrentPosition();
  }

  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }
}
