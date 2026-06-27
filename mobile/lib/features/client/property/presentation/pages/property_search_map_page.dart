import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/features/client/property/presentation/providers/property_search_provider.dart';
import 'package:reservatior/features/client/property/presentation/widgets/search/property_card_widget.dart';

class PropertySearchMapPage extends ConsumerStatefulWidget {
  const PropertySearchMapPage({super.key});

  @override
  ConsumerState<PropertySearchMapPage> createState() =>
      _PropertySearchMapPageState();
}

class _PropertySearchMapPageState extends ConsumerState<PropertySearchMapPage> {
  GoogleMapController? _mapController;
  Property? _selectedProperty;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(41.0082, 28.9784), // Istanbul
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(propertySearchResultsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.darkSurface.withOpacity(0.8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: AppColors.darkSurface.withOpacity(0.8),
              child: IconButton(
                icon: const Icon(Icons.tune, color: Colors.white, size: 20),
                onPressed: () {}, // Trigger filters from here too
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            onMapCreated: (controller) => _mapController = controller,
            markers: _buildMarkers(properties),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            style: _mapStyle, // Custom dark theme for Google Maps
            onTap: (_) => setState(() => _selectedProperty = null),
          ),
          if (_selectedProperty != null)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: PropertyCardWidget(
                property: _selectedProperty!,
                onTap: () {},
                isList: true,
              ),
            ),
          Positioned(top: 100, left: 16, child: _buildMapControls()),
        ],
      ),
    );
  }

  Set<Marker> _buildMarkers(List<Property> properties) {
    return properties.where((p) => p.lat != null && p.lng != null).map((p) {
      return Marker(
        markerId: MarkerId(p.id),
        position: LatLng(p.lat!, p.lng!),
        infoWindow: InfoWindow(title: p.name),
        onTap: () => setState(() => _selectedProperty = p),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
    }).toSet();
  }

  Widget _buildMapControls() {
    return Column(
      children: [
        _mapControlButton(
          Icons.add,
          () => _mapController?.animateCamera(CameraUpdate.zoomIn()),
        ),
        const SizedBox(height: 8),
        _mapControlButton(
          Icons.remove,
          () => _mapController?.animateCamera(CameraUpdate.zoomOut()),
        ),
        const SizedBox(height: 8),
        _mapControlButton(Icons.my_location, () {}),
      ],
    );
  }

  Widget _mapControlButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.darkSurface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  // A simplified dark map style
  final String _mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#1b1c22"
        }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#746855"
        }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#242f3e"
        }
      ]
    },
    {
      "featureType": "administrative.locality",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#d59563"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#d59563"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#303030"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#17263c"
        }
      ]
    }
  ]
  ''';
}
