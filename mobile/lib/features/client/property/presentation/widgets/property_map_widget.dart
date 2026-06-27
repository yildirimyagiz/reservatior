import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyMapWidget extends ConsumerStatefulWidget {
  final List<Property> properties;
  final Function(Property)? onPropertyTap;

  const PropertyMapWidget({
    super.key,
    required this.properties,
    this.onPropertyTap,
  });

  @override
  ConsumerState<PropertyMapWidget> createState() => _PropertyMapWidgetState();
}

class _PropertyMapWidgetState extends ConsumerState<PropertyMapWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;

  @override
  void initState() {
    super.initState();
    _createCustomMarkerIcon();
    _updateMarkers();
  }

  @override
  void didUpdateWidget(PropertyMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.properties != widget.properties) {
      _updateMarkers();
    }
  }

  void _createCustomMarkerIcon() async {
    // Create custom marker icon
    _customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/icons/property_marker.png',
    );
    setState(() {});
  }

  void _updateMarkers() {
    final validProperties = widget.properties.where(
      (p) => p.lat != null && p.lng != null,
    );

    _markers = validProperties.map((property) {
      return Marker(
        markerId: MarkerId(property.id),
        position: LatLng(property.lat!, property.lng!),
        icon:
            _customIcon ??
            BitmapDescriptor.defaultMarkerWithHue(
              _getMarkerColor(property.listingStatus?.name),
            ),
        infoWindow: InfoWindow(
          title: property.name,
          snippet:
              '\$${property.listingPrice?.toStringAsFixed(0) ?? 'Price TBD'}',
          onTap: () => widget.onPropertyTap?.call(property),
        ),
      );
    }).toSet();

    setState(() {});
  }

  double _getMarkerColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'available':
        return BitmapDescriptor.hueGreen;
      case 'pending':
        return BitmapDescriptor.hueYellow;
      case 'sold':
        return BitmapDescriptor.hueRed;
      case 'rented':
        return BitmapDescriptor.hueBlue;
      default:
        return BitmapDescriptor.hueOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.properties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('mobile.auto.no_properties_to_display'.tr()),
          ],
        ),
      );
    }

    final validProperties = widget.properties
        .where((p) => p.lat != null && p.lng != null)
        .toList();

    if (validProperties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('mobile.auto.no_properties_with_location_data'.tr()),
          ],
        ),
      );
    }

    // Calculate bounds for all properties
    final bounds = _calculateBounds(validProperties);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              bounds.southwest.latitude +
                  (bounds.northeast.latitude - bounds.southwest.latitude) / 2,
              bounds.southwest.longitude +
                  (bounds.northeast.longitude - bounds.southwest.longitude) / 2,
            ),
            zoom: _calculateZoomLevel(bounds),
          ),
          markers: _markers,
          onMapCreated: (controller) => _mapController = controller,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
        ),

        // Map Controls
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              _buildMapControl(Icons.zoom_in, () => _zoomIn()),
              SizedBox(height: 8),
              _buildMapControl(Icons.zoom_out, () => _zoomOut()),
              SizedBox(height: 8),
              _buildMapControl(Icons.my_location, () => _centerOnUser()),
              SizedBox(height: 8),
              _buildMapControl(
                Icons.center_focus_strong,
                () => _centerOnProperties(),
              ),
            ],
          ),
        ),

        // Property Count
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${validProperties.length} Properties',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Filter Chips
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', true),
                SizedBox(width: 8),
                _buildFilterChip('mobile.leftovers.for_sale'.tr(), false),
                SizedBox(width: 8),
                _buildFilterChip('mobile.leftovers.for_rent'.tr(), false),
                SizedBox(width: 8),
                _buildFilterChip('Available', false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapControl(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(icon: Icon(icon), onPressed: onPressed),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // Handle filter selection
      },
    );
  }

  LatLngBounds _calculateBounds(List<Property> properties) {
    double minLat = properties.first.lat!;
    double maxLat = properties.first.lat!;
    double minLng = properties.first.lng!;
    double maxLng = properties.first.lng!;

    for (final property in properties) {
      minLat = math.min(minLat, property.lat!);
      maxLat = math.max(maxLat, property.lat!);
      minLng = math.min(minLng, property.lng!);
      maxLng = math.max(maxLng, property.lng!);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  double _calculateZoomLevel(LatLngBounds bounds) {
    final latDiff = bounds.northeast.latitude - bounds.southwest.latitude;
    final lngDiff = bounds.northeast.longitude - bounds.southwest.longitude;

    final maxDiff = math.max(latDiff, lngDiff);

    if (maxDiff < 0.01) return 15;
    if (maxDiff < 0.1) return 13;
    if (maxDiff < 0.5) return 11;
    if (maxDiff < 1) return 10;
    if (maxDiff < 2) return 9;
    if (maxDiff < 5) return 8;
    if (maxDiff < 10) return 7;
    return 6;
  }

  void _zoomIn() {
    _mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  void _centerOnUser() async {
    // Center on user's current location
    // This would require location permissions
  }

  void _centerOnProperties() {
    if (widget.properties.isEmpty) return;

    final validProperties = widget.properties
        .where((p) => p.lat != null && p.lng != null)
        .toList();

    if (validProperties.isEmpty) return;

    final bounds = _calculateBounds(validProperties);
    _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }
}
