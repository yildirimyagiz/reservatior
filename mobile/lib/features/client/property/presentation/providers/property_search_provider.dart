import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/enums/property_type.dart';
import 'package:reservatior/shared/enums/property_category.dart';
import 'package:reservatior/shared/enums/listing_type.dart';
import 'package:reservatior/shared/enums/listing_status.dart';

class PropertySearchFilters {
  final String search;
  final List<PropertyType> propertyTypes;
  final List<PropertyCategory> categories;
  final List<ListingType> listingTypes;
  final List<ListingStatus> listingStatuses;
  final double minPrice;
  final double maxPrice;
  final int minBedrooms;
  final int maxBedrooms;
  final int minBathrooms;
  final int maxBathrooms;
  final double minArea;
  final double maxArea;
  final String sortBy;
  final bool featuredOnly;
  final bool verifiedOnly;

  PropertySearchFilters({
    this.search = '',
    this.propertyTypes = const [],
    this.categories = const [],
    this.listingTypes = const [],
    this.listingStatuses = const [],
    this.minPrice = 0,
    this.maxPrice = 10000000,
    this.minBedrooms = 0,
    this.maxBedrooms = 10,
    this.minBathrooms = 0,
    this.maxBathrooms = 10,
    this.minArea = 0,
    this.maxArea = 10000,
    this.sortBy = 'date_desc',
    this.featuredOnly = false,
    this.verifiedOnly = false,
  });

  PropertySearchFilters copyWith({
    String? search,
    List<PropertyType>? propertyTypes,
    List<PropertyCategory>? categories,
    List<ListingType>? listingTypes,
    List<ListingStatus>? listingStatuses,
    double? minPrice,
    double? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    int? minBathrooms,
    int? maxBathrooms,
    double? minArea,
    double? maxArea,
    String? sortBy,
    bool? featuredOnly,
    bool? verifiedOnly,
  }) {
    return PropertySearchFilters(
      search: search ?? this.search,
      propertyTypes: propertyTypes ?? this.propertyTypes,
      categories: categories ?? this.categories,
      listingTypes: listingTypes ?? this.listingTypes,
      listingStatuses: listingStatuses ?? this.listingStatuses,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minBedrooms: minBedrooms ?? this.minBedrooms,
      maxBedrooms: maxBedrooms ?? this.maxBedrooms,
      minBathrooms: minBathrooms ?? this.minBathrooms,
      maxBathrooms: maxBathrooms ?? this.maxBathrooms,
      minArea: minArea ?? this.minArea,
      maxArea: maxArea ?? this.maxArea,
      sortBy: sortBy ?? this.sortBy,
      featuredOnly: featuredOnly ?? this.featuredOnly,
      verifiedOnly: verifiedOnly ?? this.verifiedOnly,
    );
  }
}

class PropertySearchNotifier extends StateNotifier<PropertySearchFilters> {
  PropertySearchNotifier() : super(PropertySearchFilters());

  void setSearch(String search) => state = state.copyWith(search: search);

  void togglePropertyType(PropertyType type) {
    final types = List<PropertyType>.from(state.propertyTypes);
    if (types.contains(type)) {
      types.remove(type);
    } else {
      types.add(type);
    }
    state = state.copyWith(propertyTypes: types);
  }

  void setPriceRange(double min, double max) =>
      state = state.copyWith(minPrice: min, maxPrice: max);
  void setBedroomRange(int min, int max) =>
      state = state.copyWith(minBedrooms: min, maxBedrooms: max);

  void clearFilters() => state = PropertySearchFilters();
}

final propertySearchFiltersProvider =
    StateNotifierProvider<PropertySearchNotifier, PropertySearchFilters>((ref) {
      return PropertySearchNotifier();
    });

// This would typically call an API
final propertySearchResultsProvider = Provider<List<Property>>((ref) {
  final filters = ref.watch(propertySearchFiltersProvider);
  // For now returning mock data like the React component
  return []; // Should be populated via a FutureProvider in real app
});
