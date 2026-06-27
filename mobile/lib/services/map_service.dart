import 'package:dio/dio.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class MapService {
  final Dio _dio;
  final String _apiKey;

  MapService()
      : _dio = Dio(),
        _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  // Search nearby properties
  Future<List<dynamic>> searchNearbyProperties({
    required double latitude,
    required double longitude,
    double radius = 5000, // 5km radius
    String? propertyType,
  }) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
        queryParameters: {
          'location': '$latitude,$longitude',
          'radius': radius,
          'type': 'real_estate_agency',
          'keyword': propertyType ?? 'property',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final results = response.data['results'] as List;
        return results.map((place) => _convertToDynamic(place)).toList();
      }
      return [];
    } catch (e) {
      print('Error searching nearby properties: $e');
      return [];
    }
  }

  // Get place details
  Future<Map<String, dynamic>?> getPlaceDetails(String placeId) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'name,rating,formatted_phone_number,formatted_address,geometry',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        return response.data['result'];
      }
      return null;
    } catch (e) {
      print('Error getting place details: $e');
      return null;
    }
  }

  // Geocoding - Address to Coordinates
  Future<LatLng?> geocodeAddress(String address) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'address': address,
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200 && 
          response.data['results'].isNotEmpty) {
        final location = response.data['results'][0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      }
      return null;
    } catch (e) {
      print('Error geocoding address: $e');
      return null;
    }
  }

  // Reverse Geocoding - Coordinates to Address
  Future<String?> reverseGeocode(double latitude, double longitude) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'latlng': '$latitude,$longitude',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200 && 
          response.data['results'].isNotEmpty) {
        return response.data['results'][0]['formatted_address'];
      }
      return null;
    } catch (e) {
      print('Error reverse geocoding: $e');
      return null;
    }
  }

  // Calculate distance between two points
  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371000; // Earth's radius in meters

    final double dLat = (lat2 - lat1).toRadians();
    final double dLon = (lon2 - lon1).toRadians();

    final double a = 
        (dLat / 2).sin() * (dLat / 2).sin() +
        lat1.cos() * lat2.cos() *
        (dLon / 2).sin() * (dLon / 2).sin();

    final double c = 2 * a.sqrt().asin();

    return earthRadius * c; // Distance in meters
  }

  // Get directions between two points
  Future<Map<String, dynamic>?> getDirections(
    double originLat,
    double originLng,
    double destLat,
    double destLng,
  ) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/directions/json',
        queryParameters: {
          'origin': '$originLat,$originLng',
          'destination': '$destLat,$destLng',
          'mode': 'driving',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200 && 
          response.data['routes'].isNotEmpty) {
        return response.data['routes'][0];
      }
      return null;
    } catch (e) {
      print('Error getting directions: $e');
      return null;
    }
  }

  // Get static map image
  String getStaticMapUrl({
    required double centerLat,
    required double centerLng,
    int zoom = 14,
    int width = 600,
    int height = 400,
    List<dynamic>? markers,
  }) {
    final StringBuffer url = StringBuffer();
    url.write('https://maps.googleapis.com/maps/api/staticmap?');
    url.write('center=$centerLat,$centerLng');
    url.write('&zoom=$zoom');
    url.write('&size=${width}x$height');
    url.write('&key=$_apiKey');

    // Add markers
    if (markers != null && markers.isNotEmpty) {
      for (int i = 0; i < markers.length; i++) {
        final marker = markers[i];
        url.write('&markers=color:red%7Clabel:${i + 1}%7C${marker.latitude},${marker.longitude}');
      }
    }

    return url.toString();
  }

  // Search places with autocomplete
  Future<List<Map<String, dynamic>>> searchPlacesAutocomplete(
    String input, {
    String? sessionToken,
    String? types,
  }) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': input,
          'key': _apiKey,
          if (sessionToken != null) 'sessiontoken': sessionToken,
          if (types != null) 'types': types,
        },
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(
          response.data['predictions'] as List,
        );
      }
      return [];
    } catch (e) {
      print('Error in autocomplete search: $e');
      return [];
    }
  }

  dynamic _convertToDynamic(Map<String, dynamic> place) {
    final location = place['geometry']['location'];
    return {
      'id': place['place_id'],
      'title': place['name'] ?? 'mobile.leftovers.unknown_property'.tr(),
      'price': '\$${(location['lat'] * 1000).round()}', // Dummy price
      'latitude': location['lat'],
      'longitude': location['lng'],
      'propertyType': _extractPropertyType(place),
      'imageUrl': place['photos']?.isNotEmpty == true
          ? 'https://maps.googleapis.com/maps/api/place/photo?'
              'maxwidth=400&photo_reference=${place['photos'][0]['photo_reference']}&key=$_apiKey'
          : null,
    };
  }

  String _extractPropertyType(Map<String, dynamic> place) {
    final types = place['types'] as List? ?? [];
    
    if (types.contains('real_estate_agency')) return 'agency';
    if (types.contains('apartment')) return 'apartment';
    if (types.contains('house')) return 'house';
    if (types.contains('condominium')) return 'condo';
    if (types.contains('commercial')) return 'commercial';
    
    return 'property';
  }
}

// Extension methods for math operations
extension on double {
  double toRadians() => this * (3.14159265359 / 180);
  double sin() => math.sin(this);
  double cos() => math.cos(this);
  double asin() => math.asin(this);
  double sqrt() => math.sqrt(this);
}



class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);
}
