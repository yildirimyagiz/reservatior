import 'package:flutter/material.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/shared/enums/listing_status.dart';

class PropertyMapAdvancedWidget extends ConsumerStatefulWidget {
  final List<Property> properties;
  final Function(Property)? onPropertyTap;

  const PropertyMapAdvancedWidget({
    super.key,
    required this.properties,
    this.onPropertyTap,
  });

  @override
  ConsumerState<PropertyMapAdvancedWidget> createState() =>
      _PropertyMapAdvancedWidgetState();
}

class _PropertyMapAdvancedWidgetState
    extends ConsumerState<PropertyMapAdvancedWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  bool _showTraffic = false;
  double _currentZoom = 14.0;

  @override
  void initState() {
    super.initState();
    _updateMarkers();
  }

  @override
  void didUpdateWidget(PropertyMapAdvancedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.properties != widget.properties) {
      _updateMarkers();
    }
  }

  void _updateMarkers() {
    _markers = widget.properties
        .where((p) => p.lat != null && p.lng != null)
        .map(
          (p) => Marker(
            markerId: MarkerId(p.id),
            position: LatLng(p.lat!, p.lng!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              _getHue(p.listingStatus?.name),
            ),
            infoWindow: InfoWindow(
              title: p.name,
              snippet: '₺${p.listingPrice?.toStringAsFixed(0) ?? 'TBD'}',
              onTap: () => widget.onPropertyTap?.call(p),
            ),
          ),
        )
        .toSet();
    setState(() {});
  }

  double _getHue(String? status) {
    switch (status?.toLowerCase()) {
      case 'available':
        return BitmapDescriptor.hueGreen;
      case 'pending':
        return BitmapDescriptor.hueOrange;
      case 'sold':
        return BitmapDescriptor.hueRed;
      default:
        return BitmapDescriptor.hueAzure;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _getCenter(),
            zoom: _currentZoom,
          ),
          markers: _markers,
          mapType: _currentMapType,
          trafficEnabled: _showTraffic,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onMapCreated: (c) {
            _mapController = c;
            _setDarkMapStyle();
          },
          onCameraMove: (p) => _currentZoom = p.zoom,
        ),

        // Stats Overlay
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.darkSurface.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Text(
              '${widget.properties.length} NODES TRACKED',
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
                letterSpacing: 1,
              ),
            ),
          ),
        ),

        // Controls
        Positioned(
          right: 16,
          bottom: 120,
          child: Column(
            children: [
              _mapBtn(Icons.add_rounded, _zoomIn),
              const SizedBox(height: 12),
              _mapBtn(Icons.remove_rounded, _zoomOut),
              const SizedBox(height: 12),
              _mapBtn(Icons.my_location_rounded, _centerOnUser),
              const SizedBox(height: 12),
              _mapBtn(Icons.layers_rounded, _toggleMapType),
            ],
          ),
        ),

        // Legend
        Positioned(
          left: 16,
          bottom: 40,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.darkSurface.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _legendItem('Available', Colors.green),
                const SizedBox(height: 8),
                _legendItem('Pending', Colors.orange),
                const SizedBox(height: 8),
                _legendItem('mobile.leftovers.sold_rented'.tr(), Colors.red),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _setDarkMapStyle() async {
    // Standard Google Maps JSON style for dark mode if needed,
    // but here we just rely on the UI around it being dark.
  }

  Widget _mapBtn(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white70, size: 20),
        onPressed: () {
          HapticFeedback.lightImpact();
          onTap();
        },
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            color: Colors.white60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  LatLng _getCenter() {
    if (widget.properties.isEmpty) return const LatLng(41.0082, 28.9784);
    final valid = widget.properties
        .where((p) => p.lat != null && p.lng != null)
        .toList();
    if (valid.isEmpty) return const LatLng(41.0082, 28.9784);
    return LatLng(
      valid.map((p) => p.lat!).reduce((a, b) => a + b) / valid.length,
      valid.map((p) => p.lng!).reduce((a, b) => a + b) / valid.length,
    );
  }

  void _zoomIn() => _mapController?.animateCamera(CameraUpdate.zoomIn());
  void _zoomOut() => _mapController?.animateCamera(CameraUpdate.zoomOut());
  void _centerOnUser() {} // Location service integration needed
  void _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.hybrid
          : MapType.normal;
    });
  }
}
