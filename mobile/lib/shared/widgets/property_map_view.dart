import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyMapView extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final List<PropertyMarker>? propertyMarkers;
  final bool showUserLocation;
  final Function(LatLng)? onLocationSelected;
  final Function(PropertyMarker)? onPropertyTap;

  const PropertyMapView({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    this.propertyMarkers,
    this.showUserLocation = true,
    this.onLocationSelected,
    this.onPropertyTap,
  });

  @override
  State<PropertyMapView> createState() => _PropertyMapViewState();
}

class _PropertyMapViewState extends State<PropertyMapView> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Position? _currentPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      // Get current location
      if (widget.showUserLocation) {
        _currentPosition = await _getCurrentLocation();
      }

      // Add property markers
      if (widget.propertyMarkers != null) {
        _addPropertyMarkers();
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error initializing map: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _addPropertyMarkers() {
    final Set<Marker> markers = {};

    for (final property in widget.propertyMarkers!) {
      markers.add(
        Marker(
          markerId: MarkerId(property.id),
          position: LatLng(property.latitude, property.longitude),
          infoWindow: InfoWindow(
            title: property.title,
            snippet: property.price,
            onTap: () => widget.onPropertyTap?.call(property),
          ),
          icon: _getMarkerIcon(property.propertyType),
        ),
      );
    }

    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId:  MarkerId('current_location'),
          position: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          infoWindow:  InfoWindow(title: 'mobile.auto.your_location'.tr()),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  BitmapDescriptor _getMarkerIcon(String propertyType) {
    switch (propertyType.toLowerCase()) {
      case 'house':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'apartment':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      case 'condo':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
      case 'commercial':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    
    // Move to initial position
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(widget.initialLatitude!, widget.initialLongitude!),
            zoom: 14.0,
          ),
        ),
      );
    } else if (_currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 14.0,
          ),
        ),
      );
    }
  }

  void _onMapTap(LatLng location) {
    widget.onLocationSelected?.call(location);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLatitude ?? _currentPosition?.latitude ?? 37.7749,
            widget.initialLongitude ?? _currentPosition?.longitude ?? -122.4194,
          ),
          zoom: 14.0,
        ),
        markers: _markers,
        myLocationEnabled: widget.showUserLocation,
        myLocationButtonEnabled: widget.showUserLocation,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        onTap: _onMapTap,
        compassEnabled: true,
        mapToolbarEnabled: false,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "current_location",
            onPressed: _moveToCurrentLocation,
            child: Icon(Icons.my_location),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "search_nearby",
            onPressed: _searchNearbyProperties,
            child: Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  void _moveToCurrentLocation() async {
    if (_currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 15.0,
          ),
        ),
      );
    }
  }

  void _searchNearbyProperties() {
    if (_currentPosition != null) {
      // TODO: Implement nearby property search
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('mobile.auto.searching_nearby_properties'.tr())),
      );
    }
  }
}

class PropertyMarker {
  final String id;
  final String title;
  final String price;
  final double latitude;
  final double longitude;
  final String propertyType;
  final String? imageUrl;

  PropertyMarker({
    required this.id,
    required this.title,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.propertyType,
    this.imageUrl,
  });
}

// Map View with Property Details
class PropertyMapWithDetails extends StatelessWidget {
  final List<PropertyMarker> properties;
  final PropertyMarker? selectedProperty;

  const PropertyMapWithDetails({
    super.key,
    required this.properties,
    this.selectedProperty,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: PropertyMapView(
            propertyMarkers: properties,
            showUserLocation: true,
          ),
        ),
        if (selectedProperty != null)
          Expanded(
            flex: 1,
            child: PropertyDetailsPanel(property: selectedProperty!),
          ),
      ],
    );
  }
}

class PropertyDetailsPanel extends StatelessWidget {
  final PropertyMarker property;

  const PropertyDetailsPanel({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            property.price,
            style: TextStyle(
              fontSize: 16,
              color: Colors.green[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Type: ${property.propertyType}',
            style:  TextStyle(fontSize: 14),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to property details
            },
            child: Text('mobile.auto.view_details'.tr()),
          ),
        ],
      ),
    );
  }
}
