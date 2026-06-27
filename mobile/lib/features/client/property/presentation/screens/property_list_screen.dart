import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_card_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_map_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_filter_widget.dart';

class PropertyListScreen extends ConsumerStatefulWidget {
  const PropertyListScreen({super.key});

  @override
  ConsumerState<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends ConsumerState<PropertyListScreen> {
  PropertyViewType _currentView = PropertyViewType.grid;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load initial properties
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(propertyListProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertiesAsync = ref.watch(propertyListProvider);
    final filteredProperties = ref.watch(filteredPropertiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('mobile.auto.properties'.tr(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          PopupMenuButton<PropertyViewType>(
            icon: Icon(Icons.view_module),
            onSelected: (view) => setState(() => _currentView = view),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: PropertyViewType.grid,
                child: Row(
                  children: [
                    Icon(Icons.grid_view),
                    SizedBox(width: 8),
                    Text('mobile.auto.grid_view'.tr()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: PropertyViewType.list,
                child: Row(
                  children: [
                    Icon(Icons.list),
                    SizedBox(width: 8),
                    Text('mobile.auto.list_view'.tr()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: PropertyViewType.map,
                child: Row(
                  children: [
                    Icon(Icons.map),
                    SizedBox(width: 8),
                    Text('mobile.auto.map_view'.tr()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          const PropertyFilterWidget(),

          // Results Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${filteredProperties.length} properties found',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Spacer(),
                if (propertiesAsync.isLoading)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),

          // Content
          Expanded(child: _buildView(filteredProperties)),
        ],
      ),
      floatingActionButton: _currentView == PropertyViewType.map
          ? FloatingActionButton(
              onPressed: _centerMapOnProperties,
              child: Icon(Icons.my_location),
            )
          : null,
    );
  }

  Widget _buildView(List<Property> properties) {
    switch (_currentView) {
      case PropertyViewType.grid:
        return _buildGridView(properties);
      case PropertyViewType.list:
        return _buildListView(properties);
      case PropertyViewType.map:
        return _buildMapView(properties);
    }
  }

  Widget _buildGridView(List<Property> properties) {
    if (properties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_work, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('mobile.auto.no_properties_found'.tr()),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(propertyListProvider);
      },
      child: GridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return PropertyCardWidget(
            property: properties[index],
            viewType: PropertyViewType.grid,
            onTap: () => _navigateToPropertyDetails(properties[index]),
          );
        },
      ),
    );
  }

  Widget _buildListView(List<Property> properties) {
    if (properties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_work, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('mobile.auto.no_properties_found'.tr()),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(propertyListProvider);
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: PropertyCardWidget(
              property: properties[index],
              viewType: PropertyViewType.list,
              onTap: () => _navigateToPropertyDetails(properties[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMapView(List<Property> properties) {
    return PropertyMapWidget(
      properties: properties,
      onPropertyTap: _navigateToPropertyDetails,
    );
  }

  void _navigateToPropertyDetails(Property property) {
    // TODO: Implement navigation when routes are set up
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("${'mobile.admin.navigate_to'.tr()} ${property.name}")));
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('mobile.auto.feature_property_title'.tr()),
        content: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'mobile.auto.enter_address_city_or_property_name'.tr(),
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('mobile.auto.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(propertySearchProvider.notifier)
                  .search(_searchController.text);
              Navigator.of(context).pop();
            },
            child: Text('mobile.auto.search'.tr()),
          ),
        ],
      ),
    );
  }

  void _centerMapOnProperties() {
    ref.read(propertyMapProvider.notifier).centerOnAllProperties();
  }
}
