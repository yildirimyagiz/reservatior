import 'package:flutter/material.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class MapViewWidget extends StatefulWidget {
  final Map<String, dynamic> filters;
  final Function(Map<String, dynamic>) onPropertyTap;

  const MapViewWidget({
    super.key,
    required this.filters,
    required this.onPropertyTap,
  });

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  final LatLng _initialPosition = const LatLng(
    25.2048,
    55.2708,
  ); // Dubai coordinates

  final List<Map<String, dynamic>> _properties = [
    {
      'id': 1,
      'title': 'mobile.leftovers.luxury_villa_in_palm_jumeirah'.tr(),
      'price': '\$2,500,000',
      'location': 'mobile.leftovers.palm_jumeirah_dubai'.tr(),
      'bedrooms': 5,
      'bathrooms': 6,
      'area': 'mobile.leftovers.4_500_sqft'.tr(),
      'type': 'Villa',
      'image': 'https://images.unsplash.com/photo-1691272477702-0a2edae135f2',
      'semanticLabel':
          'mobile.leftovers.modern_white_luxury_villa_with_palm_tree'.tr(),
      'verified': true,
      'videoFreshness': 'new',
      'coordinates': const LatLng(25.1124, 55.1390),
    },
    {
      'id': 2,
      'title': 'mobile.leftovers.modern_apartment_in_downtown'.tr(),
      'price': '\$850,000',
      'location': 'mobile.leftovers.downtown_dubai'.tr(),
      'bedrooms': 2,
      'bathrooms': 3,
      'area': 'mobile.leftovers.1_800_sqft'.tr(),
      'type': 'Apartment',
      'image':
          'https://img.rocket.new/generatedImages/rocket_gen_img_13b6136d7-1766551461726.png',
      'semanticLabel':
          'mobile.leftovers.contemporary_apartment_interior_with_flo'.tr(),
      'verified': true,
      'videoFreshness': 'recent',
      'coordinates': const LatLng(25.1972, 55.2744),
    },
    {
      'id': 3,
      'title': 'mobile.leftovers.beachfront_penthouse'.tr(),
      'price': '\$3,200,000',
      'location': 'mobile.leftovers.dubai_marina'.tr(),
      'bedrooms': 4,
      'bathrooms': 5,
      'area': 'mobile.leftovers.3_800_sqft'.tr(),
      'type': 'Penthouse',
      'image':
          'https://img.rocket.new/generatedImages/rocket_gen_img_10f7fd659-1766936729005.png',
      'semanticLabel':
          'mobile.leftovers.luxurious_penthouse_terrace_with_ocean_v'.tr(),
      'verified': true,
      'videoFreshness': 'new',
      'coordinates': const LatLng(25.0805, 55.1410),
    },
    {
      'id': 4,
      'title': 'mobile.leftovers.family_townhouse'.tr(),
      'price': '\$1,450,000',
      'location': 'mobile.leftovers.arabian_ranches'.tr(),
      'bedrooms': 3,
      'bathrooms': 4,
      'area': 'mobile.leftovers.2_600_sqft'.tr(),
      'type': 'Townhouse',
      'image':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1e9655d1d-1767666490160.png',
      'semanticLabel':
          'mobile.leftovers.spacious_townhouse_with_landscaped_garde'.tr(),
      'verified': false,
      'videoFreshness': 'older',
      'coordinates': const LatLng(25.0543, 55.2708),
    },
  ];

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    _markers.clear();
    for (var property in _properties) {
      _markers.add(
        Marker(
          markerId: MarkerId(property['id'].toString()),
          position: property['coordinates'] as LatLng,
          onTap: () => widget.onPropertyTap(property),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            property['verified']
                ? BitmapDescriptor.hueBlue
                : BitmapDescriptor.hueRed,
          ),
          infoWindow: InfoWindow(
            title: property['title'] as String?,
            snippet: property['price'] as String?,
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 11.0,
          ),
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
        ),
        // Property Count Badge
        Positioned(
          top: 2.h,
          left: 4.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, color: theme.colorScheme.primary, size: 20),
                SizedBox(width: 2.w),
                Text(
                  '${_properties.length} Properties',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        // My Location Button
        Positioned(
          bottom: 2.h,
          right: 4.w,
          child: Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.my_location,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              onPressed: () {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLng(_initialPosition),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
